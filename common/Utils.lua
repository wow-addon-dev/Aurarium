local addonName, AUR = ...

local L = AUR.Localization

local AWL = ArcaneWizardLibrary

local Utils = {}

-----------------------
--- Local Functions ---
-----------------------

local function CopyTable(source)
	local target = {}

	for key, value in pairs(source) do
		if type(value) == "table" then
			target[key] = CopyTable(value)
		else
			target[key] = value
		end
	end

	return target
end

local function GetCharacterRealmKey()
	return AWL.Utils:GetCharacterRealmKey()
end

function Utils:GetToday()
	return date("%Y-%m-%d")
end

function Utils:GetGold()
	return GetMoney()
end

function Utils:GetCharacterInfo()
	local char = UnitName("player")
	local realm = GetRealmName()

	return realm, char
end

------------------------
--- Public Functions ---
------------------------

function Utils:PrintDebug(msg)
	if AUR.settings.general["debug-mode"] then
		DEFAULT_CHAT_FRAME:AddMessage(ORANGE_FONT_COLOR:WrapTextInColorCode(addonName .. " (Debug): ")  .. msg)
	end
end

function Utils:PrintMessage(msg)
	DEFAULT_CHAT_FRAME:AddMessage(NORMAL_FONT_COLOR:WrapTextInColorCode(addonName .. ": ") .. msg)
end

function Utils:IsAccountProfile()
	local characterRealmKey = GetCharacterRealmKey()

	return Aurarium_Options_v3.profileKeys[characterRealmKey]["use-account"]
end

function Utils:OpenSettingsOnLoading()
	local characterRealmKey = GetCharacterRealmKey()

	if Aurarium_Options_v3.profileKeys[characterRealmKey]["open-settings"] then
		Settings.OpenToCategory(AUR.MAIN_CATEGORY_ID)

		Aurarium_Options_v3.profileKeys[characterRealmKey]["open-settings"] = false
	end
end

function Utils:ToggleProfileMode()
	local characterRealmKey = GetCharacterRealmKey()
	local useAccountProfile = self:IsAccountProfile()

	Aurarium_Options_v3.profileKeys[characterRealmKey]["use-account"] = not useAccountProfile
	Aurarium_Options_v3.profileKeys[characterRealmKey]["open-settings"] = true
end

function Utils:ResetAllCharacterProfiles()
	local characterRealmKey = GetCharacterRealmKey()

	Aurarium_Options_v3.profiles = {}
	Aurarium_Options_v3.profileKeys = {}

	Aurarium_Options_v3.profileKeys[characterRealmKey] = {
		["use-account"] = true,
		["open-settings"] = true
	}
end

function Utils:InitializeDatabase()
	local realm, char = Utils:GetCharacterInfo()
	local characterRealmKey = GetCharacterRealmKey()

	local defaults = {
		["general"] = {
			["minimap-button"] = {
				["hide"] = false
			}
		},
		["currency-overview"] = {}
	}

	if not Aurarium_Options_v3 then
		Aurarium_Options_v3 = {
			["account"] = CopyTable(defaults),
			["profiles"] = {},
			["profileKeys"] = {}
		}
	end

	if not Aurarium_Options_v3.profiles[characterRealmKey] then
		Aurarium_Options_v3.profiles[characterRealmKey] = CopyTable(defaults)
	end

	if not Aurarium_Options_v3.profileKeys[characterRealmKey] then
		Aurarium_Options_v3.profileKeys[characterRealmKey] = {
			["use-account"] = true,
			["open-settings"] = false
		}
	end

	if Aurarium_Options_v3.profileKeys[characterRealmKey]["use-account"] then
		AUR.settings.general = Aurarium_Options_v3.account["general"]
		AUR.settings.currencyOverview = Aurarium_Options_v3.account["currency-overview"]
	else
		AUR.settings.general = Aurarium_Options_v3.profiles[characterRealmKey]["general"]
		AUR.settings.currencyOverview = Aurarium_Options_v3.profiles[characterRealmKey]["currency-overview"]
	end

	if not Aurarium_DataDates then
		Aurarium_DataDates = {}
	end

	if not Aurarium_DataCharacter then
		Aurarium_DataCharacter = {}
	end

	if not Aurarium_DataBalance then
		Aurarium_DataBalance = {}
	end

	AUR.data.dates = Aurarium_DataDates
	AUR.data.character = Aurarium_DataCharacter
	AUR.data.balance = Aurarium_DataBalance

	AUR.data.character[realm] = AUR.data.character[realm] or {}
	AUR.data.character[realm][char] = AUR.data.character[realm][char] or {}

	AUR.data.balance[realm] = AUR.data.balance[realm] or {}
	AUR.data.balance[realm][char] = AUR.data.balance[realm][char] or {}

	if AUR.GAME_TYPE_MAINLINE then
		AUR.data.balance["Warband"] = AUR.data.balance["Warband"] or {}
	end
end

function Utils:InitializeMinimapButton()
	local LDB = LibStub("LibDataBroker-1.1"):NewDataObject("Aurarium", {
		type     = "launcher",
		text     = "Aurarium",
		icon     = AUR.MEDIA_PATH .. "icon-round.blp",
		OnClick  = function(self, button)
			if button == "LeftButton" then
				if AUR.modules.Overview:IsShown() then
					AUR.modules.Overview:Hide()
				else
					AUR.modules.Overview:Show()
				end
			elseif button == "RightButton" then
				if not InCombatLockdown() then
					Settings.OpenToCategory(AUR.MAIN_CATEGORY_ID)
				else
					Utils:PrintDebug("In combat. The options menu cannot be opened.")
				end
			end
		end,
		OnTooltipShow = function(tooltip)
			GameTooltip_SetTitle(tooltip, addonName)
			GameTooltip_AddNormalLine(tooltip, AUR.ADDON_VERSION .. " (" .. AUR.ADDON_BUILD_DATE .. ")")
			GameTooltip_AddBlankLineToTooltip(tooltip)
			GameTooltip_AddHighlightLine(tooltip, L["minimap-button.tooltip"])
		end,
	})

	self.minimapButton = LibStub("LibDBIcon-1.0")
	self.minimapButton:Register("Aurarium", LDB, AUR.settings.general["minimap-button"])
end

AUR.modules.Utils = Utils
