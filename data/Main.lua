local addonName, GCT = ...

GCT.ADDON_AUTHOR = C_AddOns.GetAddOnMetadata(addonName, "Author")
GCT.ADDON_VERSION = C_AddOns.GetAddOnMetadata(addonName, "Version")
GCT.ADDON_BUILD_DATE = C_AddOns.GetAddOnMetadata(addonName, "X-BuildDate")

GCT.GAME_VERSION = GetBuildInfo()
GCT.GAME_FLAVOR = C_AddOns.GetAddOnMetadata(addonName, "X-Flavor")

GCT.LINK_GITHUB = C_AddOns.GetAddOnMetadata(addonName, "X-Github")
GCT.LINK_CURSEFORGE = C_AddOns.GetAddOnMetadata(addonName, "X-Curseforge")

GCT.NORMAL_FONT_COLOR = "ffFFD200"      -- #1
GCT.WHITE_FONT_COLOR = "ffFFFFFF"       -- #2
GCT.ORANGE_FONT_COLOR = "ffFF8040"      -- 13
GCT.GOLD_FONT_COLOR = "ffF2E699"        -- #22
GCT.LINK_FONT_COLOR = "ff66BBFF"        -- #36

GCT.MEDIA_PATH = "Interface\\AddOns\\" .. addonName .. "\\media\\"

GCT.MONTH_KEYS = {
    "month.jan", "month.feb", "month.mar", "month.apr", "month.may", "month.jun",
    "month.jul", "month.aug", "month.sep", "month.oct", "month.nov", "month.dec"
}

GCT.CURRENCY_CATEGORY_ORDER = {
    "misc",         -- 1
    "pvp",          -- 2
    "dungeonraid",  -- 22
    --"classic",      -- 4
    --"tbc",          -- 23
    --"wotlk",        -- 21
    --"cata",         -- 81
    --"mop",          -- 133
    --"wod",          -- 137
    --"legion",       -- 141
    --"bfa",          -- 143
    --"sl",           -- 245
    "df",           -- 250
    "tww"           -- 260
}

GCT.WARBAND_CURRENCIES = {
    misc = {
        2032,	-- Händlerdevisen     
    }
}

GCT.CHARACTER_CURRENCIES = {
    misc = {
        515,    -- Gewinnlos des Dunkelmond-Jahrmarkts
        2588	-- Abzeichen: Reiter v. Azeroth        
    },
    pvp = {
        391,    -- Belobigungsabzeichen von Tol Barad
        1602,	-- Eroberung
        2123,	-- Blutige Abzeichen
        1792	-- Ehre
    },
    dungeonraid = {
        1166	-- Zeitverzerrtes Abzeichen
    },
    df = {
        2003,	-- Vorräte der Dracheninseln
        2118,	-- Elementarüberfluss
        2122,	-- Sturmsiegel
        2594,	-- Parakausale Flocken
        2650,	-- Smaragdgrüner Tautropfen
        2657,	-- Mysteriöses Fragment
        2777,	-- Trauminfusion
    },
    tww = {
        2815,	-- Resonanzkristalle
        3055,	-- Angelfestabzeichen von Mereldar
        3056,	-- Kej
        3090,	-- Flammengesegnetes Eisen
        3149,	-- Versetzte verderbte Andenken
        3218,   -- Leere Kaja'Cola-Dose
        3220,   -- Altertümliche Kaja'Cola-Dose
        3226	-- Marktforschung
    }
}
