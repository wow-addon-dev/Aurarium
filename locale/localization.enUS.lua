local _, AUR = ...

AUR.localization = setmetatable({},{__index=function(self,key)
        geterrorhandler()("Aurarium (Debug): Missing entry for '" .. tostring(key) .. "'")
        return key
    end})

local L = AUR.localization

-- Options

L["options.general"] = "General Options"
L["options.general.minimap-button.name"] = "Minimap Button"
L["options.general.minimap-button.tooltip"] = "When this is enabled, the minimap button is displayed."

L["options.currency-overview"] = "Gold and Currency Overview"
L["options.currency-overview.open-on-login.name"] = "Open Automatically"
L["options.currency-overview.open-on-login.tooltip"] = "When this is enabled, the gold and currency overview opens automatically when logging in."

L["options.other"] = "Other Options"
L["options.other.debug-mode.name"] = "Debug Mode"
L["options.other.debug-mode.tooltip"] = "Enabling the debug mode displays additional information in the chat."

L["options.about"] = "About"
L["options.about.game-version"] = "Game Version"
L["options.about.addon-version"] = "Addon Version"
L["options.about.lib-version"] = "Library Version"
L["options.about.author"] = "Author"

L["options.about.button-github.name"] = "Feedback & Help"
L["options.about.button-github.tooltip"] = "Opens a popup window with a link to GitHub."
L["options.about.button-github.button"] = "GitHub"

-- General

L["minimap-button.tooltip"] = "|cnLINK_FONT_COLOR:Left-click|r to open the gold and currency overview.\n|cnLINK_FONT_COLOR:Right-click|r to open the options."

-- Chat

-- Curyency Overview

L["month.jan"] = "January"
L["month.feb"] = "February"
L["month.mar"] = "March"
L["month.apr"] = "April"
L["month.may"] = "May"
L["month.jun"] = "June"
L["month.jul"] = "July"
L["month.aug"] = "August"
L["month.sep"] = "September"
L["month.oct"] = "October"
L["month.nov"] = "November"
L["month.dec"] = "December"

L["currency-category.gold"] = "Gold"
L["currency-category.warband"] = "Warband Currencies"
L["currency-category.character"] = "Character Currencies"
L["currency-category.misc"] = "Miscellaneous"
L["currency-category.pvp"] = "Player vs. Player"
L["currency-category.dungeonraid"] = "Dungeon and Raid"
L["currency-category.season"] = "Season"
L["currency-category.timerunning"] = "Timerunning"
L["currency-category.profession"] = "Profession"
L["currency-category.classic"] = "Classic"
L["currency-category.tbc"] = "Burning Crusade"
L["currency-category.wotlk"] = "Wrath of the Lich King"
L["currency-category.cata"] = "Cataclysm"
L["currency-category.mop"] = "Mists of Pandaria"
L["currency-category.wod"] = "Warlords of Draenor"
L["currency-category.legion"] = "Legion"
L["currency-category.bfa"] = "Battle for Azeroth"
L["currency-category.sl"] = "Shadowlands"
L["currency-category.df"] = "Dragonflight"
L["currency-category.tww"] = "The War Within"
L["currency-category.mid"] = "Midnight"

L["tab.character"] = "Character"
L["tab.account"] = "Account"
L["tab.warband"] = "Warband"

L["button.next"] = "Next"
L["button.prev"] = "Previous"

L["table.date"] = "Date"
L["table.amount"] = "Amount"
L["table.difference"] = "Difference"
L["table.no-entries"] = "No entries for this month."
