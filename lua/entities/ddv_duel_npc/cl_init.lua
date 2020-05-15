--[[
    Created by DidVaitel (http://steamcommunity.com/profiles/76561198108670811)
]]
--[[
    Created by DidVaitel (http://steamcommunity.com/profiles/76561198108670811)
]]
--[[
    Created by DidVaitel (http://steamcommunity.com/profiles/76561198108670811)
]]
--[[
    Created by DidVaitel (http://steamcommunity.com/profiles/76561198108670811)
]]
--[[
    Created by DidVaitel (http://steamcommunity.com/profiles/76561198108670811)
]]


include("shared.lua")

function ENT:Draw()

    self:DrawModel()

    local vectors = Vector( 0, 0, 15)


    local position
    local Head = self:LookupBone("ValveBiped.Bip01_Head1")

    if ( Head ) then
        position = self:GetBonePosition( Head )
    else
        position = self:GetPos()
    end

    local Angles = self:GetAngles()
    local Dist = position:Distance( LocalPlayer():GetPos() )

    if ( Dist > 350 ) then return end

    color_white.a = 350 - Dist
    color_black.a = 350 - Dist

    Angles:RotateAroundAxis( Angles:Forward(), 90 )
    Angles:RotateAroundAxis( Angles:Right(), -90 )

    Angles:RotateAroundAxis( Angles:Right(), math.sin(CurTime() * math.pi) * -45 )

    cam.Start3D2D( position + vectors + Angles:Right() * 1.2, Angles, 0.065 )
        draw.SimpleTextOutlined( "Duel NPC", "gDuelFont100", -3, 0, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
    cam.End3D2D()

    Angles:RotateAroundAxis( Angles:Right(), 180 )

    cam.Start3D2D( position + vectors + Angles:Right() * 1.2, Angles, 0.065 )
        draw.SimpleTextOutlined( "Duel NPC", "gDuelFont100", -3, 0, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
    cam.End3D2D()

end
