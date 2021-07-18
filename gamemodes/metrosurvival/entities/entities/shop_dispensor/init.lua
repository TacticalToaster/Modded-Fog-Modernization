----------------------------------
--	Market Fog	
--	Programmer : LIFO/Tednesday		
--	Date : 15/10/2018		
----------------------------------

//AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

--- These fucking files get cached so I some how need it to NOT do that

function ENT:Initialize()	

	self:SetModel( "models/props_combine/combine_monitorbay.mdl" )
	
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType(SIMPLE_USE)
	self.CanUse = true
		
	local phys = self:GetPhysicsObject()  	
	if phys:IsValid() then  			
		phys:EnableMotion(false) -- Freezes the object in place.			
	end
	
end


function ENT:Use( activator, caller )
 
	if ( (activator:IsPlayer()) and (self.CanUse == true) ) then
	
		self.CanUse = false
		self:EmitSound("ItemBattery.Touch");

		SendMFShopOpen(activator)
		
		timer.Create("TutSandyUseTimer", 1, 1, function() self.CanUse = true end)
	end

end
--.
