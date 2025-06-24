local _, AUR = ...

local L =  AUR.localization

local Dialog = {}

--------------
--- Frames ---
--------------

local copyAddressDialog
local resetOptionsDialog

---------------------
--- Main Funtions ---
---------------------

function Dialog:Initialize()
    copyAddressDialog = CreateFrame("Frame", "Aurarium_CopyAdressDialog", UIParent, "Aurarium_CopyAdressDialogTemplate")
	resetOptionsDialog = CreateFrame("Frame", "Aurarium_ResetOptionsDialog", UIParent, "Aurarium_ResetOptionsDialogTemplate")
end

function Dialog:ShowCopyAddressDialog(address)
    if (not copyAddressDialog:IsShown()) and (not resetOptionsDialog:IsShown()) then
        copyAddressDialog:ShowDialog(address)
    end
end

function Dialog:ShowResetOptionsDialog()
    if (not copyAddressDialog:IsShown()) and (not resetOptionsDialog:IsShown()) then
        resetOptionsDialog:ShowDialog()
    end
end

AUR.dialog = Dialog
