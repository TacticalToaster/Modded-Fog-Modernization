----------------------------------
--	Market Fog	
--	Programmer : LIFO/Tednesday		
--	Date : 15/10/2018		
----------------------------------

local Entity = FindMetaTable("Entity")

GlobalPowerGeneratorTable = {}
GlobalResourceGeneratorTable = {}

function Entity:IsOwnable()
	return self:GetNWBool( 'objIsOwnable');
end

function Entity:SetOwnable(bool)
	self:SetNWBool( 'objIsOwnable', bool);
end

function Entity:SetObjHealth(health)
	self:SetCanDestroy(true)
	self:SetNWInt( 'objHealth', health );
end

function Entity:SetObjMaxHealth(maxHealth)
	self:SetCanDestroy(true)
	self:SetNWInt( 'objMaxHealth', maxHealth );
	self:SetObjHealth(maxHealth);
end

function Entity:SetCanDestroy(bool)
	self:SetNWBool( 'objCanDestroy', bool);
end

function Entity:GetCanDestroy(bool)
	return self:GetNWBool( 'objCanDestroy');
end

function Entity:SetPropOwner(str)
	self:SetNWString( 'propowner', str );
end

function Entity:GetPropOwner()
	return self:GetNWString( 'propowner' );
end

function Entity:GetObjHealth()
	return self:GetNWInt( 'objHealth' );
end

function Entity:GetObjMaxHealth()
	return self:GetNWInt( 'objMaxHealth' );
end


function Entity:DamageHealth(damage)
	

	--DebugMessageInfo("entity.lua", "Entity:DamageHealth(damage)", "Entity self damaged!")

	if (self:IsPlayer()) then return true end
	
	if (self:GetCanDestroy()) then
	
		--DebugMessageError("Can destroy")
		
		local totalHealth = self:GetObjHealth() - damage
		local healthColor = (totalHealth/self:GetObjMaxHealth())*255
		local color = Color( 255, healthColor, healthColor, 255 )
		
		self:SetColor(color)
		
		local cls = self:GetClass()
		-- Those of this class go invisible when selecting the transalpha rendering mode. This is a temp workaround
		if (cls ~= "fuel_generator" and cls ~= "circuit_generator" and cls ~= "metal_generator" and cls ~= "power_generator" and cls ~= "oxygen_generator") then
			self:SetRenderMode( RENDERMODE_TRANSALPHA )
		end
		
		if (totalHealth <= 0) then

			local effectdata = EffectData();
			effectdata:SetOrigin( self:GetPos() );
			util.Effect( "Explosion", effectdata );
			self:Remove()
		else
			self:SetNWInt( 'objHealth', totalHealth )
		end
	end
	
	return true;
end

function GetPickableEntity(class)

	return (class == "prop_physics" or class == "circuit_generator" or
	class == "fuel_generator" or class == "metal_generator" or class == "power_generator" or class == "oxygen_generator")

end


function TakeDamageEntity( target, dmginfo )
	--self.BaseClass.EntityTakeDamage( self, target, dmginfo )
	

	local phys = target:GetPhysicsObject()
	local attacker = dmginfo:GetAttacker()
	
	if (target:IsVehicle() or target:GetClass() == "npc_turret_floor" or GetPickableEntity(target:GetClass())) then

		if (attacker:IsPlayer()) then
			if (not attacker:GetNWBool('plyEntityDamageTut')) then
				SendHint(attacker, HintEnum["EntityDamageTutorial1"], 7)
				attacker:SetNWBool('plyEntityDamageTut', true)
			end
		end
		
		target:DamageHealth(dmginfo:GetDamage());
	end
	
	if (target:IsPlayer()) then

		if (PlayerInSafeZone(target)) then
		
			if (not target:GetNWBool('plySafeZoneTut')) then
				SendHint(target, HintEnum["SafeZoneTutorial1"], 7)
				target:SetNWBool('plySafeZoneTut', true)		
				timer.Create( CurTime().."SafeZoneWarning1", 7, 1, function()
					target:SetNWBool('plySafeZoneTut', false)	
				end )		
			end	
			dmginfo:SetDamage( 0 )			
		elseif (dmginfo:IsDamageType( DMG_CRUSH  )) then
		
			dmginfo:SetDamage( 0 )
		end
	elseif (attacker:IsPlayer() and target:IsNPC() and !target.flagIsDead and target:Health() - dmginfo:GetDamage() <= 0) then
		
		local money = attacker:GetNWInt("plyMoney")	
		local reward = 0
		
		if (target:GetClass() == "npc_re5_chainsaw_majini" or target:GetClass() == "npc_re5_giant_majini" or target:GetClass() == "npc_re5_giant_majini") then	
			reward = 3000
		elseif (target:GetClass() == "npc_re5_reaper") then
			reward = 2000
		elseif (target:GetClass() == "npc_re_tyrant") then	
			reward = 10000
		end
		target.flagIsDead = true;
		money = money + reward
		if (reward > 0) then
			attacker:SetNWInt("plyMoney", money)	
			attacker:ChatPrint("You got "..ConfigInfo["MarketFog"].Gameplay.CashDisplaySymbol..reward.."!")
		end
	end
		
end
hook.Add("EntityTakeDamage", "TylerTakeEntityDamage", TakeDamageEntity)

function GeneratorCheckInSafeZone()

	local genpos = gen:GetPos()

	if (LevelData.GasScrubbedFlag) then return true end
	
	if (LevelData.CityRuinsFlag == 1) then
		return (genpos.z <= LevelData.GasHeight)
	else
		return PlayerInSafeZone(gen)	
	end

end

function GM:PlayerSpawnProp( ply, model )
	self.BaseClass.PlayerSpawnProp( self, ply, model )
	
	return true;
end

function CheckGenerators()
	for i=1,table.Count(GlobalPowerGeneratorTable) do 
		local maxpower = GlobalPowerGeneratorTable[i]:GetNWInt("maxpower")
		GlobalPowerGeneratorTable[i]:SetNWInt("curpower", maxpower)
	end
	for i=1,table.Count(GlobalResourceGeneratorTable) do 
		
		resource = GlobalResourceGeneratorTable[i]	
		resource:SetNWBool("haspower", false)	
		for j=1,table.Count(GlobalPowerGeneratorTable) do 
			gen = GlobalPowerGeneratorTable[j]
			curpower = gen:GetNWInt("curpower")
			
			-- The generators only work above the surface.
			if (GeneratorCheckInSafeZone(gen)) then break end
			
			if (curpower) > 0 then
				local dist = resource:GetPos():Distance( gen:GetPos() )
				if (dist < 500) then
					resource:SetNWBool("haspower", true)	
					curpower = curpower - 1
					gen:SetNWInt("curpower", curpower)
					break
				end
			end
		end
	end
end

function GM:OnEntityCreated( ent )
	self.BaseClass.OnEntityCreated( self, ent )
	
	--DebugMessageInfo("entity.lua", "GM:OnEntityCreated(ent)", "Entity created!")

	if ( ent:GetClass() == "prop_physics" or ent:IsVehicle()) then
	
		ent:SetPropOwner("none");
		ent:SetOwnable(true);
		ent:SetObjMaxHealth(500);
		ent:SetCanDestroy(true)
	else
		
		ent:SetOwnable(true);
	end
	
	if (ent:GetClass() == "power_generator") then table.insert(GlobalPowerGeneratorTable,ent) end
	if (ent:GetClass() == "metal_generator") then table.insert(GlobalResourceGeneratorTable, ent) end
	if (ent:GetClass() == "circuit_generator") then table.insert(GlobalResourceGeneratorTable, ent) end
	if (ent:GetClass() == "fuel_generator") then table.insert(GlobalResourceGeneratorTable, ent) end
	if (ent:GetClass() == "oxygen_generator") then table.insert(GlobalResourceGeneratorTable, ent) end
	
	return true;
end

function GM:EntityRemoved( ent ) 

	if (IsValid(ent) and ent.parentSpawnpoint ~= nil and ent.parentSpawnpoint.counter == 0) then
		ent.parentSpawnpoint.counter = ent.parentSpawnpoint.counter + 1	
	end
	
	-- Remove a generator from the global list
	for i=1,table.Count(GlobalPowerGeneratorTable) do 
		
		gen = GlobalPowerGeneratorTable[i]
	
		if (ent == gen) then
			table.remove(GlobalPowerGeneratorTable, i)
			break
		end	
	end
	
	-- Remove a generator from the global list
	for i=1,table.Count(GlobalResourceGeneratorTable) do 
		
		resource = GlobalResourceGeneratorTable[i]
	
		if (ent == resource) then
			table.remove(GlobalResourceGeneratorTable, i)
			break
		end	
	end
end

function GM:PhysgunPickup( player, entity ) 
	self.BaseClass.OnEntityCreated( self, player, entity )
		
	DebugMessageInfo("entity.lua", "GM:PhysgunPickup( player, entity )", "Physgun pickup!")
	
	if ( entity:IsOwnable() and (GetPickableEntity(entity:GetClass()) or entity:IsVehicle())  and (entity:GetPropOwner() == "none" or entity:GetPropOwner() == player:Nick())) then
	
		entity:SetPropOwner(player:Nick());
		return true;
	end
		
	return false;

end


function LoadEntityData()

	sql.Query( "BEGIN" )

	local datatable = sql.Query("SELECT * FROM MF_entity_data")
	local physicstable = {}
	if (datatable == nil) then
		return 
	end

	
	for k, v in pairs(datatable) do
					
		if (game.GetMap() == v["MapName"] and v["Owner"] != "world" and v["Owner"] != "none") then
		
			local ent = ents.Create(v["ClassName"])

			if (v["ClassName"] == "prop_physics") then
				ent:SetModel(v["ModelName"])
			end
			
			ent:SetPos(Vector(v["xPos"], v["yPos"], v["zPos"]) )
			local ang = ent:GetAngles();
			ang.pitch = v["xAng"]
			ang.yaw = v["yAng"]
			ang.roll = v["zAng"]
			ent:SetAngles(ang);
			ent:Spawn()
			ent:SetObjMaxHealth(500);
			ent:SetOwnable(true);
			ent:SetCanDestroy(true)
			ent:SetPropOwner(v["Owner"])

			local phys = ent:GetPhysicsObject()
			if (IsValid(phys)) then
				if (v["IsFrozen"] == 1) then
					phys:EnableMotion( true ) 
				else
					phys:EnableMotion( false ) 		
				end
			end
			
		end			
	end
	


end

function SaveEntityData()

	sql.Query( "COMMIT" )

	if (sql.TableExists( "MF_entity_data")) then
		sql.Query("DROP TABLE MF_entity_data" )
	end

	sql.Query("CREATE TABLE MF_entity_data(  MapName TEXT, ClassName TEXT, ModelName TEXT, Owner TEXT, IsFrozen INTEGER, xPos INTEGER, yPos INTEGER, zPos INTEGER, xAng INTEGER, yAng INTEGER, zAng INTEGER )" )
		
	for k, v in pairs( ents.GetAll() ) do

		if (v:GetClass() == "prop_physics" or v:IsVehicle() or
		v:GetClass() == "power_generator" or v:GetClass() == "metal_generator" or v:GetClass() == "circuit_generator" or
		v:GetClass() == "fuel_generator" or v:GetClass() == "oxygen_generator") then
		
			if (v:IsOwnable() and v:GetPropOwner() != "world" and v:GetPropOwner() != "none") then
			
				local phys = v:GetPhysicsObject()
				local isFrozen = IsValid( phys ) and !phys:IsMotionEnabled()
		
				local modelName = v:GetModel()
				if (v:GetModel() == nil) then
					modelName = ""
				end
		
				if (isFrozen) then
					sql.Query( "INSERT INTO MF_entity_data( MapName, ClassName, ModelName, Owner, IsFrozen, xPos, yPos, zPos, xAng, yAng, zAng ) VALUES( '"..game.GetMap().."', '"..v:GetClass().."', '"..modelName.."', '"..v:GetPropOwner().."', 1, "..v:GetPos().x..", "..v:GetPos().y..", "..v:GetPos().z..", "..v:GetAngles().pitch..", "..v:GetAngles().yaw..", "..v:GetAngles().roll..")" )
				else
					sql.Query( "INSERT INTO MF_entity_data( MapName, ClassName, ModelName, Owner, IsFrozen, xPos, yPos, zPos, xAng, yAng, zAng ) VALUES( '"..game.GetMap().."', '"..v:GetClass().."', '"..modelName.."', '"..v:GetPropOwner().."', 0, "..v:GetPos().x..", "..v:GetPos().y..", "..v:GetPos().z..", "..v:GetAngles().pitch..", "..v:GetAngles().yaw..", "..v:GetAngles().roll..")" )
				end
				
				print ("Saving Entity")
			end	
		end

	end



end


--.