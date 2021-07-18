----------------------------------
--	Market Fog	
--	Programmer : LIFO/Tednesday		
--	Date : 18/10/2018		
----------------------------------

local function DisableNoclip( objPl )
	
	if objPl:Nick() == "LIFO" then
		return 1
	else	
		return 0 --return 0 if you want to disable
	end
end
hook.Add("PlayerNoClip", "DisableNoclip", DisableNoclip)


-- Called on a shutdown. 
function GM:ShutDown() 

	for k, v in pairs(player.GetAll()) do
		PlayerSaveData(v)
	end
	
	SaveEntityData()
end
	
-- Not called in single player
function GM:PlayerDisconnected(  ply ) 
	PlayerSaveData(ply)
end
	
function GM:PlayerSpawnEffect( ply, ent ) 
	return false
end
function GM:PlayerSpawnRagdoll( ply, ent ) 
	return false
end
function GM:PlayerSpawnVehicle( ply, ent )

	local metal = ply:GetNWInt('plyMetal');
	local fuel = ply:GetNWInt('plyFuel')
	local circuits = ply:GetNWInt('plyCircuits')
	if (metal >= 20 and circuits >= 10 and fuel >= 5) then
		metal = metal - 20
		circuits = circuits - 10
		fuel = fuel - 5
		ply:SetNWInt('plyMetal', metal);
		ply:SetNWInt('plyFuel', fuel);
		ply:SetNWInt('plyCircuits', circuits);
		return true
	else
		ply:ChatPrint("You need 20 metal, 10 circuits and 5 fuel to spawn a vehicle!")
		return false
	end

end
function GM:PlayerSpawnSWEP( ply, class, wep )
	return false;
end
function GM:PlayerSpawnNPC( ply, ent )
	return false;
end
function GM:PlayerSpawnSENT( ply, ent ) 
	return false
end
function GM:PlayerGiveSWEP( ply,  weapon,swep ) 
	return false
end

function GM:PlayerSpawnProp( ply, model )
	
	if (not ply:GetNWBool('plySpawnTut')) then
		SendHint(ply, HintEnum["SpawnPropTutorial1"], 10)
		ply:SetNWBool('plySpawnTut', true)
	end
	
	
	local metal = ply:GetNWInt('plyMetal');
	if (metal > 0) then
		metal = metal - 1
		ply:SetNWInt('plyMetal', metal);
		return true
	else
		ply:ChatPrint("You need 1 metal to spawn a prop!")
		return false
	end
	
end

function GM:EntityTakeDamage( target, dmginfo )
	return false
end

function GM:PostGamemodeLoaded() 
	hook.Remove( "OnGamemodeLoaded", "CreateMenuBar" )
end

last = Vector(0, 0, 0)
lastflag = false
function GM:ShowHelp(ply)

   --- Uncomment this when you want to print a position to the console when pressing f1
	local tr = util.TraceLine( {
	start = ply:EyePos(),
	endpos = ply:EyePos() + ply:EyeAngles():Forward() * 10000,
	filter = function( ent ) if ( ent:GetClass() == "prop_physics" ) then return true end end
	} )
	
local x = tr.HitPos.x;
local y = tr.HitPos.y;
local z = tr.HitPos.z;

	print("table.insert(EvacCombineAttackData, Vector("..ply:GetPos().x..","..ply:GetPos().y..","..ply:GetPos().z.."))")
end

hook.Add( "CanProperty", "block_property", function( ply, property, ent )

	if ( property == "remover" ) then return false end
	if ( property == "bonemanipulate" ) then return false end
		return false
end )

function GM:ShouldCollide( ent1, ent2 )

	-- If players are about to collide with each other, then they won't collide.
	if ( IsValid( ent1 ) and IsValid( ent2 ) and ent1:IsPlayer() and ent2:IsPlayer() and PlayerInSafeZone(ent1) and PlayerInSafeZone(ent2) ) then return false end

	-- We must call this because anything else should return true.
	return true

end

local inside, outside = 0, 1
local nextPrintTime = 0
local nextSpawnTime = 0
local nextcleantime = 0
local everytwosecond = 0
local nextFreezeTime = 0
local watermarktime = 0

SelfDestructTimeout = 0
SelfDestructActivatedFlag = false
SelfDestructOccurredFlag = false
local nextSelfDestructTime = 0

function Update()

	-- Set by default to despawn all npcs
	ResetGrid()

	for k, v in pairs(player.GetAll()) do
			
		 if (IsValid(v) and v:Alive()) then
		 
			local plyPos = v:GetPos()
			if (IsInside(plyPos, v)) then
				v:SetNWInt( 'plyState', inside);
				timer.Remove( v:Nick().."GasMaskSoundTimer")
			else
				v:SetNWInt( 'plyState', outside);
				if (not timer.Exists( v:Nick().."GasMaskSoundTimer" )) then
					net.Start("GasMaskSoundStart")
					net.Send(v)
					timer.Create( v:Nick().."GasMaskSoundTimer", 16, 0,
					function()
						net.Start("GasMaskSoundStart")
						net.Send(v)
					end )
				end
			end
			
			local insafe = PlayerInSafeZone(v)
			local safetutflag = v:GetNWBool('plyLeavingSafeZoneTut')
			if (not safetutflag and not insafe) then
				SendHint(v, HintEnum["LeavingSafeZoneTutorial1"], 8)
				v:SetNWBool('plyLeavingSafeZoneTut', true)
			elseif (insafe and safetutflag) then
				v:SetNWBool('plyLeavingSafeZoneTut', false) -- Reset so this message always appears.
				v:SetNWBool('plySprintO2Advise', false)
			end
			
			-- Override any despawn if the player is close to a NPC grid cell
			PlayerCheckGrid(v)
			ReplaceO2Canister(v)	
		end
	end

	
	-- Spawn and despawn based on the despawn flag.
	SpawnAndDespawnCells()
	
	-- This happens every second.
    if (CurTime() >= nextPrintTime) then

		CheckGenerators()

		if everytwosecond == 0 then
					
			-- Really want to keep this too a minimu in size.
			for k, v in pairs(player.GetAll()) do
			
				 if (IsValid(v) and v:Alive()) then
				 
				 	if (v:GetNWInt( 'plyState') == outside) then		
						local o2 = v:GetNWInt( 'plyO2')			
						if (o2 > 0) then
							
							-- Sprinting causes you to lose oxygen quicker.
							local amountdecrease = 1
							if (v:KeyDown(IN_SPEED)) then amountdecrease = 3 end 				
							o2 = o2 - amountdecrease
							v:SetNWInt( 'plyO2', o2)
						else
							v:SetHealth(v:Health()-5)    
							if (v:Health() <= 0) then
								v:Kill()
								v:ChatPrint("You suffocated!")  
							else
								v:ChatPrint("You are suffocating, " .. v:Name() .. "! Hold RELOAD to replace your O2 tank!")  
								v:EmitSound("physics/body/body_medium_break2.wav") 
							end				
						end		
								
					end
				end
			end
		end
		
		-- change what it gets modded by to change the amount of seconds
		everytwosecond = (everytwosecond + 1) % LevelData.OxygenDepletionRate
		nextPrintTime = CurTime() + 1	
    end
		
	if (CurTime() >= Airdrop.NextTime) then
	  
		SpawnAirdrop()	
		Airdrop.NextTime = Airdrop.Timeout + CurTime()
	end
	
	if (CurTime() >= watermarktime) then
	
		for k, v in pairs(player.GetAll()) do
			v:ChatPrint("You are playing Market Fog v"..VersionStr)  
		end
		watermarktime = CurTime() + 400 -- Display the watermark every 8 minutes.
	end
	
	if (ConfigInfo["MarketFog"].Gameplay.WeatherEnabled) then
	
		if (RainWeather.IsRainingFlag) then
		
			if (CurTime() >= RainWeather.RainEndsAt) then
			
				for k, v in pairs(player.GetAll()) do
					v:ChatPrint("It stopped raining.")  
					v:ConCommand( "mf_end_rain" ) 
				end
			
				RainWeather.NextRainStorm = CurTime() + math.random(ConfigInfo["MarketFog"].Gameplay.WeatherRainFrequencyMin, ConfigInfo["MarketFog"].Gameplay.WeatherRainFrequencyMax)
				RainWeather.IsRainingFlag = false
			end
		
		else
		
			if (CurTime() >= RainWeather.NextRainStorm) then
		
				for k, v in pairs(player.GetAll()) do
					v:ChatPrint("It started to rain.")  
					v:ConCommand( "mf_start_rain" ) 
				end
				
				RainWeather.RainEndsAt = CurTime() + math.random(ConfigInfo["MarketFog"].Gameplay.WeatherRainDurationMin, ConfigInfo["MarketFog"].Gameplay.WeatherRainDurationMax)
				RainWeather.IsRainingFlag = true
			end
		end
	end
	
	if (SelfDestructActivatedFlag) then
	
		if (CurTime() >= nextSelfDestructTime and SelfDestructTimeout > 0) then
			SelfDestructTimeout = SelfDestructTimeout - 1
			net.Start("SendSelfDestructCountdown")
			net.WriteInt(SelfDestructTimeout, 10)
			net.Broadcast()
			nextSelfDestructTime = nextSelfDestructTime + 1		
		elseif (SelfDestructTimeout <= 0) then
			SelfDestructActivatedFlag = false
			SelfDestructOccurredFlag = true
			SelfDestruct()
		end
					
		for k, v in pairs(player.GetAll()) do
		
			local pos = v:GetPos()
			local circlepos = LevelData.SelfDestructEvacPos
			local radius = LevelData.SelfDestructEvacRadius
			
			if (pos.z >= circlepos.z) then
			
				if (PointInCircle(pos.x, pos.y, circlepos.x, circlepos.y, radius)) then
				
					if (not v.InEvacCircleFlag) then	
						v:ChatPrint("You've entered the Evac Zone.") 
						net.Start("SendInEvac")
						net.Send(v)
						v.InEvacCircleFlag = true
					end
				else
				
					if (v.InEvacCircleFlag) then	
						v:ChatPrint("You've left the Evac Zone.") 
						net.Start("SendNotInEvac")
						net.Send(v)
						v.InEvacCircleFlag = false
					end			
				end		
			end
		end
		
	end
	
end
hook.Add("Think", "Update", Update)




function PointInCircle(px, py, cx, cy, r) 

  -- get distance between the point and circle's center
  -- using the Pythagorean Theorem
  local distX = px - cx;
  local distY = py - cy;
  local distance = math.sqrt((distX*distX) + (distY*distY))

  -- if the distance is less than the circle's
  -- radius the point is inside!
  if (distance <= r) then return true end

  return false
end

function GM:Initialize()
	util.PrecacheSound( "kaching.wav" ) 
end


SelfDestructEnemies = {}

function SelfDestruct()

	for k, v in pairs(player.GetAll()) do
			
		if (v.InEvacCircleFlag) then
			v:ScreenFade( SCREENFADE.OUT, Color( 255, 255, 255, 255 ), 7.0, 120 )
		else
			v:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0, 255 ), 7.0, 120 )	
		end
	
	end
	
	timer.Create( CurTime().."SelfDestructTimer", 7, 1,
		function()
		
			for k, v in pairs(player.GetAll()) do
		
				net.Start("SendSelfDestruct")
				net.WriteBool(v.InEvacCircleFlag)
				net.Send(v)				
				if (v.InEvacCircleFlag) then
					local money = v:GetNWInt("plyMoney")
					money = money + 50000
					v:SetNWInt("plyMoney", money)
					v:SetNWBool('plyHasAlienWeapons', true)
				else
					v:Kill()
				end
				v:SetPos(PlayerSpawnData[1])		
				v:Lock( )
			end		
		end)
	
	timer.Create( CurTime().."UnlockTimer", 70, 1,
		function()
		
			for k, v in pairs(player.GetAll()) do

				v:UnLock( )
			end		
		end)
	
	if (SelfDestructEnemies ~= nil) then
		for i=1,table.Count(SelfDestructEnemies) do 
			if (SelfDestructEnemies[i] ~= nil and IsValid(SelfDestructEnemies[i])) then
				SelfDestructEnemies[i]:Remove()	
			end
		end 	
	end

		
end



function SpawnEvacCombineDefense()

	for i=1,table.Count(EvacCombineAttackData) do 

			local aipos = EvacCombineAttackData[i]
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

			local vPoint = Vector(aipos.x, aipos.y, aipos.z + 40)
			local effectdata = EffectData()
			effectdata:SetOrigin( vPoint )
			util.Effect( "VortDispel", effectdata )	
			
			table.insert(SelfDestructEnemies, combine)
	end
end

function SpawnReaperDefense()

	for i=1,10 do 

		local ri = math.random( 1, table.Count(EvacCombineAttackData) )	
		local maji = ents.Create("npc_re5_reaper")
		maji:SetPos(EvacCombineAttackData[ri]);
		maji:SetAngles(Angle(0,  math.random( 0, 360 ), 0));
		maji:DropToFloor()
		maji:Spawn();
		table.insert(SelfDestructEnemies, maji)
	end
end

function SpawnTyrantDefense()

	for i=1,6 do 
	
		local ri = math.random( 1, table.Count(EvacCombineAttackData) )	
		local tyrant = ents.Create("npc_re_tyrant")
		tyrant:SetPos(EvacCombineAttackData[ri]);
		tyrant:SetAngles(Angle(0,  math.random( 0, 360 ), 0));
		tyrant:DropToFloor()
		tyrant:Spawn()
		tyrant:SetHealth(800)
		table.insert(SelfDestructEnemies, tyrant)
	end
end

function StartEvacDefence()

	SpawnEvacCombineDefense()
	
	timer.Create( CurTime().."SpawnEvacCombine", 180, 1,
	function()
	
		SpawnReaperDefense()
		timer.Create( CurTime().."SpawnMutantDefense", 80, 1,
		function()
				SpawnTyrantDefense()
				
				timer.Create( CurTime().."SpawnReaperDefense", 60, 1,
				function()
						SpawnTyrantDefense()
				end )
		end )
	end )
	
end

function ActivateSelfDestruct(ply)

-- Check if  the player is valid.
	if (not IsValid(ply) or not ply:IsPlayer()) then return end

	if (SelfDestructActivatedFlag or SelfDestructOccurredFlag) then
		ply:ChatPrint("This has already been activated!")
		ply:EmitSound("Grenade.Blip")
		return
	end

	rift = ents.Create( "prop_dynamic" )
	if ( !IsValid( rift ) ) then return end -- Check whether we successfully made an entity, if not - bail
	rift:SetModel( "models/effects/portalrift.mdl" )
	rift:SetPos( LevelData.SelfDestructEvacRiftEffectPos )
	rift:Spawn()

	local funnel = ents.Create( "prop_dynamic" )
	if ( !IsValid( funnel ) ) then return end -- Check whether we successfully made an entity, if not - bail
	funnel:SetModel( "models/effects/portalfunnel.mdl" )
	funnel:SetPos( LevelData.SelfDestructEvacFunnelEffectPos )
	funnel:Spawn()
	
	local glass = ents.Create( "prop_dynamic" )
	if ( !IsValid( glass ) ) then return end -- Check whether we successfully made an entity, if not - bail
	glass:SetModel( "models/effects/splodeglass.mdl" )
	glass:SetPos( LevelData.SelfDestructEvacGlassEffectPos )
	glass:Spawn()
	
	local totalSpawnPos = table.Count(PlayerSpawnData)
	ply:SetPos(PlayerSpawnData[SpawnCounter])
	SpawnCounter = (SpawnCounter + 1) % totalSpawnPos
	
	net.Start("SendSelfDestructWarningMessage")
	net.Broadcast()
	
	
	TeleportSound = CreateSound(rift, "ambient/levels/labs/teleport_rings_loop2.wav")
	TeleportSound:SetSoundLevel( 180 )
	TeleportSound:ChangeVolume( 1) 
	TeleportSound:Play()

	SelfDestructTimeout = 480
	SelfDestructActivatedFlag = true
	nextSelfDestructTime = CurTime() + 1
	
	StartEvacDefence()


	
end

function ActivateSelfDestructNet(len, ply)
	ActivateSelfDestruct(ply)
end


net.Receive( "MFActivateSelfDestruct", ActivateSelfDestructNet )


--.