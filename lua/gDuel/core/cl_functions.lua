--[[
	Script: gDuel-System
	Version: 0.2
	Created by DidVaitel
]]

surface.CreateFont("UiBolder", {
    size = 1000,
    weight = 800,
    antialias = true,
    shadow = false,
    font = "DermaLarge"})

local function ReceiveMessageFromServer()
local str = net.ReadString()
	chat.AddText( Color( 0, 178, 238 ), "[gDuels] ", Color( 255, 255, 255 ), str )
end
net.Receive("gDuel.SendMessage", ReceiveMessageFromServer)

local function DrawStart()
	dodo = CurTime() + 6
	local startTime = SysTime() + (dodo - CurTime())
	local played = false
	hook.Add("HUDPaint", "gDuel.DrawKombatStartTime", function()
		surface.SetTextColor(47, 79, 79)
		
		local diff = math.Clamp(startTime - SysTime(), 0, math.huge)
		local mul = 1 - math.Clamp((diff - 5) / 5, 0, 1)
		local rem = math.floor(diff)

		if rem == 0 then 
			rem = gDuel.Translate("GO")
			if played != true then
				surface.PlaySound("ambient/alarms/warningbell1.wav")
				local played = true
			end
			timer.Simple(0.7,function()
				hook.Remove("HUDPaint", "gDuel.DrawKombatStartTime")
			end)
		end
		
		surface.SetFont('UiBolder')
		
		local tw = surface.GetTextSize(rem)
		
		local x = 5 + mul * (((ScrW()) * 0.5) - 5)
		local x2 = (x + 0.5) - (tw * 0.5)
		local y = ScrH() * 0.44
				
		surface.SetTextPos(x2, y)
		surface.DrawText(rem)

	end)
end
net.Receive("gDuel.Animation", DrawStart)

