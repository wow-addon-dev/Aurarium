local addonName, AUR = ...

AUR.ADDON_AUTHOR = C_AddOns.GetAddOnMetadata(addonName, "Author")
AUR.ADDON_VERSION = C_AddOns.GetAddOnMetadata(addonName, "Version")
AUR.ADDON_BUILD_DATE = C_AddOns.GetAddOnMetadata(addonName, "X-BuildDate")

AUR.GAME_VERSION = GetBuildInfo()

AUR.LINK_GITHUB = C_AddOns.GetAddOnMetadata(addonName, "X-Github")
AUR.LINK_CURSEFORGE = C_AddOns.GetAddOnMetadata(addonName, "X-Curseforge")

AUR.MEDIA_PATH = "Interface\\AddOns\\" .. addonName .. "\\assets\\"

AUR.GAME_TYPE_VANILLA = (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC)
AUR.GAME_TYPE_TBC = (WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC)
---@diagnostic disable-next-line: undefined-global
AUR.GAME_TYPE_MISTS = (WOW_PROJECT_ID == WOW_PROJECT_MISTS_CLASSIC)
AUR.GAME_TYPE_MAINLINE = (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE)

AUR.GAME_FLAVOR = "unknown"

if AUR.GAME_TYPE_VANILLA then
	AUR.GAME_FLAVOR = "Classic"
elseif AUR.GAME_TYPE_TBC then
	AUR.GAME_FLAVOR = "Burning Crusade - Classic Anniversary Edition"
elseif AUR.GAME_TYPE_MISTS then
	AUR.GAME_FLAVOR = "Mist of Pandaria - Classic"
elseif AUR.GAME_TYPE_MAINLINE then
	AUR.GAME_FLAVOR = "Retail"
end
