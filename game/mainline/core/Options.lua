local addonName, AUR = ...

local L = AUR.localization
local Utils = AUR.utils
local Dialog = AUR.dialog

local Options = {}

----------------------
--- Local Funtions ---
----------------------

local minimapProxy = setmetatable({}, {
    __index = function(_, key)
        if key == "minimap-button-hide" then
            return not AUR.data.options["minimap-button-hide"]
        else
            return AUR.data.options[key]
        end
    end,
    __newindex = function(_, key, value)
        if key == "minimap-button-hide" then
            AUR.data.options["minimap-button-hide"] = not value

            if value then
                Utils.minimapButton:Show("Aurarium")
            else
                Utils.minimapButton:Hide("Aurarium")
            end
        elseif key == "minimap-button-position" then
            AUR.data.options["minimap-button-position"] = value

            local zone = {
                hide = AUR.data.options["minimap-button-hide"],
                minimapPos = AUR.data.options["minimap-button-position"],
            }

            Utils.minimapButton:Refresh("Aurarium", zone)
            Utils.minimapButton:Lock("Aurarium")
        else
            AUR.data.options[key] = value
        end
    end,
})

---------------------
--- Main Funtions ---
---------------------

function Options:Initialize()
    local backdrop = {
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Friendsframe\\UI-Toast-Border",
		tile = true, tileSize = 8, edgeSize = 8,
		insets = { left = 3, right = 3, top = 3, bottom = 3 }
    }

    local canvasFrame = CreateFrame("Frame", nil, UIParent)

    do
		local header = canvasFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightHuge")
		header:SetPoint("TOPLEFT", canvasFrame, 7, -22)
		header:SetText(addonName)

		local scrollFrame = CreateFrame("ScrollFrame", nil, canvasFrame, "QuestScrollFrameTemplate")
		scrollFrame:SetPoint("TOPLEFT", canvasFrame, "TOPLEFT", 0, -54)
		scrollFrame:SetPoint("BOTTOMRIGHT", canvasFrame, "BOTTOMRIGHT", -29, 0)

		local scrollView = CreateFrame("Frame")
		scrollView:SetSize(1, 1)
		scrollFrame:SetScrollChild(scrollView)

        local descriptionFrame = CreateFrame("Frame", nil, scrollView, "BackdropTemplate")
        descriptionFrame:SetPoint("TOPLEFT", scrollView, "TOPLEFT", 10, -20)
        descriptionFrame:SetWidth(615)
        descriptionFrame:SetBackdrop(backdrop)
        descriptionFrame:SetBackdropColor(0, 0, 0, 0.4)

        descriptionFrame.title = descriptionFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        descriptionFrame.title:SetPoint("TOPLEFT", 8, 15)
        descriptionFrame.title:SetText(L["info.description"])

        descriptionFrame.text = descriptionFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        descriptionFrame.text:SetPoint("TOPLEFT", descriptionFrame, "TOPLEFT", 15, -15)
        descriptionFrame.text:SetPoint("TOPRIGHT", descriptionFrame, "TOPRIGHT",  -15, -15)
        descriptionFrame.text:SetWidth(descriptionFrame:GetWidth() - 30)
        descriptionFrame.text:SetJustifyH("LEFT")
        descriptionFrame.text:SetSpacing(2)
        descriptionFrame.text:SetText(L["info.description.text"])

        descriptionFrame:SetHeight(descriptionFrame.text:GetStringHeight() + 30)

        local helpFrame = CreateFrame("Frame", nil, scrollView, "BackdropTemplate")
        helpFrame:SetPoint("TOPLEFT", descriptionFrame, "BOTTOMLEFT", 0, -30)
        helpFrame:SetWidth(615)
        helpFrame:SetBackdrop(backdrop)
        helpFrame:SetBackdropColor(0, 0, 0, 0.4)

        helpFrame.title = helpFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        helpFrame.title:SetPoint("TOPLEFT", 8, 15)
        helpFrame.title:SetText(L["info.help"])

        helpFrame.text = helpFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        helpFrame.text:SetPoint("TOPLEFT", helpFrame, "TOPLEFT", 15, -15)
        helpFrame.text:SetPoint("TOPRIGHT", helpFrame, "TOPRIGHT", -15, -15)
        helpFrame.text:SetWidth(helpFrame:GetWidth() - 30)
        helpFrame.text:SetJustifyH("LEFT")
        helpFrame.text:SetSpacing(2)
        helpFrame.text:SetText(L["info.help.text"])

        helpFrame.divider = helpFrame:CreateTexture(nil, "BACKGROUND")
        helpFrame.divider:SetPoint("TOP", helpFrame.text, "BOTTOM", 0, -10)
        helpFrame.divider:SetSize(550, 6)
        helpFrame.divider:SetAtlas("RecipeList-Divider")
        helpFrame.divider:SetDesaturated(true)

        local buttonReset = CreateFrame("Button", nil, helpFrame, "UIPanelButtonTemplate")
        buttonReset:SetPoint("TOP", helpFrame.divider, "BOTTOM", 0, -10)
        buttonReset:SetSize(200, 22)
        buttonReset:SetText(L["info.help.reset-button.name"])
        buttonReset:SetScript("OnClick", function(self)
            Dialog:ShowResetOptionsDialog()
        end)
        buttonReset:SetScript("OnEnter", function(self)
			GameTooltip:ClearAllPoints()
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")

			GameTooltip_SetTitle(GameTooltip, L["info.help.reset-button.name"])
			GameTooltip_AddNormalLine(GameTooltip, L["info.help.reset-button.desc"])

			GameTooltip:Show()
        end)
		buttonReset:SetScript("OnLeave", function(self)
			GameTooltip:Hide()
        end)

        helpFrame:SetHeight(helpFrame.text:GetStringHeight() + 48 + 30)

        local aboutFrame = CreateFrame("Frame", nil, scrollView, "BackdropTemplate")
        aboutFrame:SetPoint("TOPLEFT", helpFrame, "BOTTOMLEFT", 0, -30)
        aboutFrame:SetWidth(615)
        aboutFrame:SetBackdrop(backdrop)
        aboutFrame:SetBackdropColor(0, 0, 0, 0.4)

        aboutFrame.title = aboutFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        aboutFrame.title:SetPoint("TOPLEFT", 8, 15)
        aboutFrame.title:SetText(L["info.about"])

        aboutFrame.text = aboutFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        aboutFrame.text :SetPoint("TOPLEFT", aboutFrame, "TOPLEFT", 15, -15)
        aboutFrame.text :SetPoint("TOPRIGHT", aboutFrame, "TOPRIGHT",  -15, -15)
        aboutFrame.text :SetWidth(aboutFrame:GetWidth() - 30)
        aboutFrame.text :SetJustifyH("LEFT")
        aboutFrame.text :SetSpacing(2)
        aboutFrame.text :SetText(L["info.about.text"]:format(AUR.GAME_VERSION .. " (" .. AUR.GAME_FLAVOR .. ")", AUR.ADDON_VERSION .. " (" .. AUR.ADDON_BUILD_DATE .. ")", AUR.ADDON_AUTHOR))

        aboutFrame.divider = aboutFrame:CreateTexture(nil, "BACKGROUND")
        aboutFrame.divider:SetPoint("TOP", aboutFrame.text , "BOTTOM", 0, -10)
        aboutFrame.divider:SetSize(550, 6)
        aboutFrame.divider:SetAtlas("RecipeList-Divider")
        aboutFrame.divider:SetDesaturated(true)

        local buttonGithub = CreateFrame("Button", nil, aboutFrame, "UIPanelButtonTemplate")
        buttonGithub:SetPoint("TOP", aboutFrame.divider, "BOTTOM", 0, -10)
        buttonGithub:SetSize(150, 22)
        buttonGithub:SetText(L["info.help.github-button.name"])
        buttonGithub:SetScript("OnClick", function(self)
            Dialog:ShowCopyAddressDialog(AUR.LINK_GITHUB)
        end)
        buttonGithub:SetScript("OnEnter", function(self)
			GameTooltip:ClearAllPoints()
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")

			GameTooltip_SetTitle(GameTooltip, L["info.help.github-button.name"])
			GameTooltip_AddNormalLine(GameTooltip, L["info.help.github-button.desc"])

			GameTooltip:Show()
        end)
		buttonGithub:SetScript("OnLeave", function(self)
			GameTooltip:Hide()
        end)

        aboutFrame:SetHeight(aboutFrame.text :GetStringHeight() + 48 + 30)

		local lastLine = aboutFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        lastLine:SetPoint("TOPLEFT", aboutFrame, "BOTTOMLEFT", 0, -10)
    end

    local mainCategory = Settings.RegisterCanvasLayoutCategory(canvasFrame, addonName)
    mainCategory.ID = addonName

    local variableTable = AUR.data.options
    local category, layout = Settings.RegisterVerticalLayoutSubcategory(mainCategory, L["options"])

    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.general"]))

    do
        local name = L["options.open-on-login.name"]
        local tooltip = L["options.open-on-login.tooltip"]
        local variable = "open-on-login"
        local defaultValue = false

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTable, Settings.VarType.Boolean, name, defaultValue)
        Settings.CreateCheckbox(category, setting, tooltip)
    end

    do
        local nameCheckbox = L["options.minimap-button-hide.name"]
        local tooltipCheckbox = L["options.minimap-button-hide.tooltip"]
        local variableCheckbox = "minimap-button-hide"
        local defaultValueCheckbox = false

        local settingCheckbox = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variableCheckbox, variableCheckbox, minimapProxy, Settings.VarType.Boolean, nameCheckbox, not defaultValueCheckbox)

        local nameSlider = L["options.minimap-button-position.name"]
        local tooltipSlider = L["options.minimap-button-position.tooltip"]
        local variableSlider = "minimap-button-position"
        local defaultValueSlider = 250

        local minValue = 0
        local maxValue = 360
        local step = 1

        local settingSlider = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variableSlider, variableSlider, minimapProxy, Settings.VarType.Number, nameSlider, defaultValueSlider)

		local optionsSlider = Settings.CreateSliderOptions(minValue, maxValue, step)
        optionsSlider:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right)

        local initializer = CreateSettingsCheckboxSliderInitializer(settingCheckbox, nameCheckbox, tooltipCheckbox, settingSlider, optionsSlider, nameSlider, tooltipSlider)

        layout:AddInitializer(initializer)
    end

    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.other"]))

    do
        local name = L["options.debug-mode.name"]
        local tooltip = L["options.debug-mode.tooltip"]
        local variable = "debug-mode"
        local defaultValue = false

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTable, Settings.VarType.Boolean, name, defaultValue)
        Settings.CreateCheckbox(category, setting, tooltip)
    end

    Settings.RegisterAddOnCategory(mainCategory)
end

AUR.options = Options
