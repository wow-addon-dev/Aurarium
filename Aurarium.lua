local addonName, GCT = ...

local L = GCT.localization
local Utils = GCT.utils
local Dialog = GCT.dialog
local Options = GCT.options
local Overview = GCT.overview

----------------------
--- Local funtions ---
----------------------

local function SavedDate(dateStr)
    local dates = GCT.data.dates

    for _, d in ipairs(dates) do
        if d == dateStr then
            return
        end
    end

    table.insert(dates, dateStr)
    table.sort(dates)
end

local function SaveCharacterInfo(realm, char)
    local classFilename = UnitClassBase("player")
    local englishFaction = UnitFactionGroup("player")

    GCT.data.character[realm][char] = {class = classFilename, faction = englishFaction}
end

local function SaveBalance()
    local realm, char = Utils:GetCharacterInfo()
    local today = Utils:GetToday()

    SavedDate(today)
    SaveCharacterInfo(realm, char)

    local warbandHistory  = GCT.data.balance["Warband"]
    local characterHistory  = GCT.data.balance[realm][char]

    GCT.data.balance["Warband"][today] = GCT.data.balance["Warband"][today] or {}
    GCT.data.balance[realm][char][today] = GCT.data.balance[realm][char][today] or {}

    local newGold  = Utils:GetGold()
    local prevGold = 0

    local lastDate = nil
    local isChangedC1 = false
    local isChangedC2 = false

    for dateKey, dayData in pairs(characterHistory) do
        if dateKey < today and dayData["gold"] ~= nil and (not lastDate or dateKey > lastDate) then
            lastDate = dateKey
            prevGold = dayData["gold"]
        end
    end

    if newGold ~= prevGold then
        isChangedC1 = true
        GCT.data.balance[realm][char][today]["gold"] = newGold
    else
        GCT.data.balance[realm][char][today]["gold"] = nil
    end

    for _, currencies in pairs(GCT.CHARACTER_CURRENCIES) do
        for _, currencyID in ipairs(currencies) do
            local key   = "c-" .. tostring(currencyID)
            local info  = C_CurrencyInfo.GetCurrencyInfo(currencyID)
            local newQty = (info and info.quantity) or 0

            local prevQty  = 0
            lastDate = nil

            for dateKey, dayData in pairs(characterHistory) do
                if dateKey < today and dayData[key] ~= nil then
                    if not lastDate or dateKey > lastDate then
                        lastDate  = dateKey
                        prevQty   = dayData[key]
                    end
                end
            end

            if newQty ~= prevQty then
                isChangedC1 = true
                GCT.data.balance[realm][char][today][key] = info.quantity
            else
                GCT.data.balance[realm][char][today][key] = nil
            end
        end
    end

    for _, currencies in pairs(GCT.WARBAND_CURRENCIES) do
        for _, currencyID in ipairs(currencies) do
            local key   = "w-" .. tostring(currencyID)
            local info  = C_CurrencyInfo.GetCurrencyInfo(currencyID)
            local newQty = (info and info.quantity) or 0

            local prevQty  = 0
            lastDate = nil

            for dateKey, dayData in pairs(warbandHistory) do
                if dateKey < today and dayData[key] ~= nil then
                    if not lastDate or dateKey > lastDate then
                        lastDate  = dateKey
                        prevQty   = dayData[key]
                    end
                end
            end

            if newQty ~= prevQty then
                isChangedC2 = true
                GCT.data.balance["Warband"][today][key] = info.quantity
            else
                GCT.data.balance["Warband"][today][key] = nil
            end
        end
    end

    if not isChangedC1 then
        GCT.data.balance[realm][char][today] = nil
    end

    if not isChangedC2 then
       GCT.data.balance["Warband"][today] = nil
    end

    Utils:PrintDebug("Gold and currency balance saved.")
end

local function SlashCommand(msg, editbox)
    if not msg or msg:trim() == "" then
        Settings.OpenToCategory("Aurarium")
    elseif msg:trim() == "overview" then
        Overview:Show()
	else
        Utils:PrintDebug("These arguments are not accepted.")
	end
end

--------------
--- Frames ---
--------------

local goldCurrencyTrackerFrame = CreateFrame("Frame", "GoldCurrencyTracker")

---------------------
--- Main funtions ---
---------------------

function goldCurrencyTrackerFrame:OnEvent(event, ...)
	self[event](self, event, ...)
end

function goldCurrencyTrackerFrame:ADDON_LOADED(_, addOnName)
    if addOnName == addonName then
        Utils:InitializeDatabase()
        Utils:InitializeMinimapButton()
        Dialog:InitializeDialog()
        Options:Initialize()
        Overview:Initialize()

        Utils:PrintDebug("Addon fully loaded.")
    end
end

function goldCurrencyTrackerFrame:PLAYER_ENTERING_WORLD(_, isInitialLogin, isReloadingUi)
    Utils:PrintDebug("Event 'PLAYER_ENTERING_WORLD' fired. Payload: isInitialLogin=" .. tostring(isInitialLogin) .. ", isReloadingUi=" .. tostring(isReloadingUi))

    if (isInitialLogin or isReloadingUi) then
        C_Timer.After(5, function()
            SaveBalance()
        end)

        if GCT.data.options["open-on-login"]then
            Overview:Show()
        end
    end
end

function goldCurrencyTrackerFrame:PLAYER_MONEY(...)
    Utils:PrintDebug("Event 'PLAYER_MONEY' fired. No payload.")

    SaveBalance()
end

function goldCurrencyTrackerFrame:CURRENCY_DISPLAY_UPDATE(...)
    Utils:PrintDebug("Event 'CURRENCY_DISPLAY_UPDATE' fired. No payload.")

    SaveBalance()
end

goldCurrencyTrackerFrame:RegisterEvent("ADDON_LOADED")
goldCurrencyTrackerFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
goldCurrencyTrackerFrame:RegisterEvent("PLAYER_MONEY")
goldCurrencyTrackerFrame:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
goldCurrencyTrackerFrame:SetScript("OnEvent", goldCurrencyTrackerFrame.OnEvent)

SLASH_Aurarium1, SLASH_Aurarium2 = '/aur', '/Aurarium'

SlashCmdList["Aurarium"] = SlashCommand