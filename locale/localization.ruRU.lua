local _, AUR = ...

if GetLocale() ~= "ruRU" then return end

local L = AUR.localization

-- Options

L["options.general"] = "Общие параметры"
L["options.general.minimap-button.name"] = "Кнопка миникарты"
L["options.general.minimap-button.tooltip"] = "При включении этой функции отображается кнопка миникарты."

L["options.currency-overview"] = "Обзор золота и валюты"
L["options.currency-overview.open-on-login.name"] = "Открывать автоматически"
L["options.currency-overview.open-on-login.tooltip"] = "При включении этой функции обзор золота и валюты будет автоматически открываться при входе в систему."

L["options.other"] = "Другие настройки"
L["options.other.debug-mode.name"] = "Режим отладки"
L["options.other.debug-mode.tooltip"] = "Включение режима отладки отображает дополнительную информацию в чате."

L["options.about"] = "Об аддоне"
L["options.about.game-version"] = "Версия игры"
L["options.about.addon-version"] = "Версия аддона"
L["options.about.lib-version"] = "Версия библиотеки"
L["options.about.author"] = "Автор"

L["options.about.button-github.name"] = "Обратная связь и помощь"
L["options.about.button-github.tooltip"] = "Открывает всплывающее окно со ссылкой на GitHub."
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
