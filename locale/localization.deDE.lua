local _, AUR = ...

if GetLocale() ~= "deDE" then return end

local L = AUR.localization

-- Options

L["options.general"] = "Allgemeine Einstellungen"
L["options.general.minimap-button.name"] = "Minimap Button"
L["options.general.minimap-button.tooltip"] = "Bei Aktivierung wird der Minimap Button angezeigt."

L["options.currency-overview"] = "Gold- und Währungsübersicht"
L["options.currency-overview.open-on-login.name"] = "Automatisch öffnen"
L["options.currency-overview.open-on-login.tooltip"] = "Bei Aktivierung öffnet sich die Gold- und Währungsübersicht beim Login automatisch."

L["options.other"] = "Sonstige Einstellungen"
L["options.other.debug-mode.name"] = "Debugmodus"
L["options.other.debug-mode.tooltip"] = "Die Aktivierung des Debugmodus zeigt zusätzliche Informationen im Chat an."

L["options.about"] = "Über"
L["options.about.game-version"] = "Spielversion"
L["options.about.addon-version"] = "Addonversion"
L["options.about.lib-version"] = "Bibliotheksversion"
L["options.about.author"] = "Autor"

L["options.about.button-github.name"] = "Feedback & Hilfe"
L["options.about.button-github.tooltip"] = "Öffnet ein Popup-Fenster mit einem Link nach GitHub."
L["options.about.button-github.button"] = "GitHub"

-- General

L["minimap-button.tooltip"] = "|cnLINK_FONT_COLOR:Linksklick|r zum Öffnen der Gold- und Währungsübersicht.\n|cnLINK_FONT_COLOR:Rechtsklick|r zum Öffnen der Einstellungen."

-- Chat

-- Currency Overview

L["month.jan"] = "Januar"
L["month.feb"] = "Februar"
L["month.mar"] = "März"
L["month.apr"] = "April"
L["month.may"] = "Mai"
L["month.jun"] = "Juni"
L["month.jul"] = "Juli"
L["month.aug"] = "August"
L["month.sep"] = "September"
L["month.oct"] = "Oktober"
L["month.nov"] = "November"
L["month.dec"] = "Dezember"

L["currency-category.gold"] = "Gold"
L["currency-category.warband"] = "Kriegsmeutewährungen"
L["currency-category.character"] = "Charakterwährungen"
L["currency-category.misc"] = "Verschiedenes"
L["currency-category.pvp"] = "Spieler gegen Spieler"
L["currency-category.dungeonraid"] = "Dungeon und Schlachtzug"
L["currency-category.season"] = "Saison"
L["currency-category.timerunning"] = "Zeitläufer"
L["currency-category.profession"] = "Beruf"
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

L["tab.character"] = "Charakter"
L["tab.account"] = "Account"
L["tab.warband"] = "Kriegsmeute"

L["button.next"] = "Weiter"
L["button.prev"] = "Zurück"

L["table.date"] = "Datum"
L["table.amount"] = "Betrag"
L["table.difference"] = "Differenz"
L["table.no-entries"] = "Keine Einträge für diesen Monat."
