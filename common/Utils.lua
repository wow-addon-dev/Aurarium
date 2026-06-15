local addonName, AUR = ...

local AWL = ArcaneWizardLibrary
local Addon = AWL:GetAddon(addonName)

local L = AUR.Localization

local Utils = {}

-----------------------
--- Local Functions ---
-----------------------

local function CopyTable(source)
	return AWL.Utils:CopyTable(source)
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
	Addon:PrintDebug(msg)
end

function Utils:PrintMessage(msg)
	Addon:PrintMessage(msg)
end

function Utils:IsAccountProfile()
	local characterRealmKey = GetCharacterRealmKey()

	return Aurarium_Options_v3.profileKeys[characterRealmKey]["use-account"]
end

function Utils:OpenSettingsOnLoading()
	local characterRealmKey = GetCharacterRealmKey()

	if Aurarium_Options_v3.profileKeys[characterRealmKey]["open-settings"] then
		Addon:OpenCategory()

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

	local createdProfile = false
	local createdProfileKey = false

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
		createdProfile = true
	end

	if not Aurarium_Options_v3.profileKeys[characterRealmKey] then
		Aurarium_Options_v3.profileKeys[characterRealmKey] = {
			["use-account"] = true,
			["open-settings"] = false
		}
		createdProfileKey = true
	end

	local useAccountProfile = Aurarium_Options_v3.profileKeys[characterRealmKey]["use-account"]

	if useAccountProfile then
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

	if AWL.GAME_TYPE_MAINLINE then
		AUR.data.balance["Warband"] = AUR.data.balance["Warband"] or {}
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
		db = AUR.settings.general["minimap-button"],
		tooltip = L["minimap-button.tooltip"],
		onLeftClick = function()
			if AUR.modules.Overview:IsShown() then
				AUR.modules.Overview:Hide()
			else
				AUR.modules.Overview:Show()
			end
		end
	})
end

AUR.modules.Utils = Utils
