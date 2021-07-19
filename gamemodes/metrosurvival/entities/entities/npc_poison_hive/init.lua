AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:SpawnFunction( ply, tr )
	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 6
	self.Spawn_angles = ply:GetAngles()
	self.Spawn_angles.pitch = 0
	self.Spawn_angles.roll = 0
	self.Spawn_angles.yaw = self.Spawn_angles.yaw + 180
	
	local ent = ents.Create( "npc_poison_hive" )
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
	self.npc = ents.Create( "npc_poisonzombie" )
	self.npc:SetPos( self:GetPos() )
	self.npc:SetAngles( self:GetAngles() )
	//self.npc:SetKeyValue( "crabsinnest", "1" )
	self.npc:CapabilitiesAdd(CAP_FRIENDLY_DMG_IMMUNE)
	self.npc:Spawn()
	self.npc:Activate()
	//self.npc:SetKeyValue( "crabsinnest", "1" )
	self.npc:SetHealth(700)
	self.npc:SetModelScale(1.4)
	local npc_name = "npc" .. self.npc:EntIndex()
	self.npc:SetName( "Poison Hive" )
	self:SetParent(self.npc)

	self.hatchTime = 0
	self.nestTime = 0
	self.maxBabies = 5
	self.currentBabies = 0
	self.babyList = {}
 end

function ENT:CheckForHatch()
	if self.hatchTime <= CurTime() then
		if IsValid(self.npc:GetEnemy()) then
			self:Hatch(self.npc:GetEnemy():GetPos())
		end
	end
end

function ENT:CheckForNest()
	if self.nestTime <= CurTime() then
		if IsValid(self.npc:GetEnemy()) then
			self:HatchNest(math.Rand(2, 3))
		end
	end
end

function ENT:HatchNest(times)
	for i=1, times do
		self:Hatch(self.npc:GetPos() + Vector(math.Rand(-100, 100), math.Rand(-100, 100), math.Rand(50, 100)) * 3)
		self.nestTime = CurTime() + 16
	end
end

function ENT:Hatch(pos)
	if self.currentBabies >= self.maxBabies then return end
	local ent = ents.Create("npc_headcrab_black")
	ent:SetOwner(self.npc)
	//ent:SetModelScale(.6)
	ent:SetPos(self.npc:GetPos() + Vector(0, 0, 175) + Vector(math.Rand(-40, 40), math.Rand(-40, 40), math.Rand(-40, 40)))
	ent:Spawn()
	ent:SetHealth(35)
	ent:SetName("Hatchling")

	self.babyList[ent:EntIndex()] = ent
	self.currentBabies = self.currentBabies + 1
	//print(self.currentBabies, "YEET")

	local spitDir = (pos - ent:GetPos())
	spitDir.z = spitDir.z + 1 * 300
	ent:SetVelocity(spitDir)

	self.hatchTime = CurTime() + 8
end

function ENT:CheckBabies()
	for i, v in pairs(self.babyList) do
		if !v:IsValid() then
			self.currentBabies = self.currentBabies - 1
			//print(self.currentBabies, "BABES")
			self.babyList[i] = nil
		end
	end
end

function ENT:Think()
	if IsValid( self.npc ) then

		self:CheckBabies()

		self:CheckForHatch()

		self:CheckForNest()

		if !IsValid( self.npc ) or self.npc:Health() <= 0 then
			self:Remove()
		end
	end
end


function ENT:OnTakeDamage()
end

function ENT:OnRemove()
	//for i, v in pairs(self.babyList) do
		//v:TakeDamage(35)
	//end
	if IsValid( self.npc ) and self.npc:Health() > 0 then
		self.npc:Remove()		
	end
end