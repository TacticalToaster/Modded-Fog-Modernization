----------------------------------
--	Market Fog	
--	Programmer : LIFO/Tednesday		
--	Date : 15/10/2018		
----------------------------------

//AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()	


	self:SetModel( "models/props_c17/trappropeller_engine.mdl" )
	
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType(SIMPLE_USE)
	self:SetUnFreezable( false )	
	self.NextTime = CurTime() + 1
	self:SetNWInt( 'maxpower', 5 )
	self:SetNWInt( 'curpower', 5 )
	self:SetObjMaxHealth(500);		
	self:SetPropOwner("none")

		
	local phys = self:GetPhysicsObject()  	
	if phys:IsValid() then  phys:Wake() end
	
end


function ENT:Use( activator, caller )
 
	if ( activator:IsPlayer() ) then
				
		if IsValid(activator) and activator:Alive() then

		end 		
	end
end

function ENT:GiveEnergy()

	local power = self:GetNWInt( 'curpower' )
	local maxpower = self:GetNWInt( 'maxpower' )
	power = power + 1
	if (power > maxpower) then power = maxpower end
	self:SetNWInt( 'curpower', power )
end

function ENT:TakeEnergy()

	local power = self:GetNWInt( 'curpower' )
	power = power - 1
	if (power < 0) then power = 0 end
	self:SetNWInt( 'curpower', power )
end
--.
