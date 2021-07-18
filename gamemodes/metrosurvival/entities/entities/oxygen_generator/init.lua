----------------------------------
--	Market Fog	
--	Programmer : LIFO/Tednesday		
--	Date : 15/10/2018		
----------------------------------


//AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()	


	self:SetModel( "models/props_combine/combinethumper002.mdl" )
	
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType(SIMPLE_USE)
	self:SetObjMaxHealth(100);		
	self:SetPropOwner("none")
	self:SetNWBool("haspower", false)
	
	local phys = self:GetPhysicsObject()  	
	if phys:IsValid() then  		
		phys:Wake();			
	end
	
end


function ENT:Use( activator, caller )
 

	if ( activator:IsPlayer() ) then
	
			if (self:GetNWBool("haspower")) then
				
				if (IsValid(activator) and activator:Alive() and activator:GetNWInt('plyO2') < 100) then
					self:EmitSound("Grenade.Blip")
					activator:ChatPrint("Replenished Oxygen.")
					activator:SetNWInt( 'plyO2', 100)
				end 
			
			else
			
				activator:ChatPrint("Oxygen generator needs power")	
			end		
	end
 
end
--.
