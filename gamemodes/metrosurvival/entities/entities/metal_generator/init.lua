----------------------------------
--	Market Fog	
--	Programmer : LIFO/Tednesday		
--	Date : 15/10/2018		
----------------------------------

AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()	


	self:SetModel( "models/props_wasteland/laundry_washer003.mdl" )
	
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType(SIMPLE_USE)
	self:SetUnFreezable( false )	
	self.Value = 0;
	self:SetNWInt( 'resourceamount', 0 )
	self:SetNWInt( 'maxresourceamount', 20 )
	self:SetNWBool("haspower", false)
	self.Timeout = 20
	self.NextTime = CurTime() + self.Timeout
	self.NextSecond = CurTime()
	self:SetObjMaxHealth(500);		
	self:SetPropOwner("none")
		
	local phys = self:GetPhysicsObject()  	
	if phys:IsValid() then  		
		phys:Wake();			
	end
	
end

function ENT:Think()
	
	if (CurTime() >= self.NextTime && self:GetNWBool("haspower")) then
		
		local amount = self:GetNWInt( 'resourceamount')
		local maxval = self:GetNWInt( 'maxresourceamount')
		if (amount < maxval) then self:SetNWInt( 'resourceamount', amount + 1) end
		self.NextTime = CurTime() + self.Timeout
	end
	
end

function ENT:Use( activator, caller )
 

	if ( activator:IsPlayer() ) then
		
		if IsValid(activator) and activator:Alive() then
		
			local amount = self:GetNWInt("resourceamount")	
			self:EmitSound("Grenade.Blip")
			
			if (amount > 0 ) then
				activator:ChatPrint("You gained Metal (x"..amount..").")
				self:SetNWInt("resourceamount", 0)
				local metal = activator:GetNWInt("plyMetal")
				local maxmetal = activator:GetNWInt("plyMaxMetal")
				metal = metal + amount
				if (metal > maxmetal) then metal = maxmetal end
				activator:SetNWInt("plyMetal", metal)
			else
				activator:ChatPrint("This generator hasn't produced anything yet.")	
			end
			
			if (!self:GetNWInt("haspower")) then
				activator:ChatPrint("This generator requires a working power generator in close proximity.")	
			end
		end 		
	end

end
--.