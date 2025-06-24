local addonName, AUR = ...

local L = AUR.localization

local Utils = {}

-----------------------
--- Helper Funtions ---
-----------------------

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

---------------------
--- Main Funtions ---
---------------------

function Utils:PrintDebug(msg)
    if AUR.data.options["debug-mode"] then
        local notfound = true

        for i = 1, NUM_CHAT_WINDOWS do
            local name, _, _, _, _, _, shown, locked, docked, uni = GetChatWindowInfo(i)

            if name == "Debug" and docked ~= nil then
                _G['ChatFrame' .. i]:AddMessage(ORANGE_FONT_COLOR:WrapTextInColorCode(addonName .. " (Debug): ")  .. msg)
                notfound = false
                break
            end
        end

        if notfound then
            DEFAULT_CHAT_FRAME:AddMessage(ORANGE_FONT_COLOR:WrapTextInColorCode(addonName .. " (Debug): ")  .. msg)
        end
	end
end

function Utils:PrintMessage(msg)
    DEFAULT_CHAT_FRAME:AddMessage(NORMAL_FONT_COLOR:WrapTextInColorCode(addonName .. ": ") .. msg)
end

function Utils:InitializeDatabase()
    local realm, char = Utils:GetCharacterInfo()

    -- Options

    if (not Aurarium_Options) then
        Aurarium_Options = {}
    end

    AUR.data = {}
    AUR.data.options = Aurarium_Options

    -- Dates

    if (not Aurarium_DataDates) then
       Aurarium_DataDates = {}
    end

    AUR.data.dates = Aurarium_DataDates

    -- Character

    if (not Aurarium_DataCharacter) then
        Aurarium_DataCharacter = {}
    end

    AUR.data.character = Aurarium_DataCharacter

    AUR.data.character[realm] =  AUR.data.character[realm] or {}
    AUR.data.character[realm][char] =  AUR.data.character[realm][char] or {}

    -- Balance

    if (not Aurarium_DataBalance) then
        Aurarium_DataBalance = {}
    end

    AUR.data.balance = Aurarium_DataBalance

    AUR.data.balance =  AUR.data.balance or {}
    AUR.data.balance["Warband"] =  AUR.data.balance["Warband"] or {}

    AUR.data.balance[realm] =  AUR.data.balance[realm] or {}
    AUR.data.balance[realm][char] =  AUR.data.balance[realm][char] or {}
end

function Utils:InitializeMinimapButton()
    local LDB = LibStub("LibDataBroker-1.1"):NewDataObject("Aurarium", {
        type     = "launcher",
        text     = "Aurarium",
        icon     = AUR.MEDIA_PATH .. "icon-round.blp",
        OnClick  = function(self, button)
            if button == "LeftButton" then
                if AUR.overview:IsShown() then
                    AUR.overview:Hide()
                else
                    AUR.overview:Show()
                end
            elseif button == "RightButton" then
                Settings.OpenToCategory("Aurarium")
            end
        end,
        OnTooltipShow = function(tooltip)
			tooltip:ClearLines()
			tooltip:SetText(WHITE_FONT_COLOR:WrapTextInColorCode(addonName))
			tooltip:AddLine(AUR.ADDON_VERSION .. " (" .. AUR.ADDON_BUILD_DATE .. ")")
			tooltip:AddLine(" ")
			tooltip:AddLine(WHITE_FONT_COLOR:WrapTextInColorCode(L["minimap-button.tooltip"]))
        end,
    })

    local zone = {
        hide = AUR.data.options["minimap-button-hide"],
        minimapPos = AUR.data.options["minimap-button-position"],
    }

    self.minimapButton = LibStub("LibDBIcon-1.0")
    self.minimapButton:Register("Aurarium", LDB, zone)
    self.minimapButton:Lock("Aurarium")
end

AUR.utils = Utils
