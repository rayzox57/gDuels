--[[
	Script: gDuel-System
	Version: 0.2
	Created by DidVaitel
]]

TOOL.Category           = "gDuel-sys"
TOOL.Name               = gDuel.Translate("DuelToolNameGlobal")
TOOL.Command            = nil
TOOL.CurArena           = 1
TOOL.Setuped 			= false
TOOL.PointsToDraw   	= {}
if SERVER then
	function TOOL:LeftClick(trace)
		if !self:GetOwner():IsSuperAdmin() then
			sendMessageToPlayer(self:GetOwner(), gDuel.Translate("YouDontHaveRights!"))	
			return
		end
	    if(gDuel.Arenas[game.GetMap()][self.CurArena] == nil) and self.Setuped == false then
	        gDuel.Arenas[game.GetMap()][self.CurArena] = {}
	        gDuel.Arenas[game.GetMap()][self.CurArena].pos1 = trace.HitPos
	        sendMessageToPlayer(self:GetOwner(), gDuel.Translate("FirstPoint"))
	        self.Setuped = true

	        local pointsToDraw = {}
	    	for k, v in pairs(gDuel.Arenas[game.GetMap()]) do
	    		table.insert(pointsToDraw, v.pos1)
	    		table.insert(pointsToDraw, v.pos2)
			end
	    	net.Start("gDuel.UpdatePointsToDraw")
	    		net.WriteTable(pointsToDraw)
	    	net.Send(self:GetOwner())
	    elseif self.Setuped == true then
	    	sendMessageToPlayer(self:GetOwner(), gDuel.Translate("DuelToolSetFirstPointalready"))
	    elseif (gDuel.Arenas[game.GetMap()][self.CurArena] != nil) and self.Setuped == false then
	    	sendMessageToPlayer(self:GetOwner(), gDuel.Translate("RemoveAllPoints"))
	    end
	    return true
	end

	function TOOL:RightClick(trace)
		if !self:GetOwner():IsSuperAdmin() then
			sendMessageToPlayer(self:GetOwner(), gDuel.Translate("YouDontHaveRights!"))	
			return
		end
	    if self.Setuped == true then
	        gDuel.Arenas[game.GetMap()][self.CurArena].pos2 = trace.HitPos 
	        gDuel.Arenas[game.GetMap()][self.CurArena].available = true
	        self.Setuped = false
	        self.CurArena = self.CurArena + 1
	        
	    	local pointsToDraw = {}
	    	for k, v in pairs(gDuel.Arenas[game.GetMap()]) do
	    		table.insert(pointsToDraw, v.pos1)
	    		table.insert(pointsToDraw, v.pos2)
			end
	    	net.Start("gDuel.UpdatePointsToDraw")
	    		net.WriteTable(pointsToDraw)
	    	net.Send(self:GetOwner())
	    	sendMessageToPlayer(self:GetOwner(), gDuel.Translate("SecondPoint"))
		    local t = util.TableToJSON(gDuel.Arenas)
		    file.CreateDir("gduel")
		    file.Write("gduel/arenas.txt", t)
	    else
	        sendMessageToPlayer(self:GetOwner(), gDuel.Translate("DuelToolSetFirstPoint"))
	    end
	    return true
	end
end

function TOOL:Reload()
	if !self:GetOwner():IsSuperAdmin() then
		if SERVER then
			sendMessageToPlayer(self:GetOwner(), gDuel.Translate("YouDontHaveRights!"))	
		end		
		return
	end
	self.CurArena = 1
	self.Setuped = false
	self.PointsToDraw = {}
	gDuel.Arenas = {}
	gDuel.Arenas[game.GetMap()] = {}
	if SERVER then
		gDuel.Arenas = {}
		sendMessageToPlayer(self:GetOwner(), gDuel.Translate("PointsCleared"))
	end
end

function TOOL:Deploy()
	if !self:GetOwner():IsSuperAdmin() then
		if SERVER then
			sendMessageToPlayer(self:GetOwner(), gDuel.Translate("YouDontHaveRights!"))	
		end		
		return
	end
	if(gDuel.Arenas == nil) then
		gDuel.Arenas = {}
	end
	if(gDuel.Arenas[game.GetMap()] == nil or gDuel.Arenas[game.GetMap()] == {}) then
	    gDuel.Arenas[game.GetMap()] = {}
	    gDuel.Arenas[game.GetMap()][self.CurArena] = {}
	end
end

function TOOL:DrawHUD()
	net.Receive("gDuel.UpdatePointsToDraw", function()
		self.PointsToDraw = net.ReadTable()
	end)

	if(gDuel.Arenas != nil and gDuel.Arenas[game.GetMap()] != nil) then
		cam.Start3D()
		for k, v in pairs(self.PointsToDraw) do
			render.DrawLine( v - Vector(0, 0, 5), v + Vector(0, 0, 5), Color( 255, 0, 0 ), true )
			render.DrawLine( v - Vector(0, 5, 0), v + Vector(0, 5, 0), Color( 255, 0, 0 ), true )
			render.DrawLine( v - Vector(5, 0, 0), v + Vector(5, 0, 0), Color( 255, 0, 0 ), true )
		end
		cam.End3D()
	end


end

if CLIENT then
    language.Add("Tool.duelpoints.name", gDuel.Translate("DuelToolName"))
    language.Add("Tool.duelpoints.desc", gDuel.Translate("DuelToolDesc"))
    language.Add("Tool.duelpoints.0", gDuel.Translate("DuelTool0"))
end