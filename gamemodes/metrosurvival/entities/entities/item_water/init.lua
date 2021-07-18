----------------------------------
--	Market Fog	
--	Programmer : LIFO/Tednesday		
--	Date : 15/10/2018		
----------------------------------

//AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()	


	self:SetModel( "models/props_junk/garbage_plasticbottle003a.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType(SIMPLE_USE)
	self.Value = 15;

		
	local phys = self:GetPhysicsObject()  	
	if phys:IsValid() then  		
		
		
		phys:Wake();
		//phys:Sleep();
				
	end
	
end


function ENT:Use( activator, caller )
 

	if ( activator:IsPlayer() ) then
	
		local water = activator:GetNWInt("plyWater");

		if (water) < 100 then
			water = water + self.Value
			
			if water > 100 then
				activator:SetNWInt("plyWater", 100);
			else
				activator:SetNWInt("plyWater", water);
			end
			
			activator:ChatPrint("Added Water ( x 15 )")	
			self:EmitSound("ItemBattery.Touch");
			self:Remove();
	
		else
		
			self:EmitSound("Grenade.Blip")
			activator:ChatPrint("Water is full")
		
		end
	end
end
--.
