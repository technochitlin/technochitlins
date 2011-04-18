local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales
-- This is the file for our action bars settings in game via mouseover buttons around action bars.
-- I really hope you'll understand the code, because I was totally drunk when I wrote this file.
-- At least, it work fine. :P (lol)

local function ShowOrHideBar(bar, button)
	local db = TukuiDataPerChar

	if button == TukuiBarBLButton or button == TukuiBarBRButton then
		if TukuiBarUpper:IsShown() then
			db.hidebar3 = true
			db.hidebar4 = true
			TukuiBarUpper:Hide()
		else
			db.hidebar3 = false
			db.hidebar4 = false
			TukuiBarUpper:Show()
		end
	end

	if button == TukuiBar5Button then
		if TukuiBar5:IsShown() then
			db.hidebar5 = true
			TukuiBar5:Hide()
		else
			db.hidebar5 = false
			TukuiBar5:Show()
		end
	end

end

local function MoveButtonBar(button, bar)
	local db = TukuiDataPerChar

	if button == TukuiBarBLButton or  button == TukuiBarBRButton then
		if TukuiBar3:IsShown() then
			TukuiBarBLButton.text:SetText("|cff4BAF4C-|r")
			TukuiBarBRButton.text:SetText("|cff4BAF4C-|r")
		else
			TukuiBarBLButton.text:SetText("|cff4BAF4C+|r")
			TukuiBarBRButton.text:SetText("|cff4BAF4C+|r")
		end
	end

	if button == TukuiBar5Button then
		if TukuiBar5:IsShown() then
			TukuiPetBar:ClearAllPoints()
			TukuiPetBar:Point("RIGHT", TukuiBar5, "LEFT", -6, 0)
		else
			TukuiPetBar:ClearAllPoints()
			TukuiPetBar:Point("RIGHT", UIParent, "RIGHT", -23, -14)
		end
	end

end

local function DrPepper(self, bar) -- guess what! :P
	-- yep, you cannot drink DrPepper while in combat. :(
	if InCombatLockdown() then print(ERR_NOT_IN_COMBAT) return end

	local button = self

	ShowOrHideBar(bar, button)
	MoveButtonBar(button, bar)
end

local TukuiBarBRButton = CreateFrame("Button", "TukuiBarBRButton", UIParent)
TukuiBarBRButton:SetWidth(17)
TukuiBarBRButton:Height(TukuiBar1:GetHeight())
TukuiBarBRButton:Point("BOTTOMLEFT", TukuiBarLower, "BOTTOMRIGHT", T.buttonspacing, 0)
TukuiBarBRButton:SetTemplate("Default")
TukuiBarBRButton:RegisterForClicks("AnyUp")
TukuiBarBRButton:SetAlpha(0)
TukuiBarBRButton:SetScript("OnClick", function(self) DrPepper(self, TukuiBar2) end)
TukuiBarBRButton:SetScript("OnEnter", function(self) self:SetAlpha(1) end)
TukuiBarBRButton:SetScript("OnLeave", function(self) self:SetAlpha(0) end)
TukuiBarBRButton.text = T.SetFontString(TukuiBarBRButton, C.media.uffont, 30)
TukuiBarBRButton.text:SetPoint("CENTER", 0, 0)
TukuiBarBRButton.text:SetText("|cff4BAF4C-|r")


local TukuiBarBLButton = CreateFrame("Button", "TukuiBarBLButton", UIParent)
TukuiBarBLButton:SetWidth(17)
TukuiBarBLButton:Height(TukuiBar1:GetHeight())
TukuiBarBLButton:Point("BOTTOMRIGHT", TukuiBarLower, "BOTTOMLEFT", -T.buttonspacing, 0)
TukuiBarBLButton:SetTemplate("Default")
TukuiBarBLButton:RegisterForClicks("AnyUp")
TukuiBarBLButton:SetAlpha(0)
TukuiBarBLButton:SetScript("OnClick", function(self) DrPepper(self, TukuiBar2) end)
TukuiBarBLButton:SetScript("OnEnter", function(self) self:SetAlpha(1) end)
TukuiBarBLButton:SetScript("OnLeave", function(self) self:SetAlpha(0) end)
TukuiBarBLButton.text = T.SetFontString(TukuiBarBLButton, C.media.uffont, 30)
TukuiBarBLButton.text:SetPoint("CENTER", 0, 0)
TukuiBarBLButton.text:SetText("|cff4BAF4C-|r")

local TukuiBar5Button = CreateFrame("Button", "TukuiBar5Button", UIParent)
TukuiBar5Button:Width(TukuiLineToPetActionBarBackground:GetWidth())
TukuiBar5Button:Height(TukuiLineToPetActionBarBackground:GetHeight())
TukuiBar5Button:Point("RIGHT", UIParent, "RIGHT", 2, -14)
TukuiBar5Button:SetTemplate("Default")
TukuiBar5Button:RegisterForClicks("AnyUp")
TukuiBar5Button:SetAlpha(0)
TukuiBar5Button:SetScript("OnClick", function(self) if self:GetAlpha() == 1 then DrPepper(self, TukuiBar5) end end)
TukuiBar5Button:SetScript("OnEnter", function(self) if InCombatLockdown() == nil then self:SetAlpha(1) end end)
TukuiBar5Button:SetScript("OnLeave", function(self) self:SetAlpha(0) end)
TukuiBar5Button.text = T.SetFontString(TukuiBar5Button, C.media.uffont, 30)
TukuiBar5Button.text:SetPoint("CENTER", 0, 0)
TukuiBar5Button.text:SetText("<")

-- exit vehicle button on left side of bottom action bar
local vehicleleft = CreateFrame("Button", "TukuiExitVehicleButtonLeft", UIParent, "SecureHandlerClickTemplate")
vehicleleft:SetAllPoints(TukuiBarBLButton)
vehicleleft:SetFrameStrata(TukuiBarBLButton:GetFrameStrata())
vehicleleft:SetFrameLevel(TukuiBarBLButton:GetFrameLevel() + 1)
vehicleleft:SetTemplate("Default")
vehicleleft:SetBackdropBorderColor(75/255,  175/255, 76/255)
vehicleleft:RegisterForClicks("AnyUp")
vehicleleft:SetScript("OnClick", function() VehicleExit() end)
vehicleleft.text = T.SetFontString(vehicleleft, C.media.uffont, 20)
vehicleleft.text:SetPoint("CENTER", T.Scale(1), T.Scale(1))
vehicleleft.text:SetText("|cff4BAF4CV|r")
RegisterStateDriver(vehicleleft, "visibility", "[target=vehicle,exists] show;hide")

-- exit vehicle button on right side of bottom action bar
local vehicleright = CreateFrame("Button", "TukuiExitVehicleButtonRight", UIParent, "SecureHandlerClickTemplate")
vehicleright:SetAllPoints(TukuiBarBRButton)
vehicleright:SetFrameStrata(TukuiBarBRButton:GetFrameStrata())
vehicleright:SetFrameLevel(TukuiBarBRButton:GetFrameLevel() + 1)
vehicleright:SetTemplate("Default")
vehicleright:SetBackdropBorderColor(75/255,  175/255, 76/255)
vehicleright:RegisterForClicks("AnyUp")
vehicleright:SetScript("OnClick", function() VehicleExit() end)
vehicleright.text = T.SetFontString(vehicleright, C.media.uffont, 20)
vehicleright.text:SetPoint("CENTER", T.Scale(1), T.Scale(1))
vehicleright.text:SetText("|cff4BAF4CV|r")
RegisterStateDriver(vehicleright, "visibility", "[target=vehicle,exists] show;hide")

--------------------------------------------------------------
-- DrPepper taste is really good with Vodka.
--------------------------------------------------------------

local init = CreateFrame("Frame")
init:RegisterEvent("VARIABLES_LOADED")
init:SetScript("OnEvent", function(self, event)
	if not TukuiDataPerChar then TukuiDataPerChar = {} end
	local db = TukuiDataPerChar

	if db.hidebar3 or db.hidebar4 then
		DrPepper(TukuiBarBLButton, TukuiBar3)
	end

	if db.hidebar5 then
		DrPepper(TukuiBar5Button, TukuiBar5)
	end
end)