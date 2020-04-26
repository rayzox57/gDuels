--[[
    Script: gDuel-System
    Version: 0.2
    Created by DidVaitel
]]

include("shared.lua")

local function overhead()

    local hop = math.abs( math.cos( CurTime() * 1 ) )
    local ents = ents.FindByClass( "duel_npc" )
    if not ents then return end
		for i = 1, #ents do
        	local ent = ents[ i ]
            if not IsValid( ent ) then continue end
           	if ent:GetPos():Distance( LocalPlayer():GetPos() ) >= ( 400 ) then continue end
            hop = math.abs( math.cos( CurTime() * 3 ) )
            local pos = ent:GetPos() + Vector( 0, 0, ( 85 + hop * 3 ) or 85 )
            local ang = Angle( 0, LocalPlayer():EyeAngles().y - 90, 90 )
            local txtpos = 0
            cam.Start3D2D( pos, ang, 0.1 )
                gDuel.vgui.txt( "Duel NPC", 100, 0, txtpos, nil, 1 )
                txtpos = txtpos + 100
            cam.End3D2D()

        end
end

hook.Add( 'PostDrawOpaqueRenderables', 'gDuel.OverHead', overhead )
