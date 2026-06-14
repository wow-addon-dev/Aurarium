local addonName, AUR = ...

AUR.settings = AUR.settings or {}
AUR.data = AUR.data or {}
AUR.state = AUR.state or {}
AUR.modules = AUR.modules or {}

local AWL = ArcaneWizardLibrary

AWL:NewAddon(addonName, {
	debugEnabled = function()
		return AUR.settings.general and AUR.settings.general["debug-mode"]
	end
})
