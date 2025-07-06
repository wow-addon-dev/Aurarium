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

    local characterHistory  = AUR.data.balance[realm][char]

    AUR.data.balance[realm][char][today] = AUR.data.balance[realm][char][today] or {}

    local newGold  = Utils:GetGold()
    local prevGold = 0

    local lastDate = nil
    local isChangedChar = false

    for dateKey, dayData in pairs(characterHistory) do
        if dateKey < today and dayData["gold"] ~= nil and (not lastDate or dateKey > lastDate) then
            lastDate = dateKey
            prevGold = dayData["gold"]
        end
    end

    if newGold ~= prevGold then
        isChangedChar = true
        AUR.data.balance[realm][char][today]["gold"] = newGold
    else
        AUR.data.balance[realm][char][today]["gold"] = nil
    end

    if not isChangedChar then
        AUR.data.balance[realm][char][today] = nil
    end

    Utils:PrintDebug("Gold balance saved.")
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

AurariumFrame:RegisterEvent("ADDON_LOADED")
AurariumFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
AurariumFrame:RegisterEvent("PLAYER_MONEY")
AurariumFrame:SetScript("OnEvent", AurariumFrame.OnEvent)

SLASH_Aurarium1, SLASH_Aurarium2 = '/aur', '/Aurarium'

SlashCmdList["Aurarium"] = SlashCommand
