----------------------------------
--	Market Fog	
--	Programmer : LIFO/Tednesday		
--	Date : 15/10/2018		
----------------------------------

//AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()	


	self:SetModel( "models/items/boxsrounds.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType(SIMPLE_USE)
	self.Value = math.random(5, 15);

		
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
	
		local ammo = activator:GetAmmoCount( "Pistol" ) 

		if (ammo) < 120 then
		
			ammo = ammo + self.Value
			if ammo > 120 then ammo = 120 end
			activator:SetAmmo( ammo, "Pistol" ) 
			activator:ChatPrint("Added Pistol Ammo ( x "..self.Value.." )")	
			if (self.parentSpawnpoint != nil) then self.parentSpawnpoint.spawntime = CurTime() + 300 end			
			self:EmitSound("ItemBattery.Touch");
			self:Remove();
	
		else
		
			self:EmitSound("Grenade.Blip")
			activator:ChatPrint("Pistol ammo is full")
		
		end
	end
end
--.
