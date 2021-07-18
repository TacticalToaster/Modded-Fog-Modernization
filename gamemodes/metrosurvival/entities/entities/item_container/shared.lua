----------------------------------
--	Market Fog	
--	Programmer : LIFO/Tednesday		
--	Date : 15/10/2018		
----------------------------------

ENT.Type 			= "anim"
ENT.Base 			= "food_base"

ENT.PrintName		= ""
ENT.Author			= ""
ENT.Contact			= ""
ENT.Purpose			= ""
ENT.Instructions	= ""

ENT.Spawnable			= false	
ENT.AdminSpawnable		= false

function ENT:Initialize()
	Msg(self:GetModel())
end

function ENT:Draw()
 
	self:DrawModel()
	self:GetModel()

end
--.