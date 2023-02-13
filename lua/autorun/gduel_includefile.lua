--[[
	Script: gDuel-System
	Version: 0.2
	Created by DidVaitel
]]


gDuel = gDuel or {}

if SERVER then
	local files, directories = file.Find( "gDuel/*", "LUA" )
	for i, folder in pairs( directories ) do
		local files, directories = file.Find( "gDuel/" .. folder .. "/*", "LUA" )
		for i, f in pairs( files ) do
			if string.StartWith( f, "sh_" ) then
				include( "gDuel/" .. folder .. "/" .. f )
				AddCSLuaFile( "gDuel/" .. folder .. "/" .. f )
			elseif string.StartWith( f, "sv_" ) then
				include( "gDuel/" .. folder .. "/" .. f )
			elseif string.StartWith( f, "cl_" ) then
				AddCSLuaFile( "gDuel/" .. folder .. "/" .. f )
			end
		end
	end
else
	local files, directories = file.Find( "gDuel/*", "LUA" )
	for i, folder in pairs( directories ) do
		local files, directories = file.Find( "gDuel/" .. folder .. "/*", "LUA" )
		for i, f in pairs( files ) do
			if string.StartWith( f, "sh_" ) or string.StartWith( f, "config_" ) then
				include( "gDuel/" .. folder .. "/" .. f )
			elseif string.StartWith( f, "cl_" ) then
				include( "gDuel/" .. folder .. "/" .. f )
			end
		end
	end
end

local _, cSS = gDuel.Money.sys()
if SERVER then
	MsgC( Color(0,125,255,255), "[gDuel-System]", Color(255,255,255,255), ": Currency system is ", Color(0,255,0,255), cSS, Color(255,255,255,255), ".\n" )
end