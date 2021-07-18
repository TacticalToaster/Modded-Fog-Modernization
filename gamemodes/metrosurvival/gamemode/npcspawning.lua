----------------------------------
--	Market Fog	
--	Programmer : LIFO/Tednesday		
--	Date : 15/10/2018		
----------------------------------

local NonPlayerCharacter = FindMetaTable("NPC")

-- Make sure these create widths and lengths of even numbers
cellw = 0
celll = 0

Airdrop = {CachePos = Vector(0,0,0), Ent = nil, Timeout = 300, NextTime = 5}
NPCGrid={}
-- Break up the map into NPC grids
function CreateGrid()

	-- a 16 by 16 grid.
	local levelw = LevelData.LevelXMax - LevelData.LevelXMin
	local levell = LevelData.LevelYMax - LevelData.LevelYMin
	cellw = levelw / LevelData.SpawnGridSize
	celll = levell / LevelData.SpawnGridSize
	
	for x=0, LevelData.SpawnGridSize-1 do
		NPCGrid[x] = {}
		for y=0, LevelData.SpawnGridSize-1 do
			NPCGrid[x][y] = { minx = LevelData.LevelXMin + (cellw * x),
							  miny = LevelData.LevelYMin + (celll * y),
							  maxx = LevelData.LevelXMin + (cellw * x) + cellw,
							  maxy = LevelData.LevelYMin + (celll * y) + celll,
							  centre = Vector(LevelData.LevelXMin + (cellw * x) + (cellw/2), LevelData.LevelYMin + (celll * y) + (celll/2), 0),
							  despawn = true,
							  personInRadius = false,
							  personInRadiusLast = false,
							  npcspawnpoints = {},
							  itemspawnpoints = {}
							}
		end	
	end

end

function SpawnCell(x, y)

	for i=1, table.Count(NPCGrid[x][y].npcspawnpoints) do

		if (NPCGrid[x][y].npcspawnpoints[i].counter > 0 and CurTime() > NPCGrid[x][y].npcspawnpoints[i].spawntime) then
		
			SpawnEachNPC(NPCGrid[x][y].npcspawnpoints[i])
		end	
	end
	

	for i=1, table.Count(NPCGrid[x][y].itemspawnpoints) do


	
		if (NPCGrid[x][y].itemspawnpoints[i].counter > 0 and CurTime() > NPCGrid[x][y].itemspawnpoints[i].spawntime) then
		
			SpawnEachItem(NPCGrid[x][y].itemspawnpoints[i])
		end	
	end
	
end

function SpawnAndDespawnCells()

	for x=0, LevelData.SpawnGridSize-1 do
		for y=0, LevelData.SpawnGridSize-1 do
		
			-- If there is a person in my radius and there wasn't a person in this radius last time. then do a poo
			if (NPCGrid[x][y].personInRadius and not NPCGrid[x][y].personInRadiusLast) then
				SpawnCell(x,y)
				NPCGrid[x][y].personInRadiusLast = true
			elseif(not NPCGrid[x][y].personInRadius and NPCGrid[x][y].personInRadiusLast) then
				NPCGrid[x][y].personInRadiusLast = false
			end
			NPCGrid[x][y].personInRadius = false
		end	
	end
	
	for k, v in pairs( ents.GetAll() ) do
		
		if (IsValid(v) and v.parentSpawnpoint ~= nil) then
			local npcpos = v:GetPos()
			local ix = math.floor((npcpos.x - LevelData.LevelXMin) / cellw)
			local iy = math.floor((npcpos.y - LevelData.LevelYMin) / celll)
			if ix >= 0 and ix < LevelData.SpawnGridSize and iy >= 0 and iy < LevelData.SpawnGridSize and NPCGrid[ix][iy].despawn then
				v.parentSpawnpoint.counter = v.parentSpawnpoint.counter + 1
				v:Remove()
			end
		end
		
		if (IsValid(v) and v.deleteTimer ~= nil) then
			if (CurTime() >= v.deleteTimer) then v:Remove() end
		end	
		
		if (IsValid(v) and v:IsNPC() and v:GetClass() == "npc_antlion" and v.antlionUnburrowed ~= nil and not v.antlionUnburrowed) then
			for k, j in pairs(player.GetAll()) do
				local dist = v:GetPos():Distance(j:GetPos())
				if (dist <= 400) then
					v:Fire("Unburrow","",0)
					v.antlionUnburrowed = true
				end
			end
		end
	end	
end

function ResetGrid()
	
	--PrintTable(LevelData)
	for x=0, LevelData.SpawnGridSize-1 do
		for y=0, LevelData.SpawnGridSize-1 do
			
			NPCGrid[x][y].despawn = true
		end	
	end
end

function PlayerCheckGrid(ply)

--PrintTable(LevelData)
	local pos = ply:GetPos()
	local pos2d = Vector(pos.x, pos.y, 0)
	for x=0, LevelData.SpawnGridSize-1 do
	
		for y=0, LevelData.SpawnGridSize-1 do
		
			if (pos2d:Distance(NPCGrid[x][y].centre)) < 3000 then
			
				NPCGrid[x][y].despawn = false
				NPCGrid[x][y].personInRadius = true
			end
	
		end	
	end
end

function PopulateNPCGrid(npcdatatable)

	local count = table.Count(npcdatatable)		
	for i=1, count do
		local ix = math.floor((npcdatatable[i].x - LevelData.LevelXMin) / cellw)
		if (ix < 0 or ix > LevelData.SpawnGridSize-1) then return end
		local iy = math.floor((npcdatatable[i].y - LevelData.LevelYMin) / celll) 
		if (iy < 0 or iy > LevelData.SpawnGridSize-1) then return end
		
		local entry = {npcpos = Vector(npcdatatable[i].x, npcdatatable[i].y, npcdatatable[i].z), npcangle = Angle(0, 0, 0), counter = 1, npcspawntype =  npcdatatable[i].npctype, spawntime = 0}
		table.insert(NPCGrid[ix][iy].npcspawnpoints, entry)	
	end
end

function PopulateNPCGridAngle(postable, angletable, npctype)

	local count = table.Count(postable)		
	for i=1, count do
		local ix = math.floor((postable[i].x - LevelData.LevelXMin) / cellw)
		if (ix < 0 or ix > LevelData.SpawnGridSize-1) then return end
		local iy = math.floor((postable[i].y - LevelData.LevelYMin) / celll) 
		if (iy < 0 or iy > LevelData.SpawnGridSize-1) then return end
		
		local entry = {npcpos = Vector(postable[i].x, postable[i].y, postable[i].z), npcangle = angletable[i], counter = 1, npcspawntype = npctype, spawntime = 0}	
		table.insert(NPCGrid[ix][iy].npcspawnpoints, entry)	
	end
end

function PopulateItemGrid(postable, itemtype)

	local count = table.Count(postable)		
	
	for i=1, count do

		local ix = math.floor((postable[i].x - LevelData.LevelXMin) / cellw)
		if (ix >= 0 and ix <= LevelData.SpawnGridSize-1) then
			local iy = math.floor((postable[i].y - LevelData.LevelYMin) / celll) 
			if (iy >= 0 and iy <= LevelData.SpawnGridSize-1) then
				local entry = {itempos = postable[i], counter = 1, itemspawntype = itemtype, spawntime = 0}
				table.insert(NPCGrid[ix][iy].itemspawnpoints, entry)
			end
		end	
	end
end

function SpawnAirdrop()

	if (Airdrop.Ent == nil or not IsValid(Airdrop.Ent)) then
		
		local abortspawn = false
		print("Spawning Airdorp")	
		local randomairdrop = math.random(table.Count(AirdropData))
	--	PrintTable(AirdropData)
		for k, v in pairs(player.GetAll()) do
			
			if (IsValid(v) and v:Alive()) then

				print(AirdropData[randomairdrop])
				local postemp = AirdropData[randomairdrop].Position
				
				if (v:GetPos():Distance(postemp) <= 500) then
					abortspawn = true
					break
				end	
			end	
		end
		
		if (not abortspawn) then
		
			Airdrop.CachePos = AirdropData[randomairdrop].Position
			Airdrop.Ent = ents.Create("item_airdrop") 
			Airdrop.Ent:SetPos(Airdrop.CachePos)						
			Airdrop.Ent:SetUnFreezable( true ) 
			Airdrop.Ent:SetObjMaxHealth(500)
			Airdrop.Ent:SetAngles(Angle(0, math.random( 0, 360 ), 0))
			Airdrop.Ent:Spawn()

			for i=1,table.Count(AirdropData[randomairdrop].NPCList) do 
			
				local npcentry = AirdropData[randomairdrop].NPCList[i]
				local aipos = Vector(npcentry.x, npcentry.y, npcentry.z)
				local combine = ents.Create("npc_combine_s");
				combine:SetPos(aipos);
				combine:SetAngles(Angle(0, math.random( 0, 360 ), 0));
				combine:SetCurrentWeaponProficiency( WEAPON_PROFICIENCY_PERFECT );
				
				local randomWep = math.random( 0, 3 )
				if (randomWep == 0) then
					combine:SetKeyValue( "additionalequipment", "weapon_ar2" );
				elseif (randomWep == 1) then
					combine:SetKeyValue( "additionalequipment", "weapon_shotgun" );
				else
					combine:SetKeyValue( "additionalequipment", "weapon_smg1" );
				end
				
				combine:SetKeyValue("spawnflags","8192") -- won't drop weapons on death	
				combine:Spawn();
			
				local minhealth = 75
				local maxhealth = 325
				local rand = math.random( 0, 20 )		
				local npchealth = (maxhealth * math.exp(rand - 20)) + minhealth
				
				combine:SetHealth(npchealth);
			end
			SendAirdropDataToClients()	
		end	
	end

	
	
end


function SpawnEachItem(spawnpoint)


	local spawntype = spawnpoint.itemspawntype
	local item
	local pos = Vector(spawnpoint.itempos.x, spawnpoint.itempos.y, spawnpoint.itempos.z + 40)	
	
	if (spawntype == "normal") then
	
		local itemroll = math.random(0, 100)
		local roll = math.random(0, 100);
		local itemToSpawn = "item_metal"
		local itemName
		
		if (itemroll < 91) then
			itemName = "resource"
		elseif itemroll < 95 then
			itemName = "ammo"
		elseif itemroll < 98 then
			itemName = "item"
		elseif itemroll <= 100 then
			itemName = "weapon"
		end
		
		if (itemName == "item") then
		
			if (roll < 90) then
				itemToSpawn = "item_hbattery"
			else 
				itemToSpawn = "item_o2canister"
			end
		elseif (itemName == "ammo") then
		
			if (roll < 80) then
				itemToSpawn = "item_hpistolammo"
			elseif (roll < 90) then
				itemToSpawn = "item_hsmgammo"
			elseif (roll < 95) then
				itemToSpawn = "item_hshotgunammo1"
			elseif (roll < 97) then
				itemToSpawn = "item_hmagnumammo1"
			else
				itemToSpawn = "item_hrifleammo"
			end
			
		elseif (itemName == "resource") then
		
			if (roll < 50) then
				itemToSpawn = "item_metal"
			elseif (roll < 80) then
				itemToSpawn = "item_circuits"
			else
				itemToSpawn = "item_fuel"
			end
		
		elseif (itemName == "weapon") then
			
			local totalprob = 0
			for i=1, table.Count(ConfigInfo["MarketFog"].Weapon) do
				if (ConfigInfo["MarketFog"].Weapon[i].Spawnable) then
					totalprob = totalprob + ConfigInfo["MarketFog"].Weapon[i].SpawnProb
				end
			end
		
			local probscale = 100.0 / totalprob
			local prob = 0
			for i=1, table.Count(ConfigInfo["MarketFog"].Weapon) do
				if (ConfigInfo["MarketFog"].Weapon[i].Spawnable) then
					prob = prob + (ConfigInfo["MarketFog"].Weapon[i].SpawnProb * probscale)
					if (prob >= roll) then
						itemToSpawn = ConfigInfo["MarketFog"].Weapon[i].Name
						break
					end
				end
			end	
		end
			
		--print (itemToSpawn)
		item = ents.Create(itemToSpawn) 
		item:SetPos(pos)						
		item:SetUnFreezable( true ) 
		item:SetObjMaxHealth(500)
		item:SetAngles(Angle(0, math.random( 0, 360 ), 0))
		item:Spawn()	
		item.parentSpawnpoint = spawnpoint
		item.parentSpawnpoint.counter = item.parentSpawnpoint.counter - 1
		--print("normal")
	elseif (spawntype == "crate") then
	
	
		--print("chest")
		item = ents.Create("item_chest") 
		item:SetPos(pos)						
		item:SetUnFreezable( true ) 
		item:SetObjMaxHealth(500)
		item:SetAngles(Angle(0, math.random( 0, 360 ), 0))
		item:Spawn()	
		item.parentSpawnpoint = spawnpoint
		item.parentSpawnpoint.counter = item.parentSpawnpoint.counter - 1
	
	end

end

local function SpawnNPC_Combine()


end


local NPCSpawnFunction = {}
NPCSpawnFunction["Combine"] = SpawnNPC_Combine;



function SpawnEachNPC(spawnpoint)

	local spawnType = spawnpoint.npcspawntype
	local pos = spawnpoint.npcpos
		
	if (spawnType == "Combine") then
	
		local combine = ents.Create("npc_combine_s");
		combine:SetPos(pos);
		combine:SetAngles(Angle(0, math.random( 0, 360 ), 0));
		combine:SetCurrentWeaponProficiency( WEAPON_PROFICIENCY_PERFECT );
		
		local randomWep = math.random( 0, 3 )
		if (randomWep == 0) then
			combine:SetKeyValue( "additionalequipment", "weapon_ar2" );
		elseif (randomWep == 1) then
			combine:SetKeyValue( "additionalequipment", "weapon_shotgun" );
		else
			combine:SetKeyValue( "additionalequipment", "weapon_smg1" );
		end
		
		combine:SetKeyValue("spawnflags","8192") -- won't drop weapons on death
		--combine:SetKeyValue("spawnflags","1") -- wait till seen
		--combine:SetKeyValue("spawnflags","2") -- gag
		--combine:SetKeyValue("spawnflags","512") -- fade corpse
		
		combine:Spawn();
		combine.parentSpawnpoint = spawnpoint
		combine.parentSpawnpoint.counter = combine.parentSpawnpoint.counter - 1
		
		local minhealth = 75
		local maxhealth = 325
		local rand = math.random( 0, 20 )		
		local npchealth = (maxhealth * math.exp(rand - 20)) + minhealth
		
		combine:SetHealth(npchealth);
		
	elseif (spawnType == "Headcrab") then
	
		local rType = math.random( 0, 100 )
		
		if (rType <= 70) then
			local headcrab = ents.Create("npc_headcrab");	
			headcrab:SetPos(pos)
			headcrab:SetAngles(Angle(0, math.random( 0, 360 ), 0));
			headcrab:Spawn();
			headcrab.parentSpawnpoint = spawnpoint
			headcrab.parentSpawnpoint.counter = headcrab.parentSpawnpoint.counter - 1	
			headcrab:SetKeyValue("spawnflags","2") -- gag
		elseif (rType <= 90)  then
			local headcrab = ents.Create("npc_headcrab_fast");
			headcrab:SetPos(pos)
			headcrab:SetAngles(Angle(0, math.random( 0, 360 ), 0));
			headcrab:Spawn();
			headcrab.parentSpawnpoint = spawnpoint
			headcrab.parentSpawnpoint.counter = headcrab.parentSpawnpoint.counter - 1	
			headcrab:SetKeyValue("spawnflags","2") -- gag
		else
			local headcrab = ents.Create("npc_headcrab_poison");
			headcrab:SetPos(pos)
			headcrab:SetAngles(Angle(0, math.random( 0, 360 ), 0));
			headcrab:Spawn();
			headcrab.parentSpawnpoint = spawnpoint
			headcrab.parentSpawnpoint.counter = headcrab.parentSpawnpoint.counter - 1	
			headcrab:SetKeyValue("spawnflags","2") -- gag
		end
		
	elseif (spawnType == "Turret") then
		
		local turret = ents.Create("npc_turret_floor")
		turret:SetPos(pos);
		turret:SetAngles(Angle(0, math.random( 0, 360 ), 0));
		turret:Spawn()
		turret.parentSpawnpoint = spawnpoint
		turret.parentSpawnpoint.counter = turret.parentSpawnpoint.counter - 1
		
	elseif (spawnType == "Manhack") then
		
		local manhack = ents.Create("npc_manhack")
		manhack:SetPos(pos);
		manhack:SetAngles(Angle(0, math.random( 0, 360 ), 0));
		manhack:Spawn()
		manhack.parentSpawnpoint = spawnpoint
		manhack.parentSpawnpoint.counter = manhack.parentSpawnpoint.counter - 1
		
	elseif (spawnType == "Zombie") then
		
		local rType = math.random( 0, 100 )
		
		if (rType <= 60) then
		
			local minhealth = 90
			local maxhealth = 120
			local rand = math.random( 0, 20 )		
			local npchealth = (maxhealth * math.exp(rand - 20)) + minhealth
		
			local zombie = ents.Create("npc_zombie");	
			zombie:SetPos(pos)
			zombie:SetAngles(Angle(0, math.random( 0, 360 ), 0));
			zombie:Spawn();
			zombie.parentSpawnpoint = spawnpoint
			zombie.parentSpawnpoint.counter = zombie.parentSpawnpoint.counter - 1	
			zombie:SetHealth(npchealth);
			--zombie:SetKeyValue("spawnflags","1") -- wait till seen
			zombie:SetKeyValue("spawnflags","2") -- gag
			--zombie:SetKeyValue("spawnflags","512") -- fade corpse
		elseif (rType <= 95)  then
		
			local minhealth = 75
			local maxhealth = 100
			local rand = math.random( 0, 20 )		
			local npchealth = (maxhealth * math.exp(rand - 20)) + minhealth
		
			local zombie = ents.Create("npc_fastzombie");
			zombie:SetPos(pos)
			zombie:SetAngles(Angle(0, math.random( 0, 360 ), 0));
			zombie:Spawn();
			zombie.parentSpawnpoint = spawnpoint
			zombie.parentSpawnpoint.counter = zombie.parentSpawnpoint.counter - 1	
			zombie:SetHealth(npchealth);
			--zombie:SetKeyValue("spawnflags","1") -- wait till seen
			zombie:SetKeyValue("spawnflags","2") -- gag
			--zombie:SetKeyValue("spawnflags","512") -- fade corpse			
		else
		
			local minhealth = 180
			local maxhealth = 400
			local rand = math.random( 0, 20 )		
			local npchealth = (maxhealth * math.exp(rand - 20)) + minhealth
		
			local zombie = ents.Create("npc_poisonzombie");
			zombie:SetPos(pos)
			zombie:SetAngles(Angle(0, math.random( 0, 360 ), 0));
			zombie:Spawn();
			zombie.parentSpawnpoint = spawnpoint
			zombie.parentSpawnpoint.counter = zombie.parentSpawnpoint.counter - 1	
			zombie:SetHealth(npchealth);
			--zombie:SetKeyValue("spawnflags","1") -- wait till seen
			zombie:SetKeyValue("spawnflags","2") -- gag
			--zombie:SetKeyValue("spawnflags","512") -- fade corpse		
		end
		
	elseif spawnType == "Antlion" then

		local rType = math.random( 0, 100 )

		if (rType <= 1) then
			local ant = ents.Create("npc_antlionguard");	
			ant:SetPos(pos);
			ant:SetAngles(Angle(0,  math.random( 0, 360 ), 0));
			ant:Spawn();
			local minhealth = 800
			local maxhealth = 1200
			local rand = math.random( 0, 20 )		
			local npchealth = (maxhealth * math.exp(rand - 20)) + minhealth
			ant.parentSpawnpoint = spawnpoint
			ant.parentSpawnpoint.counter = ant.parentSpawnpoint.counter - 1	
			ant:SetHealth(npchealth);
		else 
			local ant = ents.Create("npc_antlion");	
			ant:SetPos(pos);
			ant:SetAngles(Angle(0,  math.random( 0, 360 ), 0));
			ant:SetKeyValue( "StartBurrowed", 1 ) 
			ant:Spawn();
			ant.antlionUnburrowed = false
			local minhealth = 50
			local maxhealth = 100
			local rand = math.random( 0, 20 )		
			local npchealth = (maxhealth * math.exp(rand - 20)) + minhealth
			ant.parentSpawnpoint = spawnpoint
			ant.parentSpawnpoint.counter = ant.parentSpawnpoint.counter - 1	
			ant:SetHealth(npchealth);
		end	
			
	elseif spawnType == "Mine" then
	
		local rType = math.random( 0, 100 )
	
		if (rType <= 10) then
		
			local npc = ents.Create("npc_rollermine");	
			npc:SetPos(pos);
			npc:SetAngles(Angle(0,  math.random( 0, 360 ), 0));
			npc:Spawn();
			npc.parentSpawnpoint = spawnpoint
			npc.parentSpawnpoint.counter = npc.parentSpawnpoint.counter - 1
		
		else
		
			local npc = ents.Create("combine_mine");	
			npc:SetPos(pos);
			npc:SetAngles(Angle(0,  math.random( 0, 360 ), 0));
			npc:Spawn();
			npc.parentSpawnpoint = spawnpoint
			npc.parentSpawnpoint.counter = npc.parentSpawnpoint.counter - 1
		
		end
		
	elseif spawnType == "Special" then
	
		local rType = math.random( 0, 100 )
		local spawnchance = math.random(0, 100)
		
		if (spawnchance < 5) then
			if (rType <= 50) then
		
				local npc = ents.Create("npc_stalker_controller");	
				if (not IsValid(npc)) then return end
				npc:SetPos(pos);
				npc:SetAngles(Angle(0,  math.random( 0, 360 ), 0));
				npc:Spawn();
				npc.parentSpawnpoint = spawnpoint
				npc.parentSpawnpoint.counter = npc.parentSpawnpoint.counter - 1
				npc:SetKeyValue("spawnflags","2") -- gag
				npc:SetHealth(1250);
			else
		
				local npc = ents.Create("npc_stalker_burer");
				if (not IsValid(npc)) then return end			
				npc:SetPos(pos);
				npc:SetAngles(Angle(0,  math.random( 0, 360 ), 0));
				npc:Spawn();
				npc.parentSpawnpoint = spawnpoint
				npc.parentSpawnpoint.counter = npc.parentSpawnpoint.counter - 1
				npc:SetKeyValue("spawnflags","2") -- gag
				npc:SetHealth(1250);
			end	
		end
		
	elseif spawnType == "Apartmentspecial" then
	
		local rType = math.random( 0, 100 )
		local spawnchance = math.random(0, 100)
		
		if (spawnchance < 35) then
			if (rType <= 50) then
		
				local npc = ents.Create("npc_stalker_controller");	
				if (not IsValid(npc)) then return end
				npc:SetPos(pos);
				npc:SetAngles(Angle(0,  math.random( 0, 360 ), 0));
				npc:Spawn();
				npc.parentSpawnpoint = spawnpoint
				npc.parentSpawnpoint.counter = npc.parentSpawnpoint.counter - 1
				npc:SetKeyValue("spawnflags","2") -- gag
				npc:SetHealth(1250);
			else
		
				local npc = ents.Create("npc_stalker_burer");	
				if (not IsValid(npc)) then return end
				npc:SetPos(pos);
				npc:SetAngles(Angle(0,  math.random( 0, 360 ), 0));
				npc:Spawn();
				npc.parentSpawnpoint = spawnpoint
				npc.parentSpawnpoint.counter = npc.parentSpawnpoint.counter - 1
				npc:SetKeyValue("spawnflags","2") -- gag
				npc:SetHealth(1250);
			end	
		end
		
	elseif spawnType == "Tripmine" then

		local npc = ents.Create("npc_tripmine");	
		npc:SetPos(pos);
		local ang = Angle(90,0,0) + spawnpoint.npcangle
		npc:SetAngles(ang)
		npc:Spawn();
		npc.parentSpawnpoint = spawnpoint
		npc.parentSpawnpoint.counter = npc.parentSpawnpoint.counter - 1

	elseif spawnType == "Misc" then

		local spawnchance = math.random(0, 1000)
	
		if (spawnchance < 880) then
			local minhealth = 150
			local maxhealth = 400
			local rand = math.random( 0, 20 )		
			local npchealth = (maxhealth * math.exp(rand - 20)) + minhealth
			
			if (rand < 12) then
			
				minhealth = 90
				maxhealth = 150
				rand = math.random( 0, 20 )		
				npchealth = (maxhealth * math.exp(rand - 20)) + minhealth
			
				zombie = ents.Create("npc_zombie")
			elseif (rand < 19) then
			
				minhealth = 75
				maxhealth = 110
				rand = math.random( 0, 20 )		
				npchealth = (maxhealth * math.exp(rand - 20)) + minhealth
			
				zombie = ents.Create("npc_fastzombie")
			else
			
				minhealth = 180
				maxhealth = 400
				rand = math.random( 0, 20 )		
				npchealth = (maxhealth * math.exp(rand - 20)) + minhealth
			
				zombie = ents.Create("npc_poisonzombie");
			end
						
			zombie:SetPos(pos)
			zombie:SetAngles(Angle(0, math.random( 0, 360 ), 0));
			zombie:Spawn();
			zombie.parentSpawnpoint = spawnpoint
			zombie.parentSpawnpoint.counter = zombie.parentSpawnpoint.counter - 1	
			zombie:SetHealth(npchealth);
			zombie:SetKeyValue("spawnflags","2") -- gag
		elseif (spawnchance < 898) then
		
			local combine = ents.Create("npc_combine_s");
			combine:SetPos(pos);
			combine:SetAngles(Angle(0, math.random( 0, 360 ), 0));
			combine:SetCurrentWeaponProficiency( WEAPON_PROFICIENCY_PERFECT );
			
			local randomWep = math.random( 0, 3 )
			if (randomWep == 0) then
				combine:SetKeyValue( "additionalequipment", "weapon_ar2" );
			elseif (randomWep == 1) then
				combine:SetKeyValue( "additionalequipment", "weapon_shotgun" );
			else
				combine:SetKeyValue( "additionalequipment", "weapon_smg1" );
			end
			
			combine:SetKeyValue("spawnflags","8192") -- won't drop weapons on death			
			combine:Spawn();
			combine.parentSpawnpoint = spawnpoint
			combine.parentSpawnpoint.counter = combine.parentSpawnpoint.counter - 1
			
			local minhealth = 75
			local maxhealth = 325
			local rand = math.random( 0, 20 )		
			local npchealth = (maxhealth * math.exp(rand - 20)) + minhealth
			
			combine:SetHealth(npchealth);
		
		elseif (spawnchance < 900) then
			local rType = math.random( 0, 100 )
		
			if (rType <= 50) then
		
				local npc = ents.Create("npc_stalker_controller");	
				if (not IsValid(npc)) then return end
				npc:SetPos(pos);
				npc:SetAngles(Angle(0,  math.random( 0, 360 ), 0));
				npc:Spawn();
				npc.parentSpawnpoint = spawnpoint
				npc.parentSpawnpoint.counter = npc.parentSpawnpoint.counter - 1
				npc:SetKeyValue("spawnflags","2") -- gag
				npc:SetHealth(1250);
			else
		
				local npc = ents.Create("npc_stalker_burer");	
				if (not IsValid(npc)) then return end
				npc:SetPos(pos);
				npc:SetAngles(Angle(0,  math.random( 0, 360 ), 0));
				npc:Spawn();
				npc.parentSpawnpoint = spawnpoint
				npc.parentSpawnpoint.counter = npc.parentSpawnpoint.counter - 1
				npc:SetKeyValue("spawnflags","2") -- gag
				npc:SetHealth(1250);
			end		
		end
	
	elseif spawnType == "Chain" then
	
		local maji
		maji = ents.Create("npc_re5_chainsaw_majini")
		if (not IsValid(maji)) then return end
		maji:SetPos(pos);
		maji:SetAngles(Angle(0,  math.random( 0, 360 ), 0));
		maji:Spawn();
		maji.parentSpawnpoint = spawnpoint
		maji.parentSpawnpoint.counter = maji.parentSpawnpoint.counter - 1
	
	elseif spawnType == "Axe" then
	
		local maji
		maji = ents.Create("npc_re5_executioner")
		if (not IsValid(maji)) then return end
		maji:SetPos(pos);
		maji:SetAngles(Angle(0,  math.random( 0, 360 ), 0));
		maji:DropToFloor()
		maji:Spawn();
		maji.parentSpawnpoint = spawnpoint
		maji.parentSpawnpoint.counter = maji.parentSpawnpoint.counter - 1
	
	elseif spawnType == "Reaper" then
	
		local rchance = math.random( 0, 100 )	
		if (rchance <= 33) then
		
			local npc = ents.Create("npc_re5_reaper");	
			if (not IsValid(npc)) then return end
			npc:SetPos(pos);
			npc:SetAngles(Angle(0,  math.random( 0, 360 ), 0));
			npc:DropToFloor()
			npc:Spawn();
			npc.parentSpawnpoint = spawnpoint
			npc.parentSpawnpoint.counter = npc.parentSpawnpoint.counter - 1
		end
	
	elseif spawnType == "MeleeMajini" then
		
		local rtype = math.random( 0, 100 )
		local rchance = math.random( 0, 100 )	
		if (rchance <= 15) then
			local maji
			if (rtype < 33) then 
				maji = ents.Create("npc_re5_chainsaw_majini")
			elseif (rtype < 67) then
				maji = ents.Create("npc_re5_giant_majini")
			else
				maji = ents.Create("npc_re5_executioner")
			end
			if (not IsValid(maji)) then return end
			maji:SetPos(pos);
			maji:SetAngles(Angle(0,  math.random( 0, 360 ), 0));
			maji:DropToFloor()
			maji:Spawn();
			maji.parentSpawnpoint = spawnpoint
			maji.parentSpawnpoint.counter = maji.parentSpawnpoint.counter - 1
		end
	
	end
end

function StartHunt()

	PrintTable(HunterMissions)
	
	local randomindex = math.random(1, table.Count(HuntPositionData))
	local npctype = HunterMissions[CurrentHunterMission.HuntMission].Name
	CurrentHunterMission.CurrentlyOngoing = true
	CurrentHunterMission.Position = HuntPositionData[randomindex]
	
	CurrentHunterMission.NPC = ents.Create(npctype)
	CurrentHunterMission.NPC:SetPos(CurrentHunterMission.Position)
	CurrentHunterMission.NPC:SetAngles(Angle(0,  math.random( 0, 360 ), 0));
	CurrentHunterMission.NPC:Spawn()
	CurrentHunterMission.NPC:SetHealth(HunterMissions[CurrentHunterMission.HuntMission].Health)
	
	BroadcastCurrentHunterMission()

end

function EndHunt(ply)

	if (ply:IsPlayer()) then
		ply:ChatPrint("Congratulations you completed the Hunt! You gained "..ConfigInfo["MarketFog"].Gameplay.CashDisplaySymbol..CurrentHunterMission.Reward)
		local money = ply:GetNWInt("plyMoney")
		money = money + CurrentHunterMission.Reward
		ply:SetNWInt("plyMoney", money)
		ply:EmitSound("kaching.wav")	
	end

	CurrentHunterMission.CurrentlyOngoing = false
	CurrentHunterMission.NPC = nil
	CurrentHunterMission.HuntMission = math.random(table.Count(HunterMissions))
	CurrentHunterMission.Reward = HunterMissions[CurrentHunterMission.HuntMission].Price
	BroadcastCurrentHunterMission()

end


function GM:OnNPCKilled(npc, attacker, inflictor ) 

	if (CurrentHunterMission.CurrentlyOngoing) then		
		if (npc == CurrentHunterMission.NPC) then
			EndHunt(attacker)			
		end	
	end

	if attacker:IsPlayer() and npc:IsValid() then
	
		if (not attacker:GetNWBool('plyNPCDamageTut')) then
			SendHint(attacker, HintEnum["NPCDamageTutorial1"], 8)
			attacker:SetNWBool('plyNPCDamageTut', true)
		end
	
		local delay = 120
		if (npc:GetClass() == "npc_combine_s") then
			delay = 240
		end
		if (npc.parentSpawnpoint ~= nil) then npc.parentSpawnpoint.spawntime = CurTime() + delay end
			
		local money = attacker:GetNWInt("plyMoney")	
		local reward = 0
		local pos = npc:GetPos()
		pos.z = pos.z + 60
		if (npc:GetClass() == "npc_combine_s") then
		
			reward = 100
			local roll = math.random(100)
			
			if (roll <= 20) then
				local ammoroll = math.random(100)
				if (ammoroll < 50) then
					itemToSpawn = "item_hpistolammo"
				elseif (ammoroll < 70) then
					 itemToSpawn = "item_hsmgammo"
				elseif (ammoroll < 80) then
					itemToSpawn = "item_hshotgunammo1"
				elseif (ammoroll < 90) then
					itemToSpawn = "item_hmagnumammo1"
				else
					itemToSpawn = "item_hrifleammo"
				end
				item = ents.Create(itemToSpawn) 
				item:SetPos(pos)						
				item:SetUnFreezable( true ) 
				item:SetAngles(Angle(0, math.random( 0, 360 ), 0))
				item:Spawn()
				item.deleteTimer = CurTime() + 30
			end
			
		elseif (npc:GetClass() == "npc_stalker_burer" or npc:GetClass() == "npc_stalker_controller") then	
			reward = 8000		
		elseif (npc:GetClass() == "npc_zombie") then	
			reward = 50
		elseif (npc:GetClass() == "npc_fastzombie") then	
			reward = 100	
		elseif (npc:GetClass() == "npc_poisonzombie") then	
			reward = 150
		elseif (npc:GetClass() == "npc_antlion") then	
			reward = 50
		elseif (npc:GetClass() == "npc_antlionguard") then	
			reward = 4000
		elseif (npc:GetClass() == "npc_headcrab" or npc:GetClass() == "npc_headcrab_fast" or npc:GetClass() == "npc_headcrab_poison") then	
			reward = 10	
		elseif (npc:GetClass() == "npc_manhack") then
			reward = 10
			local roll = math.random(100)		
			if (roll <= 60) then
				item = ents.Create("item_circuits") 
				item:SetPos(pos)						
				item:SetUnFreezable( true ) 
				item:SetAngles(Angle(0, math.random( 0, 360 ), 0))
				item:Spawn()
				item.deleteTimer = CurTime() + 30
			end
		end
		
		money = money + reward
		attacker:SetNWInt("plyMoney", money)	
		attacker:ChatPrint("You got "..ConfigInfo["MarketFog"].Gameplay.CashDisplaySymbol..reward.."!")
	end

end

function IsCriticalHit(ply, headshotflag, weptype, wepcrit)

	local weapon
	weapon = ply:GetActiveWeapon()

	local headshotmult = 1.0
	if (headshotflag) then
		headshotmult = 3.5
	end
		
	ply.CriticalMeter = ply.CriticalMeter + wepcrit * headshotmult -- Pistol increase crit meter alot
			
	if (ply.CriticalMeter > 100) then
		ply:ChatPrint("You got a critical hit!")
		ply.CriticalMeter = 0

		return true
	end		
	
	return false
end

function GM:ScaleNPCDamage( npc, hitgroup, dmginfo ) 
	
	local ply = dmginfo:GetAttacker()
	local headshotflag = false
	local iscriticalflag = false
	local scaledamage = 1.0
	
	if (ConfigInfo["MarketFog"].Gameplay.ActiveCombatEnabled and ply ~= nil and ply:IsPlayer()) then
			
		local weapon = ply:GetActiveWeapon()
		
		if (weapon ~= nil and weapon:IsWeapon()) then
			
			local wepcrit = MapWeaponNameToType[weapon:GetClass()].weaponcrit
			local weptype = MapWeaponNameToType[weapon:GetClass()].weapontype
			
			if (weptype == "shotgun") then
			
				if (npc:GetClass() == "npc_zombie") then
				
					npc:SetSchedule( SCHED_FLINCH_PHYSICS ) 

				elseif (npc:GetClass() == "npc_poisonzombie") then
					
					npc:SetSchedule( SCHED_SLEEP ) 

				elseif (npc:GetClass() == "npc_fastzombie") then
				
					npc:SetSchedule( SCHED_BIG_FLINCH ) 
					
				elseif (npc:GetClass() == "npc_combine_s") then
				
					npc:SetSchedule( SCHED_BIG_FLINCH ) 
					
				end
			
			else
				-- Shooting zombies in the feet and legs staggers them
				if (hitgroup == HITGROUP_LEFTLEG or hitgroup == HITGROUP_RIGHTLEG) then
				
					if (npc:GetClass() == "npc_zombie") then
					
						npc:SetSchedule( SCHED_FLINCH_PHYSICS ) 
						scaledamage = 0.05
				
					elseif (npc:GetClass() == "npc_combine_s") then
					
						npc:SetSchedule( SCHED_BIG_FLINCH ) 
						scaledamage = 0.05
					end

				elseif (hitgroup == HITGROUP_HEAD) then -- Shooting in the head increases crit multiplier and may result in a critical
					
					if (npc:GetClass() == "npc_fastzombie") then
					
						npc:SetSchedule( SCHED_BIG_FLINCH ) 
					elseif (npc:GetClass() == "npc_poisonzombie") then
					
						npc:SetSchedule( SCHED_SLEEP ) 

					end
					headshotflag = true
				end
			end
						
			iscriticalflag = IsCriticalHit(ply, headshotflag, weptype, wepcrit)
		
			-- Depending on the npc we want to do different things
			if (iscriticalflag) then
					
				if (npc:GetClass() == "npc_antlion" or npc:GetClass() == "npc_zombie" or npc:GetClass() == "npc_fastzombie" or npc:GetClass() == "npc_combine_s" or npc:GetClass() == "npc_poisonzombie" or npc:GetClass() == "npc_headcrab" or npc:GetClass() == "npc_headcrab_fast" or npc:GetClass() == "npc_headcrab_poison") then
				
					local npcpos = npc:GetPos()
			
					local dmgpos = dmginfo:GetDamagePosition() 
					local dirvec = dmgpos - ply:GetPos()
					dirvec:Normalize()
					dirvec:Mul(18000)
					dmginfo:SetDamageForce( dirvec ) 
					scaledamage = 15.0
				
					
					local effectdata = EffectData()
					effectdata:SetOrigin( dmgpos )
					util.Effect( "cball_explode", effectdata, true, true )
					
					dmginfo:ScaleDamage( scaledamage )	

					local totaldamage = dmginfo:GetDamage() 
					local health = npc:Health()
					
					if (iscriticalflag and (health - totaldamage <= 0)) then
						ply:EmitSound("kaching.wav")
					end
					
				end
			
			end
			
		end
	end
	

end

--.