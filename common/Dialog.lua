local _, AUR = ...

local L =  AUR.localization
local Utils = AUR.utils

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
    copyAddressDialog = CreateFrame("Frame", "AurariumCopyAdressDialog", UIParent, "AurariumCopyAdressDialogTemplate")
	resetOptionsDialog = CreateFrame("Frame", "AurariumResetOptionsDialog", UIParent, "AurariumResetOptionsDialogTemplate")
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
