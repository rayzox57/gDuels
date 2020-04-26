--[[
	Script: gDuel-System
	Version: 0.2
	Created by DidVaitel
]]

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/Humans/Group01/male_02.mdl" )
	self:SetHullType( HULL_HUMAN )
	self:SetHullSizeNormal( )
	self:SetNPCState( NPC_STATE_SCRIPT )
	self:SetSolid( SOLID_BBOX )
	self:CapabilitiesAdd( CAP_ANIMATEDFACE, CAP_TURN_HEAD )
	self:SetUseType( SIMPLE_USE )
	self:DropToFloor()
end

function ENT:AcceptInput( Name, Activator, Caller )
	if Name == "Use" and Caller:IsPlayer() and not Caller.timer or Caller.timer and Caller.timer < CurTime()  then
	Caller.timer = CurTime() + 3
	gDuel.GetdataAll(function(data)
		net.Start("gDuel.Menu")
			net.WriteTable(data)
		net.Send(Caller)
	end)
	end
end