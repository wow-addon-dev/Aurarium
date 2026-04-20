local _, AUR = ...

if GetLocale() ~= "ruRU" then return end

local L = AUR.localization

-- Options

L["options.general"] = "General Options"
L["options.general.minimap-button.name"] = "Minimap Button"
L["options.general.minimap-button.tooltip"] = "When this is enabled, the minimap button is displayed."

L["options.currency-overview"] = "Gold and Currency Overview"
L["options.currency-overview.open-on-login.name"] = "Open Automatically"
L["options.currency-overview.open-on-login.tooltip"] = "When this is enabled, the gold and currency overview opens automatically when logging in."

L["options.other.other"] = "Другие параметры"
L["options.other.debug-mode.name"] = "Режим отладки"
L["options.other.debug-mode.tooltip"] = "Включение режима отладки отображает дополнительную информацию в чате."

L["options.about"] = "Об аддоне"
L["options.about.game-version"] = "Game Version"
L["options.about.addon-version"] = "Addon Version"
L["options.about.lib-version"] = "Library Version"
L["options.about.author"] = "Author"

L["options.about.button-github.name"] = "Feedback & Help"
L["options.about.button-github.tooltip"] = "Opens a popup window with a link to GitHub."
L["options.about.button-github.button"] = "GitHub"

-- General

L["minimap-button.tooltip"] = "|cnLINK_FONT_COLOR:ЛКМ|r - открыть обзор золота и валюты.\n|cnLINK_FONT_COLOR:ПКМ|r - открыть настройки."

L["button.next"] = "Вперёд"
L["button.prev"] = "Назад"

L["month.jan"] = "Январь"
L["month.feb"] = "Февраль"
L["month.mar"] = "Март "
L["month.apr"] = "Апрель"
L["month.may"] = "Май"
L["month.jun"] = "Июнь"
L["month.jul"] = "Июль"
L["month.aug"] = "Август"
L["month.sep"] = "Сентябрь"
L["month.oct"] = "Октябрь"
L["month.nov"] = "Ноябрь"
L["month.dec"] = "Декабрь"

-- Chat

-- Curyency Overview

L["currency-overview.category.gold"] = "Золото"
L["currency-overview.category.warband"] = "Валюты Отряда"
L["currency-overview.category.character"] = "Валюты персонажа"
L["currency-overview.category.misc"] = "Разное"
L["currency-overview.category.pvp"] = "Игрок против игрока"
L["currency-overview.category.dungeonraid"] = "Подземелье и рейд"
L["currency-overview.category.season"] = "Сезон"
L["currency-overview.category.timerunning"] = "Путешествие во времени"
L["currency-overview.category.profession"] = "Profession"
L["currency-overview.category.classic"] = "Classic"
L["currency-overview.category.tbc"] = "Burning Crusade"
L["currency-overview.category.wotlk"] = "Гнев Короля-лича"
L["currency-overview.category.cata"] = "Катаклизм"
L["currency-overview.category.mop"] = "Пандария"
L["currency-overview.category.wod"] = "Дренор"
L["currency-overview.category.legion"] = "Легион"
L["currency-overview.category.bfa"] = "Битва за Азерот"
L["currency-overview.category.sl"] = "Темные Земли"
L["currency-overview.category.df"] = "Драконы"
L["currency-overview.category.tww"] = "Война Внутри"
L["currency-overview.category.mid"] = "Полночь"

L["currency-overview.tab.character"] = "Персонаж"
L["currency-overview.tab.account"] = "Аккаунт"
L["currency-overview.tab.warband"] = "Отряд"

L["currency-overview.table.date"] = "Дата"
L["currency-overview.table.amount"] = "Количество"
L["currency-overview.table.difference"] = "Разница"
L["currency-overview.table.no-entries"] = "Нет записей за этот месяц."
