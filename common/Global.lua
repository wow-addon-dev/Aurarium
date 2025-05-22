local addonName, AUR = ...

local L = AUR.localization

---------------------
--- Main Funtions ---
---------------------

function Aurarium_CompartmentOnEnter(self, button)
	GameTooltip:ClearLines()
	GameTooltip:SetOwner(type(self) ~= "string" and self or button, "ANCHOR_LEFT")
    GameTooltip:SetText(addonName)
    GameTooltip:AddLine(WrapTextInColorCode(AUR.ADDON_VERSION .. " (" .. AUR.ADDON_BUILD_DATE .. ")", AUR.WHITE_FONT_COLOR))
    GameTooltip:AddLine(" ")
    GameTooltip:AddLine(L["minimap-button.tooltip"]:format(AUR.LINK_FONT_COLOR, AUR.LINK_FONT_COLOR), 1, 1, 1)
	GameTooltip:Show()
end

function Aurarium_CompartmentOnLeave()
    GameTooltip:Hide()
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