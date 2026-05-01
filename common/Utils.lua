local addonName, AUR = ...

local L = AUR.localization

local Utils = {}

----------------------
--- Local Funtions ---
----------------------

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
    if AUR.options.other["debug-mode"] then
		DEFAULT_CHAT_FRAME:AddMessage(ORANGE_FONT_COLOR:WrapTextInColorCode(addonName .. " (Debug): ")  .. msg)
	end
end

function Utils:PrintMessage(msg)
    DEFAULT_CHAT_FRAME:AddMessage(NORMAL_FONT_COLOR:WrapTextInColorCode(addonName .. ": ") .. msg)
end

function Utils:InitializeDatabase()
    local realm, char = Utils:GetCharacterInfo()

    if (not Aurarium_Options_v2) then
        Aurarium_Options_v2 = {
			["general"] = {
				["minimap-button"] = {
					["hide"] = false
				}
			},
			["currency-overview"] = {},
			["other"] = {}
		}
    end

    if (not Aurarium_DataDates) then
       Aurarium_DataDates = {}
    end

    if (not Aurarium_DataCharacter) then
        Aurarium_DataCharacter = {}
    end

	if (not Aurarium_DataBalance) then
        Aurarium_DataBalance = {}
    end

	AUR.options = {}
	AUR.options.general = Aurarium_Options_v2["general"]
    AUR.options.currencyOverview = Aurarium_Options_v2["currency-overview"]
	AUR.options.other = Aurarium_Options_v2["other"]

    AUR.data = {}
    AUR.data.dates = Aurarium_DataDates
    AUR.data.character = Aurarium_DataCharacter
	AUR.data.balance = Aurarium_DataBalance

    AUR.data.character[realm] =  AUR.data.character[realm] or {}
    AUR.data.character[realm][char] =  AUR.data.character[realm][char] or {}

    AUR.data.balance =  AUR.data.balance or {}
    AUR.data.balance[realm] =  AUR.data.balance[realm] or {}
    AUR.data.balance[realm][char] =  AUR.data.balance[realm][char] or {}

	if AUR.GAME_TYPE_MAINLINE then
		AUR.data.balance["Warband"] = AUR.data.balance["Warband"] or {}
	end
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
				if not InCombatLockdown() then
					Settings.OpenToCategory(AUR.MAIN_CATEGORY_ID)
				else
					Utils:PrintDebug("In combat. The options menu cannot be opened.")
				end
            end
        end,
        OnTooltipShow = function(tooltip)
			GameTooltip_SetTitle(tooltip, addonName)
			GameTooltip_AddNormalLine(tooltip, AUR.ADDON_VERSION .. " (" .. AUR.ADDON_BUILD_DATE .. ")")
			GameTooltip_AddBlankLineToTooltip(tooltip)
			GameTooltip_AddHighlightLine(tooltip, L["minimap-button.tooltip"])
        end,
    })

    self.minimapButton = LibStub("LibDBIcon-1.0")
    self.minimapButton:Register("Aurarium", LDB, AUR.options.general["minimap-button"])
end

AUR.utils = Utils
