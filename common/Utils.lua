local addonName, AUR = ...

-- Library
local AWL = ArcaneWizardLibrary
local Addon = AWL:GetAddon(addonName)

-- Localization
local L = AUR.Localization

-- Current module
local Utils = AUR.Modules.Utils

-----------------------
--- Local Functions ---
-----------------------

local function PrintChatMessage(color, prefix, msg)
	DEFAULT_CHAT_FRAME:AddMessage(color:WrapTextInColorCode(prefix .. ": ") .. tostring(msg))
end

------------------------
--- Module Functions ---
------------------------

function Utils:GetToday()
	return date("%Y-%m-%d")
end

function Utils:GetGold()
	return GetMoney()
end

function Utils:PrintMessage(msg)
	PrintChatMessage(NORMAL_FONT_COLOR, addonName, msg)
end

function Utils:PrintDebug(msg)
	if AUR.Settings.general["debug-mode"] then
		PrintChatMessage(ORANGE_FONT_COLOR, addonName .. " (Debug)", msg)
	end
end

function Utils:OpenSettings()
	if not Addon:OpenCategory() then
		self:PrintDebug("In combat. The options menu cannot be opened.")
		return false
	end

	return true
end

function Utils:IsAccountProfile()
	local characterRealmKey = AWL.Utils:GetCharacterRealmKey()

	return Aurarium_Options_v4.profileKeys[characterRealmKey]["use-account"]
end

function Utils:OpenSettingsOnLoading()
	local characterRealmKey = AWL.Utils:GetCharacterRealmKey()

	if Aurarium_Options_v4.profileKeys[characterRealmKey]["open-settings"] then
		if not self:OpenSettings() then
			return
		end

		Aurarium_Options_v4.profileKeys[characterRealmKey]["open-settings"] = false
	end
end

function Utils:ToggleProfileMode()
	local characterRealmKey = AWL.Utils:GetCharacterRealmKey()
	local useAccountProfile = self:IsAccountProfile()

	Aurarium_Options_v4.profileKeys[characterRealmKey]["use-account"] = not useAccountProfile
	Aurarium_Options_v4.profileKeys[characterRealmKey]["open-settings"] = true
end

function Utils:ResetAllCharacterProfiles()
	local characterRealmKey = AWL.Utils:GetCharacterRealmKey()

	Aurarium_Options_v4.profiles = {}
	Aurarium_Options_v4.profileKeys = {}

	Aurarium_Options_v4.profileKeys[characterRealmKey] = {
		["use-account"] = true,
		["open-settings"] = true
	}
end

function Utils:InitializeDatabase()
	local char, realm = AWL.Utils:GetCharacterAndRealm()
	local characterRealmKey = AWL.Utils:GetCharacterRealmKey()

	local createdProfile = false
	local createdProfileKey = false

	local defaults = {
		["general"] = {
			["minimap-button"] = {
				["hide"] = false
			}
		},
		["currency-overview"] = {},
		["gold-display"] = {}
	}

	if not Aurarium_Options_v4 then
		Aurarium_Options_v4 = {
			["account"] = AWL.Utils:CopyTable(defaults),
			["profiles"] = {},
			["profileKeys"] = {}
		}
	end

	if not Aurarium_Options_v4.profiles[characterRealmKey] then
		Aurarium_Options_v4.profiles[characterRealmKey] = AWL.Utils:CopyTable(defaults)
		createdProfile = true
	end

	if not Aurarium_Options_v4.profileKeys[characterRealmKey] then
		Aurarium_Options_v4.profileKeys[characterRealmKey] = {
			["use-account"] = true,
			["open-settings"] = false
		}
		createdProfileKey = true
	end

	local useAccountProfile = Aurarium_Options_v4.profileKeys[characterRealmKey]["use-account"]

	if useAccountProfile then
		AUR.Settings.general = Aurarium_Options_v4.account["general"]
		AUR.Settings.currencyOverview = Aurarium_Options_v4.account["currency-overview"]
		AUR.Settings.goldDisplay = Aurarium_Options_v4.account["gold-display"]
	else
		AUR.Settings.general = Aurarium_Options_v4.profiles[characterRealmKey]["general"]
		AUR.Settings.currencyOverview = Aurarium_Options_v4.profiles[characterRealmKey]["currency-overview"]
		AUR.Settings.goldDisplay = Aurarium_Options_v4.profiles[characterRealmKey]["gold-display"]
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

	AUR.Data.dates = Aurarium_DataDates
	AUR.Data.character = Aurarium_DataCharacter
	AUR.Data.balance = Aurarium_DataBalance

	AUR.Data.character[realm] = AUR.Data.character[realm] or {}
	AUR.Data.character[realm][char] = AUR.Data.character[realm][char] or {}

	AUR.Data.balance[realm] = AUR.Data.balance[realm] or {}
	AUR.Data.balance[realm][char] = AUR.Data.balance[realm][char] or {}

	if AWL.GAME_TYPE_MAINLINE then
		AUR.Data.balance["Warband"] = AUR.Data.balance["Warband"] or {}
	end

	return {
		characterRealmKey = characterRealmKey,
		createdProfile = createdProfile,
		createdProfileKey = createdProfileKey,
		activeProfile = useAccountProfile and "account" or "character"
	}
end

function Utils:InitializeMinimapButton()
	self.minimapButton = Addon:RegisterMinimapButton({
		db = AUR.Settings.general["minimap-button"],
		tooltip = L["minimap-button.tooltip"],
		onLeftClick = function()
			if AUR.Modules.Overview:IsShown() then
				AUR.Modules.Overview:Hide()
			else
				AUR.Modules.Overview:Show()
			end
		end
	})
end
