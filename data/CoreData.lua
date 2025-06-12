local addonName, AUR = ...

AUR.ADDON_AUTHOR = C_AddOns.GetAddOnMetadata(addonName, "Author")
AUR.ADDON_VERSION = C_AddOns.GetAddOnMetadata(addonName, "Version")
AUR.ADDON_BUILD_DATE = C_AddOns.GetAddOnMetadata(addonName, "X-BuildDate")

AUR.GAME_VERSION = GetBuildInfo()
AUR.GAME_FLAVOR = C_AddOns.GetAddOnMetadata(addonName, "X-Flavor")

AUR.LINK_GITHUB = C_AddOns.GetAddOnMetadata(addonName, "X-Github")
AUR.LINK_CURSEFORGE = C_AddOns.GetAddOnMetadata(addonName, "X-Curseforge")
AUR.LINK_WAGO = C_AddOns.GetAddOnMetadata(addonName, "X-Wago")

AUR.NORMAL_FONT_COLOR = "ffFFD200"      -- #1
AUR.WHITE_FONT_COLOR = "ffFFFFFF"       -- #2
AUR.ORANGE_FONT_COLOR = "ffFF8040"      -- 13
AUR.GOLD_FONT_COLOR = "ffF2E699"        -- #22
AUR.LINK_FONT_COLOR = "ff66BBFF"        -- #36

AUR.MEDIA_PATH = "Interface\\AddOns\\" .. addonName .. "\\media\\"
