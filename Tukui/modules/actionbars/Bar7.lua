local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales
if not C["actionbar"].enable == true or not T.lowversion then return end

local bar = TukuiBar7
bar:SetAlpha(1)
MultiBarBottomRight:SetParent(bar)
