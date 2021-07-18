----------------------------------
--	Market Fog	
--	Programmer : LIFO/Tednesday		
--	Date : 15/10/2018		
----------------------------------

//AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:SetContainerType()

	self:SetModel( "models/props_c17/oildrumchunk01d.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType(SIMPLE_USE)
//	self.ItemList = {}
	//local ItemTotal = math.random( 1, 6 )
	
	//for i=1, ItemTotal do
	//	local ItemClassName = 
	//	local Roll = math.random( 100 )
		
	//	if (Roll)
		
	//	self.ItemList[i]
	//end
	

	//self:DropToFloor()
		
	local phys = self:GetPhysicsObject()  	
	if phys:IsValid() then  		
		
	
		phys:Sleep();
				
	end

end


function ENT:Initialize()	

	
end


function ENT:Use( activator, caller )
 
	if ( activator:IsPlayer() ) then
	
		local armour = activator:Armor()
		local metal = activator:GetNWInt('plyMetal')
		local maxMetal = activator:GetNWInt('plyMaxMetal')
		
		if (metal >= maxMetal) then
		
			self:EmitSound("Grenade.Blip")
			activator:ChatPrint("Cannot carry any more metal")
		else
		
			metal = metal + self.Value
			if (metal > maxMetal) then
				metal = maxMetal
			end
			activator:SetNWInt('plyMetal', metal)
			activator:ChatPrint("Added Metal ( x "..self.Value .." )")	
			self:EmitSound("ItemBattery.Touch");
			self:Remove();
		end
		
	end
 
end
--.