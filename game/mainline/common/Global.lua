local addonName, AUR = ...

local L = AUR.localization

---------------------
--- Main Funtions ---
---------------------

function Aurarium_CompartmentOnEnter(self, button)
	GameTooltip:ClearAllPoints()
	GameTooltip:SetOwner(button, "ANCHOR_LEFT")

	GameTooltip_SetTitle(GameTooltip, addonName)
	GameTooltip_AddNormalLine(GameTooltip, AUR.ADDON_VERSION .. " (" .. AUR.ADDON_BUILD_DATE .. ")")
	GameTooltip_AddBlankLineToTooltip(GameTooltip)
	GameTooltip_AddHighlightLine(GameTooltip, L["minimap-button.tooltip"])

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
        Settings.OpenToCategory(AUR.MAIN_CATEGORY_ID)
    end
end
