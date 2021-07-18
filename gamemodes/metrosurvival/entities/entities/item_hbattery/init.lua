----------------------------------
--	Market Fog	
--	Programmer : LIFO/Tednesday		
--	Date : 15/10/2018		
----------------------------------

//AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()	


	self:SetModel( "models/items/battery.mdl" )
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
	
		local armour = activator:Armor()
		local maxarmour = activator:GetNWInt('plyMaxArmour');
		
		if armour < maxarmour then
		
			armour = armour + self.Value
			if (armour > maxarmour) then armour = maxarmour end
			activator:SetArmor(armour)
	
			activator:ChatPrint("Added Armour ( x 15 )")	
			self:EmitSound("ItemBattery.Touch");
			if (self.parentSpawnpoint != nil) then self.parentSpawnpoint.spawntime = CurTime() + 300 end
			self:Remove();
	
		else
		
			self:EmitSound("Grenade.Blip")
			activator:ChatPrint("Suit is full")	
		end	
	end
end
--.
