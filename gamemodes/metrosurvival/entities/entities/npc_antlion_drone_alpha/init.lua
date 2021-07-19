AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:SpawnFunction( ply, tr )
	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 6
	self.Spawn_angles = ply:GetAngles()
	self.Spawn_angles.pitch = 0
	self.Spawn_angles.roll = 0
	self.Spawn_angles.yaw = self.Spawn_angles.yaw + 180
	
	local ent = ents.Create( "npc_antlion_drone_alpha" )
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
	self.npc = ents.Create( "npc_antlion" )
	self.npc:SetPos( self:GetPos() )
	self.npc:SetAngles( self:GetAngles() )
	//self.npc:SetKeyValue( "cavernbreed", "1" )
	//self.npc:SetKeyValue( "incavern", "1" )
	//self.npc:SetMaterial("Models/antlion_guard/antlionGuard2")
	self.npc:CapabilitiesAdd(CAP_FRIENDLY_DMG_IMMUNE)
	self.npc:Spawn()
	self.npc:Activate()
	self.npc:SetHealth(200)
	self.npc:SetModelScale(1.2)
	self.npc:SetSkin(3)
	self.npc:SetName("Antlion Alpha")
	self:SetParent(self.npc)
 end

function ENT:Think()
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