----------------------------------
--	Market Fog	
--	Programmer : LIFO/Tednesday		
--	Date : 15/10/2018		
----------------------------------

//AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()	


	self:SetModel( "models/props_c17/consolebox01a.mdl" )
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
	
		local armour = activator:Armor()
		local money = activator:GetNWInt('plyMoney')

		money = money + self.Value 
		activator:SetNWInt('plyMoney', money)
		activator:ChatPrint("Added Cash ( x "..self.Value .." )")	
		self:EmitSound("ItemBattery.Touch");
		self:Remove();
	
	end
 
end
--.