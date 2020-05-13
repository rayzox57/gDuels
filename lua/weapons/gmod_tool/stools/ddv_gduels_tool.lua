--[[
	Created by DidVaitel (http://steamcommunity.com/profiles/76561198108670811)
]]

TOOL.Category		= "DidVaitel Tools"
TOOL.Name			= "gDuels Arena Creator"

if CLIENT then
	language.Add( "Tool.ddv_gduels_tool.name", gDuel.Translate("DuelToolName") );
	language.Add( "Tool.ddv_gduels_tool.desc", gDuel.Translate("DuelToolDesc") );
	language.Add( "Tool.ddv_gduels_tool.0", gDuel.Translate("DuelTool0") );
end;


TOOL.CurArena           = 1
TOOL.PointsToDraw   	= {}

function TOOL:LeftClick( Trace )

	if SERVER then
		if (!self:GetOwner():IsSuperAdmin()) then
			sendMessageToPlayer(self:GetOwner(), gDuel.Translate("YouDontHaveRights!"))	
			return
		end

	    if (!gDuel.Arenas[game.GetMap()][self.CurArena] or !gDuel.Arenas[game.GetMap()][self.CurArena].pos1) then

	        gDuel.Arenas[game.GetMap()][self.CurArena] = {}
	        gDuel.Arenas[game.GetMap()][self.CurArena].pos1 = Trace.HitPos
	        sendMessageToPlayer(self:GetOwner(), gDuel.Translate("FirstPoint"))

	        local pointsToDraw = {}
	    	for k, v in pairs(gDuel.Arenas[game.GetMap()]) do
	    		table.insert(pointsToDraw, v.pos1)
	    		table.insert(pointsToDraw, v.pos2)
			end

	    	net.Start("gDuel.UpdatePointsToDraw")
	    		net.WriteTable(pointsToDraw)
	    	net.Send(self:GetOwner())

	    elseif (gDuel.Arenas[game.GetMap()][self.CurArena].pos1) then
	    	sendMessageToPlayer(self:GetOwner(), gDuel.Translate("DuelToolSetFirstPointalready"))
	    end
	end

    return true

end

function TOOL:RightClick( Trace )

	if SERVER then

		if (!self:GetOwner():IsSuperAdmin()) then
			sendMessageToPlayer(self:GetOwner(), gDuel.Translate("YouDontHaveRights!"))	
			return
		end

	    if (gDuel.Arenas[game.GetMap()][self.CurArena] and !gDuel.Arenas[game.GetMap()][self.CurArena].pos2 and gDuel.Arenas[game.GetMap()][self.CurArena].pos1) then

	        gDuel.Arenas[game.GetMap()][self.CurArena].pos2 = Trace.HitPos 
	        gDuel.Arenas[game.GetMap()][self.CurArena].available = true

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

			if (!file.Exists("didvaitel", "DATA")) then
				file.CreateDir("didvaitel")
			end

			if (!file.Exists("didvaitel/gduels", "DATA")) then
				file.CreateDir("didvaitel/gduels")
			end

		    file.Write("didvaitel/gduels/arenas.txt", util.TableToJSON(gDuel.Arenas))
	    elseif (!gDuel.Arenas[game.GetMap()][self.CurArena] or !gDuel.Arenas[game.GetMap()][self.CurArena].pos1) then
	        sendMessageToPlayer(self:GetOwner(), gDuel.Translate("DuelToolSetFirstPoint"))
	    end

	end

    return true
end


function TOOL:Reload()

	if !self:GetOwner():IsSuperAdmin() then
		if SERVER then
			sendMessageToPlayer(self:GetOwner(), gDuel.Translate("YouDontHaveRights!"))	
		end		
		return
	end

	self.CurArena = 1
	self.PointsToDraw = {}
	gDuel.Arenas[game.GetMap()] = {}

	if SERVER then
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

	if (gDuel.Arenas == nil) then
		gDuel.Arenas = {}
	end
	if (gDuel.Arenas[game.GetMap()] == nil or gDuel.Arenas[game.GetMap()] == {}) then
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
