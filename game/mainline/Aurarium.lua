local addonName, AUR = ...

local L = AUR.localization
local Utils = AUR.utils
local Dialog = AUR.dialog
local Options = AUR.options
local Overview = AUR.overview

----------------------
--- Local funtions ---
----------------------

local function SavedDate(dateStr)
    local dates = AUR.data.dates

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

    AUR.data.character[realm][char] = {class = classFilename, faction = englishFaction}
end

local function SaveBalance()
    local realm, char = Utils:GetCharacterInfo()
    local today = Utils:GetToday()

    SavedDate(today)
    SaveCharacterInfo(realm, char)

    local warbandHistory  = AUR.data.balance["Warband"]
    local characterHistory  = AUR.data.balance[realm][char]

    AUR.data.balance["Warband"][today] = AUR.data.balance["Warband"][today] or {}
    AUR.data.balance[realm][char][today] = AUR.data.balance[realm][char][today] or {}

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
        AUR.data.balance[realm][char][today]["gold"] = newGold
    else
        AUR.data.balance[realm][char][today]["gold"] = nil
    end

    for _, currencies in pairs(AUR.CHARACTER_CURRENCIES) do
        for _, currencyID in ipairs(currencies) do
            local key   = "c-" .. tostring(currencyID)
            local info  = C_CurrencyInfo.GetCurrencyInfo(currencyID)

			if info then
				do break end
			end

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
                AUR.data.balance[realm][char][today][key] = info.quantity
            else
                AUR.data.balance[realm][char][today][key] = nil
            end
        end
    end

    for _, currencies in pairs(AUR.WARBAND_CURRENCIES) do
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
                AUR.data.balance["Warband"][today][key] = info.quantity
            else
                AUR.data.balance["Warband"][today][key] = nil
            end
        end
    end

    if not isChangedC1 then
        AUR.data.balance[realm][char][today] = nil
    end

    if not isChangedC2 then
       AUR.data.balance["Warband"][today] = nil
    end

    Utils:PrintDebug("Gold and currency balance saved.")
end

local function SlashCommand(msg, editbox)
    if not msg or msg:trim() == "" then
        Settings.OpenToCategory(AUR.MAIN_CATEGORY_ID)
    elseif msg:trim() == "overview" then
        Overview:Show()
	else
        Utils:PrintDebug("These arguments are not accepted.")
	end
end

--------------
--- Frames ---
--------------

local AurariumFrame = CreateFrame("Frame", "Aurarium")

---------------------
--- Main funtions ---
---------------------

function AurariumFrame:OnEvent(event, ...)
	self[event](self, event, ...)
end

function AurariumFrame:ADDON_LOADED(_, addOnName)
    if addOnName == addonName then
        Utils:InitializeDatabase()
        Utils:InitializeMinimapButton()
        Dialog:Initialize()
        Options:Initialize()
        Overview:Initialize()

        Utils:PrintDebug("Addon fully loaded.")
    end
end

function AurariumFrame:PLAYER_ENTERING_WORLD(_, isInitialLogin, isReloadingUi)
    Utils:PrintDebug("Event 'PLAYER_ENTERING_WORLD' fired. Payload: isInitialLogin=" .. tostring(isInitialLogin) .. ", isReloadingUi=" .. tostring(isReloadingUi))

    if (isInitialLogin or isReloadingUi) then
        C_Timer.After(5, function()
            SaveBalance()
        end)

        if AUR.data.options["open-on-login"]then
            Overview:Show()
        end
    end
end

function AurariumFrame:PLAYER_MONEY(...)
    Utils:PrintDebug("Event 'PLAYER_MONEY' fired. No payload.")

    SaveBalance()
end

function AurariumFrame:CURRENCY_DISPLAY_UPDATE(...)
    Utils:PrintDebug("Event 'CURRENCY_DISPLAY_UPDATE' fired. No payload.")

    SaveBalance()
end

AurariumFrame:RegisterEvent("ADDON_LOADED")
AurariumFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
AurariumFrame:RegisterEvent("PLAYER_MONEY")
AurariumFrame:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
AurariumFrame:SetScript("OnEvent", AurariumFrame.OnEvent)

SLASH_Aurarium1, SLASH_Aurarium2 = '/aur', '/Aurarium'

SlashCmdList["Aurarium"] = SlashCommand
