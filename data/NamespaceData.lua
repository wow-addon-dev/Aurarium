local addonName, AUR = ...

AUR.Settings = AUR.Settings or {}
AUR.Data = AUR.Data or {}
AUR.State = AUR.State or {}
AUR.Modules = AUR.Modules or {}

AUR.Modules.Options = AUR.Modules.Options or {}
AUR.Modules.Overview = AUR.Modules.Overview or {}
AUR.Modules.Utils = AUR.Modules.Utils or {}

local AWL = ArcaneWizardLibrary

AWL:NewAddon(addonName, {
	debugEnabled = function()
		return AUR.Settings.general and AUR.Settings.general["debug-mode"]
	end
})
