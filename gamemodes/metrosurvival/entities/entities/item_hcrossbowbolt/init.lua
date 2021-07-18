----------------------------------
--	Market Fog	
--	Programmer : LIFO/Tednesday		
--	Date : 15/10/2018		
----------------------------------


//AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()	


	self:SetModel( "models/items/crossbowrounds.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType(SIMPLE_USE)
	self.Value = 1;

		
	local phys = self:GetPhysicsObject()  	
	if phys:IsValid() then  		
		
		
		phys:Wake();
		//phys:Sleep();
				
	end
	
end

function ENT:Use( activator, caller )
 

	if ( activator:IsPlayer() ) then
	
		local ammo = activator:GetAmmoCount( "XBowBolt" ) 

		if (ammo) < 20 then
		
			ammo = ammo + self.Value
			
			activator:SetAmmo( ammo, "XBowBolt" ) 
			activator:ChatPrint("Added Crossbow Bolt ( x "..self.Value.." )")				
			self:EmitSound("ItemBattery.Touch");
			self:Remove();
	
		else
		
			self:EmitSound("Grenade.Blip")
			activator:ChatPrint("Cross ammo is full")
		
		end
	end

end
--.
