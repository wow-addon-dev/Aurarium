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

function Utils:HexToRGB(hex)
    hex = hex:gsub("^#","")
    hex = hex:gsub("^ff","")

    local r = tonumber(hex:sub(1,2), 16) / 255
    local g = tonumber(hex:sub(3,4), 16) / 255
    local b = tonumber(hex:sub(5,6), 16) / 255

    return r, g, b
end

function Utils:RGBToHex(r, g, b)
    r = math.min(math.max(r,0),1)
    g = math.min(math.max(g,0),1)
    b = math.min(math.max(b,0),1)

    return string.format("ff%02X%02X%02X", r * 255, g * 255, b * 255)
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
                _G['ChatFrame' .. i]:AddMessage(WrapTextInColorCode("Gold & Currency Tracker (Debug): ", AUR.ORANGE_FONT_COLOR) .. msg)
                notfound = false
                break
            end
        end

        if notfound then
            DEFAULT_CHAT_FRAME:AddMessage(WrapTextInColorCode("Gold & Currency Tracker (Debug): ", AUR.ORANGE_FONT_COLOR)  .. msg)
        end
	end
end

function Utils:PrintMessage(msg)
    DEFAULT_CHAT_FRAME:AddMessage(WrapTextInColorCode(addonName .. ": ", AUR.NORMAL_FONT_COLOR) .. msg)
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
            tooltip:SetText(addonName)
            tooltip:AddLine(WrapTextInColorCode(AUR.ADDON_VERSION .. " (" .. AUR.ADDON_BUILD_DATE .. ")", AUR.WHITE_FONT_COLOR))
            tooltip:AddLine(" ")
            tooltip:AddLine(L["minimap-button.tooltip"]:format(AUR.LINK_FONT_COLOR, AUR.LINK_FONT_COLOR), 1, 1, 1)
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
