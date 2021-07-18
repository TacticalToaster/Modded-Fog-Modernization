----------------------------------
--	Market Fog	
--	Programmer : LIFO/Tednesday		
--	Date : 15/10/2018		
----------------------------------
//AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()	


	self:SetModel( "models/items/combine_rifle_cartridge01.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType(SIMPLE_USE)
	self.Value = math.random(10, 30);

		
	local phys = self:GetPhysicsObject()  	
	if phys:IsValid() then  		
		
		
		phys:Wake();
		//phys:Sleep();
				
	end
	
end

function ENT:SetValue(val) 
	self.Value = val
end


function ENT:Use( activator, caller )
 

	if ( activator:IsPlayer() ) then
	
		local ammo = activator:GetAmmoCount( "AR2" ) 

		if (ammo) < 90 then
		
			ammo = ammo + self.Value
			if ammo > 90 then ammo = 90 end
			activator:SetAmmo( ammo, "AR2" ) 
			activator:ChatPrint("Added Rifle Ammo ( x "..self.Value.." )")			
			self:EmitSound("ItemBattery.Touch");
			if (self.parentSpawnpoint != nil) then self.parentSpawnpoint.spawntime = CurTime() + 300 end			
			self:Remove();
	
		else
		
			self:EmitSound("Grenade.Blip")
			activator:ChatPrint("Rifle ammo is full")
		
		end
		
	
	end
 
end
--.