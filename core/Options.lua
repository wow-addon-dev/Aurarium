local addonName, AUR = ...

local AWL = ArcaneWizardLibrary
local Addon = AWL:GetAddon(addonName)

local L = AUR.Localization
local Utils = AUR.Modules.Utils

local Options = {}

-----------------------
--- Local Functions ---
-----------------------

local minimapButtonProxy = setmetatable({}, {
	__index = function(_, key)
		if key == "hide" then
			return not AUR.Settings.general["minimap-button"]["hide"]
		end
	end,
	__newindex = function(_, key, value)
		if key ~= "hide" then
			return
		end

		AUR.Settings.general["minimap-button"]["hide"] = not value

		if value then
			Utils.minimapButton:Show("Aurarium")
		else
			Utils.minimapButton:Hide("Aurarium")
		end
	end,
})

local currencyOverviewProxy = setmetatable({}, {
	__index = function(_, key)
		if key == "hide-unchanged-entries" then
			return AUR.Settings.currencyOverview["hide-unchanged-entries"]
		end
	end,
	__newindex = function(_, key, value)
		if key ~= "hide-unchanged-entries" then
			return
		end

		AUR.Settings.currencyOverview["hide-unchanged-entries"] = value

		if AUR.Modules.Overview and AUR.Modules.Overview:IsShown() then
			AUR.Modules.Overview:Refresh()
		end
	end,
})

------------------------
--- Public Functions ---
------------------------

function Options:Initialize()
	local category, layout = Settings.RegisterVerticalLayoutCategory(addonName)

	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.general"]))

	-- Minimap Button
	AWL.Settings:AddCheckbox(category, {
		variableTable = minimapButtonProxy,
		settingKey    = addonName .. "_hide",
		variableName  = "hide",
		name          = L["options.general.minimap-button.name"],
		tooltip       = L["options.general.minimap-button.tooltip"],
		default       = true
	})

	-- Debug Mode
	AWL.Settings:AddCheckbox(category, {
		variableTable = AUR.Settings.general,
		settingKey    = addonName .. "_debug-mode",
		variableName  = "debug-mode",
		name          = L["options.general.debug-mode.name"],
		tooltip       = L["options.general.debug-mode.tooltip"],
		default       = false
	})

	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.currency-overview"]))

	-- Open on Login
	AWL.Settings:AddCheckbox(category, {
		variableTable = AUR.Settings.currencyOverview,
		settingKey    = addonName .. "_open-on-login",
		variableName  = "open-on-login",
		name          = L["options.currency-overview.open-on-login.name"],
		tooltip       = L["options.currency-overview.open-on-login.tooltip"],
		default       = false
	})

	-- Hide Unchanged Entries
	AWL.Settings:AddCheckbox(category, {
		variableTable = currencyOverviewProxy,
		settingKey    = addonName .. "_hide-unchanged-entries",
		variableName  = "hide-unchanged-entries",
		name          = L["options.currency-overview.hide-unchanged-entries.name"],
		tooltip       = L["options.currency-overview.hide-unchanged-entries.tooltip"],
		default       = false
	})

	-- Profiles Section
	AWL.Settings:AddProfilesSection(layout, {
		useAccountProfile = Utils:IsAccountProfile(),
		onSwitchProfile = function()
			Utils:ToggleProfileMode()
			ReloadUI()
		end,
		onDeleteCharacterProfiles = function()
			Utils:ResetAllCharacterProfiles()
			ReloadUI()
		end
	})

	-- About Section
	AWL.Settings:AddAboutSection(layout, addonName)

	Settings.RegisterAddOnCategory(category)

	Addon:SetMainCategoryId(category:GetID())
end

AUR.Modules.Options = Options
