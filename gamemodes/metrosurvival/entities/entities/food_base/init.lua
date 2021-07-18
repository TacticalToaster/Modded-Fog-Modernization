----------------------------------
--	Market Fog	
--	Programmer : LIFO/Tednesday		
--	Date : 15/10/2018		
----------------------------------

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:Initialize()	


	self:PhysicsInit( SOLID_VPHYSICS )

	local phys = self:GetPhysicsObject()  	
	if phys:IsValid() then  		
		
		phys:Wake()  	
	end
	
end

 function ENT:OnTakeDamage( dmginfo ) 
   
 	self.Entity:TakePhysicsDamage( dmginfo ) 
 	 
 end 
 
 --.
