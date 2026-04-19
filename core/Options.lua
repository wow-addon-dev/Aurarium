local addonName, AUR = ...

local L = AUR.localization
local Utils = AUR.utils

local AWL = ArcaneWizardLibrary

local Options = {}

----------------------
--- Local Funtions ---
----------------------

local minimapButtonProxy = setmetatable({}, {
    __index = function(_, key)
        return not AUR.options.general["minimap-button"]["hide"]
    end,
    __newindex = function(_, key, value)
        AUR.options.general["minimap-button"]["hide"] = not value

        if value then
            Utils.minimapButton:Show("Aurarium")
        else
            Utils.minimapButton:Hide("Aurarium")
        end
    end,
})

---------------------
--- Main Funtions ---
---------------------

function Options:Initialize()
    local category, layout = Settings.RegisterVerticalLayoutCategory(addonName)

	local variableTableGeneral = AUR.options.general
	local variableTableCurrencyOverview = AUR.options.currencyOverview
	local variableTableOther = AUR.options.other

	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.general"]))

	do
        local name = L["options.general.minimap-button.name"]
        local tooltip = L["options.general.minimap-button.tooltip"]
        local variable = "hide"
        local defaultValue = false

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, minimapButtonProxy, Settings.VarType.Boolean, name, not defaultValue)

        Settings.CreateCheckbox(category, setting, tooltip)
    end

	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.currency-overview"]))

    do
        local name = L["options.currency-overview.open-on-login.name"]
        local tooltip = L["options.currency-overview.open-on-login.tooltip"]
        local variable = "open-on-login"
        local defaultValue = false

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTableCurrencyOverview, Settings.VarType.Boolean, name, defaultValue)
        Settings.CreateCheckbox(category, setting, tooltip)
    end

    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.other"]))

    do
        local name = L["options.other.debug-mode.name"]
        local tooltip = L["options.other.debug-mode.tooltip"]
        local variable = "debug-mode"
        local defaultValue = false

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTableOther, Settings.VarType.Boolean, name, defaultValue)
        Settings.CreateCheckbox(category, setting, tooltip)
    end

	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.about"]))

	do
		layout:AddInitializer(Settings.CreateElementInitializer("ArcaneWizardLibrary_SettingsPanelTextNormal", {
			leftText = L["options.about.game-version"],
			rightText = AUR.GAME_VERSION .. " (" .. AUR.GAME_FLAVOR .. ")",
		}))
	end

	do
		layout:AddInitializer(Settings.CreateElementInitializer("ArcaneWizardLibrary_SettingsPanelTextNormal", {
			leftText = L["options.about.addon-version"],
			rightText = AUR.ADDON_VERSION .. " (" .. AUR.ADDON_BUILD_DATE .. ")"
		}))
	end

	do
		layout:AddInitializer(Settings.CreateElementInitializer("ArcaneWizardLibrary_SettingsPanelTextNormal", {
			leftText = L["options.about.lib-version"],
			rightText = AUR.ADDON_VERSION .. " (" .. AUR.ADDON_BUILD_DATE .. ")"
		}))
	end

	do
		layout:AddInitializer(Settings.CreateElementInitializer("ArcaneWizardLibrary_SettingsPanelTextLarge", {
			leftText = L["options.about.author"],
			rightText = AUR.ADDON_AUTHOR
		}))
	end

	do
        local name = L["options.about.button-github.name"]
        local tooltip = L["options.about.button-github.tooltip"]
		local buttonText = L["options.about.button-github.button"]

        local function OnButtonClick()
            AWL.Dialogs:ShowLinkDialog(AUR.LINK_GITHUB)
        end

        local buttonInitializer = CreateSettingsButtonInitializer(name, buttonText, OnButtonClick, tooltip, true)
        layout:AddInitializer(buttonInitializer)
    end

    Settings.RegisterAddOnCategory(category)

	AUR.MAIN_CATEGORY_ID = category:GetID()
end

AUR.options = Options
