--[[
	Created by DidVaitel (http://steamcommunity.com/profiles/76561198108670811)
]]

function sendMessageToPlayer(ply, str)

	net.Start("gDuel.SendMessage")
		net.WriteString(str)
	net.Send(ply)

end

function IsInDuel(ply)

	for k,v in pairs(gDuel.Duels) do
		if (v.ply == ply and v.active or v.enemy == ply and v.active) then
			return true
		end
	end

	return false

end
gDuel.Duels = gDuel.Duels or {}
gDuel.Arenas = gDuel.Arenas or {}
gDuel.NpcSpawns 		= {}

local function SendRequest(len, ply)
	local enemy = net.ReadEntity()
	local amt = tonumber(net.ReadInt(32))
	local types = tonumber(net.ReadInt(16))

	if !enemy or !IsValid(enemy) then return end
	if !amt then return end
	if !types or types and types == 0 or types and types > #gDuel.Types then return end

	if gDuel.Arenas[game.GetMap()] and table.IsEmpty(gDuel.Arenas[game.GetMap()]) or table.IsEmpty(gDuel.Arenas) then
		sendMessageToPlayer(ply, gDuel.Translate("PointNotFound"))
		return
	end

	if !table.IsEmpty(DarkRP) then
		if amt < gDuel.minBet then
			sendMessageToPlayer(ply, gDuel.Translate("Small amount"))
			return
		end

		if amt > gDuel.maxBet then
			sendMessageToPlayer(ply, gDuel.Translate("Big amount"))
			return
		end

	
		if !ply:canAfford(amt) then
			sendMessageToPlayer(ply, gDuel.Translate("CantAfford"))
			return
		end

		if !enemy:canAfford(amt) then
			sendMessageToPlayer(ply, gDuel.Translate("CantAffordEnemy"))
			return
		end
	end

	for k,v in pairs(gDuel.Duels) do
		if v.enemy == enemy and v.ply == ply then
			sendMessageToPlayer(ply, gDuel.Translate("AlreadySended"))
			return
		end
	end

	if ( IsInDuel(ply) or IsInDuel(enemy) ) then
		sendMessageToPlayer(ply, gDuel.Translate("EnemyInDuel"))
		return
	end

	local id = math.random( 0, 9999 )
	gDuel.Duels[ id ] = { ply = ply, enemy = enemy, amt = amt, types = types, active = false }

	net.Start("gDuel.SendRequest")
		net.WriteEntity(ply)
		net.WriteInt(amt, 32)
		net.WriteInt(types, 16)
		net.WriteInt(id,24)
	net.Send(enemy)
end
net.Receive("gDuel.SendRequest", SendRequest)

local function DeclineRequest(len,ply)
	local id = net.ReadInt(24)

	if gDuel.Duels[ id ] == nil or gDuel.Duels[ id ] != nil and !table.HasValue( gDuel.Duels[ id ], ply ) then
		ply:Kick("Exploiting![gDuels]")
	end
	sendMessageToPlayer(ply, gDuel.Translate("Declined"))
	sendMessageToPlayer(gDuel.Duels[ id ].ply, gDuel.Translate("DeclinedEnemy"))
	gDuel.Duels[id] = nil
end
net.Receive("gDuel.DeclineRequest", DeclineRequest)

local function AcceptedRequest(len, ply)
	local id = net.ReadInt(24)
	local ply2 = gDuel.Duels[ id ].ply

	if ( IsInDuel(ply) or IsInDuel(ply2) ) then
		sendMessageToPlayer(ply, gDuel.Translate("EnemyInDuel"))
		return
	end

	if !table.IsEmpty(DarkRP) then
		if !ply2:canAfford(gDuel.Duels[ id ].amt) then
			sendMessageToPlayer(ply, gDuel.Translate("CantAffordEnemy"))
			gDuel.Duels[id] = nil
			return
		end

		if !ply:canAfford(gDuel.Duels[ id ].amt) then
			sendMessageToPlayer(ply, gDuel.Translate("CantAfford"))
			gDuel.Duels[id] = nil
			return
		end

		ply:addMoney(-gDuel.Duels[ id ].amt)
		ply2:addMoney(-gDuel.Duels[ id ].amt)
	end

	if !ply:Alive() then
		ply:Spawn()
	elseif !ply2:Alive() then
		ply2:Spawn()
	end

	gDuel.Duels[ id ].active = true

	ply:SetHealth(100)
	ply2:SetHealth(100)

	if gDuel.Arenas[game.GetMap()] and table.IsEmpty(gDuel.Arenas[game.GetMap()]) or table.IsEmpty(gDuel.Arenas) then
		sendMessageToPlayer(ply, gDuel.Translate("PointNotFound"))
		return
	end

	local map = gDuel.Arenas[game.GetMap()]
	for k,v in pairs(gDuel.Arenas[game.GetMap()]) do
		if v.available == true then
			posit = map[k]
			break
		end
	end

	ply.LastPos = ply:GetPos()

	ply:SetPos(posit.pos1)

	ply2.LastPos = ply2:GetPos()

	ply2:SetPos(posit.pos2)

	ply2:SetEyeAngles(Angle(0,90,0))
	ply:SetEyeAngles(Angle(0,-90,0))

	posit.available = false
	ply.weaponslistduel = {}
	ply2.weaponslistduel = {}
	for k,v in pairs(ply:GetWeapons()) do
		table.insert(ply.weaponslistduel, v:GetClass())
	end
	for k,v in pairs(ply2:GetWeapons()) do
		table.insert(ply2.weaponslistduel, v:GetClass())
	end
	ply:StripWeapons()
	ply2:StripWeapons()

	if gDuel.Types[ gDuel.Duels[ id ].types ].onSpawn != nil then
		gDuel.Types[ gDuel.Duels[ id ].types ].onSpawn(ply)
		gDuel.Types[ gDuel.Duels[ id ].types ].onSpawn(ply2)
	end

	ply:Give(gDuel.Types[ gDuel.Duels[ id ].types ].weapon)

	ply2:Give(gDuel.Types[ gDuel.Duels[ id ].types ].weapon)

	ply:Freeze(true)
	ply2:Freeze(true)

	timer.Create("BeforeMatch",5,1,function()
		if ply:IsValid() then
			ply:Freeze(false)
		end
		if ply2:IsValid() then
			ply2:Freeze(false)
		end
	end)

	net.Start("gDuel.Animation")
	net.Send(ply)

	net.Start("gDuel.Animation")
	net.Send(ply2)


	ply.Opponent = ply2
	ply2.Opponent = ply
	local random = math.random(0,99999999)
	timer.Create(random.."_GduelsTimer",1,0,function()
		if ply2.Opponent == nil or ply.Opponent == nil then
			gDuel.Duels[id] = nil
			if ply.HaveDuel == true then
				ply.HaveDuel = false
			elseif ply2.HaveDuel == true  then
				ply2.HaveDuel = false
			end
			if ply.deathduel == true then
				ply:Spawn()
	    		for k,v in pairs(ply.weaponslistduel) do
	    			ply:Give(v)
	    		end
			elseif ply2.deathduel == true then
				ply2:Spawn()
	    		for k,v in pairs(ply2.weaponslistduel) do
	    			ply2:Give(v)
	    		end
			end

			timer.Remove(random.."_GduelsTimer")
		end
	end)

end
net.Receive("gDuel.AcceptRequest", AcceptedRequest)
hook.Add("PlayerDeath", "DuelsCheckDeath", function(victim, pric, attacker)
	if victim.Opponent != nil then
		for k,v in pairs(gDuel.Duels) do
			if v.ply == victim.Opponent or v.enemy == victim.Opponent then
				if !table.IsEmpty(DarkRP) then
					local balance = v.amt
					victim.Opponent:addMoney(balance*2)
				end
				victim.Opponent:SetPos(victim.Opponent.LastPos)
				victim.Opponent:SetHealth(victim.Opponent:GetMaxHealth())
				sendMessageToPlayer(victim, gDuel.Translate("YouLose!"))
				sendMessageToPlayer(victim.Opponent, gDuel.Translate("Youwin!"))
				victim.Opponent:StripWeapons()

    			for k,v in pairs(victim.Opponent.weaponslistduel) do
    				victim.Opponent:Give(v)
    			end
    			victim.Opponent:SelectWeapon("weapon_physgun")
    			victim.Opponent:SetHealth(victim.Opponent:GetMaxHealth())
   				gDuel.SaveWin(victim.Opponent)
   				gDuel.SaveLose(victim)
    			victim.Opponent.Opponent = nil
				victim.Opponent = nil
				victim.deathduel = true
				gDuel.Duels[k] = {}
			end
		end
	end
end)

local function BlockSuicide(ply)
    if ply.Opponent != nil then
    	return false
    end
    return true
end
hook.Add( "CanPlayerSuicide", "BlockSuicide", BlockSuicide )

hook.Add("PlayerDisconnected", "gDuels.OnPlayerDisconnected", function(ply)
	if ply.Opponent != nil then
		for k,v in pairs(gDuel.Duels) do
			if v.ply == ply.Opponent or v.enemy == ply.Opponent then
				if !table.IsEmpty(DarkRP) then
					local balance = v.amt
					ply.Opponent:addMoney(balance*2)
				end
				ply.Opponent:SetPos(ply.Opponent.LastPos)
				ply.Opponent:SetHealth(ply.Opponent:GetMaxHealth())
				sendMessageToPlayer(ply.Opponent, gDuel.Translate("Youwin!"))
				ply.Opponent:StripWeapons()
    			for k,v in pairs(ply.Opponent.weaponslistduel) do
    				ply.Opponent:Give(v)
    			end
    			ply.Opponent:SelectWeapon("weapon_physgun")
    			ply.Opponent:SetHealth(ply.Opponent:GetMaxHealth())
    			gDuel.SaveLose(ply)
				gDuel.SaveWin(ply.Opponent)
    			ply.Opponent.Opponent = nil
    			gDuel.Duels[k] = {}
			end
		end
	end
end)

hook.Add("PlayerShouldTakeDamage","DuelBlockDamage",function(ply1,ply2)
	if ( ply1.Opponent != nil ) then
		return ply1.Opponent == ply2
	elseif ( ply2:IsPlayer() and ply2~=ply1 and ply2.Opponent != nil ) then
		return ply2.Opponent == ply1 or ply1.Opponent==ply2
	end
end)

hook.Add( "playerCanChangeTeam", "gDuels.CanChange", function( ply,  team,  force)
    if ply.Opponent != nil then
    	return false, gDuel.Translate("OnTheDuel")
    end
end)

hook.Add("PlayerSpawnProp", "gDuel.AntiProp", function( ply, model )
	if ply.Opponent != nil then
		return false
	end
	return true
end)

hook.Add( "InitPostEntity", "gDuel.LoadArenas", function()

	gDuel.LoadArenas()

end )

function gDuel.LoadArenas()

	if (!file.Exists("didvaitel", "DATA")) then
		file.CreateDir("didvaitel")
	end

	if (!file.Exists("didvaitel/gduels", "DATA")) then
		file.CreateDir("didvaitel/gduels")
	end

	if file.Exists("didvaitel/gduels/arenas.txt","DATA") then

		local t = util.JSONToTable( file.Read( "didvaitel/gduels/arenas.txt", "DATA" ) )
		gDuel.Arenas = t

		if (!gDuel.Arenas[game.GetMap()]) then
			gDuel.Arenas[game.GetMap()] = {}
		end

		for k,v in pairs(gDuel.Arenas[game.GetMap()]) do
			if (v.pos1 and v.pos2 and v.available) then
				continue
			else
				v = {}
			end
		end

	end

end

function gDuel.SaveWin(ply)
	local data = sql.Query("SELECT * FROM gduels_infos WHERE steamID = ".. sql.SQLStr(ply:SteamID())..";")
	local r=data[1]
	local duels = r.Duels + 1
	local wins = r.Duelswin + 1

	sql.Query([[REPLACE INTO gduels_infos VALUES(]].. sql.SQLStr(ply:SteamID()) ..[[,]].. sql.SQLStr(ply:Nick())..[[,]].. duels ..[[,]].. wins..[[,]].. r.Duelslose..[[ );]])
end

function gDuel.SaveLose(ply)
	local data = sql.Query("SELECT * FROM gduels_infos WHERE steamID = ".. sql.SQLStr(ply:SteamID())..";")
	local r=data[1]
	local duels = r.Duels + 1
	local wins = r.Duelswin
	local loses = r.Duelslose + 1
	
	sql.Query([[REPLACE INTO gduels_infos VALUES(]].. sql.SQLStr(ply:SteamID()) ..[[,]].. sql.SQLStr(ply:Nick())..[[,]].. duels ..[[,]].. wins..[[,]].. loses..[[);]])
end


local function DarkRPInit()
	sql.Query("CREATE TABLE IF NOT EXISTS gduels_infos(steamID VARCHAR(20) NOT NULL PRIMARY KEY, Name VARCHAR(32) NOT NULL, Duels int NOT NULL, Duelswin int NOT NULL, Duelslose int NOT NULL);")
end
hook.Add("InitPostEntity", "gDuels.DataBase", DarkRPInit)

function gDuel.Getdata(ply, callback)
	local data = sql.Query("SELECT * FROM gduels_infos WHERE steamID = ".. sql.SQLStr(ply:SteamID())..";")
	callback(data)
end

function gDuel.GetdataAll(callback)
	local data = sql.Query("SELECT * FROM gduels_infos;")
	callback(data)
end

function gDuel.CreateData(pl)
	sql.Query([[REPLACE INTO gduels_infos VALUES(]].. sql.SQLStr(pl:SteamID()) ..[[,]].. sql.SQLStr(pl:Nick())..[[,0,0,0 );]])
end


hook.Add("PlayerAuthed", "gDuels.LeadersTable", function(pl)
	gDuel.Getdata(pl, function(data)
		local datas = data and data[1] or {}
		if not data then gDuel.CreateData(pl) end
	end)
end)
