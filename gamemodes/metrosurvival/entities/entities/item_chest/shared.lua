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

end

function ENT:Draw()
 
	self:DrawModel()
	self:GetModel()

end