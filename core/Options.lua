local addonName, AUR = ...

local L = AUR.Localization

local Utils = AUR.modules.Utils

local AWL = ArcaneWizardLibrary

local Options = {}

-----------------------
--- Local Functions ---
-----------------------

local minimapButtonProxy = setmetatable({}, {
	__index = function(_, key)
		if key == "hide" then
			return not AUR.settings.general["minimap-button"]["hide"]
		end
	end,
	__newindex = function(_, key, value)
		if key ~= "hide" then
			return
		end

		AUR.settings.general["minimap-button"]["hide"] = not value

		if value then
			Utils.minimapButton:Show("Aurarium")
		else
			Utils.minimapButton:Hide("Aurarium")
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
		variableTable = AUR.settings.general,
		settingKey    = addonName .. "_debug-mode",
		variableName  = "debug-mode",
		name          = L["options.general.debug-mode.name"],
		tooltip       = L["options.general.debug-mode.tooltip"],
		default       = false
	})

	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.currency-overview"]))

	-- Open on Login
	AWL.Settings:AddCheckbox(category, {
		variableTable = AUR.settings.currencyOverview,
		settingKey    = addonName .. "_open-on-login",
		variableName  = "open-on-login",
		name          = L["options.currency-overview.open-on-login.name"],
		tooltip       = L["options.currency-overview.open-on-login.tooltip"],
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
	AWL.Settings:AddAboutSection(layout, {
		gameVersion    = AUR.GAME_VERSION,
		gameFlavor     = AUR.GAME_FLAVOR,
		addonVersion   = AUR.ADDON_VERSION,
		addonBuildDate = AUR.ADDON_BUILD_DATE,
		addonAuthor    = AUR.ADDON_AUTHOR,
		githubLink     = AUR.LINK_GITHUB
	})

	Settings.RegisterAddOnCategory(category)

	AUR.MAIN_CATEGORY_ID = category:GetID()
end

AUR.modules.Options = Options
