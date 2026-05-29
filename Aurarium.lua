local addonName, AUR = ...

local Options = AUR.modules.Options
local Overview = AUR.modules.Overview
local Utils = AUR.modules.Utils

-----------------------
--- Local Functions ---
-----------------------

local function UpdateDateHistory(today)
	local dates = AUR.data.dates

	for _, d in ipairs(dates) do
		if d == today then return end
	end

	table.insert(dates, today)
	table.sort(dates)
end

local function SaveCharacterMetadata(realm, char)
	local classFilename = UnitClassBase("player")
	local englishFaction = UnitFactionGroup("player")

	AUR.data.character[realm][char] = {class = classFilename, faction = englishFaction}
end

local function TrackGoldBalance(realm, char, today)
	local characterHistory = AUR.data.balance[realm][char]
	AUR.data.balance[realm][char][today] = AUR.data.balance[realm][char][today] or {}

	local newGold = Utils:GetGold()
	local prevGold = 0
	local lastDate = nil

	for dateKey, dayData in pairs(characterHistory) do
		if dateKey < today and dayData["gold"] ~= nil and (not lastDate or dateKey > lastDate) then
			lastDate = dateKey
			prevGold = dayData["gold"]
		end
	end

	if newGold ~= prevGold then
		AUR.data.balance[realm][char][today]["gold"] = newGold
		return true
	else
		AUR.data.balance[realm][char][today]["gold"] = nil
		return false
	end
end

local function TrackCharacterCurrencies(realm, char, today)
	local characterHistory = AUR.data.balance[realm][char]
	local changed = false

	for _, currencies in pairs(AUR.CHARACTER_CURRENCIES) do
		for _, currencyID in ipairs(currencies) do
			local key = "c-" .. tostring(currencyID)
			local info = C_CurrencyInfo.GetCurrencyInfo(currencyID)

			if info then
				local newQty = info.quantity
				local prevQty = 0
				local lastDate = nil

				for dateKey, dayData in pairs(characterHistory) do
					if dateKey < today and dayData[key] ~= nil and (not lastDate or dateKey > lastDate) then
						lastDate = dateKey
						prevQty = dayData[key]
					end
				end

				if newQty ~= prevQty then
					AUR.data.balance[realm][char][today][key] = newQty
					changed = true
				else
					AUR.data.balance[realm][char][today][key] = nil
				end
			end
		end
	end

	return changed
end

local function TrackWarbandCurrencies(today)
	local warbandHistory = AUR.data.balance["Warband"]
	AUR.data.balance["Warband"][today] = AUR.data.balance["Warband"][today] or {}
	local changed = false

	for _, currencies in pairs(AUR.WARBAND_CURRENCIES) do
		for _, currencyID in ipairs(currencies) do
			local key = "w-" .. tostring(currencyID)
			local info = C_CurrencyInfo.GetCurrencyInfo(currencyID)
			local newQty = (info and info.quantity) or 0
			local prevQty = 0
			local lastDate = nil

			for dateKey, dayData in pairs(warbandHistory) do
				if dateKey < today and dayData[key] ~= nil and (not lastDate or dateKey > lastDate) then
					lastDate = dateKey
					prevQty = dayData[key]
				end
			end

			if newQty ~= prevQty then
				AUR.data.balance["Warband"][today][key] = newQty
				changed = true
			else
				AUR.data.balance["Warband"][today][key] = nil
			end
		end
	end

	return changed
end

local function SaveBalance()
	local realm, char = Utils:GetCharacterInfo()
	local today = Utils:GetToday()

	UpdateDateHistory(today)
	SaveCharacterMetadata(realm, char)

	if AUR.GAME_TYPE_MISTS then
		local goldChanged = TrackGoldBalance(realm, char, today)
		local charCurChanged = TrackCharacterCurrencies(realm, char, today)

		if not (goldChanged or charCurChanged) then
			AUR.data.balance[realm][char][today] = nil
		end
	elseif AUR.GAME_TYPE_MAINLINE then
		local goldChanged = TrackGoldBalance(realm, char, today)
		local charCurChanged = TrackCharacterCurrencies(realm, char, today)
		local warbandChanged = TrackWarbandCurrencies(today)

		if not (goldChanged or charCurChanged) then
			AUR.data.balance[realm][char][today] = nil
		end

		if not warbandChanged then
			AUR.data.balance["Warband"][today] = nil
		end
	else
		local goldChanged = TrackGoldBalance(realm, char, today)

		if not goldChanged then
			AUR.data.balance[realm][char][today] = nil
		end
	end

	Utils:PrintDebug("Balance saved.")
end

local function SlashCommand(msg, editbox)
	if not msg or strtrim(msg) == "" then
		if not InCombatLockdown() then
			Settings.OpenToCategory(AUR.MAIN_CATEGORY_ID)
		else
			Utils:PrintDebug("In combat. The options menu cannot be opened.")
		end
	elseif strtrim(msg) == "overview" then
		Overview:Show()
	else
		Utils:PrintDebug("These arguments are not accepted.")
	end
end

--------------
--- Frames ---
--------------

local AurariumFrame = CreateFrame("Frame", "Aurarium")

------------------------
--- Public Functions ---
------------------------

function AurariumFrame:OnEvent(event, ...)
	self[event](self, event, ...)
end

function AurariumFrame:ADDON_LOADED(_, addOnName)
	if addOnName == addonName then
		local dbInit = Utils:InitializeDatabase()
		Utils:InitializeMinimapButton()
		Options:Initialize()
		Overview:Initialize()

		Utils:OpenSettingsOnLoading()

		Utils:PrintDebug(string.format(
			"InitializeDatabase: key=%s, createdProfile=%s, createdProfileKey=%s, activeProfile=%s",
			tostring(dbInit.characterRealmKey), tostring(dbInit.createdProfile), tostring(dbInit.createdProfileKey), tostring(dbInit.activeProfile)
		))
		Utils:PrintDebug("Addon fully loaded.")
	end
end

function AurariumFrame:PLAYER_ENTERING_WORLD(_, isInitialLogin, isReloadingUi)
	Utils:PrintDebug(string.format(
		"Event 'PLAYER_ENTERING_WORLD' fired. Payload: isInitialLogin=%s, isReloadingUi=%s",
		tostring(isInitialLogin), tostring(isReloadingUi)
	))

	if (isInitialLogin or isReloadingUi) then
		C_Timer.After(5, function()
			SaveBalance()
		end)

		if AUR.settings.currencyOverview["open-on-login"] then
			Overview:Show()
		end
	end
end

function AurariumFrame:PLAYER_MONEY(...)
	Utils:PrintDebug("Event 'PLAYER_MONEY' fired. No payload.")

	SaveBalance()
end

function AurariumFrame:CURRENCY_DISPLAY_UPDATE(_, currencyType, quantity, quantityChange, quantityGainSource, quantityLostSource)
	Utils:PrintDebug(string.format(
		"Event 'CURRENCY_DISPLAY_UPDATE' fired. Payload: currencyType=%s, quantity=%s, quantityChange=%s, quantityGainSource=%s, quantityLostSource=%s",
		tostring(currencyType), tostring(quantity), tostring(quantityChange), tostring(quantityGainSource), tostring(quantityLostSource)
	))

	SaveBalance()
end

AurariumFrame:RegisterEvent("ADDON_LOADED")
AurariumFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
AurariumFrame:RegisterEvent("PLAYER_MONEY")
AurariumFrame:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
AurariumFrame:SetScript("OnEvent", AurariumFrame.OnEvent)

SLASH_Aurarium1, SLASH_Aurarium2 = '/aur', '/aurarium'

SlashCmdList["Aurarium"] = SlashCommand
