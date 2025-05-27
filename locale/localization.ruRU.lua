local _, AUR = ...

if GetLocale() ~= "ruRU" then return end

local L = AUR.localization

-- Generel

L["addon.version"] = "Версия"

-- Addon specific

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

L["tab.character"] = "Персонаж"
L["tab.warband"] = "Отряд"
L["tab.account"] = "Аккаунт"

L["button.next"] = "Вперёд"
L["button.prev"] = "Назад"

L["table.date"] = "Дата"
L["table.amount"] = "Количество"
L["table.difference"] = "Разница"
L["table.no-entries"] = "Нет записей за этот месяц."

L["minimap-button.tooltip"] = "|c%sЛКМ|r - открыть обзор золота и валюты.\n|c%sПКМ|r - открыть настройки."

-- Options

L["info.description"] = "Описание"
L["info.description.text"] = "Aurarium - это дополнение, которое дает подробную информацию о прогрессе состояния, отслеживая золото и валюту всех персонажей и отображая их с течением времени.\n\nЕсли Вы нашли ошибку или у Вас есть вопросы по аддону, то можете связаться со мной через Github или Curseforge. Вы также можете помочь мне с переводом через Github. Спасибо."

L["info.help"] = "Помощь"
L["info.help.text"] = "В случае возникновения проблем после обновления, Вы можете сбросить настройки здесь."
L["info.help.reset-button.name"] = "Сбросить параметры"
L["info.help.reset-button.desc"] = "Сбрасывает параметры на значения по умолчанию. Это касается всех персонажей."
L["info.help.github-button.name"] = "GitHub"
L["info.help.github-button.desc"] = "Открывает всплывающее окно со ссылкой на GitHub."
L["info.help.curseforge-button.name"] = "CurseForge"
L["info.help.curseforge-button.desc"] = "Открывает всплывающее окно со ссылкой на CurseForge."

L["info.about"] = "Об аддоне"
L["info.about.text"] = "|cffF2E699Версия игры:|r %s\n|cffF2E699Версия дополнения:|r %s\n\n|cffF2E699Автор:|r %s"

L["options"] = "Параметры"
L["options.general"] = "Общие параметры"
L["options.open-on-login.name"] = "Обзор золота и валюты"
L["options.open-on-login.tooltip"] = "Если эта функция включена, обзор золота и валюты открывается автоматически при входе в систему."
L["options.minimap-button-hide.name"] = "Кнопка миникарты"
L["options.minimap-button-hide.tooltip"] = "Если эта функция включена, отображается кнопка на миникарте."
L["options.minimap-button-position.name"] = "Положение"
L["options.minimap-button-position.tooltip"] = "Определяет положение кнопки миникарты."

L["options.other"] = "Другие параметры"
L["options.debug-mode.name"] = "Режим отладки"
L["options.debug-mode.tooltip"] = "Включение режима отладки отображает дополнительную информацию в чате."

-- Chat

L["chat.reset-options.success"] = "Параметры успешно сброшены."

-- Dialog

L["dialog.copy-address.text"] = "Чтобы скопировать ссылку, нажмите CTRL + C."
L["dialog.reset-options.text"] = "Вы действительно хотите сбросить настройки?"
