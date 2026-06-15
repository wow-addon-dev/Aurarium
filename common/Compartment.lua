local addonName, AUR = ...

local AWL = ArcaneWizardLibrary
local Addon = AWL:GetAddon(addonName)

local L = AUR.Localization

local handlers = Addon:CreateCompartmentHandlers({
	tooltip = L["minimap-button.tooltip"],
	onLeftClick = function()
		if AUR.modules.Overview:IsShown() then
			AUR.modules.Overview:Hide()
		else
			AUR.modules.Overview:Show()
		end
	end
})

------------------------
--- Public Functions ---
------------------------

function Aurarium_CompartmentOnEnter(self, button)
	handlers.OnEnter(self, button)
end

function Aurarium_CompartmentOnLeave()
	handlers.OnLeave()
end

function Aurarium_CompartmentOnClick(self, button)
	handlers.OnClick(self, button)
end
