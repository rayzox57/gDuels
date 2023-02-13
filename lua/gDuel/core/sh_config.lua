--[[
	Created by DidVaitel (http://steamcommunity.com/profiles/76561198108670811)
]]


-- Currency : Warning for moment, this feature doesn't has full check if the currency is installed on the server, so if you use a currency that isn't installed on the server, it will causes error! !.
gDuel.currency = "DRP" -- DRP = DarkRP / PS1 = Pointshop 1 / PS2 = Pointshop 2 / PPS2 = Pointshop 2 Premium / PS1 = Pointshop 1 / SH_PS = SH Pointshop / ZPN = Zero´s PumpkinNight 🎃 🎄 (Halloween / Christmas Script) / FREE = No Currency

gDuel.maxBet 		= 1000000 -- max bet
gDuel.minBet 		= 500     -- min bet
gDuel.Lang = "eng"            -- rus,eng,fra



-- Builder-X Support (https://www.gmodstore.com/market/view/builder-x) [ for moment, no Builder-X check ]
gDuel.builderX_Support = false
-- end of Builder-X Support



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


