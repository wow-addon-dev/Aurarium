local addonName, GCT = ...

local L = GCT.localization

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
    if GCT.data.options["debug-mode"] then
        local notfound = true

        for i = 1, NUM_CHAT_WINDOWS do
            local name, _, _, _, _, _, shown, locked, docked, uni = GetChatWindowInfo(i)

            if name == "Debug" and docked ~= nil then
                _G['ChatFrame' .. i]:AddMessage(WrapTextInColorCode("Gold & Currency Tracker (Debug): ", GCT.ORANGE_FONT_COLOR) .. msg)
                notfound = false
                break
            end
        end

        if notfound then
            DEFAULT_CHAT_FRAME:AddMessage(WrapTextInColorCode("Gold & Currency Tracker (Debug): ", GCT.ORANGE_FONT_COLOR)  .. msg)
        end
	end
end

function Utils:PrintMessage(msg)
    DEFAULT_CHAT_FRAME:AddMessage(WrapTextInColorCode(addonName .. ": ", GCT.NORMAL_FONT_COLOR) .. msg)
end

function Utils:InitializeDatabase()
    local realm, char = Utils:GetCharacterInfo()

    -- Options

    if (not Aurarium_Options) then
        Aurarium_Options = {}
    end

    GCT.data = {}
    GCT.data.options = Aurarium_Options

    -- Dates

    if (not Aurarium_DataDates) then
       Aurarium_DataDates = {}
    end

    GCT.data.dates = Aurarium_DataDates

    -- Character

    if (not Aurarium_DataCharacter) then
        Aurarium_DataCharacter = {}
    end

    GCT.data.character = Aurarium_DataCharacter

    GCT.data.character[realm] =  GCT.data.character[realm] or {}
    GCT.data.character[realm][char] =  GCT.data.character[realm][char] or {}

    -- Balance

    if (not Aurarium_DataBalance) then
        Aurarium_DataBalance = {}
    end

    GCT.data.balance = Aurarium_DataBalance

    GCT.data.balance =  GCT.data.balance or {}
    GCT.data.balance["Warband"] =  GCT.data.balance["Warband"] or {}

    GCT.data.balance[realm] =  GCT.data.balance[realm] or {}
    GCT.data.balance[realm][char] =  GCT.data.balance[realm][char] or {}
end

function Utils:InitializeMinimapButton()
    local LDB = LibStub("LibDataBroker-1.1"):NewDataObject("Aurarium", {
        type     = "launcher",
        text     = "Aurarium",
        icon     = GCT.MEDIA_PATH .. "icon-round.blp",
        OnClick  = function(self, button)
            if button == "LeftButton" then
                if GCT.overview:IsShown() then
                    GCT.overview:Hide()
                else
                    GCT.overview:Show()
                end
            elseif button == "RightButton" then
                Settings.OpenToCategory("Aurarium")
            end
        end,
        OnTooltipShow = function(tooltip)
            tooltip:SetText(addonName)
            tooltip:AddLine(WrapTextInColorCode(GCT.ADDON_VERSION .. " (" .. GCT.ADDON_BUILD_DATE .. ")", GCT.WHITE_FONT_COLOR))
            tooltip:AddLine(" ")
            tooltip:AddLine(L["minimap-button.tooltip"]:format(GCT.LINK_FONT_COLOR, GCT.LINK_FONT_COLOR), 1, 1, 1)
        end,
    })

    local zone = {}
    zone.hide = GCT.data.options["minimap-button-hide"]
    zone.minimapPos = GCT.data.options["minimap-button-position"]

    local zone = {
        hide = GCT.data.options["minimap-button-hide"],
        minimapPos = GCT.data.options["minimap-button-position"],
    }

    self.minimapButton = LibStub("LibDBIcon-1.0")
    self.minimapButton:Register("Aurarium", LDB, zone)
    self.minimapButton:Lock("Aurarium")
end

GCT.utils = Utils
