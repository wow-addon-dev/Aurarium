local addonName, AUR = ...

local L = AUR.localization

local compartmentTooltip = CreateFrame("GameTooltip", "Aurarium_CompartmentTooltip", UIParent, "GameTooltipTemplate")

---------------------
--- Main Funtions ---
---------------------

function Aurarium_CompartmentOnEnter(self, button)
	compartmentTooltip:ClearLines()
	compartmentTooltip:SetOwner(type(self) ~= "string" and self or button, "ANCHOR_LEFT")
	compartmentTooltip:SetText(WHITE_FONT_COLOR:WrapTextInColorCode(addonName))
	compartmentTooltip:AddLine(AUR.ADDON_VERSION .. " (" .. AUR.ADDON_BUILD_DATE .. ")")
	compartmentTooltip:AddLine(" ")
	compartmentTooltip:AddLine(WHITE_FONT_COLOR:WrapTextInColorCode(L["minimap-button.tooltip"]))
	compartmentTooltip:Show()
end

function Aurarium_CompartmentOnLeave()
    compartmentTooltip:Hide()
end

function Aurarium_CompartmentOnClick(_, button)
    if button == "LeftButton" then
        if AUR.overview:IsShown() then
            AUR.overview:Hide()
        else
            AUR.overview:Show()
        end
    elseif button == "RightButton" then
        Settings.OpenToCategory("Aurarium")
    end
end
