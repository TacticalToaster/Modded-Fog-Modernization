----------------------------------
--	Market Fog	
--	Programmer : LIFO/Tednesday		
--	Date : 15/10/2018		
----------------------------------

local Player = FindMetaTable("Player")

-- Can also work for entities too.
function PlayerInSafeZone(ply)
	local pos = ply:GetPos()	
	return (pos.x >= LevelData.SafeRoomMinX and pos.x <= LevelData.SafeRoomMaxX and pos.y >= LevelData.SafeRoomMinY and pos.y <= LevelData.SafeRoomMaxY and pos.z < LevelData.GasHeight)
end

function GM:PlayerHurt( victim, attacker )

	


end


function SetSuit(ply)

	local suittype = ply:GetNWInt('plySuit')	
	local can =	ply:GetNWInt('plyO2Canisters');
	
	ply:SetNWInt('plyMaxArmour', ConfigInfo["MarketFog"].Apparel[suittype].MaxArmour);
	ply:SetNWInt('plyMaxO2Canisters', ConfigInfo["MarketFog"].Apparel[suittype].MaxO2Canisters);
	if can > ConfigInfo["MarketFog"].Apparel[suittype].MaxO2Canisters then can = ConfigInfo["MarketFog"].Apparel[suittype].MaxO2Canisters end	
	ply:SetArmor(ConfigInfo["MarketFog"].Apparel[suittype].MaxArmour)
	ply:SetModel( ConfigInfo["MarketFog"].Apparel[suittype].ModelName ) 	
	ply:SetNWInt('plyMaxMetal', ConfigInfo["MarketFog"].Apparel[suittype].MaxMetal);
	ply:SetNWInt('plyMaxCircuits', ConfigInfo["MarketFog"].Apparel[suittype].MaxCircuits);
	ply:SetNWInt('plyMaxFuel', ConfigInfo["MarketFog"].Apparel[suittype].MaxFuel);
	ply:SetNWInt('plyO2Canisters', can);
	
end


function PlayerSaveData(ply)

	ply:SetPData("plyVersion", 1)
	ply:SetPData( "plyMoney", ply:GetNWInt('plyMoney') )
	ply:SetPData( "plySuit", ply:GetNWInt('plySuit') )
	
	ply:SetPData( "plySuitStorage1", ply:GetNWInt('plySuitStorage1', 0) )
	ply:SetPData( "plySuitStorage2", ply:GetNWInt('plySuitStorage2', 0) )
	ply:SetPData( "plySuitStorage3", ply:GetNWInt('plySuitStorage3', 0) )
	
	ply:SetPData( "plyStorage0", ply:GetNWInt('plyStorage0') )
	ply:SetPData( "plyStorage1", ply:GetNWInt('plyStorage1') )
	ply:SetPData( "plyStorage2", ply:GetNWInt('plyStorage2') )
	ply:SetPData( "plyStorage3", ply:GetNWInt('plyStorage3') )
	ply:SetPData( "plyStorage4", ply:GetNWInt('plyStorage4') )
	ply:SetPData( "plyStorage5", ply:GetNWInt('plyStorage5') )
	ply:SetPData( "plyStorage6", ply:GetNWInt('plyStorage6') )
	ply:SetPData( "plyStorage7", ply:GetNWInt('plyStorage7') )
	ply:SetPData( "plyStorage8", ply:GetNWInt('plyStorage8') )
	ply:SetPData('plyO2Canisters', ply:GetNWInt('plyO2Canisters'))
	ply:SetPData( "plyMetal", ply:GetNWInt('plyMetal') )
	ply:SetPData( "plyCircuits", ply:GetNWInt('plyCircuits') )
	ply:SetPData( "plyFuel", ply:GetNWInt('plyFuel') )
	
	ply:SetPData("AmmoPistol", ply:GetAmmoCount("Pistol"))
	ply:SetPData("AmmoSMG1", ply:GetAmmoCount("SMG1"))
	ply:SetPData("AmmoShotgun", ply:GetAmmoCount("Buckshot"))
	ply:SetPData("AmmoRifle", ply:GetAmmoCount("AR2"))
	ply:SetPData("AmmoMagnum", ply:GetAmmoCount("357"))
		
	ply:SetPData("CurrentWeaponCount", table.Count(ply:GetWeapons()))
	local count = 0
	for k, v in pairs(ply:GetWeapons()) do
		ply:SetPData("Weapon_"..count, v:GetClass())
		count = count + 1
	end
	local propInfo = {}
	ply:SetPData("Health", ply:Health())
	ply:SetPData("AlienWeaponFlag", ply:GetNWBool('plyHasAlienWeapons') )
	ply:SetPData("PropInfo", propInfo)
end

function IsValidWeapon(weaponclassname) 

	for i=1,table.Count(ConfigInfo["MarketFog"].Weapon) do 
		if (ConfigInfo["MarketFog"].Weapon[i].Name == weaponclassname) then return true end
	end 

	return false
end

function IsValidWeaponIndex(index)
	if (index < 0) then return false end
	if (index > table.Count(ConfigInfo["MarketFog"].Weapon)) then return false end
	return true
end

function IsValidSuitIndex(index)
	if (index < 0) then return false end
	if (index > table.Count(ConfigInfo["MarketFog"].Apparel)) then return false end
	return true
end

function PlayerGiveStartWeapons(ply)

	for i=1,table.Count(ConfigInfo["MarketFog"].Gameplay.StartingWeapons) do 
		ply:Give(ConfigInfo["MarketFog"].Gameplay.StartingWeapons[i])
	end 
end

function PlayerGiveRespawnWeapons(ply)

	for i=1,table.Count(ConfigInfo["MarketFog"].Gameplay.RespawnWeapons) do 
		ply:Give(ConfigInfo["MarketFog"].Gameplay.RespawnWeapons[i])
	end 
end

function PlayerGetData(ply)

	local money = tonumber(ply:GetPData( "plyMoney", ConfigInfo["MarketFog"].Gameplay.StartingMoneyQuantity ))
	money = money * (1.0 - ConfigInfo["MarketFog"].Gameplay.MoneyDegradation) -- Apply inflation of money every time someone joins the server.
	money = math.Round(money) 
	if (money < 10) then money = 0 end	
	ply:SetNWInt('plyMoney', money)
	local suitid = tonumber(ply:GetPData( "plySuit", ConfigInfo["MarketFog"].Gameplay.StartingSuit ))
	if (suitid < 1) then suitid = 1 end
	if (suitid > table.Count(ConfigInfo["MarketFog"].Apparel)) then suitid = 1 end
	ply:SetNWInt('plySuit', suitid)
		
	-- Bounds check on apparel
	local suitStore = tonumber(ply:GetPData('plySuitStorage1', 0))
	if (not IsValidSuitIndex(suitStore)) then suitStore = 0 end
	ply:SetNWInt( "plySuitStorage1", suitStore )
	
	suitStore = tonumber(ply:GetPData('plySuitStorage2', 0))
	if (not IsValidSuitIndex(suitStore)) then suitStore = 0 end
	ply:SetNWInt( "plySuitStorage2", suitStore )
	
	suitStore = tonumber(ply:GetPData('plySuitStorage3', 0))
	if (not IsValidSuitIndex(suitStore)) then suitStore = 0 end
	ply:SetNWInt( "plySuitStorage3", suitStore )


	-- Have to do bound checks on these.
	local store = tonumber(ply:GetPData('plyStorage0', 0))
	if (not IsValidWeaponIndex(store)) then store = 0 end
	ply:SetNWInt( "plyStorage0", store )
	
	store = tonumber(ply:GetPData('plyStorage1', 0))
	if (not IsValidWeaponIndex(store)) then store = 0 end
	ply:SetNWInt( "plyStorage1", store )
	
	store = tonumber(ply:GetPData('plyStorage2', 0))
	if (not IsValidWeaponIndex(store)) then store = 0 end
	ply:SetNWInt( "plyStorage2", store )
	
	store = tonumber(ply:GetPData('plyStorage3', 0))
	if (not IsValidWeaponIndex(store)) then store = 0 end
	ply:SetNWInt( "plyStorage3", store )	
	
	store = tonumber(ply:GetPData('plyStorage4', 0))
	if (not IsValidWeaponIndex(store)) then store = 0 end
	ply:SetNWInt( "plyStorage4", store )	
	
	store = tonumber(ply:GetPData('plyStorage5', 0))
	if (not IsValidWeaponIndex(store)) then store = 0 end
	ply:SetNWInt( "plyStorage5", store )
	
	store = tonumber(ply:GetPData('plyStorage6', 0))
	if (not IsValidWeaponIndex(store)) then store = 0 end
	ply:SetNWInt( "plyStorage6", store )
	
	store = tonumber(ply:GetPData('plyStorage7', 0))
	if (not IsValidWeaponIndex(store)) then store = 0 end
	ply:SetNWInt( "plyStorage7", store )
	
	store = tonumber(ply:GetPData('plyStorage8', 0))
	if (not IsValidWeaponIndex(store)) then store = 0 end	
	ply:SetNWInt( "plyStorage8", store )


	ply:SetNWInt('plyO2Canisters', tonumber(ply:GetPData('plyO2Canisters', ConfigInfo["MarketFog"].Gameplay.StartingO2FilterQuantity)) )
	ply:SetNWInt( "plyMetal", tonumber(ply:GetPData('plyMetal', ConfigInfo["MarketFog"].Gameplay.StartingMetalQuantity)) )
	ply:SetNWInt( "plyCircuits", tonumber(ply:GetPData('plyCircuits', ConfigInfo["MarketFog"].Gameplay.StartingCircuitsQuantity)) )
	ply:SetNWInt('plyFuel', tonumber(ply:GetPData('plyFuel', ConfigInfo["MarketFog"].Gameplay.StartingFuelQuantity)) )
	
	ply:SetAmmo( tonumber(ply:GetPData('AmmoPistol', ConfigInfo["MarketFog"].Gameplay.StartingPistolAmmoQuantity)), "Pistol")
	ply:SetAmmo( tonumber(ply:GetPData('AmmoSMG1', ConfigInfo["MarketFog"].Gameplay.StartingSMGAmmoQuantity)), "SMG1")
	ply:SetAmmo( tonumber(ply:GetPData('AmmoShotgun', ConfigInfo["MarketFog"].Gameplay.StartingBuckshotAmmoQuantity)), "Buckshot")
	ply:SetAmmo( tonumber(ply:GetPData('AmmoRifle', ConfigInfo["MarketFog"].Gameplay.StartingAR2AmmoQuantity)), "AR2")
	ply:SetAmmo( tonumber(ply:GetPData('AmmoMagnum', ConfigInfo["MarketFog"].Gameplay.Starting357AmmoQuantity)), "357")
	
	local count = tonumber(ply:GetPData('CurrentWeaponCount', 0))

	if (count ~= 0) then

		for i=0,count-1 do 
			local weaponname = ply:GetPData("Weapon_"..i, "null")
			
			if (IsValidWeapon(weaponname) ) then
				ply:Give(weaponname)
			end
		end 
	else

		PlayerGiveStartWeapons(ply)
	end
	
	local health = tonumber(ply:GetPData('Health', 100))
	if (health <= 0) then health = 100 end
	ply:SetHealth(health)

	ply:SetNWBool('plyHasAlienWeapons', ply:GetPData("AlienWeaponFlag" ))
end

function ResetPlayerData(ply)

	ply:SetNWInt('plyMoney', ConfigInfo["MarketFog"].Gameplay.StartingMoneyQuantity)
	ply:SetNWInt('plySuit', ConfigInfo["MarketFog"].Gameplay.StartingSuit)
	ply:SetNWInt( "plyStorage0", 0 )
	ply:SetNWInt( "plyStorage1", 0 )
	ply:SetNWInt( "plyStorage2", 0 )
	ply:SetNWInt( "plyStorage3", 0 )
	ply:SetNWInt( "plyStorage4", 0 )
	ply:SetNWInt( "plyStorage5", 0 )
	ply:SetNWInt( "plyStorage6", 0 )
	ply:SetNWInt( "plyStorage7", 0 )
	ply:SetNWInt( "plyStorage8", 0 )
	
	ply:SetNWInt("plySuitStorage1", 0)
	ply:SetNWInt("plySuitStorage2", 0)
	ply:SetNWInt("plySuitStorage3", 0)
	
	ply:SetNWInt('plyO2Canisters', 0)
	ply:SetNWInt( "plyMetal", ConfigInfo["MarketFog"].Gameplay.StartingMetalQuantity )
	ply:SetNWInt( "plyCircuits", ConfigInfo["MarketFog"].Gameplay.StartingCircuitsQuantity )
	ply:SetNWInt('plyFuel', ConfigInfo["MarketFog"].Gameplay.StartingFuelQuantity  )
	SetSuit(ply)
	ply:ChatPrint("You have reset your character data")
end

SpawnCounter = 1
function GM:PlayerSpawn( ply )
	self.BaseClass:PlayerSpawn( ply )
	
	local totalSpawnPos = table.Count(PlayerSpawnData)
	ply:SetPos(PlayerSpawnData[SpawnCounter])
	SpawnCounter = (SpawnCounter + 1)
	if (SpawnCounter > totalSpawnPos) then SpawnCounter = 1 end
	
	ply:SetNWBool( 'plyJumpingAllowed', true );
	ply:SetNWInt( 'plyState', 0); 	-- 0 being that the player is inside where there is oxygen
	ply:SetNWBool("plyIsAiming", false)
	ply.UseWeaponSpawn = CurTime()
	ply:SetNWInt( 'plyO2', ConfigInfo["MarketFog"].Gameplay.RespawningO2Quantity);
		
	ply.CriticalMeter = 0
	ply.CriticalMeterMax = 100	
	
	-- When you aren't spawning for the first time.
	if (not ply.initialspawnflag) then
	
		ply:SetNWInt('plyO2Canisters', ConfigInfo["MarketFog"].Gameplay.RespawningO2FilterQuantity);
		ply:SetNWInt('plyMetal', ConfigInfo["MarketFog"].Gameplay.RespawningMetalQuantity)
		ply:SetNWInt('plyCircuits', ConfigInfo["MarketFog"].Gameplay.RespawningCircuitsQuantity)
		ply:SetNWInt('plyFuel', ConfigInfo["MarketFog"].Gameplay.RespawningFuelQuantity)
		ply:SetAmmo( ConfigInfo["MarketFog"].Gameplay.RespawningAR2AmmoQuantity, "AR2" ) 
		ply:SetAmmo( ConfigInfo["MarketFog"].Gameplay.Respawning357AmmoQuantity, "357" ) 
		ply:SetAmmo( ConfigInfo["MarketFog"].Gameplay.RespawningBuckshotAmmoQuantity, "buckshot" ) 
		ply:SetAmmo( ConfigInfo["MarketFog"].Gameplay.RespawningSMGAmmoQuantity, "SMG1" ) 	
		ply:SetAmmo(ConfigInfo["MarketFog"].Gameplay.RespawningPistolAmmoQuantity, "Pistol")
		PlayerGiveRespawnWeapons(ply)
	else
	
		PlayerGetData(ply)	
	end
	
	SetSuit(ply)
	ply.initialspawnflag = false
	
	SendAirdropDataToClients()
end

--hook.Add( "PlayerSpawn", "PlayerSpawnHook", SpawnPlayer )

function GM:PlayerLoadout( ply )
	ply:StripWeapons()
end


function GM:PlayerInitialSpawn(ply)
	self.BaseClass:PlayerInitialSpawn( ply )
	
	SendConfigInfo_Gameplay(ply)
	SendConfigInfo_Apparel(ply)
	SendConfigInfo_Weapons(ply)
	SendConfigInfo_Items(ply)
	SendHintTable(ply)
	SendLevelDataTable(ply)
	SendClientGUIMarkerTable(ply)
	SendCurrentHunterMission(ply)
	SendKeyCodes(ply)
	
	-- Uses our custom collision rule. i.e. that there should be no collision between players.
	ply:SetCustomCollisionCheck( true ) 
	ply:CollisionRulesChanged() 
	
	ply.initialspawnflag = true
	ply.pressedReload = 0
	ply:SetNWInt("plyDefaultWalkSpeed", 225)
	ply:SetNWInt("plyDefaultRunSpeed", 325)
	ply:SetNWInt("plyBackwardWalkSpeed", 90)
	ply:SetNWInt("plyBackwardRunSpeed", 95)
	ply:SetNWInt("plyAimWalkSpeed", 100)
	ply:SetNWInt("plyAimRunSpeed", 110)
	ply:SetNWInt('plyMaxO2', 100);	
		
	ply:SetNWInt('plyOwnedSuits', 0)
		
	ply:SetNWInt( 'plyQuestStage', 0)
	
	ply:SetNWBool('plyEntityDamageTut', false)
	ply:SetNWBool('plyNPCDamageTut', false)
	ply:SetNWBool('plyDeathTut', false)
	ply:SetNWBool('plyInventoryTut', false)
	ply:SetNWBool('plySpawnTut', false)
	ply:SetNWBool('plyReloadTut', false)
	ply:SetNWBool('plyO2Tut', false)
	ply:SetNWBool('plySafeZoneTut', false)
	ply:SetNWBool('plyLeavingSafeZoneTut', false)
	ply:SetNWBool('plySprintO2Advise', false)
	
	ply:SetNWBool("plyUseDefaultGasmarkPP", ConfigInfo["MarketFog"].Gameplay.UseDefaultGasMaskPostProcessFlag)
	ply:SetNWBool("plyEnableWeather", ConfigInfo["MarketFog"].Gameplay.WeatherEnabled)
	
	ply:SetNWBool( 'plyReplaceO2', false )
			
	ply.shootFlag = false
	ply.aimFlag = false
	ply.backFlag = false
	ply.forwardFlag = false
	ply.rightFlag = false
	ply.leftFlag = false
	ply.reloadFlag = false
	ply.replaceO2 = false
	ply.CurrentlyBeingPunishedForJumpingFlag = false
	ply.InEvacCircleFlag = false
		
	SendResourceDataToClients()	
		
	-- INITILISE THE TUTORIAL.
	timer.Create( CurTime().."HintInitialHelp", 4, 1, function()
		SendHint(ply, HintEnum["Help"], 8)
		
		timer.Create( CurTime().."HintInitialIntro1", 9, 1, function()
			SendHint(ply, HintEnum["Intro1"], 8)
			
			timer.Create( CurTime().."HintInitialIntro2", 9, 1, function()
				SendHint(ply, HintEnum["Intro2"], 8)
				
				timer.Create( CurTime().."HintInitialIntro3", 9, 1, function()
					SendHint(ply, HintEnum["Intro3"], 8)
					
					timer.Create( CurTime().."HintInitialIntro4", 9, 1, function()
						SendHint(ply, HintEnum["Intro4"], 8)
					end )
				end )
			end )
		end )
	end )
	
	
		
		
end

function GM:KeyPress( ply, key )

	if (key == IN_SPEED and not PlayerInSafeZone(ply)) then
		if (not ply:GetNWBool('plySprintO2Advise')) then
			SendHint(ply, HintEnum["SprintAdvise"], 7)
			ply:SetNWBool('plySprintO2Advise', true)
		end
	end
		
	if (key == IN_FORWARD) then ply.forwardFlag = true end
	if (key == IN_MOVELEFT) then ply.leftFlag = true end
	if (key == IN_MOVERIGHT) then ply.rightFlag = true end
	if (key == IN_BACK) then ply.backFlag = true end
	if (key == IN_ATTACK2) then ply.aimFlag = true end
	if (key == IN_ATTACK) then ply.shootFlag = true end
	if (key == IN_RELOAD) then 
		ply.reloadFlag = true
		ply.pressedReload = CurTime()
		if (not ply:GetNWBool('plyReloadTut')) then
			SendHint(ply, HintEnum["AmmoWarning1"], 9)
			ply:SetNWBool('plyReloadTut', true)
		end
	end

	if ( key == IN_JUMP ) then

		if (ply:GetNWBool("plyJumpingAllowed") == true) then
				
			ply:SetNWBool( 'plyJumpingAllowed', false );
			ply.CurrentlyBeingPunishedForJumpingFlag = true
			--ply:SetWalkSpeed( ply:GetNWInt("plyBackwardWalkSpeed") ) 
			--ply:SetRunSpeed( ply:GetNWInt("plyBackwardRunSpeed") ) 	
			
			-- Prevent jumping for a set number of seconds
			timer.Create( ply:Nick().."_JumpTimer", 3, 1,
			function ()
				if (IsValid(ply)) then
				
					ply:SetWalkSpeed( ply:GetNWInt("plyDefaultWalkSpeed") ) 
					ply:SetRunSpeed( ply:GetNWInt("plyDefaultRunSpeed")) 
					ply:SetNWBool( 'plyJumpingAllowed', true )
					ply.CurrentlyBeingPunishedForJumpingFlag = false
					ply:SetJumpPower(200);
					timer.Remove( ply:Nick().."_JumpTimer" ) 
	
				end		
			end);
	
		else

			ply:SetJumpPower( 0 ) ;
		end
	
	else
	
		if (ply.backFlag or ply.shootFlag or ply.aimFlag or ply.reloadFlag  ) then

			ply:SetWalkSpeed( ply:GetNWInt("plyBackwardWalkSpeed") ) 
			ply:SetRunSpeed( ply:GetNWInt("plyBackwardRunSpeed") ) 
		else
			ply:SetWalkSpeed( ply:GetNWInt("plyDefaultWalkSpeed") ) 
			ply:SetRunSpeed( ply:GetNWInt("plyDefaultRunSpeed")) 
		end	
	end

end

function PlayerResetSuitOnDeath(ply)

	if (ConfigInfo["MarketFog"].Gameplay.LostSuitOnDeathFlag) then
		local defaultsuitname = ConfigInfo["MarketFog"].Gameplay.DefaultSuitOnDeath	
		local index = 1
		local foundsuitflag = false
		for k, v in pairs( ConfigInfo["MarketFog"].Apparel ) do
		
			if (v.Name == defaultsuitname) then
				foundsuitflag = true
				break
			end	
			index = index + 1
		end
		
		if (foundsuitflag) then
			ply:SetNWInt('plySuit', index)
		else
			ply:SetNWInt('plySuit', 1)
		end
	end

end

function KillerStealMoney(victim, killer)
	
	if (ConfigInfo["MarketFog"].Gameplay.KillersStealMoneyFlag) then
	
		if (not killer:IsPlayer()) then return end
		if (killer == victim) then return end -- If you committed suicide.
		
		local victimmoney = victim:GetNWInt('plyMoney')
		local killermoney = killer:GetNWInt('plyMoney')
	
		local stolenmoney = victimmoney * ConfigInfo["MarketFog"].Gameplay.KillersStealMoneyRatio
		stolenmoney = math.Round( stolenmoney )
	
		victimmoney = victimmoney - stolenmoney
		killermoney = killermoney + stolenmoney
		
		victim:SetNWInt('plyMoney', victimmoney)
		killer:GetNWInt('plyMoney', killermoney)
		
		victim:ChatPrint("You had "..ConfigInfo["MarketFog"].Gameplay.CashDisplaySymbol..stolenmoney.." stolen.")
		killer:ChatPrint("You stole "..ConfigInfo["MarketFog"].Gameplay.CashDisplaySymbol..stolenmoney.." from the player you killed.")
	
	end

end

function PlayerLoseMoneyOnDeath(ply)


	if (ConfigInfo["MarketFog"].Gameplay.MoneyLostOnDeathFlag) then
	
		local money = ply:GetNWInt('plyMoney');
		money = money * (1.0 - ConfigInfo["MarketFog"].Gameplay.MoneyLostOnDeathRatio)
		money = math.Round( money )
		ply:SetNWInt('plyMoney', money);
	
	end
	

end

function PlayerDropsWeaponsOnDeath(ply)

	if ConfigInfo["MarketFog"].Gameplay.WeaponsLostOnDeathFlag then
		for k, v in pairs( ply:GetWeapons() ) do
			ply:DropWeapon( v );
		end
	end

end

function GM:PlayerDeath( victim, inflictor, attacker )

	if (not victim:GetNWBool('plyDeathTut')) then
		SendHint(victim, HintEnum["DyingTutorial1"], 9)
		victim:SetNWBool('plyDeathTut', true)
	end

	if (SelfDestructActivatedFlag) then
		victim:ChatPrint("You've left the Evac Zone.") 
		net.Start("SendNotInEvac")
		net.Send(victim)
		victim.InEvacCircleFlag = false
	end
	
	PlayerDropsWeaponsOnDeath(victim)
	PlayerResetSuitOnDeath(victim)
	KillerStealMoney(victim, attacker)
	PlayerLoseMoneyOnDeath(victim)

end

concommand.Add( "select_weapon", function( ply, cmd, args )

	if (not ply:IsValid()) then return end

	local weaponclassname = args[1]
		
	ply:SelectWeapon( weaponclassname )
		
	
end )

concommand.Add( "drop_weapon", function( ply, cmd, args )

	if (not ply:IsValid()) then return end

	local weaponclassname = args[1]
		
	 local tr = util.TraceLine( {
	start = ply:EyePos(),
	endpos = ply:EyePos() + ply:EyeAngles():Forward() * 90,
	filter = function( ent ) if ( ent:GetClass() == "prop_physics" ) then return true end end
	} )
		
	ply:StripWeapon( weaponclassname )
	local weapon = ents.Create(weaponclassname)
	weapon:SetPos(tr.HitPos)
	weapon:Spawn()	
	
end )

function ReplaceO2Canister(ply) 
	
	if (ply.reloadFlag and not ply.replaceO2 and CurTime() >= ply.pressedReload + 1 and not ply:GetNWBool( 'plyReplaceO2') and ply:GetNWInt( 'plyO2') < 100) then
		ply:ChatPrint("Release the Reload Button to change O2 tanks!")
		ply:EmitSound("Grenade.Blip")	
		ply.replaceO2 = true
	
	end 
		
end

function GM:CanTool( ply, tr, tool )

	if (tool == "remover") then
	
		if IsValid( tr.Entity ) then	
		end
	
		return false
	end
	
	if (tool == "dynamite") then return false end
	if (tool == "colour") then return false end
	if (tool == "paint") then return false end
	if (tool == "material") then return false end
	return true
end

function GM:KeyRelease( ply, key )

	if (key == IN_FORWARD) then ply.forwardFlag = false end
	if (key == IN_MOVELEFT) then ply.leftFlag = false end
	if (key == IN_MOVERIGHT) then ply.rightFlag = false end

	if (key == IN_BACK) then ply.backFlag = false end
	if (key == IN_ATTACK2) then ply.aimFlag = false end
	if (key == IN_ATTACK) then ply.shootFlag = false end
	if (key == IN_RELOAD) then 

		-- Replace my o2 canister
		if (ply.reloadFlag and ply.replaceO2) then
		
			local can = ply:GetNWInt('plyO2Canisters');
			if (can > 0) then
		
				if (not ply:GetNWBool('plyO2Tut')) then
					ply:SetNWBool('plyO2Tut', true)
				end
		
				ply:SetNWBool( 'plyReplaceO2', true )
				ply:ChatPrint("Replacing O2 Canister..")
				ply:EmitSound("AlyxEMP.Charge")
				timer.Create( ply:Nick().."_O2Timer", 2, 1,
						function ()
							ply:SetNWBool( 'plyReplaceO2', false )
							ply:EmitSound("AlyxEMP.Discharge")
							ply:ChatPrint("Successfully replaced O2 tank!")
							ply:SetNWInt('plyO2Canisters', can - 1);
							
							o2 = ply:GetNWInt('plyMaxO2') 
							ply:SetNWInt('plyO2', o2);
							
							if (ply.backFlag or ply.shootFlag or ply.aimFlag or ply.reloadFlag  ) then
	
								ply:SetWalkSpeed( ply:GetNWInt("plyBackwardWalkSpeed") ) 
								ply:SetRunSpeed( ply:GetNWInt("plyBackwardRunSpeed") ) 
							else
								ply:SetWalkSpeed( ply:GetNWInt("plyDefaultWalkSpeed") ) 
								ply:SetRunSpeed( ply:GetNWInt("plyDefaultRunSpeed")) 
							end
										
							timer.Remove( ply:Nick().."_O2Timer" ) 
						end);
			else
				ply:ChatPrint("You don't have any spare oxygen tanks!")
				ply:EmitSound("Grenade.Blip")						
			end	
			ply.replaceO2 = false
		end
	
		ply.reloadFlag = false	
	end
	
	-- Theres a bug with the PWB guns. If I walk backward shoot and reload the 
	-- speed gets reset. So I'm forcing it twice to be the walk speed.
	if (not ply.CurrentlyBeingPunishedForJumpingFlag) then
		if (ply.backFlag or ply.shootFlag or ply.aimFlag or ply.reloadFlag  ) then

			ply:SetWalkSpeed( ply:GetNWInt("plyBackwardWalkSpeed") ) 
			ply:SetRunSpeed( ply:GetNWInt("plyBackwardRunSpeed") ) 
		else
			ply:SetWalkSpeed( ply:GetNWInt("plyDefaultWalkSpeed") ) 
			ply:SetRunSpeed( ply:GetNWInt("plyDefaultRunSpeed")) 
		end
	end
	

end


local function PlayerCanPickupWeapon( ply, weap )

	if ( CurTime() <= ( ply.UseWeaponSpawn or 0 ) ) then return end 
	if ( not ply:KeyDown( IN_USE ) ) then return false end 
	local trace = util.QuickTrace( ply:GetShootPos(), ply:GetAimVector() * 8192, ply ) 
	if ( not trace.Entity or not trace.Entity:IsValid() or trace.Entity ~= weap ) then return false end 
	if (not CanEquipWeapon(ply, weap:GetClass())) then return false end

	-- Start a spawn timer
	if (weap.parentSpawnpoint ~= nil) then weap.parentSpawnpoint.spawntime = CurTime() + 300 end

	return true
	
end
hook.Add( "PlayerCanPickupWeapon", "UseWeapon", PlayerCanPickupWeapon )

function GetWeaponType(weaponName)

	for i=1, table.Count(ConfigInfo["MarketFog"].Weapon) do
		if (ConfigInfo["MarketFog"].Weapon[i].Name == weaponName) then
			return ConfigInfo["MarketFog"].Weapon[i].WeaponType 
		end
	end
	return "unknown"
end

function CanEquipWeapon(ply, weaponName)

	--Play the tutorial message
	if (not ply:GetNWBool('plyInventoryTut')) then
		SendHint(ply, HintEnum["InventoryTutorial1"], 15)
		ply:SetNWBool('plyInventoryTut', true)
	end

	local weaponType = GetWeaponType(weaponName)
	local wepTable = ply:GetWeapons()
	local totalWeapons = table.Count( wepTable )
	
	local pistolflag = false
	local totalweapon = 0
	local gmodflag = false
	local physgun = false
	local meleeflag = false
	
	for i=1, totalWeapons do
	
		if (IsValid(wepTable[i])) then
		
			local carriedWeaponName = wepTable[i]:GetClass()	
			local carriedWeaponType = GetWeaponType(carriedWeaponName)
			if (carriedWeaponName == weaponName) then
			
				ply:ChatPrint("You already have this weapon!")
				ply:EmitSound("AlyxEMP.Stop")
				return false
			end
			
			if (carriedWeaponType == "pistol") then totalweapon = totalweapon + 1 end
			if (carriedWeaponType == "smg") then totalweapon = totalweapon + 1 end
			if (carriedWeaponType == "shotgun") then totalweapon = totalweapon + 1 end
			if (carriedWeaponType == "rifle") then totalweapon = totalweapon + 1 end
			if (carriedWeaponType == "gmod") then gmodflag = true end
			if (carriedWeaponType == "phys") then physgun = true end
			if (carriedWeaponType == "melee") then meleeflag = true end

		end
	end
	
	if (weaponType == "gmod" and gmodflag) then
		ply:ChatPrint("You are carrying a gmod tool already. Open inventory with TAB, and drop a weapon.")
		ply:EmitSound("Grenade.Blip")
		return false
	elseif (weaponType == "gmod") then
		return true
	end
	
	if (weaponType == "phys" and physgun) then
		ply:ChatPrint("You are carrying a physgun already. Open inventory with TAB, and drop a weapon.")
		ply:EmitSound("Grenade.Blip")
		return false
	elseif (weaponType == "phys") then
		return true
	end
	
	if (weaponType == "melee" and meleeflag) then
		ply:ChatPrint("You are carrying a melee weapon already. Open inventory with TAB, and drop a weapon.")
		ply:EmitSound("Grenade.Blip")
		return false
	elseif (weaponType == "melee") then
		return true
	end
	
	if (totalweapon >= 3) then
		ply:ChatPrint("You can only carry up to 3 weapons. Press TAB to drop a weapon.")
		ply:EmitSound("Grenade.Blip")
		return false	
	end
		
	return true
end

--.