local _, AUR = ...

local L = AUR.localization

Aurarium_CopyAdressDialogMixin = {}

function Aurarium_CopyAdressDialogMixin:OnLoad()
    self.Text:SetText(L["dialog.copy-address.text"])
	self:SetHeight(self:GetTop() - self.CloseButton:GetBottom() + 20)

    tinsert(UISpecialFrames, self:GetName())
end

function Aurarium_CopyAdressDialogMixin:ShowDialog(address)
    self.EditBox:SetText(address)
	self.EditBox:HighlightText()
    self:Show()
end

Aurarium_ResetOptionsDialogMixin = {}

function Aurarium_ResetOptionsDialogMixin:OnLoad()
	self.Text:SetText(L["dialog.reset-options.text"])
	self:SetHeight(self:GetTop() - self.NoButton:GetBottom() + 20)

    tinsert(UISpecialFrames, self:GetName())
end

function Aurarium_ResetOptionsDialogMixin:ShowDialog()
    self:Show()
end
