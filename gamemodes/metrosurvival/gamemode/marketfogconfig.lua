----------------------------------
--	Market Fog	
--	Programmer : LIFO/Tednesday		
--	Date : 15/10/2018		
----------------------------------

-- Remove settings at your own risk
-- Make sure you keep a back up if you want to reset to the default values.

ConfigInfo = {}
ConfigInfo["MarketFog"] = {}

-- Gameplay Settings
ConfigInfo["MarketFog"].Gameplay = {}
ConfigInfo["MarketFog"].Gameplay.ActiveCombatEnabled = true -- Turns on critical hits and knockdown/stun effects on enemies.
ConfigInfo["MarketFog"].Gameplay.WeatherEnabled = true -- Enables weather.
ConfigInfo["MarketFog"].Gameplay.WeatherRainFrequencyMin = 120 -- In seconds, the duration until the next rain storm. A random value is chosen between min and max.
ConfigInfo["MarketFog"].Gameplay.WeatherRainFrequencyMax = 300 
ConfigInfo["MarketFog"].Gameplay.WeatherRainDurationMin = 60 -- In seconds, the duration of the rain storm. A random value is chosen between min and max.
ConfigInfo["MarketFog"].Gameplay.WeatherRainDurationMax = 450 

ConfigInfo["MarketFog"].Gameplay.LostSuitOnDeathFlag = false -- When true, the player's suit is reset back to the one specified.
ConfigInfo["MarketFog"].Gameplay.DefaultSuitOnDeath = "Grunt" -- Make this the name of the suit that the player equips when they die. If this is invalid then it will be set to the first suit in the apparel list.
ConfigInfo["MarketFog"].Gameplay.MoneyLostOnDeathFlag = true -- The player loses money when dying
ConfigInfo["MarketFog"].Gameplay.MoneyLostOnDeathRatio = 0.25 -- Money lost by the player upon death as a fraction. e.g. 0.5 means that the player loses half of their money. 1.0 means they lose all money
ConfigInfo["MarketFog"].Gameplay.WeaponsLostOnDeathFlag = true -- If true, the player drops all their weapons on death.
ConfigInfo["MarketFog"].Gameplay.KillersStealMoneyFlag = false -- If true, when a player dies, money is stolen from the player and given to the killer. This happens AFTER money is lost on death if that flag is selected.
ConfigInfo["MarketFog"].Gameplay.KillersStealMoneyRatio = 1.0 -- Money stolen by the killer of a player as a ratio. e.g. 1.0 means that the killer takes all of the players money.
ConfigInfo["MarketFog"].Gameplay.CashDisplaySymbol = "$" -- Change this to change the display symbol for cash.

ConfigInfo["MarketFog"].Gameplay.StartingMetalQuantity = 0 -- The amount of metal that a first time player is given
ConfigInfo["MarketFog"].Gameplay.StartingCircuitsQuantity = 0 -- The amount of circuits that a first time player is given
ConfigInfo["MarketFog"].Gameplay.StartingFuelQuantity = 0 -- The amount of fuel that a first time player is given
ConfigInfo["MarketFog"].Gameplay.StartingMoneyQuantity = 0 -- The amount of money that a first time player is given
ConfigInfo["MarketFog"].Gameplay.StartingO2FilterQuantity = 1 -- The amount of O2 canisters/filters a first time player is given
ConfigInfo["MarketFog"].Gameplay.StartingSuit = 1 -- The suit a first time player is given upon joining the server. (Is a number that corresponds to the suit's position in the apparel list. Starts at 1)
ConfigInfo["MarketFog"].Gameplay.StartingAR2AmmoQuantity = 0 -- The amount of AR2/Rifle Ammo that a first time player is given
ConfigInfo["MarketFog"].Gameplay.StartingBuckshotAmmoQuantity = 0 -- The amount of Shotgun Ammo that a first time player is given
ConfigInfo["MarketFog"].Gameplay.StartingSMGAmmoQuantity = 0 -- The amount of SMG Ammo that a first time player is given
ConfigInfo["MarketFog"].Gameplay.StartingPistolAmmoQuantity = 64 -- The amount of Pistol Ammo that a first time player is given
ConfigInfo["MarketFog"].Gameplay.Starting357AmmoQuantity = 0 -- The amount of 357 Ammo that a first time player is given

ConfigInfo["MarketFog"].Gameplay.StartingWeapons = {} -- A list of weapon classnames that a first time player will spawn with
table.insert(ConfigInfo["MarketFog"].Gameplay.StartingWeapons, "arccw_melee_knife")
table.insert(ConfigInfo["MarketFog"].Gameplay.StartingWeapons, "arccw_m9")

ConfigInfo["MarketFog"].Gameplay.RespawnWeapons = {} -- A list of weapon classnames that a player who dies will spawn with
table.insert(ConfigInfo["MarketFog"].Gameplay.RespawnWeapons, "arccw_melee_knife")
table.insert(ConfigInfo["MarketFog"].Gameplay.RespawnWeapons, "arccw_m9")

ConfigInfo["MarketFog"].Gameplay.RespawningMetalQuantity = 0 -- The amount of metal that a respawning player has after they die
ConfigInfo["MarketFog"].Gameplay.RespawningCircuitsQuantity = 0 -- The amount of circuits that a respawning player has after they die
ConfigInfo["MarketFog"].Gameplay.RespawningFuelQuantity = 0 -- The amount of fuel that a respawning player has after they die
ConfigInfo["MarketFog"].Gameplay.RespawningO2FilterQuantity = 1 -- The amount of O2 canisters/filters that a respawning player has after they die
ConfigInfo["MarketFog"].Gameplay.RespawningAR2AmmoQuantity = 0 -- The amount of AR2/Rifle Ammo that a respawning player has after they die
ConfigInfo["MarketFog"].Gameplay.RespawningBuckshotAmmoQuantity = 0 -- The amount of Shotgun Ammo that a respawning player has after they die
ConfigInfo["MarketFog"].Gameplay.RespawningSMGAmmoQuantity = 0 -- The amount of SMG Ammo that a respawning player has after they die
ConfigInfo["MarketFog"].Gameplay.RespawningPistolAmmoQuantity = 64 -- The amount of Pistol Ammo that a respawning player has after they die
ConfigInfo["MarketFog"].Gameplay.Respawning357AmmoQuantity = 0 -- The amount of 357 Ammo that a respawning player has after they die
ConfigInfo["MarketFog"].Gameplay.RespawningO2Quantity = 75 -- The amount of O2 given to a spawning player. Recommend making this less than the Max O2 amount as a tutorial for new players.

ConfigInfo["MarketFog"].Gameplay.MoneyDegradation = 0.01 -- Everytime someone joins the server their money is reduced by the percentage%. Attempts to mitigate massive devaluation of resources. Default is 5%

-- Gas Mask Settings
ConfigInfo["MarketFog"].Gameplay.UseDefaultGasMaskPostProcessFlag = false -- Uses the default toy town effect gasmask. Turn this off if you want to use your own post processing effects. i.e. the metro ones. 

ConfigInfo["MarketFog"].Gameplay.GasMaskPP = {} -- Adds various effects based on the amount of health. Make sure the thresholds are in descending order. Only works when the UseDefaultGasMaskPostProcessFlag is false. These need to be functional Post Processing overlays.
local GasMaskData = {
	PPMaterialName = "effects/Morganicism/overlay/MetroMask", -- The name of PP material to be displayed
	PPRefractAmount = 0.2, -- The amount the PP refracts light
	HealthThreshold = 90 -- Any player health value above this and the material is displayed.
}
table.insert(ConfigInfo["MarketFog"].Gameplay.GasMaskPP, GasMaskData)
GasMaskData = {
	PPMaterialName = "effects/Morganicism/overlay/MetroMask1", -- The name of PP material to be displayed
	PPRefractAmount = 0.2, -- The amount the PP refracts light
	HealthThreshold = 75 -- Any player health value above this and the material is displayed.
}
table.insert(ConfigInfo["MarketFog"].Gameplay.GasMaskPP, GasMaskData)
GasMaskData = {
	PPMaterialName = "effects/Morganicism/overlay/MetroMask2", -- The name of PP material to be displayed
	PPRefractAmount = 0.2, -- The amount the PP refracts light
	HealthThreshold = 40 -- Any player health value above this and the material is displayed.
}
table.insert(ConfigInfo["MarketFog"].Gameplay.GasMaskPP, GasMaskData)
GasMaskData = {
	PPMaterialName = "effects/Morganicism/overlay/MetroMask3", -- The name of PP material to be displayed
	PPRefractAmount = 0.2, -- The amount the PP refracts light
	HealthThreshold = 20 -- Any player health value above this and the material is displayed.
}
table.insert(ConfigInfo["MarketFog"].Gameplay.GasMaskPP, GasMaskData)
GasMaskData = {
	PPMaterialName = "effects/Morganicism/overlay/MetroMask4", -- The name of PP material to be displayed
	PPRefractAmount = 0.2, -- The amount the PP refracts light
	HealthThreshold = 0 -- Any player health value above this and the material is displayed.
}
table.insert(ConfigInfo["MarketFog"].Gameplay.GasMaskPP, GasMaskData)


-- The Weapon Settings
--
ConfigInfo["MarketFog"].Weapon = {}
-- The M9
local WeaponInfo = {
	WeaponType = "pistol", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/w_pist_p228.mdl", -- The icon used to display this weapon in derma menus
	Name = "arccw_m9",
	DisplayName = "Knox",
	Spawnable = false, -- If true this weapon will spawn in the world.
	Buyable = true, -- If true this weapon will be buyable from the shop
	Description = "A classic police issue pistol.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	Price = 500,
	CritChance = 5, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The Glock 17
WeaponInfo = {
	WeaponType = "pistol", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/w_pist_glock18.mdl", -- The icon used to display this weapon in derma menus
	Name = "arccw_g18",
	DisplayName = "PP-A9",
	Spawnable = false, -- If true this weapon will spawn in the world.
	Buyable = false, -- If true this weapon will be buyable from the shop
	Description = "A porcelain gun made in Germany that costs more then you make in a month.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	Price = 750,
	CritChance = 4, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The P99 replaced by USP
WeaponInfo = {
	WeaponType = "pistol", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/w_pist_p228.mdl", -- The icon used to display this weapon in derma menus
	Name = "arccw_usp",
	DisplayName = "SP40",
	Spawnable = false, -- If true this weapon will spawn in the world.
	Buyable = true, -- If true this weapon will be buyable from the shop
	Description = "A tactical handgun with a high critical hit rate.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	Price = 1000,
	CritChance = 7, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The CZ75
WeaponInfo = {
	WeaponType = "pistol", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/w_pist_p228.mdl", -- The icon used to display this weapon in derma menus
	Name = "arccw_p228",
	DisplayName = "Sigma-9",
	Spawnable = false, -- If true this weapon will spawn in the world.
	Buyable = true, -- If true this weapon will be buyable from the shop
	Description = "A powerful handgun. Soyboys like it.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	Price = 1100,
	CritChance = 3, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The Uzi replaced by mac11
WeaponInfo = {
	WeaponType = "pistol", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/arccw/w_mk201.mdl", -- The icon used to display this weapon in derma menus
	Name = "arccw_mac11",
	DisplayName = "MK 201",
	Spawnable = true, -- If true this weapon will spawn in the world.
	SpawnProb = 6.0, -- The percentage chance this will spawn in the world. 0 - 100%
	Buyable = false, -- If true this weapon will be buyable from the shop
	Description = "Aim away from face.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	Price = 1800,
	CritChance = 3, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The Remington 870 replaced by doublebarrel
WeaponInfo = {
	WeaponType = "shotgun", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/arccw/w_db.mdl", -- The icon used to display this weapon in derma menus
	Name = "arccw_db",
	DisplayName = "Partner Doublebarrel",
	Spawnable = true, -- If true this weapon will spawn in the world.
	SpawnProb = 10.0, -- The percentage chance this will spawn in the world. 0 - 100%
	Buyable = true, -- If true this weapon will be buyable from the shop
	Description = "Westward classic..",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	Price = 2050,
	CritChance = 2, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The AKS74U replaced by Type 2
WeaponInfo = {
	WeaponType = "smg", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/w_rif_galil.mdl", -- The icon used to display this weapon in derma menus
	Name = "arccw_ak47",
	DisplayName = "Type 2",
	Spawnable = true, -- If true this weapon will spawn in the world.
	SpawnProb = 6.0, -- The percentage chance this will spawn in the world. 0 - 100%
	Buyable = true, -- If true this weapon will be buyable from the shop
	Description = "This is what the bad guys use.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	Price = 2265,
	CritChance = 2, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The AKM repalced by Galil
WeaponInfo = {
	WeaponType = "rifle", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/w_rif_galil.mdl", -- The icon used to display this weapon in derma menus
	Name = "arccw_galil762",
	DisplayName = "Lion Battle Rifle",
	Spawnable = true, -- If true this weapon will spawn in the world.
	SpawnProb = 4.0, -- The percentage chance this will spawn in the world. 0 - 100%
	Buyable = true, -- If true this weapon will be buyable from the shop
	Description = "A extremely retooled Type 2 used in the Middle East.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	Price = 3265,
	CritChance = 3, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The M590A1 repalced by shorty
WeaponInfo = {
	WeaponType = "shotgun", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/w_shot_m3super90.mdl", -- The icon used to display this weapon in derma menus
	Name = "arccw_shorty",
	DisplayName = "Defender Shorty",
	Spawnable = true, -- If true this weapon will spawn in the world.
	SpawnProb = 4.0, -- The percentage chance this will spawn in the world. 0 - 100%
	Buyable = true, -- If true this weapon will be buyable from the shop
	Description = "A lightweight shotgun with high mobility.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	Price = 4850,
	CritChance = 2, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The Desert Eagle
WeaponInfo = {
	WeaponType = "pistol", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/w_pist_deagle.mdl", -- The icon used to display this weapon in derma menus
	Name = "arccw_deagle357",
	DisplayName = "Millenium Hawk",
	Spawnable = false, -- If true this weapon will spawn in the world.
	Buyable = true, -- If true this weapon will be buyable from the shop
	Description = "Compensates for small you-know-whats.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	Price = 6050,
	CritChance = 2, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The P90
WeaponInfo = {
	WeaponType = "smg", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/w_smg_p90.mdl", -- The icon used to display this weapon in derma menus
	Name = "arccw_p90",
	DisplayName = "PDW-57",
	Spawnable = true, -- If true this weapon will spawn in the world.
	SpawnProb = 2.0, -- The percentage chance this will spawn in the world. 0 - 100%
	Buyable = false, -- If true this weapon will be buyable from the shop
	Description = "A gun that shoots bullets like highly pressurized streams of piss. I didn't write that.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	Price = 8550,
	CritChance = 1, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The XM1014
WeaponInfo = {
	WeaponType = "shotgun", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/w_shot_xm1014.mdl", -- The icon used to display this weapon in derma menus
	Name = "arccw_m1014",
	DisplayName = "AS-1217",
	Spawnable = false, -- If true this weapon will spawn in the world.
	Buyable = true, -- If true this weapon will be buyable from the shop
	Description = "An semi-automatic shotgun.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	Price = 10750,
	CritChance = 4, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The HK416
WeaponInfo = {
	WeaponType = "rifle", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/w_rif_m4a1.mdl", -- The icon used to display this weapon in derma menus
	Name = "arccw_m4a1",
	DisplayName = "MK 4",
	Spawnable = false, -- If true this weapon will spawn in the world.
	Buyable = true, -- If true this weapon will be buyable from the shop
	Description = "Eugene Stoner's classic design, modernized.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	Price = 12575,
	CritChance = 3, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The M200
WeaponInfo = {
	WeaponType = "rifle", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/w_snip_scout.mdl", -- The icon used to display this weapon in derma menus
	Name = "arccw_scout",
	DisplayName = "PSRS Sniper",
	Spawnable = false, -- If true this weapon will spawn in the world.
	Buyable = true, -- If true this weapon will be buyable from the shop
	Description = "A bolt-action sniper rifle.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	Price = 15175,
	CritChance = 15, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The M60
WeaponInfo = {
	WeaponType = "shotgun", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/arccw/w_m60.mdl", -- The icon used to display this weapon in derma menus
	Name = "arccw_m60",
	DisplayName = "M60",
	Spawnable = false, -- If true this weapon will spawn in the world.
	Buyable = true, -- If true this weapon will be buyable from the shop
	Description = "I Am Become Death.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	Price = 18000,
	CritChance = 3, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The Knife
WeaponInfo = {
	WeaponType = "melee", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/w_knife_ct.mdl", -- The icon used to display this weapon in derma menus
	Name = "arccw_melee_knife",
	DisplayName = "Knife",
	Spawnable = false, -- If true this weapon will spawn in the world.
	Buyable = false, -- If true this weapon will be buyable from the shop
	Description = "Just a knife. It sucks.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The Tool Gun
WeaponInfo = {
	WeaponType = "tool", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/w_toolgun.mdl", -- The icon used to display this weapon in derma menus
	Name = "gmod_tool",
	DisplayName = "Tool Gun",
	Spawnable = false, -- If true this weapon will spawn in the world.
	Buyable = false, -- If true this weapon will be buyable from the shop
	Description = "You found this in a junk shop.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	Price = 1000
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The Phys Gun
WeaponInfo = {
	WeaponType = "phys", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/w_physics.mdl", -- The icon used to display this weapon in derma menus
	Name = "weapon_physgun",
	DisplayName = "Physgun",
	Spawnable = false, -- If true this weapon will spawn in the world.
	Buyable = false, -- If true this weapon will be buyable from the shop
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	Price = 1000
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The 57
WeaponInfo = {
	WeaponType = "pistol", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/w_pist_fiveseven.mdl", -- The icon used to display this weapon in derma menus
	Name = "arccw_fiveseven",
	DisplayName = "NXS-57",
	Spawnable = true, -- If true this weapon will spawn in the world.
	SpawnProb = 12.0, -- The percentage chance this will spawn in the world. 0 - 100%
	Buyable = false, -- If true this weapon will be buyable from the shop
	Description = "A super powerful pistol.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	Price = 1500,
	CritChance = 3, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The MP5
WeaponInfo = {
	WeaponType = "smg", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/w_smg_mp5.mdl", -- The icon used to display this weapon in derma menus
	Name = "arccw_mp5",
	DisplayName = "Swordfish",
	Spawnable = true, -- If true this weapon will spawn in the world.
	SpawnProb = 6.0, -- The percentage chance this will spawn in the world. 0 - 100%
	Buyable = false, -- If true this weapon will be buyable from the shop
	Description = "A basic german submachine gun.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	Price = 1800,
	CritChance = 2, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The AWP
WeaponInfo = {
	WeaponType = "rifle", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/w_snip_awp.mdl", -- The icon used to display this weapon in derma menus
	Name = "arccw_awm",
	DisplayName = "HS-338 Magnum",
	Spawnable = true, -- If true this weapon will spawn in the world.
	SpawnProb = 1.0, -- The percentage chance this will spawn in the world. 0 - 100%
	Buyable = false, -- If true this weapon will be buyable from the shop
	Description = "A rare sniper rifle. High crit chance.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	Price = 12000,
	CritChance = 10, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The SG552
WeaponInfo = {
	WeaponType = "rifle", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/w_rif_sg552.mdl", -- The icon used to display this weapon in derma menus
	Name = "arccw_sg552",
	DisplayName = "Roland CX-R",
	Spawnable = true, -- If true this weapon will spawn in the world.
	SpawnProb = 2.0, -- The percentage chance this will spawn in the world. 0 - 100%
	Buyable = false, -- If true this weapon will be buyable from the shop
	Description = "Used by Strelok. You can trust it.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	Price = 9000,
	CritChance = 3, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The RGD5
WeaponInfo = {
	WeaponType = "grenade", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/arccw/w_nade_impact.mdl", -- The icon used to display this weapon in derma menus
	Name = "arccw_nade_impact",
	DisplayName = "Impact Grenade",
	Spawnable = false, -- If true this weapon will spawn in the world.
	SpawnProb = 2.0, -- The percentage chance this will spawn in the world. 0 - 100%
	Buyable = false, -- If true this weapon will be buyable from the shop
	Description = "A grenade. Hurl it at enemies.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	Price = 0,
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The SG550
WeaponInfo = {
	WeaponType = "rifle", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/w_snip_sg550.mdl", -- The icon used to display this weapon in derma menus
	Name = "arccw_sg550",
	DisplayName = "Roland SS-X",
	Spawnable = false, -- If true this weapon will spawn in the world.
	SpawnProb = 2.0, -- The percentage chance this will spawn in the world. 0 - 100%
	Buyable = true, -- If true this weapon will be buyable from the shop
	Description = "The big brother of the CR-X.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	Price = 25000,
	CritChance = 10, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The 1873
WeaponInfo = {
	WeaponType = "rifle", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/arccw/w_winchester1873.mdl", -- The icon used to display this weapon in derma menus
	Name = "arccw_winchester1873",
	DisplayName = "Randall Repeater",
	Spawnable = false, -- If true this weapon will spawn in the world.
	SpawnProb = 2.0, -- The percentage chance this will spawn in the world. 0 - 100%
	Buyable = true, -- If true this weapon will be buyable from the shop
	Description = "The spirit of the west...",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	Price = 35000,
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The M98B
WeaponInfo = {
	WeaponType = "rifle", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/arccw/w_bfg.mdl", -- The icon used to display this weapon in derma menus
	Name = "arccw_m107",
	DisplayName = "BFG-50",
	Spawnable = false, -- If true this weapon will spawn in the world.
	SpawnProb = 2.0, -- The percentage chance this will spawn in the world. 0 - 100%
	Buyable = true, -- If true this weapon will be buyable from the shop
	Description = "You have a very small pair of balls for using this.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	Price = 35000,
	CritChance = 25, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The F1 Grenade
WeaponInfo = {
	WeaponType = "grenade", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/arccw/w_nade_frag.mdl", -- The icon used to display this weapon in derma menus
	Name = "arccw_nade_frag",
	DisplayName = "Frag Grenade",
	Spawnable = false, -- If true this weapon will spawn in the world.
	SpawnProb = 2.0, -- The percentage chance this will spawn in the world. 0 - 100%
	Buyable = false, -- If true this weapon will be buyable from the shop
	Description = "A classic explosive present.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	Price = 0,
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The Old Spade
WeaponInfo = {
	WeaponType = "melee", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/arccw/w_machete.mdl", -- The icon used to display this weapon in derma menus
	Name = "arccw_melee_machete",
	DisplayName = "Machete",
	Spawnable = false, -- If true this weapon will spawn in the world.
	SpawnProb = 2.0, -- The percentage chance this will spawn in the world. 0 - 100%
	Buyable = false, -- If true this weapon will be buyable from the shop
	Description = "You know why they would craft this? It's really good. Don't tell anybody that this has a 80 percent crit rate.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = true, -- A flag that signifies this is a craftable weapon
	MetalPrice = 10,
	CircuitsPrice = 0,
	FuelPrice = 0,
	Price = 0,
	CritChance = 82, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The Old Pistol
WeaponInfo = {
	WeaponType = "pistol", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/arccw/w_ragingbull.mdl", -- The icon used to display this weapon in derma menus
	Name = "arccw_ragingbull",
	DisplayName = "Old Revolver",
	Spawnable = false, -- If true this weapon will spawn in the world.
	SpawnProb = 2.0, -- The percentage chance this will spawn in the world. 0 - 100%
	Buyable = false, -- If true this weapon will be buyable from the shop
	Description = "This gun will outlive you. Someone's etched the name LEON on it.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = true, -- A flag that signifies this is a craftable weapon
	MetalPrice = 25,
	CircuitsPrice = 0,
	FuelPrice = 1,
	Price = 1000,
	CritChance = 8, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The Old Rifle
WeaponInfo = {
	WeaponType = "smg", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/arccw/w_tommygun.mdl", -- The icon used to display this weapon in derma menus
	Name = "arccw_tommygun",
	DisplayName = "Typewriter E2",
	Spawnable = false, -- If true this weapon will spawn in the world.
	SpawnProb = 2.0, -- The percentage chance this will spawn in the world. 0 - 100%
	Buyable = false, -- If true this weapon will be buyable from the shop
	Description = "The Typewriter. Used by the mafia, now used by you, the scum that you are.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = true, -- A flag that signifies this is a craftable weapon
	MetalPrice = 35,
	CircuitsPrice = 0,
	FuelPrice = 3,
	Price = 1500,
	CritChance = 5, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The Flamethrower
WeaponInfo = {
	WeaponType = "rifle", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/syndod/v_m2.mdl", -- The icon used to display this weapon in derma menus
	Name = "weapon_752_m2_flamethrower",
	DisplayName = "Flamethrower",
	Spawnable = false, -- If true this weapon will spawn in the world.
	SpawnProb = 2.0, -- The percentage chance this will spawn in the world. 0 - 100%
	Buyable = false, -- If true this weapon will be buyable from the shop
	Description = "Your ancestors must've fought on Iwo Jima.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = true, -- A flag that signifies this is a craftable weapon
	MetalPrice = 80,
	CircuitsPrice = 0,
	FuelPrice = 15,
	Price = 3000,
	CritChance = 0, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The Rail Gun
WeaponInfo = {
	WeaponType = "rifle", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/w_crossbow.mdl", -- The icon used to display this weapon in derma menus
	Name = "weapon_railcannon",
	DisplayName = "Rail Cannon",
	Spawnable = false, -- If true this weapon will spawn in the world.
	SpawnProb = 2.0, -- The percentage chance this will spawn in the world. 0 - 100%
	Buyable = false, -- If true this weapon will be buyable from the shop
	Description = "FRONT TOWARDS ENEMY.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = true, -- A flag that signifies this is a craftable weapon
	MetalPrice = 80,
	CircuitsPrice = 30,
	FuelPrice = 0,
	Price = 5000,
	CritChance = 0, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The Blunderkat
WeaponInfo = {
	WeaponType = "shotgun", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/w_blundergat.mdl", -- The icon used to display this weapon in derma menus
	Name = "deika_blundergat",
	DisplayName = "Demonic Shotgun",
	Spawnable = false, -- If true this weapon will spawn in the world.
	SpawnProb = 2.0, -- The percentage chance this will spawn in the world. 0 - 100%
	Buyable = false, -- If true this weapon will be buyable from the shop
	Description = "Are we going to get copyrighted for this?",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = true, -- A flag that signifies this is a craftable weapon
	MetalPrice = 100,
	CircuitsPrice = 0,
	FuelPrice = 20,
	Price = 8000,
	CritChance = 0, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The Tesla Gun
WeaponInfo = {
	WeaponType = "rifle", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/wunderwaffe.mdl", -- The icon used to display this weapon in derma menus
	Name = "weapon_teslagun",
	DisplayName = "Tesla Gun",
	Spawnable = false, -- If true this weapon will spawn in the world.
	SpawnProb = 2.0, -- The percentage chance this will spawn in the world. 0 - 100%
	Buyable = false, -- If true this weapon will be buyable from the shop
	Description = "Tesla wanted his inventions to be used for peace.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = true, -- A flag that signifies this is a craftable weapon
	MetalPrice = 150,
	CircuitsPrice = 50,
	FuelPrice = 30,
	Price = 10000,
	CritChance = 10, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The Hornet
WeaponInfo = {
	WeaponType = "smg", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/w_rif_ak47.mdl", -- The icon used to display this weapon in derma menus
	Name = "sfw_hornet",
	DisplayName = "Hornet",
	Spawnable = false, -- If true this weapon will spawn in the world.
	SpawnProb = 2.0, -- The percentage chance this will spawn in the world. 0 - 100%
	Buyable = true, -- If true this weapon will be buyable from the shop
	Description = "Ew. Get it off!",
	IsAlien = true, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	Price = 21000,
	CritChance = 2, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The Stinger
WeaponInfo = {
	WeaponType = "rifle", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/w_rif_ak47.mdl", -- The icon used to display this weapon in derma menus
	Name = "sfw_stinger",
	DisplayName = "Stinger",
	Spawnable = false, -- If true this weapon will spawn in the world.
	SpawnProb = 2.0, -- The percentage chance this will spawn in the world. 0 - 100%
	Buyable = true, -- If true this weapon will be buyable from the shop
	Description = "Creates mildly inconvenient pain",
	IsAlien = true, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	Price = 21000,
	CritChance = 1, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The Pulsar
WeaponInfo = {
	WeaponType = "rifle", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/w_rif_ak47.mdl", -- The icon used to display this weapon in derma menus
	Name = "sfw_pulsar",
	DisplayName = "Pulsar",
	Spawnable = false, -- If true this weapon will spawn in the world.
	SpawnProb = 2.0, -- The percentage chance this will spawn in the world. 0 - 100%
	Buyable = true, -- If true this weapon will be buyable from the shop
	Description = "Now you can buy yourself a suicide.",
	IsAlien = true, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	Price = 21000,
	CritChance = 1, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The AUG
WeaponInfo = {
	WeaponType = "rifle", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/w_rif_aug.mdl", -- The icon used to display this weapon in derma menus
	Name = "arccw_aug",
	DisplayName = "Para 556",
	Spawnable = true, -- If true this weapon will spawn in the world.
	SpawnProb = 2.0, -- The percentage chance this will spawn in the world. 0 - 100%
	Buyable = false, -- If true this weapon will be buyable from the shop
	Description = "Austrian bullpup. Olive green.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	AirDroppable = true, -- A flag that signifies that this weapon will appear in air drops.
	Price = 16000,
	CritChance = 4, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The MP7
WeaponInfo = {
	WeaponType = "smg", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/arccw/w_mp7.mdl", -- The icon used to display this weapon in derma menus
	Name = "arccw_mp7",
	DisplayName = "Lancet 4.6mm",
	Spawnable = true, -- If true this weapon will spawn in the world.
	SpawnProb = 2, -- The percentage chance this will spawn in the world. 0 - 100%
	Buyable = false, -- If true this weapon will be buyable from the shop
	Description = "A rapid fire SMG.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	AirDroppable = true, -- A flag that signifies that this weapon will appear in air drops.
	Price = 8000,
	CritChance = 8, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The Saiga 12
WeaponInfo = {
	WeaponType = "shotgun", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/w_rif_ak47.mdl", -- The icon used to display this weapon in derma menus
	Name = "arccw_saiga",
	DisplayName = "Type 8-K",
	Spawnable = true, -- If true this weapon will spawn in the world.
	SpawnProb = 2.0, -- The percentage chance this will spawn in the world. 0 - 100%
	Buyable = false, -- If true this weapon will be buyable from the shop
	Description = "Someone at the Kalash plant decided to make an AK 12 gauge.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	AirDroppable = true, -- A flag that signifies that this weapon will appear in air drops.
	Price = 10000,
	CritChance = 8, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The TMP
WeaponInfo = {
	WeaponType = "smg", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/w_smg_tmp.mdl", -- The icon used to display this weapon in derma menus
	Name = "arccw_tmp",
	DisplayName = "MPC-9",
	Spawnable = true, -- If true this weapon will spawn in the world.
	SpawnProb = 2.0, -- The percentage chance this will spawn in the world. 0 - 100%
	Buyable = false, -- If true this weapon will be buyable from the shop
	Description = "A silenced SMG.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	AirDroppable = true, -- A flag that signifies that this weapon will appear in air drops.
	Price = 9500,
	CritChance = 4, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The TAR21
WeaponInfo = {
	WeaponType = "rifle", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/w_rif_famas.mdl", -- The icon used to display this weapon in derma menus
	Name = "arccw_famas",
	DisplayName = "Canin C6",
	Spawnable = true, -- If true this weapon will spawn in the world.
	SpawnProb = 2.0, -- The percentage chance this will spawn in the world. 0 - 100%
	Buyable = false, -- If true this weapon will be buyable from the shop
	Description = "A bullpup rifle that people seem to like really more then they should.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	AirDroppable = true, -- A flag that signifies that this weapon will appear in air drops.
	Price = 14000,
	CritChance = 5, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- The Spas 12
WeaponInfo = {
	WeaponType = "shotgun", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/w_shotgun.mdl", -- The icon used to display this weapon in derma menus
	Name = "arccw_fleshy_spas12",
	DisplayName = "Sporter-12",
	Spawnable = true, -- If true this weapon will spawn in the world.
	SpawnProb = 2.0, -- The percentage chance this will spawn in the world. 0 - 100%
	Buyable = false, -- If true this weapon will be buyable from the shop
	Description = "The one shotgun used by Nova Prospekt guards that reduce your HP to nothing.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	AirDroppable = true, -- A flag that signifies that this weapon will appear in air drops.
	Price = 11000,
	CritChance = 12, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)
-- PRADIT BREAKER WHAT NO WHAT WHY
WeaponInfo = {
	WeaponType = "pistol", -- The type of weapon, can be melee, pistol, smg, shotgun, rifle
	DisplayModelName = "models/weapons/arccw/w_pradit1911.mdl", -- The icon used to display this weapon in derma menus
	Name = "arccw_pradit1911",
	DisplayName = "PRADIT BREAKER",
	Spawnable = false, -- If true this weapon will spawn in the world.
	SpawnProb = 2.0, -- The percentage chance this will spawn in the world. 0 - 100%
	Buyable = false, -- If true this weapon will be buyable from the shop
	Description = "Whatever you are doing with this, stop.",
	IsAlien = false, -- A flag that signifies this is an "alien" weapon
	Craftable = false, -- A flag that signifies this is a craftable weapon
	AirDroppable = true, -- A flag that signifies that this weapon will appear in air drops.
	Price = 12000,
	CritChance = 13, -- A percentage value, 0-100%. The chance of a critical hit.
}
table.insert(ConfigInfo["MarketFog"].Weapon, WeaponInfo)


-- The Apparel Settings -- Make sure there is always atleast one entry in this list.
-- 
ConfigInfo["MarketFog"].Apparel = {}
ConfigInfo["MarketFog"].Apparel[1] = {}
ConfigInfo["MarketFog"].Apparel[1].Name = "Grunt" -- This can be any name you want.
ConfigInfo["MarketFog"].Apparel[1].ModelName = "models/player/police.mdl" -- The model used by the player
ConfigInfo["MarketFog"].Apparel[1].ShopDisplayModel = "models/player/police.mdl"
ConfigInfo["MarketFog"].Apparel[1].ShopDesc = "Low armour and low carrying capacity"
ConfigInfo["MarketFog"].Apparel[1].Price = 1000
ConfigInfo["MarketFog"].Apparel[1].MaxArmour = 25
ConfigInfo["MarketFog"].Apparel[1].MaxMetal = 100
ConfigInfo["MarketFog"].Apparel[1].MaxCircuits = 15
ConfigInfo["MarketFog"].Apparel[1].MaxFuel = 5
ConfigInfo["MarketFog"].Apparel[1].MaxO2Canisters = 1
-- "Officer" Armor.
ConfigInfo["MarketFog"].Apparel[2] = {}
ConfigInfo["MarketFog"].Apparel[2].Name = "Officer"
ConfigInfo["MarketFog"].Apparel[2].ModelName = "models/player/jackathan/beta/elitepolice.mdl"
ConfigInfo["MarketFog"].Apparel[1].ShopDisplayModel = "models/player/jackathan/beta/elitepolice.mdl"
ConfigInfo["MarketFog"].Apparel[2].ShopDesc = "Direct upgrade from grunt armor."
ConfigInfo["MarketFog"].Apparel[2].Price = 2500
ConfigInfo["MarketFog"].Apparel[2].MaxArmour = 30
ConfigInfo["MarketFog"].Apparel[2].MaxMetal = 150
ConfigInfo["MarketFog"].Apparel[2].MaxCircuits = 20
ConfigInfo["MarketFog"].Apparel[2].MaxFuel = 6
ConfigInfo["MarketFog"].Apparel[1].MaxO2Canisters = 2
-- "Scavenger" Armor.
ConfigInfo["MarketFog"].Apparel[3] = {}
ConfigInfo["MarketFog"].Apparel[3].Name = "Scavenger"
ConfigInfo["MarketFog"].Apparel[3].ModelName = "models/player/combine_soldran.mdl"
ConfigInfo["MarketFog"].Apparel[1].ShopDisplayModel = "models/player/combine_soldran.mdl"
ConfigInfo["MarketFog"].Apparel[3].ShopDesc = "Okay armour and okay carrying capacity."
ConfigInfo["MarketFog"].Apparel[3].Price = 5000
ConfigInfo["MarketFog"].Apparel[3].MaxArmour = 30
ConfigInfo["MarketFog"].Apparel[3].MaxMetal = 200
ConfigInfo["MarketFog"].Apparel[3].MaxCircuits = 20
ConfigInfo["MarketFog"].Apparel[3].MaxFuel = 8
ConfigInfo["MarketFog"].Apparel[3].MaxO2Canisters = 2
-- "Packmule" Armor.
ConfigInfo["MarketFog"].Apparel[4] = {}
ConfigInfo["MarketFog"].Apparel[4].Name = "Packmule"
ConfigInfo["MarketFog"].Apparel[4].ModelName = "models/player/jackathan/beta/combine_soldier_3003.mdl"
ConfigInfo["MarketFog"].Apparel[1].ShopDisplayModel = "models/player/jackathan/beta/combine_soldier_3003.mdl"
ConfigInfo["MarketFog"].Apparel[4].ShopDesc = "Trades off armor for carrying space."
ConfigInfo["MarketFog"].Apparel[4].Price = 6500
ConfigInfo["MarketFog"].Apparel[4].MaxArmour = 10
ConfigInfo["MarketFog"].Apparel[4].MaxMetal = 500
ConfigInfo["MarketFog"].Apparel[4].MaxCircuits = 50
ConfigInfo["MarketFog"].Apparel[4].MaxFuel = 50
ConfigInfo["MarketFog"].Apparel[4].MaxO3Canisters = 4
-- "Ranger" Armor.
ConfigInfo["MarketFog"].Apparel[5] = {}
ConfigInfo["MarketFog"].Apparel[5].Name = "Ranger"
ConfigInfo["MarketFog"].Apparel[5].ModelName = "models/player/combine_soldur2.mdl"
ConfigInfo["MarketFog"].Apparel[1].ShopDisplayModel = "models/player/combine_soldur2.mdl"
ConfigInfo["MarketFog"].Apparel[5].ShopDesc = "A good amount of armour and good carrying capacity."
ConfigInfo["MarketFog"].Apparel[5].Price = 11000
ConfigInfo["MarketFog"].Apparel[5].MaxArmour = 50
ConfigInfo["MarketFog"].Apparel[5].MaxMetal = 300
ConfigInfo["MarketFog"].Apparel[5].MaxCircuits = 30
ConfigInfo["MarketFog"].Apparel[5].MaxFuel = 15
ConfigInfo["MarketFog"].Apparel[5].MaxO2Canisters = 3
-- "Soldier" Armor.
ConfigInfo["MarketFog"].Apparel[6] = {}
ConfigInfo["MarketFog"].Apparel[6].Name = "Soldier"
ConfigInfo["MarketFog"].Apparel[6].ModelName = "models/player/combine_soldinf.mdl"
ConfigInfo["MarketFog"].Apparel[6].ShopDisplayModel = "models/player/combine_soldinf.mdl"
ConfigInfo["MarketFog"].Apparel[6].ShopDesc = "Great armour and even better carrying capacity."
ConfigInfo["MarketFog"].Apparel[6].Price = 21000
ConfigInfo["MarketFog"].Apparel[6].MaxArmour = 75
ConfigInfo["MarketFog"].Apparel[6].MaxMetal = 400
ConfigInfo["MarketFog"].Apparel[6].MaxCircuits = 40
ConfigInfo["MarketFog"].Apparel[6].MaxFuel = 20
ConfigInfo["MarketFog"].Apparel[6].MaxO2Canisters = 4
-- "Charger" Armor.
ConfigInfo["MarketFog"].Apparel[7] = {}
ConfigInfo["MarketFog"].Apparel[7].Name = "Charger"
ConfigInfo["MarketFog"].Apparel[7].ModelName = "models/player/jackathan/beta/combine_soldier_2002.mdl"
ConfigInfo["MarketFog"].Apparel[7].ShopDisplayModel = "models/player/jackathan/beta/combine_soldier_2002.mdl"
ConfigInfo["MarketFog"].Apparel[7].ShopDesc = "High-end suit of armor."
ConfigInfo["MarketFog"].Apparel[7].Price = 30000
ConfigInfo["MarketFog"].Apparel[7].MaxArmour = 85
ConfigInfo["MarketFog"].Apparel[7].MaxMetal = 450
ConfigInfo["MarketFog"].Apparel[7].MaxCircuits = 45
ConfigInfo["MarketFog"].Apparel[7].MaxFuel = 25
ConfigInfo["MarketFog"].Apparel[7].MaxO2Canisters = 5
-- "Explorer" Armor.
ConfigInfo["MarketFog"].Apparel[8]= {}
ConfigInfo["MarketFog"].Apparel[8].Name = "Explorer"
ConfigInfo["MarketFog"].Apparel[8].ModelName = "models/player/combine_super_soldier.mdl"
ConfigInfo["MarketFog"].Apparel[8].ShopDisplayModel = "models/player/combine_super_soldier.mdl"
ConfigInfo["MarketFog"].Apparel[8].ShopDesc = "Excellent armour and carrying capacity."
ConfigInfo["MarketFog"].Apparel[8].Price = 40000
ConfigInfo["MarketFog"].Apparel[8].MaxArmour = 100
ConfigInfo["MarketFog"].Apparel[8].MaxMetal = 1000
ConfigInfo["MarketFog"].Apparel[8].MaxCircuits = 70
ConfigInfo["MarketFog"].Apparel[8].MaxFuel = 30
ConfigInfo["MarketFog"].Apparel[8].MaxO2Canisters = 6

--- Crafting Items
ConfigInfo["MarketFog"].PurchaseItems = {}
-- The Suit Battery
local ItemInfo = {
	Name = "Suit Battery (x1)", -- Name of the item to be displayed in the shop
	DisplayModelName = "models/Items/battery.mdl", -- The icon used to display this weapon in derma menus
	Description = "Armour (x10)", -- The display description
	Price = 20,
	Quantity = 10, -- The amount of this item that will be given to the player.
	ConsoleCommand = "shop_buy_armour" -- The console command to run when purchased.
}
table.insert(ConfigInfo["MarketFog"].PurchaseItems, ItemInfo)
-- The Oxygen Canister
ItemInfo = {
	Name = "Oxygen Canister (x1)", -- Name of the item to be displayed in the shop
	DisplayModelName = "models/Items/combine_rifle_ammo01.mdl", -- The icon used to display this weapon in derma menus
	Description = "Adds 25% to O2 when consumed", -- The display description
	Price = 1000,
	Quantity = 1, -- The amount of this item that will be given to the player.
	ConsoleCommand = "shop_buy_o2" -- The console command to run when purchased.
}
table.insert(ConfigInfo["MarketFog"].PurchaseItems, ItemInfo)
-- The Health Kit
ItemInfo = {
	Name = "Health (x1)", -- Name of the item to be displayed in the shop
	DisplayModelName = "models/Items/healthkit.mdl", -- The icon used to display this weapon in derma menus
	Description = "Heals target by 25%", -- The display description
	Price = 250,
	Quantity = 25, -- The amount of this item that will be given to the player.
	ConsoleCommand = "shop_buy_health" -- The console command to run when purchased.
}
table.insert(ConfigInfo["MarketFog"].PurchaseItems, ItemInfo)
-- The Phys Gun
ItemInfo = {
	Name = "Phys Gun (x1)", -- Name of the item to be displayed in the shop
	DisplayModelName = "models/weapons/w_physics.mdl", -- The icon used to display this weapon in derma menus
	Description = "Allows you to move props", -- The display description
	Price = 750,
	Quantity = 1, -- The amount of this item that will be given to the player.
	ConsoleCommand = "shop_buy_weapon", -- The console command to run when purchased.
	Classname = "weapon_physgun",
	DisplayName = "Phys Gun" -- The name displayed in the chat informing the player they bought the weapon.
}
table.insert(ConfigInfo["MarketFog"].PurchaseItems, ItemInfo)
-- The Tool Gun
ItemInfo = {
	Name = "Tool Gun (x1)", -- Name of the item to be displayed in the shop
	DisplayModelName = "models/weapons/w_toolgun.mdl", -- The icon used to display this weapon in derma menus
	Description = "Allows you to construct more advanced buildings", -- The display description
	Price = 2500,
	Quantity = 1, -- The amount of this item that will be given to the player.
	ConsoleCommand = "shop_buy_weapon", -- The console command to run when purchased.
	Classname = "gmod_tool",
	DisplayName = "Tool Gun" -- The name displayed in the chat informing the player they bought the weapon.
}
table.insert(ConfigInfo["MarketFog"].PurchaseItems, ItemInfo)


-- Some config data is set on a level by level basis. 
-- Config Info for the cityruin.bsp map
ConfigInfo["CityRuins"] = {}
ConfigInfo["CityRuins"].OxygenRate = 3 -- This is per second e.g. 1 unit of oxygen is lost every 1 second
ConfigInfo["CityRuins"].FogColour = Color(145, 125, 75, 255)
ConfigInfo["CityRuins"].FogDistance = 1500

ConfigInfo["CityRuins"].QuestStrings = {}


-- Config Info for the Zaton Maps
ConfigInfo["ZatonEvening"] = {}
ConfigInfo["ZatonEvening"].OxygenRate = 3
ConfigInfo["ZatonEvening"].FogColour = Color(158,134,126, 255)
ConfigInfo["ZatonEvening"].FogDistance = 4000

ConfigInfo["ZatonDay"] = {}
ConfigInfo["ZatonDay"].OxygenRate = 3
ConfigInfo["ZatonDay"].FogColour = Color(138,148,160, 255)
ConfigInfo["ZatonDay"].FogDistance = 4000

ConfigInfo["ZatonNight"] = {}
ConfigInfo["ZatonNight"].OxygenRate = 3
ConfigInfo["ZatonNight"].FogColour = Color(46,72,93, 255)
ConfigInfo["ZatonNight"].FogDistance = 4000




--.
