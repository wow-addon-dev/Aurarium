local addonName, AUR = ...

AUR.ADDON_AUTHOR = C_AddOns.GetAddOnMetadata(addonName, "Author")
AUR.ADDON_VERSION = C_AddOns.GetAddOnMetadata(addonName, "Version")
AUR.ADDON_BUILD_DATE = C_AddOns.GetAddOnMetadata(addonName, "X-BuildDate")

AUR.GAME_VERSION = GetBuildInfo()
AUR.GAME_FLAVOR = C_AddOns.GetAddOnMetadata(addonName, "X-Flavor")

AUR.LINK_GITHUB = C_AddOns.GetAddOnMetadata(addonName, "X-Github")
AUR.LINK_CURSEFORGE = C_AddOns.GetAddOnMetadata(addonName, "X-Curseforge")
AUR.LINK_WAGO = C_AddOns.GetAddOnMetadata(addonName, "X-Wago")

AUR.MEDIA_PATH = "Interface\\AddOns\\" .. addonName .. "\\media\\"
