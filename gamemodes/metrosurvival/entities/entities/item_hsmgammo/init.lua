----------------------------------
--	Market Fog	
--	Programmer : LIFO/Tednesday		
--	Date : 15/10/2018		
----------------------------------

//AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()	


	self:SetModel( "models/items/boxmrounds.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType(SIMPLE_USE)
	self.Value = math.random(15, 45);

		
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
	
		local ammo = activator:GetAmmoCount( "SMG1" ) 

		if (ammo) < 120 then
		
			ammo = ammo + self.Value
			if ammo > 120 then ammo = 120 end
			activator:SetAmmo( ammo, "SMG1" ) 
			activator:ChatPrint("Added SMG Ammo ( x "..self.Value.." )")			
			self:EmitSound("ItemBattery.Touch");
			if (self.parentSpawnpoint != nil) then self.parentSpawnpoint.spawntime = CurTime() + 300 end			
			self:Remove();
	
		else
		
			self:EmitSound("Grenade.Blip")
			activator:ChatPrint("SMG ammo is full")
		
		end
		
	
	end
 
end
--.