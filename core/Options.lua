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
    local offsetY = -20
    local spacing = 30

    local backdrop = {
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Friendsframe\\UI-Toast-Border",
		tile = true, tileSize = 8, edgeSize = 8,
		insets = { left = 3, right = 3, top = 3, bottom = 3 }
    }

    local canvasFrame = CreateFrame("Frame", nil, UIParent)

    local header = canvasFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightHuge")
    header:SetPoint("TOPLEFT", canvasFrame, 7, -22)
    header:SetText(addonName)

    local scrollFrame = CreateFrame("ScrollFrame", nil, canvasFrame, "QuestScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", canvasFrame, "TOPLEFT", 0, -54)
    scrollFrame:SetPoint("BOTTOMRIGHT", canvasFrame, "BOTTOMRIGHT", -29, 0)

    local scrollView = CreateFrame("Frame")
    scrollView:SetSize(1, 1)
    scrollFrame:SetScrollChild(scrollView)

    do
        local descriptionFrame = CreateFrame("Frame", nil, scrollView, "BackdropTemplate")
        descriptionFrame:ClearAllPoints()
        descriptionFrame:SetPoint("TOPLEFT", scrollView, "TOPLEFT", 10, offsetY)
        descriptionFrame:SetWidth(615)
        descriptionFrame:SetBackdrop(backdrop)
    	descriptionFrame:SetBackdropColor(0, 0, 0, 0.4)

        descriptionFrame.title = descriptionFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        descriptionFrame.title:SetPoint("TOPLEFT", 8, 15)
        descriptionFrame.title:SetText(L["info.description"])

        local text = descriptionFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        text:SetPoint("TOPLEFT", descriptionFrame, "TOPLEFT", 15, -15)
        text:SetPoint("TOPRIGHT", descriptionFrame, "TOPRIGHT",  -15, -15)
        text:SetWidth(descriptionFrame:GetWidth() - 30)
        text:SetJustifyH("LEFT")
        text:SetSpacing(2)
        text:SetWordWrap(true)
        text:SetText(L["info.description.text"])

        local totalHeight = text:GetStringHeight() + 30
        descriptionFrame:SetHeight(totalHeight)

        offsetY = offsetY - descriptionFrame:GetHeight() - spacing
    end

    do
        local helpFrame = CreateFrame("Frame", nil, scrollView, "BackdropTemplate")
        helpFrame:ClearAllPoints()
        helpFrame:SetPoint("TOPLEFT", scrollView, "TOPLEFT", 10, offsetY)
        helpFrame:SetWidth(615)
        helpFrame:SetBackdrop(backdrop)
        helpFrame:SetBackdropColor(0, 0, 0, 0.4)

        helpFrame.title = helpFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        helpFrame.title:SetPoint("TOPLEFT", 8, 15)
        helpFrame.title:SetText(L["info.help"])

        local text = helpFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        text:SetPoint("TOPLEFT", helpFrame, "TOPLEFT", 15, -15)
        text:SetPoint("TOPRIGHT", helpFrame, "TOPRIGHT", -15, -15)
        text:SetWidth(helpFrame:GetWidth() - 30)
        text:SetJustifyH("LEFT")
        text:SetSpacing(2)
        text:SetWordWrap(true)
        text:SetText(L["info.help.text"])

        local divider = helpFrame:CreateTexture(nil, "BACKGROUND")
        divider:SetPoint("TOP", text, "BOTTOM", 0, -10)
        divider:SetSize(550, 6)
        divider:SetAtlas("thewarwithin-scenario-line-top-glowing")
        divider:SetDesaturated(true)
        divider:SetVertexColor(Utils:HexToRGB("ffB9B9B9"))

        local buttonReset = CreateFrame("Button", nil, helpFrame, "UIPanelButtonTemplate")
        buttonReset:SetPoint("TOP", divider, "BOTTOM", 0, -10)
        buttonReset:SetSize(200, 22)
        buttonReset:SetText(L["info.help.reset-button.name"])
        buttonReset:SetScript("OnClick", function(self)
            Dialog:ShowResetOptionsDialog()
        end)
        buttonReset:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
            GameTooltip:SetText(L["info.help.reset-button.name"], 1, 1, 1, true)
            GameTooltip:AddLine(L["info.help.reset-button.desc"], true)
            GameTooltip:Show()
        end)
        buttonReset:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)

        local totalHeight = text:GetStringHeight() + 48 + 30
        helpFrame:SetHeight(totalHeight)

        offsetY = offsetY - helpFrame:GetHeight() - spacing
    end

    do
        local aboutFrame = CreateFrame("Frame", nil, scrollView, "BackdropTemplate")
        aboutFrame:ClearAllPoints()
        aboutFrame:SetPoint("TOPLEFT", scrollView, "TOPLEFT", 10, offsetY)
        aboutFrame:SetWidth(615)
        aboutFrame:SetBackdrop(backdrop)
        aboutFrame:SetBackdropColor(0,0,0,0.4)

        aboutFrame.title = aboutFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        aboutFrame.title:SetPoint("TOPLEFT", 8, 15)
        aboutFrame.title:SetText(L["info.about"])

        local text = aboutFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        text:SetPoint("TOPLEFT", aboutFrame, "TOPLEFT", 15, -15)
        text:SetPoint("TOPRIGHT", aboutFrame, "TOPRIGHT",  -15, -15)
        text:SetWidth(aboutFrame:GetWidth() - 30)
        text:SetJustifyH("LEFT")
        text:SetSpacing(2)
        text:SetWordWrap(true)
        text:SetText(L["info.about.text"]:format(AUR.GAME_VERSION .. " (" .. AUR.GAME_FLAVOR .. ")",AUR.ADDON_VERSION .. " (" .. AUR.ADDON_BUILD_DATE .. ")", AUR.ADDON_AUTHOR))

        local divider = aboutFrame:CreateTexture(nil, "BACKGROUND")
        divider:SetPoint("TOP", text, "BOTTOM", 0, -10)
        divider:SetSize(550, 6)
        divider:SetAtlas("thewarwithin-scenario-line-top-glowing")
        divider:SetDesaturated(true)
        divider:SetVertexColor(Utils:HexToRGB("ffB9B9B9"))

        local buttonGithub = CreateFrame("Button", nil, aboutFrame, "UIPanelButtonTemplate")
        buttonGithub:SetPoint("TOP", divider, "BOTTOM", 0, -10)
        buttonGithub:SetSize(150, 22)
        buttonGithub:SetText(L["info.help.github-button.name"])
        buttonGithub:SetScript("OnClick", function(self)
            Dialog:ShowCopyAddressDialog(AUR.LINK_GITHUB)
        end)
        buttonGithub:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
            GameTooltip:SetText(L["info.help.github-button.name"], 1, 1, 1, true)
            GameTooltip:AddLine(L["info.help.github-button.desc"], true)
            GameTooltip:Show()
        end)
        buttonGithub:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)

        local totalHeight = text:GetStringHeight() + 48 + 30
        aboutFrame:SetHeight(totalHeight)

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

        local initializer= CreateSettingsCheckboxSliderInitializer(settingCheckbox, nameCheckbox, tooltipCheckbox, settingSlider, optionsSlider, nameSlider, tooltipSlider)

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
