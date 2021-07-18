----------------------------------
--	Market Fog	
--	Programmer : LIFO/Tednesday		
--	Date : 15/10/2018		
----------------------------------

//AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()	


	self:SetModel( "models/props_lab/reciever01c.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType(SIMPLE_USE)
	self.Value = math.random(1, 3);

		
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
	
		local armour = activator:Armor()
		local metal = activator:GetNWInt('plyCircuits')
		local maxMetal = activator:GetNWInt('plyMaxCircuits')
		
		if (metal >= maxMetal) then
		
			self:EmitSound("Grenade.Blip")
			activator:ChatPrint("Cannot carry any more circuits")
		else
		
			metal = metal + self.Value 
			if (metal > maxMetal) then
				metal = maxMetal
			end
			activator:SetNWInt('plyCircuits', metal)
			activator:ChatPrint("Added Circuits ( x "..self.Value .." )")	
			if (self.parentSpawnpoint != nil) then 
				self.parentSpawnpoint.spawntime = CurTime() + 300
			end
			self:EmitSound("ItemBattery.Touch");
			self:Remove();
		end
		
	end
 
end
--.