----------------------------------
--	Market Fog	
--	Programmer : LIFO/Tednesday		
--	Date : 15/10/2018		
----------------------------------


//AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()	


	self:SetModel( "models/items/combine_rifle_ammo01.mdl" )
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

function ENT:SetValue(val) 
	self.Value = val
end

function ENT:Use( activator, caller )
 

	if ( activator:IsPlayer() ) then
	
		local cans = activator:GetNWInt('plyO2Canisters')
		local maxcans = activator:GetNWInt('plyMaxO2Canisters')
		
		if (cans >= maxcans) then
		
			self:EmitSound("Grenade.Blip")
			activator:ChatPrint("Cannot carry any more o2 tanks")
		else
		
			cans = cans + self.Value
			if (cans > maxcans) then
				cans = maxcans
			end
			activator:SetNWInt('plyO2Canisters', cans)
			activator:ChatPrint("Added O2 Canister ( x "..self.Value.." )")	
			self:EmitSound("ItemBattery.Touch");
			if (self.parentSpawnpoint != nil) then self.parentSpawnpoint.spawntime = CurTime() + 300 end
			self:Remove();
		end
	
	end

end
--.
