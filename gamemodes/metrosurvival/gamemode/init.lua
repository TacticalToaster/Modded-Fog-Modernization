----------------------------------
--	Market Fog	
--	Programmer : LIFO/Tednesday		
--	Date : 15/10/2018		
----------------------------------

--resource.AddWorkshop( "738364159" ) --blundercats
--resource.AddWorkshop( "767035145" ) -- infamy melee
--resource.AddWorkshop( "304625393" ) -- wunderwaffle
--resource.AddWorkshop( "681689569" ) --flamethrower
--resource.AddWorkshop( "764064561" ) -- infamy pistols
--resource.AddWorkshop( "764529727" ) -- infamy smgs
--resource.AddWorkshop( "372475588" ) --  rail cannon
--resource.AddWorkshop( "369546736" ) -- hsnova
--resource.AddWorkshop( "430501804" ) -- phys slugger
--resource.AddWorkshop( "420970650" ) -- iscifiweaps
--resource.AddWorkshop( "151539013" ) -- city ruins
--resource.AddWorkshop( "1227359878" ) -- burer and controller
--resource.AddWorkshop( "1205759235" ) -- resi tyrant
--resource.AddWorkshop( "922433152" ) -- pwb misc
--resource.AddWorkshop( "921842698" ) -- pwb machine gn
--resource.AddWorkshop( "923515273" ) -- pwb dlc
--resource.AddWorkshop( "918900571" ) -- pwb sniper
--resource.AddWorkshop( "916201112" ) -- pwb rifle
--resource.AddWorkshop( "917779957" ) -- pwb shotgun
--resource.AddWorkshop( "914808995" ) -- pwb smg
--resource.AddWorkshop( "913618147" ) -- pwb pistol
--resource.AddWorkshop( "1519864281" ) -- re5 mini boss
--resource.AddWorkshop( "1528924033" ) -- zaton
--resource.AddWorkshop( "1528932671" ) -- zaton contetn1
--resource.AddWorkshop( "1528938017" ) -- zaton content 2
--resource.AddWorkshop("378014558") -- gasmask metro pp overlays.
--resource.AddWorkshop("155092389") -- PP weather effects


-- OLD WORKSHOP CODE ABOVE --
-- NEW BELOW --

resource.AddWorkshop(2197650007) -- modded fog itself (arccw version)
resource.AddWorkshop(1528925370) -- Zaton (Night)
resource.AddWorkshop(1528932671) -- Zaton resource numero one
resource.AddWorkshop(1528938017) -- Zaton resource 2
resource.AddWorkshop(1227359878) -- Burer && Controller
resource.AddWorkshop(420970650) -- Darken scifi bujllshit
resource.AddWorkshop(372475588) -- Rail Cannon 
resource.AddWorkshop(738364159) -- the blundergat
resource.AddWorkshop(304625393) -- wunderwaffe
resource.AddWorkshop(681689569) -- m2 flame
resource.AddWorkshop(2131057232) -- arc base
resource.AddWorkshop(2131058270) -- arc m9k extras
resource.AddWorkshop(1519864281) -- minibosses
resource.AddWorkshop(378014558) -- metro 2033
resource.AddWorkshop(155092389) -- the horrible post processing plugin THAT IS FROM 2013 LOL
resource.AddWorkshop(151539013) -- city ruins
resource.AddWorkshop(2131256922) -- arc fesiug
resource.AddWorkshop(619791481) -- beta models hl2
resource.AddWorkshop(155822157) -- raising bar
resource.AddWorkshop(1205759235) -- tyrant snpc
resource.AddWorkshop(369546736) -- hs14 nova
resource.AddWorkshop(2411672781) -- l4d anims
resource.AddWorkshop(2143558752) -- xd reanims base
resource.AddWorkshop(2493356270) -- xd irons
resource.AddWorkshop(2169293226) -- xd radio chatter



resource.AddFile("sound/gasmask1.wav")
resource.AddFile("content/sound/gasmask1.wav")
resource.AddFile("sound/kaching.wav")
resource.AddFile("content/sound/kaching.wav")
resource.AddFile("sound/dontleave.wav")
resource.AddFile("content/sound/dontleave.wav")

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile("mapposinfo.lua")
AddCSLuaFile( "cl_net.lua" )
AddCSLuaFile( "cl_inventory.lua" )
AddCSLuaFile( "cl_quest1.lua" )
AddCSLuaFile( "cl_misc.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile("gm.lua")
AddCSLuaFile( "entity.lua")
AddCSLuaFile( "debug.lua")
AddCSLuaFile( "player.lua")
AddCSLuaFile( "spawndata.lua")
AddCSLuaFile("NPCSpawning.lua")
AddCSLuaFile("marketfogconfig.lua")
AddCSLuaFile("concommands.lua")
AddCSLuaFile ("cl_shapes.lua")
AddCSLuaFile("cl_gm.lua")

include ("mapposinfo.lua")
include ("marketfogconfig.lua")
include ("spawndata.lua")
include( "shared.lua" )
include("entity.lua")
include("debug.lua")
include("player.lua")
include("NPCSpawning.lua")
include("concommands.lua")
include("gm.lua")

util.AddNetworkString( "GasMaskSoundStart" )
util.AddNetworkString( "UpdateResource" )
util.AddNetworkString( "UpdateAirdrop" )
util.AddNetworkString( "SendHintId" )
util.AddNetworkString( "SendHintIdTable")
util.AddNetworkString( "SendLevelDataTable")
util.AddNetworkString( "SendClientGUIMarkerTable")
util.AddNetworkString( "SendConfigInfo_Gameplay")
util.AddNetworkString( "SendConfigInfo_Weapons")
util.AddNetworkString( "SendConfigInfo_Apparel")
util.AddNetworkString( "SendConfigInfo_Items")
util.AddNetworkString( "SendCurrentHunterMission")
util.AddNetworkString( "SendKeyCodes")


util.AddNetworkString( "MFQuestIntro")
util.AddNetworkString( "MFQuestSubway")
util.AddNetworkString( "MFQuestStreet")
util.AddNetworkString( "MFQuestParking")
util.AddNetworkString( "MFQuestShop")
util.AddNetworkString( "MFQuestPlaza")
util.AddNetworkString( "MFQuestApartment")
util.AddNetworkString( "MFQuestLab01")
util.AddNetworkString( "MFQuestLab02")
util.AddNetworkString( "MFQuestLab03")
util.AddNetworkString( "MFHunterMenu")
util.AddNetworkString( "MFKeypadOpen")
util.AddNetworkString( "MFShopOpen" )


util.AddNetworkString ("MFActivateSelfDestruct")
util.AddNetworkString("SendLabWarningMessage")
util.AddNetworkString("SendSelfDestructWarningMessage")
util.AddNetworkString("SendSelfDestructCountdown")
util.AddNetworkString("SendInEvac")
util.AddNetworkString("SendNotInEvac")
util.AddNetworkString("SendSelfDestruct")

VersionStr = "1.5.0"

Metal = {}
Metal["MaxPrice"] = 100;
Metal["Price"] = 5
Metal["Supply"] = 2000

Circuits = {}
Circuits["MaxPrice"] = 1000;
Circuits["Price"] = 50
Circuits["Supply"] = 1000

Fuel = {}
Fuel["MaxPrice"] = 10000;
Fuel["Price"] = 150
Fuel["Supply"] = 500

BillZombieEntity = nil
PlayerLabSpawn = Vector(-1605.2127685547, -4752.8715820313, -376.88330078125)


-- look at this later --

-- Hunter Missions
HunterMissions = {}

CurrentHunterMission = {
	CurrentlyOngoing = false,
	HuntMission = 0,
	NPC = nil,
	Reward = 0,
	Position = Vector(0, 0, 0)
}

KeyCodes = {}

function CalculatePrices()

	local baseMetalPrice = Metal["MaxPrice"]
	local baseCircuitsPrice = Circuits["MaxPrice"]
	local baseFuelPrice = Fuel["MaxPrice"]
	
	local metal = Metal["Supply"]
	local circuits = Circuits["Supply"]
	local fuel = Fuel["Supply"]

	-- Calculate the supply curve
	local as = 1 -- This is arbitrary.
	local bmin = 0
	local bmax = 20
	local metalSupplyMax = 2000
	local circuitsSupplyMax = 1000
	local fuelSupplyMax = 500
	
	-- Calculate the demand curve

	local bd = 1 -- I'm just gonna make my demand a fixed rate. Could change with the amount of people on the server?
	
	-- This is the gradient. If I've got a lot of supply then the gradient should be shallow.
	-- if not then the gradient should be high
	local ad = baseMetalPrice;
	local bs = ((metal / metalSupplyMax) * (bmax - bmin)) + bmin	
	local price = (ad + as) / (bs + bd)
	price = math.Round(price)
	Metal["Price"] = price
	
	ad = baseCircuitsPrice
	bs = ((circuits / circuitsSupplyMax) * (bmax - bmin)) + bmin	
	price = (ad + as) / (bs + bd)
	price = math.Round(price)
	SetGlobalInt("CircuitsPrice", price)
	Circuits["Price"] = price
	
	ad = baseFuelPrice
	bs = ((fuel / fuelSupplyMax) * (bmax - bmin)) + bmin	
	price = (ad + as) / (bs + bd)
	price = math.Round(price)
	Fuel["Price"] = price
	
	SendResourceDataToClients()	
end

function SendResourceDataToClients()

	net.Start("UpdateResource")
	net.WriteUInt( Metal["Price"], 32) 
	net.WriteUInt( Metal["Supply"], 32 ) 
	net.WriteUInt( Circuits["Price"], 32 ) 
	net.WriteUInt( Circuits["Supply"], 32 ) 
	net.WriteUInt( Fuel["Price"], 32 ) 
	net.WriteUInt( Fuel["Supply"], 32 ) 
	net.Broadcast()

end

function SendAirdropDataToClients()

	net.Start("UpdateAirdrop")
	net.WriteVector( Airdrop.CachePos ) 
	net.Broadcast()

end

function SendHint(ply, hintid, timeout)

	net.Start("SendHintId")
	net.WriteUInt(hintid, 32)
	net.WriteUInt(timeout, 32)
	net.Send(ply)

end

function SendHintTable(ply)
	net.Start("SendHintIdTable")
	net.WriteTable(HintTable)
	net.WriteTable(HintEnum)
	print("Hint Bytes: "..net.BytesWritten()) 
	net.Send(ply)
end 

		
function SendCurrentHunterMission(ply)
	net.Start("SendCurrentHunterMission")
	net.WriteTable(CurrentHunterMission)
	net.Send(ply)
end 

function BroadcastCurrentHunterMission()

	net.Start("SendCurrentHunterMission")
	net.WriteTable(CurrentHunterMission)
	net.Broadcast()
	
end

function SendConfigInfo_Gameplay(ply)
	net.Start("SendConfigInfo_Gameplay")
	net.WriteTable(ConfigInfo["MarketFog"].Gameplay)
		print("Gameplay Bytes: "..net.BytesWritten()) 
	net.Send(ply)

end

function SendConfigInfo_Weapons(ply)
	net.Start("SendConfigInfo_Weapons")
	net.WriteTable(ConfigInfo["MarketFog"].Weapon)
		print("Weapon Bytes: "..net.BytesWritten()) 
	net.Send(ply)

end

function SendConfigInfo_Apparel(ply)
	net.Start("SendConfigInfo_Apparel")
	net.WriteTable(ConfigInfo["MarketFog"].Apparel)
		print("Apparel Bytes: "..net.BytesWritten()) 
	net.Send(ply)

end

function SendConfigInfo_Items(ply)
	net.Start("SendConfigInfo_Items")
	net.WriteTable(ConfigInfo["MarketFog"].PurchaseItems)
		print("Items Bytes: "..net.BytesWritten()) 
	net.Send(ply)

end

function SendLevelDataTable(ply)
	net.Start("SendLevelDataTable")
	net.WriteTable(LevelData)
	print("Level Bytes: "..net.BytesWritten()) 
	net.Send(ply)
end

function SendClientGUIMarkerTable(ply)
	net.Start("SendClientGUIMarkerTable")
	net.WriteTable(GUIMarkerData)
	print("GUI Bytes: "..net.BytesWritten()) 
	net.Send(ply)
end

function SendKeyCodes(ply)

	net.Start("SendKeyCodes")
	net.WriteTable(KeyCodes)
	net.Send(ply)

end


function SendMFQuestIntro(ply)

	net.Start("MFQuestIntro") 
	print("Quest Bytes: "..net.BytesWritten()) 	
	net.Send(ply)
end

function SendMFQuestSubway(ply)

	net.Start("MFQuestSubway") 
	print("Quest Bytes: "..net.BytesWritten()) 	
	net.Send(ply)
end

function SendMFQuestStreet(ply)

	net.Start("MFQuestStreet") 
	print("Quest Bytes: "..net.BytesWritten()) 	
	net.Send(ply)
end

function SendMFQuestParking(ply)

	net.Start("MFQuestParking") 
	print("Quest Bytes: "..net.BytesWritten()) 	
	net.Send(ply)
end

function SendMFQuestShop(ply)

	net.Start("MFQuestShop") 
	print("Quest Bytes: "..net.BytesWritten()) 	
	net.Send(ply)
end

function SendMFQuestPlaza(ply)

	net.Start("MFQuestPlaza") 
	print("Quest Bytes: "..net.BytesWritten()) 	
	net.Send(ply)
end

function SendMFQuestApartment(ply)

	net.Start("MFQuestApartment") 
	print("Quest Bytes: "..net.BytesWritten()) 	
	net.Send(ply)
end

function SendMFQuestLab01(ply)

	net.Start("MFQuestLab01") 
	print("Quest Bytes: "..net.BytesWritten()) 	
	net.Send(ply)
end

function SendMFQuestLab02(ply)

	net.Start("MFQuestLab02") 
	print("Quest Bytes: "..net.BytesWritten()) 	
	net.Send(ply)
end

function SendMFQuestLab03(ply)

	net.Start("MFQuestLab03") 
	print("Quest Bytes: "..net.BytesWritten()) 	
	net.Send(ply)
end

function SendMFHunterMenu(ply)

	net.Start("MFHunterMenu") 
	print("Quest Bytes: "..net.BytesWritten()) 	
	net.Send(ply)
end

function SendMFKeypadOpen(ply)

	net.Start("MFKeypadOpen") 
	print("Quest Bytes: "..net.BytesWritten()) 	
	net.Send(ply)
end

function SendMFShopOpen(ply)

	net.Start("MFShopOpen") 
	print("Quest Bytes: "..net.BytesWritten()) 	
	net.Send(ply)
end

function GetWeaponTable()

	return ConfigInfo["MarketFog"].Weapon
end

RainWeather = {
IsRainingFlag = false,
NextRainStorm = 0,
RainEndsAt = 0,
}

function IsInside(plypos, ply)

	if (LevelData.GasScrubbedFlag) then return true end
	
	if (LevelData.CityRuinsFlag == 1) then
		return (plypos.z <= LevelData.GasHeight)
	else
		return PlayerInSafeZone(ply)	
	end
end

MapWeaponNameToType = {}

function WeaponClassToWeaponTypeMap()

	for i=1,table.Count(ConfigInfo["MarketFog"].Weapon) do 
		local weaponname = ConfigInfo["MarketFog"].Weapon[i].Name
		local wtype = "rifle"
		local wcrit = 0
		
		if (ConfigInfo["MarketFog"].Weapon[i].WeaponType ~= nil) then wtype = ConfigInfo["MarketFog"].Weapon[i].WeaponType end
		if (ConfigInfo["MarketFog"].Weapon[i].CritChance ~= nil) then wcrit = ConfigInfo["MarketFog"].Weapon[i].CritChance end
		
		MapWeaponNameToType[weaponname] = {
			weapontype = wtype,
			weaponcrit = wcrit	
		}
	end 
end

function InitHunterMissions()
	
	local Hunted = {Name = "npc_antlionguard", Price = 2000, Health = 850}
	table.insert(HunterMissions, Hunted )
	Hunted = {Name = "npc_stalker_controller", Price = 7000, Health = 850}
	table.insert(HunterMissions, Hunted )
	Hunted = {Name = "npc_stalker_burer", Price = 6000, Health = 850}
	table.insert(HunterMissions, Hunted )
	Hunted = {Name = "npc_re_tyrant", Price = 20000, Health = 1500}
	table.insert(HunterMissions, Hunted )
	
	CurrentHunterMission.HuntMission = math.random(table.Count(HunterMissions))
	CurrentHunterMission.Reward = HunterMissions[CurrentHunterMission.HuntMission].Price
	

end

function InitWeather()

	RainWeather.NextRainStorm = CurTime() + math.random(ConfigInfo["MarketFog"].Gameplay.WeatherRainFrequencyMin, ConfigInfo["MarketFog"].Gameplay.WeatherRainFrequencyMax)
	RainWeather.RainEndsAt = CurTime() + math.random(ConfigInfo["MarketFog"].Gameplay.WeatherRainDurationMin, ConfigInfo["MarketFog"].Gameplay.WeatherRainDurationMax)

end

function GM:InitPostEntity()

	-- Load map specific Data
	if (LoadMapData()) then
	
		-- Create table for prop data.
		InitHunterMissions()
		InitWeather()
		
		WeaponClassToWeaponTypeMap()
	
		print("loaded map data")
		CreateGrid()
		PopulateNPCGrid(NPCPositionData)
		PopulateItemGrid(ItemPositionData, "normal")
		PopulateItemGrid(CratePositionData, "crate")	
			

		
		local o2Dispensor = ents.Create( "oxygen_dispenser" )
		o2Dispensor:SetPos( ObjectPositionData.O2 )
		o2Dispensor:Spawn()
			
		local shopDispensor = ents.Create( "shop_dispensor" )
		shopDispensor:SetPos( Vector(ObjectPositionData.Shop.x, ObjectPositionData.Shop.y, ObjectPositionData.Shop.z) )
		local ang = shopDispensor:GetAngles();
		ang:RotateAroundAxis(shopDispensor:GetUp(), ObjectPositionData.Shop.angle);
		shopDispensor:SetAngles(ang);	
		shopDispensor:Spawn()
	
		local huntersTerminal = ents.Create( "quest_computer" )
		huntersTerminal:SetPos(  Vector(ObjectPositionData.HunterTerminal.x, ObjectPositionData.HunterTerminal.y, ObjectPositionData.HunterTerminal.z)   )
		local ang = huntersTerminal:GetAngles();
		ang:RotateAroundAxis(huntersTerminal:GetUp(), ObjectPositionData.HunterTerminal.angle);
		huntersTerminal:SetAngles(ang);	
		huntersTerminal:Spawn()
		huntersTerminal:SetComputerType(99)
		
		local introTerminal = ents.Create( "quest_computer" )
		introTerminal:SetPos(  Vector(ObjectPositionData.IntroTerminal.x, ObjectPositionData.IntroTerminal.y, ObjectPositionData.IntroTerminal.z)   )
		local ang = introTerminal:GetAngles();
		ang:RotateAroundAxis(introTerminal:GetUp(), ObjectPositionData.IntroTerminal.angle);
		introTerminal:SetAngles(ang);	
		introTerminal:Spawn()
		introTerminal:SetComputerType(0)
		
		local subwayTerminal = ents.Create( "quest_computer" )
		subwayTerminal:SetPos( Vector(ObjectPositionData.SubwayTerminal.x, ObjectPositionData.SubwayTerminal.y, ObjectPositionData.SubwayTerminal.z)  )
		local ang = subwayTerminal:GetAngles();
		ang:RotateAroundAxis(subwayTerminal:GetUp(), ObjectPositionData.SubwayTerminal.angle);
		subwayTerminal:SetAngles(ang);	
		subwayTerminal:Spawn()
		subwayTerminal:SetComputerType(1)
		
		local streetTerminal = ents.Create("quest_computer")
		streetTerminal:SetPos( Vector(ObjectPositionData.StreetTerminal.x, ObjectPositionData.StreetTerminal.y, ObjectPositionData.StreetTerminal.z) )
		local ang = streetTerminal:GetAngles();
		ang:RotateAroundAxis(streetTerminal:GetUp(), ObjectPositionData.StreetTerminal.angle);
		streetTerminal:SetAngles(ang);	
		streetTerminal:Spawn()
		streetTerminal:SetComputerType(2)
		
		local parkingTerminal = ents.Create("quest_computer")
		parkingTerminal:SetPos(Vector(ObjectPositionData.ParkingTerminal.x, ObjectPositionData.ParkingTerminal.y, ObjectPositionData.ParkingTerminal.z) )
		local ang = parkingTerminal:GetAngles();
		ang:RotateAroundAxis(parkingTerminal:GetUp(), ObjectPositionData.ParkingTerminal.angle);
		parkingTerminal:SetAngles(ang);	
		parkingTerminal:Spawn()
		parkingTerminal:SetComputerType(3)
		
		local shopTerminal = ents.Create("quest_computer")
		shopTerminal:SetPos(  Vector(ObjectPositionData.ShopTerminal.x, ObjectPositionData.ShopTerminal.y, ObjectPositionData.ShopTerminal.z)  )
		local ang = shopTerminal:GetAngles();
		ang:RotateAroundAxis(shopTerminal:GetUp(), ObjectPositionData.ShopTerminal.angle);
		shopTerminal:SetAngles(ang);	
		shopTerminal:Spawn()
		shopTerminal:SetComputerType(4)
		
		local plazaTerminal = ents.Create("quest_computer")
		plazaTerminal:SetPos(  Vector(ObjectPositionData.PlazaTerminal.x, ObjectPositionData.PlazaTerminal.y, ObjectPositionData.PlazaTerminal.z)  )
		local ang = plazaTerminal:GetAngles();
		ang:RotateAroundAxis(plazaTerminal:GetUp(), ObjectPositionData.PlazaTerminal.angle);
		plazaTerminal:SetAngles(ang);	
		plazaTerminal:Spawn()
		plazaTerminal:SetComputerType(5)

		local apartmentTerminal = ents.Create("quest_computer")
		apartmentTerminal:SetPos( 	Vector(ObjectPositionData.ApartmentTerminal.x, ObjectPositionData.ApartmentTerminal.y, ObjectPositionData.ApartmentTerminal.z)   )
		local ang = apartmentTerminal:GetAngles();
		ang:RotateAroundAxis(apartmentTerminal:GetUp(), ObjectPositionData.ApartmentTerminal.angle);
		apartmentTerminal:SetAngles(ang);	
		apartmentTerminal:Spawn()
		apartmentTerminal:SetComputerType(6)
		
		local labkeypad = ents.Create("lab_keypad")
		labkeypad:SetPos( Vector(ObjectPositionData.LabKeyPad.x, ObjectPositionData.LabKeyPad.y, ObjectPositionData.LabKeyPad.z)  )
		local ang = labkeypad:GetAngles();
		ang:RotateAroundAxis(labkeypad:GetUp(), ObjectPositionData.LabKeyPad.angle);
		labkeypad:SetAngles(ang);	
		labkeypad:Spawn()
		
		if (LevelData.TeleportSafeRoom == 1) then -- i.e for city ruins
			-- Create the lab  
			local container = ents.Create("prop_physics")
			container:SetModel("models/props_wasteland/cargo_container01b.mdl")
			container:SetPos(Vector(-1716.9343261719, -4779.1293945313, -325.96875) )
			container:SetUnFreezable( true )
			local ang = container:GetAngles();
			ang:RotateAroundAxis(container:GetUp(), 90);
			container:SetAngles(ang);
			container:Spawn()
			container:SetCanDestroy(false)
			container:SetPropOwner("world")
			local phys = container:GetPhysicsObject()
			if phys and phys:IsValid() then
				phys:EnableMotion(false) -- Freezes the object in place.
			end
			
				local door = ents.Create("prop_physics")
			door:SetModel("models/props_lab/blastdoor001c.mdl")
			door:SetPos( Vector(-1526.9400634766, -4780.3505859375, -376.88330078125) )
			door:SetUnFreezable( true )
			local ang = door:GetAngles();
			ang:RotateAroundAxis(door:GetUp(), 0);
			door:SetAngles(ang);
			door:Spawn()
			door:SetCanDestroy(false)
			door:SetPropOwner("world")
			local phys = door:GetPhysicsObject()
			if phys and phys:IsValid() then
				phys:EnableMotion(false) -- Freezes the object in place.
			end
			
			local labterminal1 = ents.Create("quest_computer")
			labterminal1:SetPos( 	Vector(-1605.2620849609, -4820.533203125, -376.88330078125)  )
			local ang = labterminal1:GetAngles();
			ang:RotateAroundAxis(labterminal1:GetUp(), 90);
			labterminal1:SetAngles(ang);	
			labterminal1:Spawn()
			labterminal1:SetComputerType(10)
			
			local labterminal2 = ents.Create("quest_computer")
			labterminal2:SetPos( 	Vector(-1735.0993652344, -4740.8266601563, -376.88330078125) )
			local ang = labterminal2:GetAngles();
			ang:RotateAroundAxis(labterminal2:GetUp(), -90);
			labterminal2:SetAngles(ang);	
			labterminal2:Spawn()
			labterminal2:SetComputerType(11)
					 
			local labterminal3 = ents.Create("quest_computer")
			labterminal3:SetPos( 	Vector(-1892.4312744141, -4777.9985351563, -376.88330078125)  )
			local ang = labterminal3:GetAngles();
			ang:RotateAroundAxis(labterminal3:GetUp(), 0);
			labterminal3:SetAngles(ang);	
			labterminal3:Spawn()
			labterminal3:SetComputerType(12)
			
			local combinetower1 = ents.Create("prop_physics")
			combinetower1:SetModel("models/props_combine/combinetower001.mdl")
			combinetower1:SetPos( Vector(-3167.6892089844, -1658.7762451172, -113.96875) )
			combinetower1:SetUnFreezable( true )
			local ang = combinetower1:GetAngles();
			ang:RotateAroundAxis(combinetower1:GetUp(), 0);
			combinetower1:SetAngles(ang);
			combinetower1:Spawn()
			combinetower1:SetCanDestroy(false)
			combinetower1:SetPropOwner("world")
			local phys = combinetower1:GetPhysicsObject()
			if phys and phys:IsValid() then
				phys:EnableMotion(false) -- Freezes the object in place.
			end
			
			local combinetower2 = ents.Create("prop_physics")
			combinetower2:SetModel("models/props_combine/combinetower001.mdl")
			combinetower2:SetPos( Vector(-4434.8276367188, -1671.3947753906, -113.96875) )
			combinetower2:SetUnFreezable( true )
			local ang = combinetower2:GetAngles();
			ang:RotateAroundAxis(combinetower2:GetUp(), 90);
			combinetower2:SetAngles(ang);
			combinetower2:Spawn()
			combinetower2:SetCanDestroy(false)
			combinetower2:SetPropOwner("world")
			local phys = combinetower2:GetPhysicsObject()
			if phys and phys:IsValid() then
				phys:EnableMotion(false) -- Freezes the object in place.
			end
			
			local combinebooth1 = ents.Create("prop_physics")
			combinebooth1:SetModel("models/props_combine/combine_booth_short01a.mdl")
			combinebooth1:SetPos( Vector(-3207.1223144531, -436.20687866211, -363.96875) )
			combinebooth1:SetUnFreezable( true )
			local ang = combinebooth1:GetAngles();
			ang:RotateAroundAxis(combinebooth1:GetUp(), 90);
			combinebooth1:SetAngles(ang);
			combinebooth1:Spawn()
			combinebooth1:SetCanDestroy(false)
			combinebooth1:SetPropOwner("world")
			local phys = combinebooth1:GetPhysicsObject()
			if phys and phys:IsValid() then
				phys:EnableMotion(false) -- Freezes the object in place.
			end
			
			local combinebooth2 = ents.Create("prop_physics")
			combinebooth2:SetModel("models/props_combine/combine_booth_short01a.mdl")
			combinebooth2:SetPos( Vector(-4954.509765625, -431.4140625, -363.96875) )
			combinebooth2:SetUnFreezable( true )
			local ang = combinebooth2:GetAngles();
			ang:RotateAroundAxis(combinebooth2:GetUp(), 90);
			combinebooth2:SetAngles(ang);
			combinebooth2:Spawn()
			combinebooth2:SetCanDestroy(false)
			combinebooth2:SetPropOwner("world")
			local phys = combinebooth2:GetPhysicsObject()
			if phys and phys:IsValid() then
				phys:EnableMotion(false) -- Freezes the object in place.
			end	
			
		else
			
				local labterminal1 = ents.Create("quest_computer")
				labterminal1:SetPos( 	Vector(ObjectPositionData.Computer1.x,ObjectPositionData.Computer1.y,ObjectPositionData.Computer1.z)  )
				local ang = labterminal1:GetAngles();
				ang:RotateAroundAxis(labterminal1:GetUp(), ObjectPositionData.Computer1.angle);
				labterminal1:SetAngles(ang);	
				labterminal1:Spawn()
				labterminal1:SetComputerType(10)
				
				local labterminal2 = ents.Create("quest_computer")
				labterminal2:SetPos( 	Vector(ObjectPositionData.Computer2.x,ObjectPositionData.Computer2.y,ObjectPositionData.Computer2.z) )
				local ang = labterminal2:GetAngles();
				ang:RotateAroundAxis(labterminal2:GetUp(), ObjectPositionData.Computer2.angle);
				labterminal2:SetAngles(ang);	
				labterminal2:Spawn()
				labterminal2:SetComputerType(11)
						 
				local labterminal3 = ents.Create("quest_computer")
				labterminal3:SetPos( 	Vector(ObjectPositionData.Computer3.x,ObjectPositionData.Computer3.y,ObjectPositionData.Computer3.z)  )
				local ang = labterminal3:GetAngles();
				ang:RotateAroundAxis(labterminal3:GetUp(), ObjectPositionData.Computer3.angle);
				labterminal3:SetAngles(ang);	
				labterminal3:Spawn()
				labterminal3:SetComputerType(12)
			
				LevelData.LabDoor = ents.Create("prop_physics")
				LevelData.LabDoor:SetModel("models/props_lab/blastdoor001c.mdl")
				LevelData.LabDoor:SetPos( Vector(ObjectPositionData.LabBlastDoor.x,ObjectPositionData.LabBlastDoor.y,ObjectPositionData.LabBlastDoor.z) )
				LevelData.LabDoor:SetUnFreezable( true )
				local ang = LevelData.LabDoor:GetAngles();
				ang:RotateAroundAxis(LevelData.LabDoor:GetUp(), ObjectPositionData.LabBlastDoor.angle);
				LevelData.LabDoor:SetAngles(ang);
				LevelData.LabDoor:Spawn()
				LevelData.LabDoor:SetCanDestroy(false)
				LevelData.LabDoor:SetPropOwner("world")
				local phys = LevelData.LabDoor:GetPhysicsObject()
				if phys and phys:IsValid() then
					phys:EnableMotion(false) -- Freezes the object in place.
				end
			
		end	

	end
		
	KeyCodes["JeffKey"] = math.random(0, 512)
	KeyCodes["BillKey"] = math.random(0, 512)
	KeyCodes["JohnKey"] = math.random(0, 512)
	KeyCodes["AnnaKey"] = math.random(0, 512)
	KeyCodes["GrahamKey"] = math.random(0, 512)

	
	SetGlobalInt("LabChoiceMade", 0) -- 0 - no choice made, 1 - weapons chosen, 2 - pump chosen
	
	CalculatePrices()
	LoadEntityData()
end

--.
