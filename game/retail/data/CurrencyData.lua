local _, AUR = ...

AUR.CURRENCY_CATEGORY_ORDER = {
    "misc",         -- 1
    "pvp",          -- 2
    "dungeonraid",  -- 22
    --"classic",      -- 4
    --"tbc",          -- 23
    --"wotlk",        -- 21
    --"cata",         -- 81
    "mop",          -- 133
    "wod",          -- 137
    "legion",       -- 141
    "bfa",          -- 143
    "sl",           -- 245
    "df",           -- 250
    "tww"           -- 260
}

AUR.WARBAND_CURRENCIES = {
    misc = {
        2032,	-- Händlerdevisen
    }
}

AUR.CHARACTER_CURRENCIES = {
    misc = {
        515,    -- Gewinnlos des Dunkelmond-Jahrmarkts
        2588,	-- Abzeichen: Reiter v. Azeroth
		3309	-- Höllensteinscherbe
    },
    pvp = {
        391,    -- Belobigungsabzeichen von Tol Barad
        1602,	-- Eroberung
		1792,	-- Ehre
        2123	-- Blutige Abzeichen
    },
    dungeonraid = {
        1166	-- Zeitverzerrtes Abzeichen
    },
	mop = {
		738,	-- Geringes Amulett des Glücks
		777		-- Zeitlose Münze
	},
	wod = {
		823,	-- Apexiskristalle
		824,	-- Garnisonsressourcen
		1101	-- Öl
	},
	legion = {
		1149,    -- Blindes Auge
		1155,    -- Uraltes Mana
		1220,    -- Ordensressourcen
		1226,    -- Nethersplitter
		1275,    -- Kuriose Münze
		1342,    -- Kriegsvorräte der Legionsrichter
		1508,    -- Verschleierter Argunit
		1533	 -- Erweckende Essenz
	},
	bfa = {
		1299,	--Kämpfergold
		1560,	--Kriegsressourcen
		1710,	--Seefahrerdublone
		1717,	--Dienstmedaille der 7. Legion
		1719,	--Verderbte Andenken
		1721,	--Prismatische Manaperle
		1755,	--Manifestierte Visionen
		1803	--Echos aus Ny'alotha
	},
	sl = {
		1767,	--Stygia
		1813,	--Reservoiranima
		1816,	--Sündensteinfragmente
		1819,	--Medaillon des Dienstes
		1820,	--Durchfluteter Rubin
		1828,	--Seelenasche
		1885,	--Dankbare Gabe
		1906,	--Seelenglut
		1931,	--Katalogisierte Forschung
		1977,	--Stygische Glut
		1979,	--Chiffren der Ersten
		2009	--Kosmischer Flux
	},
    df = {
        2003,	-- Vorräte der Dracheninseln
        2118,	-- Elementarüberfluss
        2122,	-- Sturmsiegel
        2594,	-- Parakausale Flocken
        2650,	-- Smaragdgrüner Tautropfen
        2657,	-- Mysteriöses Fragmentp
        2777	-- Trauminfusion
    },
    tww = {
        2815,	-- Resonanzkristalle
        3055,	-- Angelfestabzeichen von Mereldar
        3056,	-- Kej
        3090,	-- Flammengesegnetes Eisen
        3149,	-- Versetzte verderbte Andenkena
        3218,   -- Leere Kaja'Cola-Dose
        3220,   -- Altertümliche Kaja'Cola-Dose
        3226	-- Marktforschung
    }
}
