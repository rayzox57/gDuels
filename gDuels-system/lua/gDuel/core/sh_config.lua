--[[
	Created by DidVaitel (http://steamcommunity.com/profiles/76561198108670811)
]]

gDuel.maxBet 		= 1000000 -- max bet [DARKRP ONLY]
gDuel.minBet 		= 500 -- min bet [DARKRP ONLY]
gDuel.Lang = "eng" -- rus,eng

gDuel.Types		= {
	//{
	//	name 			= 'Explosionz', -- Name in Types
	//	desc 			= 'Spawn with 999 nades, and fuck up the opponent with em!', -- desc
	//	weapon 		= 'weapon_frag', -- Weapon
	//	onSpawn 		= function(pl)
	//		pl:GiveAmmo(999, 'Grenade') - What we will give player on spawn
	//	end
	//},
	{
		name 			= 'Kinky Crowbar',
		desc 			= 'You have kinky crowbar sex with the opponent',
		weapon 		= 'weapon_crowbar'
	},
	{
		name 			= 'Fisting',
		desc 			= 'You both spawn with 50 hp and have to fist eachother to death xd',
		weapon 		= 'weapon_fists',
		onSpawn 		= function(pl)
			pl:SetHealth(50)
		end
	},
	{
		name 			= 'Explosionz',
		desc 			= 'Spawn with 999 nades, and fuck up the opponent with em!',
		weapon 		= 'weapon_frag',
		onSpawn 		= function(pl)
			pl:GiveAmmo(999, 'Grenade')
		end
	}
}

gDuel.NpcSpawns 		= {}
gDuel.Arenas 		= {}
gDuel.Arenas[game.GetMap()] = {}


