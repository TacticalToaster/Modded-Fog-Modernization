AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:SpawnFunction( ply, tr )
	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 6
	self.Spawn_angles = ply:GetAngles()
	self.Spawn_angles.pitch = 0
	self.Spawn_angles.roll = 0
	self.Spawn_angles.yaw = self.Spawn_angles.yaw + 180
	
	local ent = ents.Create( "npc_scanner_enforcer" )
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
	self.npc = ents.Create( "npc_clawscanner" )
	self.npc:SetPos( self:GetPos() )
	self.npc:SetAngles( self:GetAngles() )
	self.npc:SetKeyValue( "shouldinspect", "0" )
	//self.npc:SetKeyValue( "incavern", "1" )
	//self.npc:SetMaterial("Models/antlion_guard/antlionGuard2")
	self.npc:CapabilitiesAdd(CAP_FRIENDLY_DMG_IMMUNE)
	self.npc:Spawn()
	self.npc:Activate()
	self.npc:SetHealth(100)
	self.npc:SetModelScale(1.3)
	//self.npc:SetSkin(3)
	self.npc:SetName("Scanner Enforcer")
	self:SetParent(self.npc)

	self.fireTime = 0
	self.shooting = false
 end

function ENT:Think()

	if self.npc:GetEnemy() then
		//print(self.npc:GetEnemy())
		//self.npc:SetLastPosition(self.npc:GetEnemy():GetPos())
		self.npc:SetTarget(self.npc:GetEnemy())
		self.npc:SetSchedule(SCHED_TARGET_CHASE)

		local tr = util.TraceLine({
			start = self.npc:GetPos(),
			endpos = self.npc:GetEnemy():GetPos(),
			filter = {self.npc, self.npc:GetEnemy()}
		})

		if tr.HitPos == self.npc:GetEnemy():GetPos() then
			self.shooting = true
		else
			self.shooting = false
		end

		if self.fireTime <= CurTime() and self.shooting and self.npc:GetPos():Distance(self.npc:GetEnemy():GetPos()) <= 1000 then
			self.npc:EmitSound("Weapon_functank.Single")
			self.npc:FireBullets({
				Attacker = self,
				Damage = 3,
				Num = 1,
				TracerName = "AR2Tracer",
				Dir = self.npc:GetAimVector(),
				Spread = Vector(.025, .025, 0),
				Src = self.npc:GetPos()
			})
			self.fireTime = CurTime() + .05
			//print(self.fireTime)
		end
	else
		self.npc:SetSchedule(SCHED_IDLE_STAND)
		print(self.npc:GetCurrentSchedule())
	end

	if !IsValid( self.npc ) or self.npc:Health() <= 0 then
		self:Remove()
	end
	self:NextThink(CurTime() + .01)
	return true
end


function ENT:OnTakeDamage()
end

function ENT:OnRemove()
	if IsValid( self.npc ) and self.npc:Health() > 0 then
		self.npc:Remove()		
	end
end