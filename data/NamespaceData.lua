local addonName, AUR = ...

AUR.Settings = AUR.Settings or {}
AUR.Data = AUR.Data or {}
AUR.State = AUR.State or {}
AUR.Modules = AUR.Modules or {}

local AWL = ArcaneWizardLibrary

AWL:NewAddon(addonName, {
	debugEnabled = function()
		return AUR.Settings.general and AUR.Settings.general["debug-mode"]
	end
})
