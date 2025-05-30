local _, AUR = ...

AUR.localization = setmetatable({},{__index=function(self,key)
        geterrorhandler()("Aurarium (Debug): Missing entry for '" .. tostring(key) .. "'")
        return key
    end})

local L = AUR.localization

-- Generel

L["addon.version"] = "Version"

-- Addon specific

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

L["tab.character"] = "Character"
L["tab.warband"] = "Warband"
L["tab.account"] = "Account"

L["button.next"] = "Next"
L["button.prev"] = "Previous"

L["table.date"] = "Date"
L["table.amount"] = "Amount"
L["table.difference"] = "Difference"
L["table.no-entries"] = "No entries for this month."

L["minimap-button.tooltip"] = "|c%sLeft-click|r to open the gold and currency overview.\n|c%sRight-click|r to open the options."

-- Options

L["info.description"] = "Description"
L["info.description.text"] = "Aurarium is an addon that provides a detailed insight into wealth progression by tracking gold and currencies across all characters and displaying them over time.\n\nIf you find a bug or have questions about the addon, you can contact me via GitHub. You can also help me with the translation via GitHub. Thank you."

L["info.help"] = "Help"
L["info.help.text"] = "In case of problems after an update or if you want to, you can reset the options here."
L["info.help.reset-button.name"] = "Reset Options"
L["info.help.reset-button.desc"] = "Resets the options to the default values. This applies to all characters."
L["info.help.github-button.name"] = "GitHub"
L["info.help.github-button.desc"] = "Opens a popup window with a link to GitHub."

L["info.about"] = "About"
L["info.about.text"] = "|cffF2E699Game version:|r %s\n|cffF2E699Addon version:|r %s\n\n|cffF2E699Author:|r %s"

L["options"] = "Options"
L["options.general"] = "General Options"
L["options.open-on-login.name"] = "Gold and Currency Overview"
L["options.open-on-login.tooltip"] = "When this is enabled, the gold and currency overview opens automatically when logging in."
L["options.minimap-button-hide.name"] = "Minimap Button"
L["options.minimap-button-hide.tooltip"] = "When this is enabled, the minimap button is displayed."
L["options.minimap-button-position.name"] = "Position"
L["options.minimap-button-position.tooltip"] = "Determines the position of the minimap button."

L["options.other"] = "Other Options"
L["options.debug-mode.name"] = "Debug Mode"
L["options.debug-mode.tooltip"] = "Enabling the debug mode displays additional information in the chat."

-- Chat

L["chat.reset-options.success"] = "Options successfully reseted."

-- Dialog

L["dialog.copy-address.text"] = "To copy the link press CTRL + C."
L["dialog.reset-options.text"] = "Do you really want to reset the options?"
