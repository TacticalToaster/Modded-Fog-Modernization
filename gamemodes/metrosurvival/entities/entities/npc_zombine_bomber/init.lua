AddCSLuaFile( "shared.lua" )

include('shared.lua')

local explodeSound = Sound("BaseExplosionEffect.Sound")

function ENT:SpawnFunction( ply, tr )
	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 6
	self.Spawn_angles = ply:GetAngles()
	self.Spawn_angles.pitch = 0
	self.Spawn_angles.roll = 0
	self.Spawn_angles.yaw = self.Spawn_angles.yaw + 180
	
	local ent = ents.Create( "npc_zombine_bomber" )
	ent:SetKeyValue( "disableshadows", "1" )
	ent:SetPos( SpawnPos )
	ent:SetAngles( self.Spawn_angles )
	ent:SetModel( "" )
	ent:SetNoDraw(true)
	ent:Spawn()
	ent:Activate()
	
	return ent
end

function ENT:Initialize()
	self.npc = ents.Create( "npc_zombine" )
	self.npc:SetPos( self:GetPos() )
	self.npc:SetAngles( self:GetAngles() )
	//self.npc:SetKeyValue( "cavernbreed", "1" )
	//self.npc:SetKeyValue( "incavern", "1" )
	//self.npc:SetMaterial("Models/antlion_guard/antlionGuard2")
	self.npc:CapabilitiesAdd(CAP_FRIENDLY_DMG_IMMUNE)
	self.npc:Spawn()
	self.npc:Activate()
	self.npc:SetHealth(110)
	self.npc:SetColor(Color(240, 86, 86))
	self.npc:SetModelScale(1.05)
	//self.npc:SetSkin(3)
	self.npc:SetName("Zombine Bomber")
	self:SetParent(self.npc)

	self.Radius = 256
	self.Damage = 150
 end

function ENT:Think()
	if IsValid(self.npc) and self.npc:Health() <= 0 then
		print("AH YEAH KABOOM")
		util.BlastDamage( self.npc, self.npc, self.npc:GetPos(), self.Radius, self.Damage )
		local effectdata = EffectData()
		effectdata:SetOrigin( self.npc:GetPos() )
		//util.Effect( "HelicopterMegaBomb", effectdata )
		util.Effect( "Explosion", effectdata )	 -- Big flame
	
		local shake = ents.Create( "env_shake" )
		shake:SetOwner( self )
		shake:SetPos( self.npc:GetPos() )
		shake:SetKeyValue( "amplitude", "50" )	-- Power of the shake
		shake:SetKeyValue( "radius", tostring(self.Radius * 2) )	-- Radius of the shake
		shake:SetKeyValue( "duration", "1" )	-- Time of shake
		shake:SetKeyValue( "frequency", "50" )	-- How har should the screenshake be
		shake:SetKeyValue( "spawnflags", "4" )	-- Spawnflags( In Air )
		shake:Spawn()
		shake:Activate()
		shake:Fire( "StartShake", "", 0 )
	
		local physExplo = ents.Create( "env_physexplosion" )
		physExplo:SetOwner( self )
        physExplo:SetPos( self.npc:GetPos() )
        physExplo:SetKeyValue( "Magnitude", "40" )	-- Power of the Physicsexplosion
        physExplo:SetKeyValue( "radius", tostring(self.Radius) )	-- Radius of the explosion
        physExplo:SetKeyValue( "spawnflags", "19" )
        physExplo:Spawn()
        physExplo:Fire( "Explode", "", 0.02 )	
		
		self.Entity:EmitSound( explodeSound )
		self.Entity:Remove()
	end

	if !IsValid( self.npc ) or self.npc:Health() <= 0 then
		self:Remove()
	end
end


function ENT:OnTakeDamage()
end

function ENT:OnRemove()
	if IsValid( self.npc ) and self.npc:Health() > 0 then
		self.npc:Remove()		
	end
end