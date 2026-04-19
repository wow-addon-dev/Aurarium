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

-- Chat

-- Curyency Overview

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

L["currency-category.gold"] = "Золото"
L["currency-category.warband"] = "Валюты Отряда"
L["currency-category.character"] = "Валюты персонажа"
L["currency-category.misc"] = "Разное"
L["currency-category.pvp"] = "Игрок против игрока"
L["currency-category.dungeonraid"] = "Подземелье и рейд"
L["currency-category.season"] = "Сезон"
L["currency-category.timerunning"] = "Путешествие во времени"
L["currency-category.profession"] = "Profession"
L["currency-category.classic"] = "Classic"
L["currency-category.tbc"] = "Burning Crusade"
L["currency-category.wotlk"] = "Гнев Короля-лича"
L["currency-category.cata"] = "Катаклизм"
L["currency-category.mop"] = "Пандария"
L["currency-category.wod"] = "Дренор"
L["currency-category.legion"] = "Легион"
L["currency-category.bfa"] = "Битва за Азерот"
L["currency-category.sl"] = "Темные Земли"
L["currency-category.df"] = "Драконы"
L["currency-category.tww"] = "Война Внутри"
L["currency-category.mid"] = "Полночь"

L["tab.character"] = "Персонаж"
L["tab.account"] = "Аккаунт"
L["tab.warband"] = "Отряд"

L["button.next"] = "Вперёд"
L["button.prev"] = "Назад"

L["table.date"] = "Дата"
L["table.amount"] = "Количество"
L["table.difference"] = "Разница"
L["table.no-entries"] = "Нет записей за этот месяц."
