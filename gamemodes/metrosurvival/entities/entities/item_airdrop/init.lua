----------------------------------
--	Market Fog	
--	Programmer : LIFO/Tednesday		
--	Date : 15/10/2018		
----------------------------------

//AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()	


	self:SetModel( "models/items/ammocrate_smg1.mdl" )
	self:SetValue(10)
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType(SIMPLE_USE)
	
	local phys = self:GetPhysicsObject()  	
	if phys:IsValid() then  		
		
		
		phys:Wake();
		//phys:Sleep();
				
	end
	
end


function ENT:SetValue(val)
self.Value = val;

end

function ENT:GetValue()
return self.Value

end



 
function ENT:Use( activator, caller )
 

	if ( activator:IsPlayer() ) then
		
		local newPos = self:GetPos()
		newPos.z = newPos.z + 40.0;
		local typeroll = math.random(100)
		local delay = 60
		if (typeroll < 35) then
			local subroll = math.random(100)
			if (subroll < 40) then
			
				for i=1,5 do 	
					local wep=ents.Create("item_hpistolammo")	
					wep:SetPos(newPos)
					wep.deleteTimer = CurTime() + delay
					wep:Spawn()	
				end
			
			elseif (subroll < 60) then
			
				for i=1,4 do 	
					local wep=ents.Create("item_hshotgunammo1")
					wep:SetPos(newPos)
					wep.deleteTimer = CurTime() + delay
					wep:Spawn()	
				end
			
			elseif (subroll < 80) then
			
				for i=1,4 do 	
					local wep=ents.Create("item_hsmgammo")
					wep:SetPos(newPos)
					wep.deleteTimer = CurTime() + delay
					wep:Spawn()	
				end		
			elseif (subroll < 100) then
			
				for i=1,3 do 	
					local wep=ents.Create("item_hrifleammo")
					wep:SetPos(newPos)
					wep.deleteTimer = CurTime() + delay
					wep:Spawn()	
				end	
			end
		else
			AirdropTable = {}
			local TempTable = GetWeaponTable()
			PrintTable(TempTable)
						
			for i=1, table.Count(TempTable) do
				if (TempTable[i].AirDroppable ~= nil and TempTable[i].AirDroppable) then
					table.insert(AirdropTable, TempTable[i])
				end
			end

			if (table.Count(AirdropTable) > 0) then
			
				local roll = math.random(table.Count(AirdropTable))
				local wep=ents.Create(AirdropTable[roll].Name)
				wep:SetPos(newPos)
				wep:Spawn()
			
			end
		
		
		end
		
			
	
		self:EmitSound("ItemBattery.Touch");
		self:Remove();
	end
 
end
--.