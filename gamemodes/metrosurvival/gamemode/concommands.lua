----------------------------------
--	Market Fog	
--	Programmer : LIFO/Tednesday		
--	Date : 18/10/2018		
----------------------------------

-- ------------------------------------------------------CONCOMMAND	 MENUS

concommand.Add( "shop_sell_resource", function( ply, cmd, args )

		if (not ply:IsValid()) then return end

		local quantity = tonumber( args[1] ) 
		local resourcetype = args[2]
		
		print("type "..resourcetype.." quantity"..quantity)
		
		local money = ply:GetNWInt('plyMoney')	
		local resource = 0	 
		if resourcetype == "metal" then resource = ply:GetNWInt('plyMetal') end
		if resourcetype == "circuits" then resource = ply:GetNWInt('plyCircuits') end
		if resourcetype == "fuel" then resource = ply:GetNWInt('plyFuel') end

		if (resource >= quantity and quantity > 0) then
		
			for i=1,quantity do 

				local globalresource = 0
			
				if resourcetype == "metal" then
					money = money + Metal["Price"]
					Metal["Supply"] = Metal["Supply"] + 1
				end
				if resourcetype == "circuits" then 
					money = money + Circuits["Price"]
					Circuits["Supply"] = Circuits["Supply"] + 1
				end
				if resourcetype == "fuel" then
					money = money + Fuel["Price"]
					Fuel["Supply"] = Fuel["Supply"] + 1
				end	
	
				CalculatePrices()
			end 
			
			ply:SetNWInt('plyMoney', money)
			
			if resourcetype == "metal" then ply:SetNWInt('plyMetal', resource - quantity) end
			if resourcetype == "circuits" then ply:SetNWInt('plyCircuits', resource - quantity) end
			if resourcetype == "fuel" then 	ply:SetNWInt('plyFuel', resource - quantity) end	
			
			ply:EmitSound("ItemBattery.Touch")
		else
		
			ply:ChatPrint("Unable to buy resource")
			ply:EmitSound("AlyxEMP.Stop")
		end
		
	
end )

concommand.Add( "shop_buy_resource", function( ply, cmd, args )

	if (not ply:IsValid()) then return end

	local money = ply:GetNWInt('plyMoney')
	local quantity = tonumber( args[1] ) 
	local resourcetype = args[2]
	
	local resource = 0	
	if resourcetype == "metal" then resource = ply:GetNWInt('plyMetal') end
	if resourcetype == "circuits" then resource = ply:GetNWInt('plyCircuits') end
	if resourcetype == "fuel" then resource = ply:GetNWInt('plyFuel') end
	
	local maxresource = 0
	if resourcetype == "metal" then maxresource = ply:GetNWInt('plyMaxMetal') end
	if resourcetype == "circuits" then maxresource = ply:GetNWInt('plyMaxCircuits') end
	if resourcetype == "fuel" then maxresource = ply:GetNWInt('plyMaxFuel') end
	
	local supply = 0
	if resourcetype == "metal" then supply = Metal["Supply"] end
	if resourcetype == "circuits" then supply = Circuits["Supply"] end
	if resourcetype == "fuel" then supply = Fuel["Supply"] end
	
	local price = 0
	if resourcetype == "metal" then price = Metal["Price"] end
	if resourcetype == "circuits" then price = Circuits["Price"] end
	if resourcetype == "fuel" then price = Fuel["Price"] end
	
	if (quantity > 0 and supply >= quantity and money >= price * quantity and quantity + resource <= maxresource ) then
	
		for i=1,quantity do 
		
			if resourcetype == "metal" then money = money - Metal["Price"] end
			if resourcetype == "circuits" then money = money - Circuits["Price"] end
			if resourcetype == "fuel" then money = money - Fuel["Price"] end
		
			if resourcetype == "metal" then Metal["Supply"] = Metal["Supply"] - 1 end
			if resourcetype == "circuits" then Circuits["Supply"] = Circuits["Supply"] - 1 end
			if resourcetype == "fuel" then Fuel["Supply"] = Fuel["Supply"] - 1 end
					
			CalculatePrices()
		end 
	
		ply:SetNWInt('plyMoney', money)
		
		if resourcetype == "metal" then ply:SetNWInt('plyMetal', resource + quantity) end
		if resourcetype == "circuits" then ply:SetNWInt('plyCircuits', resource + quantity) end
		if resourcetype == "fuel" then ply:SetNWInt('plyFuel', resource + quantity) end
		
		ply:EmitSound("ItemBattery.Touch")
		CalculatePrices()
	else
	
		ply:ChatPrint("Unable to buy resource")
		ply:EmitSound("AlyxEMP.Stop")
	end


	
end )

concommand.Add( "shop_buy_armour", function( ply, cmd, args )

	if (not ply:IsValid()) then return end

	local money = ply:GetNWInt('plyMoney')
	local armour = ply:Armor();
	local maxarmour = ply:GetNWInt('plyMaxArmour')

	local armourPrice = tonumber(args[1])
	local armourVal = tonumber(args[2])
		
	if (money >= armourPrice and armour < maxarmour) then
	
		money = money - armourPrice
		ply:SetNWInt('plyMoney', money)
		
		armour = armour + armourVal
		if (armour > maxarmour) then armour = maxarmour end
		ply:SetArmor(armour)
		ply:EmitSound("ItemBattery.Touch")

	else
	
		ply:ChatPrint("Unable to buy armour")
		ply:EmitSound("AlyxEMP.Stop")
	end
	
end )

concommand.Add( "shop_buy_o2", function( ply, cmd, args )

	if (not ply:IsValid()) then return end

	local money = ply:GetNWInt('plyMoney')
	local canisters = ply:GetNWInt("plyO2Canisters")
	local maxcanisters = ply:GetNWInt('plyMaxO2Canisters')
	local price = tonumber(args[1])
	local quantity = tonumber(args[2])
		
	if (money >= price and canisters < maxcanisters) then
	
		money = money - price
		ply:SetNWInt('plyMoney', money)
		
		canisters = canisters + quantity
		if (canisters > maxcanisters) then canisters = maxcanisters end
		ply:SetNWInt( "plyO2Canisters", canisters ) 
		ply:EmitSound("ItemBattery.Touch")
	else
	
		ply:ChatPrint("Unable to buy o2")
		ply:EmitSound("AlyxEMP.Stop")
	end

end )

concommand.Add( "shop_buy_health", function( ply, cmd, args )

	if (not ply:IsValid()) then return end

	local money = ply:GetNWInt('plyMoney')
	local health = ply:Health()
	local maxhealth = ply:GetMaxHealth()
	local price = tonumber(args[1])
	local quantity = tonumber(args[2])
		
	if (money >= price and health < maxhealth) then
	
		money = money - price
		ply:SetNWInt('plyMoney', money)
		
		health = health + quantity
		if (health > maxhealth) then health = maxhealth end
		ply:SetHealth(health)
		ply:EmitSound("ItemBattery.Touch")
	else
	
		ply:ChatPrint("Unable to buy health")
		ply:EmitSound("Grenade.Blip")
	end

end )

concommand.Add( "shop_buy_ammo", function( ply, cmd, args )

	if (not ply:IsValid()) then return end

	local money = ply:GetNWInt('plyMoney')
	local price = tonumber(args[1])
	local quantity = tonumber(args[2])
	local ammotype = args[3]
		
	local ammo = ply:GetAmmoCount( ammotype )
	local maxammo = 120
		
	if ammotype == "Pistol" then maxammo = 120 end
	if ammotype == "Buckshot" then maxammo = 48 end
	if ammotype == "AR2" then maxammo = 90 end
	
	if (money >= price and ammo < maxammo) then
	
		money = money - price
		ply:SetNWInt('plyMoney', money)
		
		ammo = ammo + quantity
		if (ammo > maxammo) then ammo = maxammo end
		ply:SetAmmo( ammo, ammotype ) 
		ply:ChatPrint("You bought ammo(x"..quantity..")")
		ply:EmitSound("ItemBattery.Touch")
	else
	
		ply:ChatPrint("Unable to buy ammo")
		ply:EmitSound("Grenade.Blip")
	end

end )

concommand.Add( "shop_buy_weapon", function( ply, cmd, args )

	if (not ply:IsValid()) then return end

	local money = ply:GetNWInt('plyMoney')
	local price = tonumber(args[1])
	local weaponName = args[2]
	local printName = args[3]

	if (money >= price) then
			
		if (CanEquipWeapon(ply, weaponName)) then
			-- To get around my horrible hack for auto picking weapons up
			money = money - price
			ply:SetNWInt('plyMoney', money)
			ply.UseWeaponSpawn = CurTime() + 1
			if (not IsValid(ply:Give( weaponName, true ))) then return end 
			ply.UseWeaponSpawn = CurTime()
			ply:ChatPrint("You bought the "..printName.."!")
			ply:EmitSound("ItemBattery.Touch")
		end
	
	else
	
		ply:ChatPrint("You couldn't afford the "..printName.."!")
		ply:EmitSound("Grenade.Blip")
	end

end )

concommand.Add( "inventory_craft_weapon", function( ply, cmd, args )

	if (not ply:IsValid()) then return end

	local metal = ply:GetNWInt('plyMetal')
	local circuits = ply:GetNWInt('plyCircuits')
	local fuel = ply:GetNWInt('plyFuel')
	
	local metalprice = tonumber(args[1])
	local circuitsprice = tonumber(args[2])
	local fuelprice = tonumber(args[3])
	local weaponname = args[4]
	local printname = args[5]

	
	if (metal >= metalprice and circuits >= circuitsprice and fuel >= fuelprice) then
			
		if (CanEquipWeapon(ply, weaponname)) then
			-- To get around my horrible hack for auto picking weapons up
			metal = metal - metalprice
			circuits = circuits - circuitsprice
			fuel = fuel - fuelprice
			ply:SetNWInt('plyMetal', metal)
			ply:SetNWInt('plyCircuits', circuits)
			ply:SetNWInt('plyFuel', fuel)
			ply.UseWeaponSpawn = CurTime() + 1		
			if (weaponname == "deika_blundergat" or weaponname == "weapon_teslagun") then
				if (not IsValid(ply:Give( weaponname, false ))) then return end 
			else
				if (not IsValid(ply:Give( weaponname, true ))) then return end 
			end		
			ply.UseWeaponSpawn = CurTime()
			ply:ChatPrint("You crafted the "..printname.."!")
			ply:EmitSound("ItemBattery.Touch")
		else
			ply:ChatPrint("You are carrying too many weapons to craft this item. Drop a weapon first.")
			ply:EmitSound("Grenade.Blip")
		end
	
	else
	
		ply:ChatPrint("You don't have the parts to craft the "..printname.."!")
		ply:EmitSound("Grenade.Blip")
	end

end )

concommand.Add( "inventory_craft_base", function( ply, cmd, args )

	if (not ply:IsValid()) then return end

	local metal = ply:GetNWInt('plyMetal')
	local circuits = ply:GetNWInt('plyCircuits')
	local fuel = ply:GetNWInt('plyFuel')
	
	local metalprice = tonumber(args[1])
	local circuitsprice = tonumber(args[2])
	local fuelprice = tonumber(args[3])
	local itemname = args[4]
	local printname = args[5]

	local tr = util.TraceLine( {
	start = ply:EyePos(),
	endpos = ply:EyePos() + ply:EyeAngles():Forward() * 90,
	filter = function( ent ) if ( ent:GetClass() == "prop_physics" ) then return true end end
	} )
	
	if (metal >= metalprice and circuits >= circuitsprice and fuel >= fuelprice) then
		metal = metal - metalprice
		circuits = circuits - circuitsprice
		fuel = fuel - fuelprice
		ply:SetNWInt('plyMetal', metal)
		ply:SetNWInt('plyCircuits', circuits)
		ply:SetNWInt('plyFuel', fuel)
		local item = ents.Create(itemname) 
		print(itemname)
		item:SetPos(tr.HitPos)						
		item:SetAngles(Angle(0, math.random( 0, 360 ), 0))
		item:Spawn()
		item:SetPropOwner(ply:Nick())
		ply:ChatPrint("You crafted the "..printname.."!")
		ply:EmitSound("ItemBattery.Touch")
	else
	
		ply:ChatPrint("You don't have the parts to craft the "..printname.."!")
		ply:EmitSound("Grenade.Blip")
	end

end )

concommand.Add( "inventory_craft_ammo", function( ply, cmd, args )

	if (not ply:IsValid()) then return end

	local metal = ply:GetNWInt('plyMetal')	
	local pistolammo = ply:GetAmmoCount( "Pistol" )
	local shotgunammo = ply:GetAmmoCount( "Buckshot" )
	local smgammo = ply:GetAmmoCount( "SMG1" )
	local rifleammo = ply:GetAmmoCount( "AR2" )
	
	local metalprice = tonumber(args[1])
	local pistolprice = tonumber(args[2])
	local smgprice = tonumber(args[3])
	local shotgunprice = tonumber(args[4])
	local rifleprice = tonumber(args[5])
	local quantity = tonumber(args[6])
	local ammotype = args[7]
	local printname = args[8]

	local ammo = ply:GetAmmoCount( ammotype )
	local maxammo = 120
		
	if ammotype == "Pistol" then maxammo = 120 end
	if ammotype == "Buckshot" then maxammo = 48 end
	if ammotype == "AR2" then maxammo = 90 end
	
	if (metal >= metalprice and pistolammo >= pistolprice and smgammo >= smgprice and shotgunammo >= shotgunprice and rifleammo >= rifleprice and ammo < maxammo) then
			
		ammo = ammo + quantity
		if (ammo > maxammo) then ammo = maxammo end
		if ammotype == "Pistol" then pistolammo = ammo end
		if ammotype == "Buckshot" then shotgunammo = ammo end
		if ammotype == "SMG1" then smgammo = ammo end
		if ammotype == "AR2" then rifleammo = ammo end
		
		metal = metal - metalprice
		pistolammo = pistolammo - pistolprice
		smgammo = smgammo - smgprice
		shotgunammo = shotgunammo - shotgunprice
		rifleammo = rifleammo - rifleprice
		
		ply:SetAmmo( pistolammo, "Pistol" ) 
		ply:SetAmmo( smgammo, "SMG1" ) 
		ply:SetAmmo( shotgunammo, "Buckshot" ) 
		ply:SetAmmo( rifleammo, "AR2" ) 
		ply:SetNWInt('plyMetal', metal)	
		
		ply:ChatPrint("You crafted the "..printname.."!")
		ply:EmitSound("ItemBattery.Touch")
	else
	
		ply:ChatPrint("You were unable to craft "..printname.."!")
		ply:EmitSound("Grenade.Blip")
	end

end )

concommand.Add( "shop_sell_weapon", function( ply, cmd, args )

	if (not ply:IsValid()) then return end

	local money = ply:GetNWInt('plyMoney')
	local price = tonumber(args[1])
	local weaponName = args[2]
	local printName = args[3]

	ply:StripWeapon( weaponName )
	money = money + price
	ply:ChatPrint("You sold the "..printName.." for "..ConfigInfo["MarketFog"].Gameplay.CashDisplaySymbol..price)
	ply:EmitSound("ItemBattery.Touch")
	ply:SetNWInt("plyMoney", money)

end )

concommand.Add( "increment_quest", function( ply, cmd, args )

	if (not ply:IsValid()) then return end

	local money = ply:GetNWInt('plyMoney')
	local curqueststage = ply:GetNWInt("plyQuestStage")
	local newqueststage = tonumber(args[1])

	if (curqueststage == 0 and newqueststage == 1) then -- intro
			
		ply:ChatPrint("You completed the quest! You gain "..ConfigInfo["MarketFog"].Gameplay.CashDisplaySymbol.."1000")
		money = money + 1000
		ply:SetNWInt("plyQuestStage", newqueststage)
		ply:EmitSound("ItemBattery.Touch")
		ply:SetNWInt('plyMoney', money)
	elseif (curqueststage == 1 and newqueststage == 2) then --subway
	
		ply:ChatPrint("You completed the quest! You gain "..ConfigInfo["MarketFog"].Gameplay.CashDisplaySymbol.."2500")
		money = money + 2500
		ply:SetNWInt("plyQuestStage", newqueststage)
		ply:EmitSound("ItemBattery.Touch")
		ply:SetNWInt('plyMoney', money)
	elseif (curqueststage == 2 and newqueststage == 3) then --street
	
		ply:ChatPrint("You completed the quest! You gain "..ConfigInfo["MarketFog"].Gameplay.CashDisplaySymbol.."2750")
		money = money + 2750
		ply:SetNWInt("plyQuestStage", newqueststage)
		ply:EmitSound("ItemBattery.Touch")
		ply:SetNWInt('plyMoney', money)
	elseif (curqueststage == 3 and newqueststage == 4) then --parking
	
		ply:ChatPrint("You completed the quest! You gain "..ConfigInfo["MarketFog"].Gameplay.CashDisplaySymbol.."4000")
		money = money + 4000
		ply:SetNWInt("plyQuestStage", newqueststage)
		ply:EmitSound("ItemBattery.Touch")
		ply:SetNWInt('plyMoney', money)
		
	elseif (curqueststage == 4 and newqueststage == 5) then --parking
	
		ply:ChatPrint("You completed the quest! You gain "..ConfigInfo["MarketFog"].Gameplay.CashDisplaySymbol.."5000")
		money = money + 5000
		ply:SetNWInt("plyQuestStage", newqueststage)
		ply:EmitSound("ItemBattery.Touch")
		ply:SetNWInt('plyMoney', money)
	elseif (curqueststage == 5 and newqueststage == 6) then --parking
	
		ply:ChatPrint("You completed the quest! You gain "..ConfigInfo["MarketFog"].Gameplay.CashDisplaySymbol.."6000")
		money = money + 6000
		ply:SetNWInt("plyQuestStage", newqueststage)
		ply:EmitSound("ItemBattery.Touch")
		ply:SetNWInt('plyMoney', money)
	elseif (curqueststage == 6 and newqueststage == 7) then --parking
	
		ply:ChatPrint("You completed the quest! You gain "..ConfigInfo["MarketFog"].Gameplay.CashDisplaySymbol.."8000")
		money = money + 8000
		ply:SetNWInt("plyQuestStage", newqueststage)
		ply:EmitSound("ItemBattery.Touch")
		ply:SetNWInt('plyMoney', money)
		
		
		if (BillZombieEntity == nil) then
			BillZombieEntity = ents.Create("npc_re_tyrant");
			if (not IsValid(BillZombieEntity)) then return end			
			BillZombieEntity:SetPos(Vector(ObjectPositionData.Bill.x, ObjectPositionData.Bill.y, ObjectPositionData.Bill.z));
			BillZombieEntity:SetAngles(Angle(0,  ObjectPositionData.Bill.angle, 0));
			BillZombieEntity:Spawn();
			BillZombieEntity:SetHealth(2500);
		end	
	end
end )

concommand.Add( "teleport_to_lab", function( ply, cmd, args )

	if (not ply:IsValid()) then return end
		
	if (LevelData.CityRuinsFlag == 1) then
		ply:SetPos(PlayerLabSpawn)
	elseif (LevelData.LabDoor ~= nil) then
		LevelData.LabDoor:Remove()
	end
	
	net.Start("SendLabWarningMessage")
	net.Broadcast()
	
	local money = ply:GetNWInt("plyMoney")
	money = money + 100000
	ply:SetNWInt("plyMoney", money)
	ply:ChatPrint("Congratulations. You found the lab! You gained "..ConfigInfo["MarketFog"].Gameplay.CashDisplaySymbol..tostring(100000).."!")

end )

concommand.Add( "storage_withdraw_weapon", function( ply, cmd, args )

	if (not ply:IsValid()) then return end

	local storageindex = tonumber(args[1])
	local wepindex = tonumber(args[2])
	local weaponName = ConfigInfo["MarketFog"].Weapon[wepindex].Name
	
	if (CanEquipWeapon(ply, weaponName)) then
	
		ply.UseWeaponSpawn = CurTime() + 1
		if (not IsValid(ply:Give( weaponName, true ))) then return end 
		ply.UseWeaponSpawn = CurTime()
		
		ply:EmitSound("ItemBattery.Touch")	
		if (storageindex == 0) then ply:SetNWInt('plyStorage0', 0) end
		if (storageindex == 1) then ply:SetNWInt('plyStorage1', 0) end
		if (storageindex == 2) then ply:SetNWInt('plyStorage2', 0) end
		if (storageindex == 3) then ply:SetNWInt('plyStorage3', 0) end		
		if (storageindex == 4) then ply:SetNWInt('plyStorage4', 0) end
		if (storageindex == 5) then ply:SetNWInt('plyStorage5', 0) end
		if (storageindex == 6) then ply:SetNWInt('plyStorage6', 0) end
		if (storageindex == 7) then ply:SetNWInt('plyStorage7', 0) end	
		if (storageindex == 8) then ply:SetNWInt('plyStorage8', 0) end
		ply:ChatPrint("You withdrew the weapon.")
	end
	
end)

concommand.Add( "storage_deposit_weapon", function( ply, cmd, args )

	if (not ply:IsValid()) then return end
	
	local myindex = tonumber(args[1])
	local wepindex = tonumber(args[2])
	local weptable = ply:GetWeapons()
	
	local storageindex = ply:GetNWInt('plyStorage0');
	if (storageindex == 0) then
		ply:SetNWInt('plyStorage0', wepindex)
		ply:EmitSound("ItemBattery.Touch")
		ply:ChatPrint("You deposited the weapon.")

		ply:StripWeapon( ConfigInfo["MarketFog"].Weapon[wepindex].Name )
		return 
	end
	storageindex = ply:GetNWInt('plyStorage1');
	if (storageindex == 0) then
		ply:SetNWInt('plyStorage1', wepindex)
		ply:EmitSound("ItemBattery.Touch")
		ply:ChatPrint("You deposited the weapon.")
		ply:StripWeapon( ConfigInfo["MarketFog"].Weapon[wepindex].Name )
		return 
	end
	storageindex = ply:GetNWInt('plyStorage2');
	if (storageindex == 0) then
		ply:SetNWInt('plyStorage2', wepindex)
		ply:EmitSound("ItemBattery.Touch")
		ply:ChatPrint("You deposited the weapon.")
		ply:StripWeapon( ConfigInfo["MarketFog"].Weapon[wepindex].Name )		
		return 
	end	
	storageindex = ply:GetNWInt('plyStorage3');
	if (storageindex == 0) then
		ply:SetNWInt('plyStorage3', wepindex)
		ply:EmitSound("ItemBattery.Touch")
		ply:StripWeapon( ConfigInfo["MarketFog"].Weapon[wepindex].Name )
		return 
	end	
	storageindex = ply:GetNWInt('plyStorage4');
	if (storageindex == 0) then
		ply:SetNWInt('plyStorage4', wepindex)
		ply:EmitSound("ItemBattery.Touch")
		ply:ChatPrint("You deposited the weapon.")	
		ply:StripWeapon( ConfigInfo["MarketFog"].Weapon[wepindex].Name )		
		return 
	end	
	storageindex = ply:GetNWInt('plyStorage5');
	if (storageindex == 0) then
		ply:SetNWInt('plyStorage5', wepindex)
		ply:EmitSound("ItemBattery.Touch")
		ply:ChatPrint("You deposited the weapon.")	
		ply:StripWeapon( ConfigInfo["MarketFog"].Weapon[wepindex].Name )		
		return 
	end	
	storageindex = ply:GetNWInt('plyStorage6');
	if (storageindex == 0) then
		ply:SetNWInt('plyStorage6', wepindex)
		ply:EmitSound("ItemBattery.Touch")
		ply:ChatPrint("You deposited the weapon.")	
		ply:StripWeapon( ConfigInfo["MarketFog"].Weapon[wepindex].Name )		
		return 
	end	
	storageindex = ply:GetNWInt('plyStorage7');
	if (storageindex == 0) then
		ply:SetNWInt('plyStorage7', wepindex)
		ply:EmitSound("ItemBattery.Touch")
		ply:ChatPrint("You deposited the weapon.")
		ply:StripWeapon( ConfigInfo["MarketFog"].Weapon[wepindex].Name )		
		return 
	end
	storageindex = ply:GetNWInt('plyStorage8');
	if (storageindex == 0) then
		ply:SetNWInt('plyStorage8', wepindex)
		ply:EmitSound("ItemBattery.Touch")
		ply:ChatPrint("You deposited the weapon.")	
		ply:StripWeapon( ConfigInfo["MarketFog"].Weapon[wepindex].Name )		
		return 
	end

	ply:ChatPrint("You have run out of storage space.")
	ply:EmitSound("Grenade.Blip")
	
end )

concommand.Add( "mf_character_reset", function( ply, cmd, args )

	if (not ply:IsValid()) then return end
	ResetPlayerData(ply)

end )

-- Admin commands

function MF_AdminCommandGiveMetal(ply, cmd, args )

	if (not ply:IsValid()) then return end
	
	if (args[1] ~= nil) then
	
		local val = tonumber(args[1])
		local amount = ply:GetNWInt("plyMetal")
		amount = amount + val
		ply:SetNWInt("plyMetal", amount)
	end

end
concommand.Add( "mf_give_metal",  MF_AdminCommandGiveMetal, nil, "Gives the specified amount of metal", FCVAR_CHEAT)

function MF_AdminCommandGiveCircuits(ply, cmd, args )

	if (not ply:IsValid()) then return end
	
	if (args[1] ~= nil) then
	
		local val = tonumber(args[1])
		local amount = ply:GetNWInt("plyCircuits")
		amount = amount + val
		ply:SetNWInt("plyCircuits", amount)
	end

end
concommand.Add( "mf_give_circuits",  MF_AdminCommandGiveCircuits, nil, "Gives the specified amount of circuits", FCVAR_CHEAT)

function MF_AdminCommandGiveFuel(ply, cmd, args )

	if (not ply:IsValid()) then return end
	
	if (args[1] ~= nil) then
	
		local val = tonumber(args[1])
		local amount = ply:GetNWInt("plyFuel")
		amount = amount + val
		ply:SetNWInt("plyFuel", amount)
	end

end
concommand.Add( "mf_give_fuel",  MF_AdminCommandGiveFuel, nil, "Gives the specified amount of fuel", FCVAR_CHEAT)

function MF_AdminCommandGiveMoney(ply, cmd, args )

	if (not ply:IsValid()) then return end
	
	if (args[1] ~= nil) then
	
		local val = tonumber(args[1])
		local amount = ply:GetNWInt("plyMoney")
		amount = amount + val
		ply:SetNWInt("plyMoney", amount)
	end

end
concommand.Add( "mf_give_money",  MF_AdminCommandGiveMoney, nil, "Gives the specified amount of money", FCVAR_CHEAT)

function MF_TurnOffWeather(ply, cmd, args)

	if (not ply:IsValid()) then return end

	ply:SetNWBool("plyEnableWeather", false)
end
concommand.Add( "mf_enable_weather", MF_TurnOffWeather, nil, "Turns off weather effects.") 

concommand.Add( "shop_sell_suit", function( ply, cmd, args )

	if (not ply:IsValid()) then return end
	
	local suitconfigindex = tonumber(args[1])
	local sellprice = (tonumber(args[2]) / 4)
	local cursuittype = ply:GetNWInt('plySuit')
	
	if (suitconfigindex == cursuittype) then
		ply:ChatPrint("You are can't sell the suit you are wearing!")
		ply:EmitSound("AlyxEMP.Discharge")
		return
	end
	
	local suitStorageIndex = 0
	for i=1,3 do
		local j = ply:GetNWInt('plySuitStorage'..i)
		if (j == suitconfigindex) then
			suitStorageIndex = i
		end
	end
	
	if (suitStorageIndex == 0) then
		ply:ChatPrint("You don't own this suit.")
		ply:EmitSound("AlyxEMP.Discharge")
		return
	end
	
	local money = ply:GetNWInt('plyMoney')
	money = money + sellprice
	ply:SetNWInt('plyMoney', money)
	ply:ChatPrint("You sold the suit.")
	ply:SetNWInt('plySuitStorage'..suitStorageIndex, 0) -- place my current suit in storage
	ply:EmitSound("ItemBattery.Touch")

end)

concommand.Add( "shop_equip_suit", function( ply, cmd, args )

	if (not ply:IsValid()) then return end

	local suitconfigindex = tonumber(args[1])
	local cursuittype = ply:GetNWInt('plySuit')

	if (suitconfigindex == cursuittype) then
		ply:ChatPrint("You are wearing this suit already!")
		ply:EmitSound("AlyxEMP.Discharge")
		return
	end
	
	local suitStorageIndex = 0
	for i=1,3 do
		local j = ply:GetNWInt('plySuitStorage'..i)
		if (j == suitconfigindex) then
			suitStorageIndex = i
		end
	end
	
	if (suitStorageIndex == 0) then
		return
	end
	
	ply:ChatPrint("You equipped the suit.")
	ply:SetNWInt('plySuitStorage'..suitStorageIndex, cursuittype) -- place my current suit in storage
	ply:SetNWInt('plySuit', suitconfigindex)
	ply:EmitSound("ItemBattery.Touch")
	SetSuit(ply)
	
end )

concommand.Add( "shop_buy_suit", function( ply, cmd, args )

	if (not ply:IsValid()) then return end

	local money = ply:GetNWInt('plyMoney')
	local price = tonumber(args[1])
	local suitconfigindex = tonumber(args[2])
	local suittype
	local cursuittype = ply:GetNWInt('plySuit')
	
	if (suitconfigindex == cursuittype) then
		ply:ChatPrint("You are wearing this suit!")
		ply:EmitSound("AlyxEMP.Discharge")
		return
	end
	
	if (money < price) then
		ply:ChatPrint("You cannot afford this suit!")
		ply:EmitSound("AlyxEMP.Discharge")
		return
	end
	
	local hasEmptyStorageSpot = false
	local emptyIndex = 0
	for i=1,3 do
		local index = ply:GetNWInt('plySuitStorage'..i)
		if (suitconfigindex == index) then
			ply:ChatPrint("You already own a suit like this!")
			ply:EmitSound("AlyxEMP.Discharge")
			return
		end
		
		if (index == 0) then
			hasEmptyStorageSpot = true
			emptyIndex = i
		end
	end
	
	if (!hasEmptyStorageSpot) then
		ply:ChatPrint("You can only own 4 suits at a time. You need to sell one!")
		ply:EmitSound("AlyxEMP.Discharge")
		return
	end

	money = money - price
	ply:SetNWInt('plyMoney', money)
	ply:ChatPrint("You purchased the suit.")
	ply:SetNWInt('plySuitStorage'..emptyIndex, cursuittype) -- place my current suit in storage
	ply:SetNWInt('plySuit', suitconfigindex)

	ply:EmitSound("ItemBattery.Touch")
	SetSuit(ply)

end )



concommand.Add( "mf_enable_overlay", function( ply, cmd, args )

	if (not ply:IsValid()) then return end
	
	local bool = not ply:GetNWBool("plyUseDefaultGasmarkPP")
	ply:SetNWBool("plyUseDefaultGasmarkPP", bool)
	
end )


function MF_StartHunt(ply, cmd, args)

	if (not ply:IsValid()) then return end
	StartHunt()
	
end
concommand.Add( "mf_start_hunt", MF_StartHunt, nil, "Starts the next hunt.") 

local DropItemTable ={}
DropItemTable["Pistol"] = {classname = "item_hpistolammo", GetAmount = function(ply) return ply:GetAmmoCount( "Pistol" ) end, SetAmount = function(ply, amount) ply:SetAmmo(amount, "Pistol") end, Display = "Pistol Ammo" }
DropItemTable["SMG"] = {classname = "item_hsmgammo", GetAmount = function(ply) return ply:GetAmmoCount( "SMG1" ) end, SetAmount = function(ply, amount) ply:SetAmmo(amount, "SMG1") end, Display = "SMG Ammo" }
DropItemTable["Shotgun"] = {classname = "item_hshotgunammo1", GetAmount = function(ply) return ply:GetAmmoCount( "Buckshot" ) end, SetAmount = function(ply, amount) ply:SetAmmo(amount, "Buckshot") end, Display = "Shotgun Ammo" }
DropItemTable["Rifle"] = {classname = "item_hrifleammo", GetAmount = function(ply) return ply:GetAmmoCount( "AR2" ) end, SetAmount = function(ply, amount) ply:SetAmmo(amount, "AR2") end, Display = "Rifle Ammo" }
DropItemTable["Metal"] = {classname = "item_metal", GetAmount = function(ply) return ply:GetNWInt("plyMetal") end, SetAmount = function(ply, amount) ply:SetNWInt("plyMetal", amount) end, Display = "Metal" }
DropItemTable["Circuits"] = {classname = "item_circuits", GetAmount = function(ply)  return ply:GetNWInt("plyCircuits") end, SetAmount = function(ply, amount) ply:SetNWInt("plyCircuits", amount) end, Display = "Circuits" }
DropItemTable["Fuel"] = {classname = "item_fuel", GetAmount = function(ply) return ply:GetNWInt("plyFuel") end, SetAmount = function(ply, amount) ply:SetNWInt("plyFuel", amount) end, Display = "Fuel" }
DropItemTable["Cash"] = {classname = "item_money", GetAmount = function(ply) return ply:GetNWInt("plyMoney") end, SetAmount = function(ply, amount) ply:SetNWInt("plyMoney", amount) end, Display = "Cash"}
DropItemTable["O2"] = {classname = "item_o2canister", GetAmount = function(ply) return ply:GetNWInt("plyO2Canisters") end, SetAmount = function(ply, amount) ply:SetNWInt("plyO2Canisters", amount) end, Display = "O2"}


function MF_DropItem(ply, cmd, args)

	if (not ply:IsValid()) then return end
	if (args[1] == nil or args[2] == nil) then return end
	
	local itemname = args[1]
	local dropamount = tonumber(args[2])

	if (dropamount <= 0) then return end
	
	local tr = util.TraceLine( {
		start = ply:EyePos(),
		endpos = ply:EyePos() + ply:EyeAngles():Forward() * 90,
		filter = function( ent ) if ( ent:GetClass() == "prop_physics" ) then return true end end
	} )
	
	local itemamount = DropItemTable[itemname].GetAmount(ply)
	
	if (itemamount == 0) then return end
	if (dropamount > itemamount) then dropamount = itemamount end
	
	local item = ents.Create(DropItemTable[itemname].classname)
	item:SetPos(tr.HitPos)
	item:Spawn()
	item:SetValue(dropamount)

	ply:ChatPrint("You dropped "..DropItemTable[itemname].Display.." (x"..dropamount..")")
	ply:EmitSound("ItemBattery.Touch")
	DropItemTable[itemname].SetAmount(ply, itemamount - dropamount)
	
end
concommand.Add("mf_drop_item", MF_DropItem, nil, "Drops the amount of an item. <item> <amount>")


function MF_CraftItem(ply, cmd, args)
	
	if (not ply:IsValid()) then return end
	if (args[1] == nil or args[2] == nil or args[3] == nil or args[4] == nil or args[5] == nil or args[6] == nil) then return end

	local display = args[1]
	local className = args[2]
	local itemType = args[3]
	local metalcost = args[4]
	local circuitcost = args[5]
	local fuelcost = args[6]
	
	if (itemType == "Weapon") then
		ply:ConCommand( "inventory_craft_weapon "..metalcost.." "..circuitcost.." "..fuelcost.." "..className.." "..display) 
	else
		ply:ConCommand( "inventory_craft_base "..metalcost.." "..circuitcost.." "..fuelcost.." "..className.." "..display) 
	end
	

end
concommand.Add("mf_craft_item", MF_CraftItem, nil, "Craft an item. <item>")
--.