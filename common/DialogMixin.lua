local _, AUR = ...

local L = AUR.localization

AurariumCopyAdressDialogMixin = {}

function AurariumCopyAdressDialogMixin:OnLoad()
    self.Text:SetText(L["dialog.copy-address.text"])
	self:SetHeight(self:GetTop() - self.CloseButton:GetBottom() + 20)

    tinsert(UISpecialFrames, self:GetName())
end

function AurariumCopyAdressDialogMixin:ShowDialog(address)
    self.EditBox:SetText(address)
	self.EditBox:HighlightText()
    self:Show()
end

AurariumResetOptionsDialogMixin = {}

function AurariumResetOptionsDialogMixin:OnLoad()
	self.Text:SetText(L["dialog.reset-options.text"])
	self:SetHeight(self:GetTop() - self.NoButton:GetBottom() + 20)

    tinsert(UISpecialFrames, self:GetName())
end

function AurariumResetOptionsDialogMixin:ShowDialog()
    self:Show()
end
