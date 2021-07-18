----------------------------------
--	Market Fog	
--	Programmer : LIFO/Tednesday		
--	Date : 15/10/2018		
----------------------------------

//AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()	

	print("HAVE I BEEN CACHED")

	self:SetModel( "models/props_combine/combine_interface001.mdl" )
	
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

function ENT:SetComputerType(queststage)

	self.queststage = queststage
end



function ENT:Use( activator, caller )
 
	if ( (activator:IsPlayer()) and (self.CanUse == true) ) then
	
		self.CanUse = false
		self:EmitSound("buttons/button1.wav");
		print("Using Terminal")
		
		if (self.queststage == 0) then SendMFQuestIntro(activator) end
		if (self.queststage == 1) then SendMFQuestSubway(activator)  end
		if (self.queststage == 2) then SendMFQuestStreet(activator) end
		if (self.queststage == 3) then SendMFQuestParking(activator) end
		if (self.queststage == 4) then SendMFQuestShop(activator) end
		if (self.queststage == 5) then SendMFQuestPlaza(activator) end
		if (self.queststage == 6) then SendMFQuestApartment(activator) end
		if (self.queststage == 10) then SendMFQuestLab01(activator) end
		if (self.queststage == 11) then SendMFQuestLab02(activator) end
		if (self.queststage == 12) then SendMFQuestLab03(activator) end
		if (self.queststage == 99) then SendMFHunterMenu(activator) end

		timer.Create("TutSandyUseTimer", 1, 1, function() self.CanUse = true end)
	end
 
end
--.