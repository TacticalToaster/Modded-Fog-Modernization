AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:SpawnFunction( ply, tr )
	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 6
	self.Spawn_angles = ply:GetAngles()
	self.Spawn_angles.pitch = 0
	self.Spawn_angles.roll = 0
	self.Spawn_angles.yaw = self.Spawn_angles.yaw + 180
	
	local ent = ents.Create( "npc_antlion_ancient_guardian" )
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
	self.npc = ents.Create( "npc_antlionguard" )
	self.npc:SetPos( self:GetPos() )
	self.npc:SetAngles( self:GetAngles() )
	self.npc:SetKeyValue( "cavernbreed", "1" )
	self.npc:SetKeyValue( "incavern", "1" )
	self.npc:SetMaterial("Models/antlion_guard/antlionGuard2")
	self.npc:CapabilitiesAdd(CAP_FRIENDLY_DMG_IMMUNE)
	self.npc:Spawn()
	self.npc:Activate()
	self.npc:SetHealth(1000)
	self.npc:SetModelScale(1.5)
	local npc_name = "npc" .. self.npc:EntIndex()
	self.npc:SetName( npc_name )
	self:SetParent(self.npc)

	self.spitTime = 0
	self.showerTime = 0
 end

function ENT:CheckForSpray()
	if self.spitTime <= CurTime() then
		if IsValid(self.npc:GetEnemy()) then
			self:FlingAcid(self.npc:GetEnemy():GetPos())
		end
	end
end

function ENT:CheckForShower()
	if self.showerTime <= CurTime() then
		if IsValid(self.npc:GetEnemy()) then
			self:ShowerAcid(math.Rand(20, 30))
		end
	end
end

function ENT:ShowerAcid(times)
	for i=1, times do
		self:FlingAcid(self.npc:GetPos() + Vector(math.Rand(-100, 100), math.Rand(-100, 100), math.Rand(50, 100)) * 3)
		self.showerTime = CurTime() + 6
	end
end

function ENT:FlingAcid(pos)
	for i=1, 5 do
		local ent = ents.Create("grenade_spit")
		ent:SetOwner(self.npc)
		ent:SetPos(self.npc:GetPos() + Vector(0, 0, 175))
		ent:Spawn()

		local spitDir = (pos - ent:GetPos())
		spitDir.z = spitDir.z + 1 * 300
		//print(i)
		if i > 1 then
			spitDir = spitDir + Vector(math.Rand(-50, 50), math.Rand(-50, 50), math.Rand(-50, 50))
		end
		ent:SetVelocity(spitDir)
	end
	self.spitTime = CurTime() + 2
end

function ENT:Think()
	if IsValid( self.npc ) then

		self:CheckForShower()

		self:CheckForSpray()

		if !IsValid( self.npc ) or self.npc:Health() <= 0 then
			self:Remove()
		end
	end
end


function ENT:OnTakeDamage()
end

function ENT:OnRemove()
	if IsValid( self.npc ) and self.npc:Health() > 0 then
		self.npc:Remove()		
	end
end