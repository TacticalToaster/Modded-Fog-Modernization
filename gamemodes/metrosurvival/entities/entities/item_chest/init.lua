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
	
		local roll = math.random(1, 100)
		local subroll = math.random(1, 100)
		
		local newPos = self:GetPos()
		newPos.z = newPos.z + 40.0;
		local delay = 60
		if (roll < 50) then
		
			if (subroll < 50) then
			
				for i=1,4 do 	
					local wep=ents.Create("item_metal")	
					wep:SetPos(newPos)
					wep.deleteTimer = CurTime() + delay
					wep:Spawn()	
				end
			
			elseif (subroll < 80) then
			
				for i=1,4 do 	
					local wep=ents.Create("item_circuits")
					wep:SetPos(newPos)
					wep.deleteTimer = CurTime() + delay
					wep:Spawn()	
				end
			
			elseif (subroll <= 100) then
			
				for i=1,3 do 	
					local wep=ents.Create("item_fuel")
					wep:SetPos(newPos)
					wep.deleteTimer = CurTime() + delay
					wep:Spawn()	
				end		
			end
		
		elseif (roll < 60) then
		
			if (subroll < 80) then	
				for i=1,1 do 	
					local wep=ents.Create("item_hbattery")
					wep:SetPos(newPos)
					wep.deleteTimer = CurTime() + delay
					wep:Spawn()	
				end		
			else
				for i=1,1 do 	
					local wep=ents.Create("item_o2canister")
					wep:SetPos(newPos)
					wep.deleteTimer = CurTime() + delay
					wep:Spawn()	
				end			
			end
		
		elseif (roll < 80) then
		
			if (subroll < 40) then
			
				for i=1,2 do 	
					local wep=ents.Create("item_hpistolammo")	
					wep:SetPos(newPos)
					wep.deleteTimer = CurTime() + delay
					wep:Spawn()	
				end
			
			elseif (subroll < 60) then
			
				for i=1,1 do 	
					local wep=ents.Create("item_hshotgunammo1")
					wep:SetPos(newPos)
					wep.deleteTimer = CurTime() + delay
					wep:Spawn()	
				end
			
			elseif (subroll < 80) then
			
				for i=1,1 do 	
					local wep=ents.Create("item_hsmgammo")
					wep:SetPos(newPos)
					wep.deleteTimer = CurTime() + delay
					wep:Spawn()	
				end		
			elseif (subroll < 100) then
			
				for i=1,1 do 	
					local wep=ents.Create("item_hrifleammo")
					wep:SetPos(newPos)
					wep.deleteTimer = CurTime() + delay
					wep:Spawn()	
				end	
			end
		
		else
		
			local totalprob = 0
			local TempTable = GetWeaponTable()
			PrintTable(TempTable)
			
			for i=1, table.Count(TempTable) do
				if (TempTable[i].Spawnable ~= nil and TempTable[i].Spawnable) then
					totalprob = totalprob + TempTable[i].SpawnProb
				end
			end
		
			local probscale = 100.0 / totalprob
			local prob = 0
			for i=1, table.Count(TempTable) do
				if (TempTable[i].Spawnable ~= nil and TempTable[i].Spawnable ) then
					prob = prob + (TempTable[i].SpawnProb * probscale)
					if (prob >= roll) then
						itemToSpawn = TempTable[i].Name
						break
					end
				end
			end	

			local wep=ents.Create(itemToSpawn)
			wep:SetPos(newPos)
			//wep.deleteTimer = CurTime() + delay
			wep:Spawn()	
		end

		if (self.parentSpawnpoint != nil) then self.parentSpawnpoint.spawntime = CurTime() + 360 end
		self:EmitSound("ItemBattery.Touch");
		self:Remove();

	end
 
end
