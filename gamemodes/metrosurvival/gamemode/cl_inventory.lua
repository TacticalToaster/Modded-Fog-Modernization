----------------------------------
--	Market Fog	
--	Programmer : LIFO/Tednesday		
--	Date : 15/10/2018		
----------------------------------

frameX = ScrW() / 5
frameY = ScrH() / 5
frameW = ScrW() - (2 * frameX)
frameH = ScrH() - (2 * frameY)

imageW = ScrW() / 10
imageH = ScrH() / 10

function WeaponClassNameToIndex(classname)
		
	local index = 1
	for i=1, table.Count(ConfigInfo["MarketFog"].Weapon) do
		if (ConfigInfo["MarketFog"].Weapon[i].Name == classname) then
			return index
		end
		index = index + 1
	end

	return 0	
end

function WeaponClassNameToModelName(classname)
		
	for i=1, table.Count(ConfigInfo["MarketFog"].Weapon) do
		if (ConfigInfo["MarketFog"].Weapon[i].Name == classname and not ConfigInfo["MarketFog"].Weapon[i].IsAlien) then
			return ConfigInfo["MarketFog"].Weapon[i].DisplayModelName
		end
	end

	return "models/weapons/w_knife_ct.mdl"	
end

function WeaponClassNameToPrice(classname)
		
	for i=1, table.Count(ConfigInfo["MarketFog"].Weapon) do
		if (ConfigInfo["MarketFog"].Weapon[i].Name == classname and ConfigInfo["MarketFog"].Weapon[i].Price ~= nil) then
			return ConfigInfo["MarketFog"].Weapon[i].Price
		end
	end

	return 500
end

function WeaponClassNameToDisplayName(classname)

	for i=1, table.Count(ConfigInfo["MarketFog"].Weapon) do
	
		if (ConfigInfo["MarketFog"].Weapon[i].Name == classname) then
			return ConfigInfo["MarketFog"].Weapon[i].DisplayName
		end
	end

	return "No Display Name for "..classname	
	
end

function WeaponClassNameToWeaponType(classname)

	for i=1, table.Count(ConfigInfo["MarketFog"].Weapon) do
	
		if (ConfigInfo["MarketFog"].Weapon[i].Name == classname) then
			return ConfigInfo["MarketFog"].Weapon[i].WeaponType
		end
	end

	return "No Weapon Type "	
	
end

function GetSuitName()

	local typesuit = LocalPlayer():GetNWInt('plySuit')	
	
	return ConfigInfo["MarketFog"].Apparel[typesuit].Name
	
end

gridX = 0
gridY = 0
gridW = 0
gridH = 0

ammodividerx = 0
ammodividerendx = 0
ammodividery = 0
ammodividerendy = 0

miscdividerx = 0 
miscdividerendx = 0
miscdividery = 0
miscdividerendy = 0

InventoryInitFlag = false

AmmoCraftEntries = {}
AmmoCraftEntry = {
name = "Pistol Ammo (x10)",
modelname = "models/Items/boxsrounds.mdl",
desc = "Metal to Pistol Rounds", 
desc2 = "Requires Metal (x50)",
metalprice = 50,
pistolprice = 0,
smgprice = 0,
shotgunprice = 0,
rifleprice = 0,
quantity = 10,
consolecommand = "inventory_craft_ammo" ,
ammotype = "Pistol",
display = "Pistol Ammo"
}
table.insert(AmmoCraftEntries, AmmoCraftEntry)
AmmoCraftEntry = {
name = "SMG Ammo (x45)",
modelname = "models/Items/boxmrounds.mdl",
desc = "Pistol to SMG Rounds", 
desc2 = "Requires Pistol Ammo (x90)",
metalprice = 0,
pistolprice = 90,
smgprice = 0,
shotgunprice = 0,
rifleprice = 0,
quantity = 45,
consolecommand = "inventory_craft_ammo" ,
ammotype = "SMG1",
display = "SMG Ammo"
}
table.insert(AmmoCraftEntries, AmmoCraftEntry)
AmmoCraftEntry = {
name = "Shotgun Ammo (x6)",
modelname = "models/Items/boxbuckshot.mdl",
desc = "SMG to Shotgun Rounds", 
desc2 = "Requires SMG Ammo (x90)",
metalprice = 0,
pistolprice = 0,
smgprice = 90,
shotgunprice = 0,
rifleprice = 0,
quantity = 6,
consolecommand = "inventory_craft_ammo" ,
ammotype = "Buckshot",
display = "Shotgun Ammo"
}
table.insert(AmmoCraftEntries, AmmoCraftEntry)
AmmoCraftEntry = {
name = "Rifle Ammo (x15)",
modelname = "models/Items/combine_rifle_cartridge01.mdl",
desc = "Shotgun to Rifle Ammo", 
desc2 = "Requires Shotgun Ammo (x12)",
metalprice = 0,
pistolprice = 0,
smgprice = 0,
shotgunprice = 12,
rifleprice = 0,
quantity = 15,
consolecommand = "inventory_craft_ammo" ,
ammotype = "AR2",
display = "Rifle Ammo"
}
table.insert(AmmoCraftEntries, AmmoCraftEntry)

BaseEntries = {}
BaseEntry = {
name = "Power Generator",
modelname = "models/props_c17/trappropeller_engine.mdl",
desc = "Generates power.", 
desc2 = "Metal(x100) Circuits(x15) Fuel(x5)",
metalprice = 100,
circuitsprice = 15,
fuelprice = 5,
consolecommand = "inventory_craft_base" ,
classname = "power_generator",
display = "Power Generator"
}
table.insert(BaseEntries, BaseEntry)
BaseEntry = {
name = "Metal Generator",
modelname = "models/props_wasteland/laundry_washer003.mdl",
desc = "Produced metal when powered.", 
desc2 = "Metal(x120) Circuits(x10) Fuel(x1)",
metalprice = 120,
circuitsprice = 10,
fuelprice = 1,
consolecommand = "inventory_craft_base" ,
classname = "metal_generator",
display = "Metal Generator"
}
table.insert(BaseEntries, BaseEntry)
BaseEntry = {
name = "Circuits Generator",
modelname = "models/props_lab/reciever_cart.mdl",
desc = "Produces circuits when powered.", 
desc2 = "Metal(x50) Circuits(x30) Fuel(x1)",
metalprice = 50,
circuitsprice = 30,
fuelprice = 1,
consolecommand = "inventory_craft_base" ,
classname = "circuit_generator",
display = "Circuits Generator"
}
table.insert(BaseEntries, BaseEntry)
BaseEntry = {
name = "Fuel Generator",
modelname = "models/props_wasteland/gaspump001a.mdl",
desc = "Produces fuel when powered.", 
desc2 = "Metal(x50) Circuits(x15) Fuel(x10)",
metalprice = 50,
circuitsprice = 15,
fuelprice = 10,
consolecommand = "inventory_craft_base" ,
classname = "fuel_generator",
display = "Fuel Generator"
}
table.insert(BaseEntries, BaseEntry)
BaseEntry = {
name = "Oxygen Generator",
modelname = "models/props_combine/combinethumper002.mdl",
desc = "Refills oxygen when powered.", 
desc2 = "Metal(x100) Circuits(x15) Fuel(x5)",
metalprice = 100,
circuitsprice = 15,
fuelprice = 5,
consolecommand = "inventory_craft_base" ,
classname = "oxygen_generator",
display = "Oxygen Generator"
}
table.insert(BaseEntries, BaseEntry)

InventoryCloseFlag = false
InventoryIsOpen = false
InventoryType = "Weapons"
InventoryMenuClose = false

function DrawWeaponWheel( )

	local numitems = 0;
		
	-- Num of weapons plus money and resources.
	-- fuel, circuits, metal, money
	local numitems = table.Count(LocalPlayer():GetWeapons()) + numitems
	local radius = ScrH() / 5
	
	function WeaponWheelFrame:Paint(w, h) 
	
		surface.SetDrawColor( Color( 90, 90, 90, 60 ) )	
		surface.DrawRect( 0, 0, w, h ) 
	
		local deltaAngle = (math.pi * 2) / numitems
		local curAngle = (math.pi / -2);
		local cx = w / 2
		local cy = h / 2
		surface.SetDrawColor( Color( 0, 225, 102, 230 ) )	
		for i = 1, numitems do
		
			local x = radius * math.cos(curAngle) + cx
			local y = radius * math.sin(curAngle) + cy
			local sx = (0.5 * radius) * math.cos(curAngle) + cx
			local sy = (0.5 * radius) * math.sin(curAngle) + cy
			surface.DrawLine( sx, sy, x, y ) 
			curAngle = curAngle + deltaAngle
		end

	end
	
	local deltaAngle = (math.pi * 2) / numitems
	local curAngle = (math.pi / -2);
	local cx = ScrW() / 2
	local cy = ScrH() / 2
	local iconW = ScrH() / 12
	local iconHW = iconW / 2
	for k, v in pairs( LocalPlayer():GetWeapons() ) do
			
		local display = WeaponClassNameToDisplayName(v:GetClass())
		local model = WeaponClassNameToModelName(v:GetClass())
		local weptype = WeaponClassNameToWeaponType(v:GetClass())

		local x = (((radius + iconHW) * math.cos(curAngle) + cx) - iconHW)
		local y = (((radius + iconHW) * math.sin(curAngle) + cy) - iconHW)
		local GunBoxGridImage = vgui.Create( "SpawnIcon", WeaponWheelFrame)
		GunBoxGridImage:SetModel( model )
		GunBoxGridImage:SetPos( x, y )
		GunBoxGridImage:SetSize( iconW, iconW )
		GunBoxGridImage:SetTooltip( "LMB Equip | RMB Drop" ) -- disable tooltip for this panel
		--GunBoxGridImage:RebuildSpawnIcon() 
		GunBoxGridImage.DoClick = function()
			RunConsoleCommand("select_weapon", v:GetClass())
			WeaponWheelFrame:Close()
		end
		GunBoxGridImage.DoRightClick = function()
			RunConsoleCommand("drop_weapon", v:GetClass())
			WeaponWheelFrame:Close()
		end

		local GunLabel = vgui.Create("DLabel", GunBoxGridImage)
		GunLabel:SetFont("HudHintTextLarge")
		GunLabel:SetColor( Color( 0, 225, 102 ) )
		GunLabel:SetText( display )
		GunLabel:SizeToContents()

		curAngle = curAngle + deltaAngle
	end	
	
end

function DrawAmmoWheel()
		
	local numammo = 0
		
	local ammotable = {}
	ammotable[1] = {}
	ammotable[1].modelname = "models/items/boxsrounds.mdl"
	ammotable[1].command = "Pistol"
	ammotable[1].display = "Pistol Ammo"
	ammotable[1].cost = 100 -- metal
	ammotable[1].amount = 10 -- bullets
	ammotable[2] = {}
	ammotable[2].modelname = "models/items/boxmrounds.mdl"
	ammotable[2].command = "SMG1"
	ammotable[2].display = "SMG Ammo"
	ammotable[2].cost = 10 -- pistol bullets
	ammotable[2].amount = 15 -- bullets
	ammotable[3] = {}
	ammotable[3].modelname = "models/items/boxbuckshot.mdl"
	ammotable[3].command = "Buckshot"
	ammotable[3].display = "Shotgun Shells"
	ammotable[3].cost = 15 -- smg bullets
	ammotable[3].amount = 2 -- bullets
	ammotable[4] = {}
	ammotable[4].modelname = "models/items/combine_rifle_cartridge01.mdl"
	ammotable[4].command = "AR2"
	ammotable[4].display = "Rifle Ammo"
	ammotable[4].cost = 2 -- shotgun bullets
	ammotable[4].amount = 5 -- bullets

	numammo = numammo + 4

	local deltaAngle = (math.pi * 2) / numammo
	local curAngle = (math.pi / -2);
	local cx = ScrW() / 2
	local cy = ScrH() / 2
	local iconW = ScrH() / 12
	local iconHW = iconW / 2
	local radius = ScrH() / 5
	
	function WeaponWheelFrame:Paint(w, h) 
	
		surface.SetDrawColor( Color( 90, 90, 90, 60 ) )	
		surface.DrawRect( 0, 0, w, h ) 
	
		local deltaAngle = (math.pi * 2) / numammo
		local curAngle = (math.pi / -2);
		local cx = w / 2
		local cy = h / 2
		surface.SetDrawColor( Color( 176, 224, 230, 230 ) )	
		for i = 1, numammo do
		
			local x = radius * math.cos(curAngle) + cx
			local y = radius * math.sin(curAngle) + cy
			local sx = (0.5 * radius) * math.cos(curAngle) + cx
			local sy = (0.5 * radius) * math.sin(curAngle) + cy
			surface.DrawLine( sx, sy, x, y ) 
			curAngle = curAngle + deltaAngle
		end
	end
					
	for i = 1, 4 do
	
		local x = (((radius + iconHW) * math.cos(curAngle) + cx) - iconHW)
		local y = (((radius + iconHW) * math.sin(curAngle) + cy) - iconHW)
		local AmmoCraftIcon = vgui.Create( "SpawnIcon", WeaponWheelFrame)
		AmmoCraftIcon:SetModel( ammotable[i].modelname )
		AmmoCraftIcon:SetPos( x, y )
		AmmoCraftIcon:SetSize( iconW, iconW )
		AmmoCraftIcon:SetTooltip( "Craft?" ) -- disable tooltip for this panel	
		AmmoCraftIcon.DoClick = function()
			CraftAmmo(ammotable[i].display, ammotable[i].command, ammotable[i].cost, ammotable[i].amount)
			WeaponWheelFrame:Close()
		end

		local AmmoCraftLabel = vgui.Create("DLabel", AmmoCraftIcon)
		AmmoCraftLabel:SetFont("HudHintTextLarge")
		AmmoCraftLabel:SetColor( Color( 176, 224, 230 ) )
		AmmoCraftLabel:SetText( ammotable[i].display)
		AmmoCraftLabel:SizeToContents()
		
		curAngle = curAngle + deltaAngle			
	end	
		
end

function DrawCraftingWheel()

	local numcraft = 0

	-- All crafting items.
	for i=1, table.Count(ConfigInfo["MarketFog"].Weapon) do
		if (ConfigInfo["MarketFog"].Weapon[i].Craftable) then
			numcraft = numcraft + 1
		end
	end
	
	numcraft = numcraft + table.Count(BaseEntries)
	
	local deltaAngle = (math.pi * 2) / numcraft
	local curAngle = (math.pi / -2);
	local cx = ScrW() / 2
	local cy = ScrH() / 2
	local iconW = ScrH() / 12
	local iconHW = iconW / 2
	local radius = ScrH() / 5
	
	function WeaponWheelFrame:Paint(w, h) 
	
		surface.SetDrawColor( Color( 90, 90, 90, 60 ) )	
		surface.DrawRect( 0, 0, w, h ) 
	
		local deltaAngle = (math.pi * 2) / numcraft
		local curAngle = (math.pi / -2);
		local cx = w / 2
		local cy = h / 2
		surface.SetDrawColor( Color( 225, 223, 0, 230 ) )	
		for i = 1, numcraft do
		
			local x = radius * math.cos(curAngle) + cx
			local y = radius * math.sin(curAngle) + cy
			local sx = (0.5 * radius) * math.cos(curAngle) + cx
			local sy = (0.5 * radius) * math.sin(curAngle) + cy
			surface.DrawLine( sx, sy, x, y ) 
			curAngle = curAngle + deltaAngle
		end
	end
	
	for i=1, table.Count(ConfigInfo["MarketFog"].Weapon) do
		if (ConfigInfo["MarketFog"].Weapon[i].Craftable) then
			local x = (((radius + iconHW) * math.cos(curAngle) + cx) - iconHW)
			local y = (((radius + iconHW) * math.sin(curAngle) + cy) - iconHW)
				
			local display = ConfigInfo["MarketFog"].Weapon[i].DisplayName
			local model = ConfigInfo["MarketFog"].Weapon[i].DisplayModelName
			
			local CraftWeaponIcon = vgui.Create( "SpawnIcon", WeaponWheelFrame)
			CraftWeaponIcon:SetModel( model )
			CraftWeaponIcon:SetPos( x, y )
			CraftWeaponIcon:SetSize( iconW, iconW )
			CraftWeaponIcon:SetTooltip( display ) -- disable tooltip for this panel	
			CraftWeaponIcon.DoClick = function()
				--DropResourceAmmo(ammotable[i].command, ammotable[i].amount)
				--RunConsoleCommand("inventory_craft_weapon", ConfigInfo["MarketFog"].Weapon[i].MetalPrice, ConfigInfo["MarketFog"].Weapon[i].CircuitsPrice, ConfigInfo["MarketFog"].Weapon[i].FuelPrice, ConfigInfo["MarketFog"].Weapon[i].Name, ConfigInfo["MarketFog"].Weapon[i].DisplayName)				
				CraftItem(ConfigInfo["MarketFog"].Weapon[i].DisplayName, ConfigInfo["MarketFog"].Weapon[i].Description, ConfigInfo["MarketFog"].Weapon[i].Name, "Weapon", ConfigInfo["MarketFog"].Weapon[i].MetalPrice, ConfigInfo["MarketFog"].Weapon[i].CircuitsPrice, ConfigInfo["MarketFog"].Weapon[i].FuelPrice)
				WeaponWheelFrame:Close()
			end

			local CraftWeaponLabel = vgui.Create("DLabel", CraftWeaponIcon)
			CraftWeaponLabel:SetFont("HudHintTextLarge")
			CraftWeaponLabel:SetColor( Color( 225, 223, 0 ) )
			CraftWeaponLabel:SetText( display )
			CraftWeaponLabel:SizeToContents()
			
			curAngle = curAngle + deltaAngle
		end
	end
	
	for i=1,table.Count(BaseEntries) do 
	
		local x = (((radius + iconHW) * math.cos(curAngle) + cx) - iconHW)
		local y = (((radius + iconHW) * math.sin(curAngle) + cy) - iconHW)
	
		local CraftBaseIcon = vgui.Create( "SpawnIcon", WeaponWheelFrame)
		CraftBaseIcon:SetModel( BaseEntries[i].modelname )
		CraftBaseIcon:SetPos( x, y )
		CraftBaseIcon:SetSize( iconW, iconW )
		CraftBaseIcon:SetTooltip( BaseEntries[i].name ) -- disable tooltip for this panel	
		CraftBaseIcon.DoClick = function()
			CraftItem(BaseEntries[i].name, BaseEntries[i].desc, BaseEntries[i].classname, "Base", BaseEntries[i].metalprice, BaseEntries[i].circuitsprice, BaseEntries[i].fuelprice)
			WeaponWheelFrame:Close()
		end

		local CraftBaseLabel = vgui.Create("DLabel", CraftBaseIcon)
		CraftBaseLabel:SetFont("HudHintTextLarge")
		CraftBaseLabel:SetColor( Color( 225, 223, 0 ) )
		CraftBaseLabel:SetText( BaseEntries[i].name )
		CraftBaseLabel:SizeToContents()

		curAngle = curAngle + deltaAngle
	end
	
end

function DrawApparelWheel()

	local numitems = 0

	local resourcesTable = {}
	resourcesTable[1] = {}
	resourcesTable[1].modelname = "models/props_junk/gascan001a.mdl"
	resourcesTable[1].command = "Fuel"
	resourcesTable[1].amount = LocalPlayer():GetNWInt("plyFuel")
	resourcesTable[2] = {}
	resourcesTable[2].modelname = "models/props_lab/reciever01c.mdl"
	resourcesTable[2].command = "Circuits"
	resourcesTable[2].amount = LocalPlayer():GetNWInt("plyCircuits")
	resourcesTable[3] = {}
	resourcesTable[3].modelname = "models/props_c17/oildrumchunk01d.mdl"
	resourcesTable[3].command = "Metal"
	resourcesTable[3].amount = LocalPlayer():GetNWInt("plyMetal")
	resourcesTable[4] = {}
	resourcesTable[4].modelname = "models/props_c17/consolebox01a.mdl"
	resourcesTable[4].command = "Cash"
	resourcesTable[4].amount = LocalPlayer():GetNWInt("plyMoney")
		
	for i = 1, 4 do
		if (resourcesTable[i].amount > 0) then
			numitems = numitems + 1
		end
	end
	
	ammotable = {}
	ammotable[1] = {}
	ammotable[1].modelname = "models/items/boxsrounds.mdl"
	ammotable[1].command = "Pistol"
	ammotable[1].amount = LocalPlayer():GetAmmoCount( "Pistol" )
	ammotable[2] = {}
	ammotable[2].modelname = "models/items/boxmrounds.mdl"
	ammotable[2].command = "SMG"
	ammotable[2].amount = LocalPlayer():GetAmmoCount( "SMG1" )
	ammotable[3] = {}
	ammotable[3].modelname = "models/items/boxbuckshot.mdl"
	ammotable[3].command = "Shotgun"
	ammotable[3].amount = LocalPlayer():GetAmmoCount( "Buckshot" )
	ammotable[4] = {}
	ammotable[4].modelname = "models/items/combine_rifle_cartridge01.mdl"
	ammotable[4].command = "Rifle"
	ammotable[4].amount =  LocalPlayer():GetAmmoCount( "AR2" )
	ammotable[5] = {}
	ammotable[5].modelname = "models/items/combine_rifle_ammo01.mdl"
	ammotable[5].command = "O2"
	ammotable[5].amount = LocalPlayer():GetNWInt("plyO2Canisters")
	
	-- pistol ,smg , shotgun, rifle, o2 cans
	for i = 1, 5 do
		if (ammotable[i].amount > 0) then
			numitems = numitems + 1
		end
	end

	local deltaAngle = (math.pi) / numitems
	local curAngle = (math.pi / -2);
	local cx = ScrW() / 2
	local cy = ScrH() / 2
	local iconW = ScrH() / 12
	local iconHW = iconW / 2
	local radius = ScrH() / 5
	
	local suitW = ScrW() / 8
	local suitH = ScrW() / 5
	local suitX = cx - (suitW / 2) - (ScrW() / 8)
	local suitY = cy - (suitH / 2)
	
	local SuitIcon = vgui.Create( "DModelPanel", WeaponWheelFrame )
	SuitIcon:SetPos( suitX, suitY )
	SuitIcon:SetSize( suitW, suitH )
	SuitIcon:SetModel( LocalPlayer():GetModel() )
	SuitIcon:SetFOV( 45 )	
	
	local suitname = ConfigInfo["MarketFog"].Apparel[LocalPlayer():GetNWInt('plySuit')].Name
	
	local SuitLabel = vgui.Create("DLabel", SuitIcon)
	SuitLabel:SetFont("HudHintTextLarge")
	SuitLabel:SetColor( Color( 225, 223, 0 ) )
	SuitLabel:SetText( "Suit: "..suitname )
	SuitLabel:SizeToContents()
	
	function WeaponWheelFrame:Paint(w, h) 
	
		surface.SetDrawColor( Color( 90, 90, 90, 60 ) )	
		surface.DrawRect( 0, 0, w, h ) 
	
		local deltaAngle = (math.pi) / numitems
		local curAngle = (math.pi / -2);
		local cx = w / 2
		local cy = h / 2
		surface.SetDrawColor( Color( 225, 223, 0, 230 ) )	
		for i = 1, numitems do
		
			local x = radius * math.cos(curAngle) + cx
			local y = radius * math.sin(curAngle) + cy
			local sx = (0.5 * radius) * math.cos(curAngle) + cx
			local sy = (0.5 * radius) * math.sin(curAngle) + cy
			surface.DrawLine( sx, sy, x, y ) 
			curAngle = curAngle + deltaAngle
		end
	end

		
	for i = 1, 5 do
	
		if (ammotable[i].amount > 0) then
	
			local x = (((radius + iconHW) * math.cos(curAngle) + cx) - iconHW)
			local y = (((radius + iconHW) * math.sin(curAngle) + cy) - iconHW)
			local AmmoDropIcon = vgui.Create( "SpawnIcon", WeaponWheelFrame)
			AmmoDropIcon:SetModel( ammotable[i].modelname )
			AmmoDropIcon:SetPos( x, y )
			AmmoDropIcon:SetSize( iconW, iconW )
			AmmoDropIcon:SetTooltip( "Drop" ) -- disable tooltip for this panel	
			AmmoDropIcon.DoClick = function()
				DropResourceAmmo(ammotable[i].command, ammotable[i].amount)
				WeaponWheelFrame:Close()
			end

			local AmmoDropLabel = vgui.Create("DLabel", AmmoDropIcon)
			AmmoDropLabel:SetFont("HudHintTextLarge")
			AmmoDropLabel:SetColor( Color( 225, 223, 0 ) )
			AmmoDropLabel:SetText( ammotable[i].command..": "..ammotable[i].amount )
			AmmoDropLabel:SizeToContents()
			
			curAngle = curAngle + deltaAngle
		
		end
	end

	for i = 1, 4 do
	
		if (resourcesTable[i].amount > 0) then
			local x = (((radius + iconHW) * math.cos(curAngle) + cx) - iconHW)
			local y = (((radius + iconHW) * math.sin(curAngle) + cy) - iconHW)
			local ResourceDropIcon = vgui.Create( "SpawnIcon", WeaponWheelFrame)
			ResourceDropIcon:SetModel( resourcesTable[i].modelname )
			ResourceDropIcon:SetPos( x, y )
			ResourceDropIcon:SetSize( iconW, iconW )
			ResourceDropIcon:SetTooltip( "Drop?" ) -- disable tooltip for this panel	
			ResourceDropIcon.DoClick = function()
				DropResourceAmmo(resourcesTable[i].command, resourcesTable[i].amount)
				WeaponWheelFrame:Close()
			end

			local ResourceDropLabel = vgui.Create("DLabel", ResourceDropIcon)
			ResourceDropLabel:SetFont("HudHintTextLarge")
			ResourceDropLabel:SetColor( Color( 225, 223, 0 ) )
			ResourceDropLabel:SetText( resourcesTable[i].command..": "..resourcesTable[i].amount )
			ResourceDropLabel:SizeToContents()
			
			curAngle = curAngle + deltaAngle			
		end
	end	

	
end

function InventoryWheelSelector()

	WeaponWheelFrame = vgui.Create( "DFrame" )
	--DropCircleFrame:Center()
	WeaponWheelFrame:SetSize( ScrW(), ScrH() )
	WeaponWheelFrame:SetVisible( true )
	WeaponWheelFrame:MakePopup()
	WeaponWheelFrame:ShowCloseButton( false )
	WeaponWheelFrame:SetDraggable(false)
	
	-- Weapons, Ammo, Craft, Settings
	local buttonMenuR =  ScrH() / 16
	local nummenus = 4
	local buttondeltaAngle = (math.pi * 2) / (nummenus)
	local buttoncurAngle = (math.pi / -2);
	local buttoncx = ScrW() / 2
	local buttoncy = ScrH() / 2
	local buttoniconW = ScrH() / 16
	local buttoniconHW = buttoniconW / 2
	local menutable = {}
	menutable = {}
	menutable[1] = { name = "Weapons", buttonName = "Weapons"}
	menutable[2] = { name = "Craft Ammo", buttonName = "Craft"}
	menutable[3] = { name = "Equipment", buttonName = "Equipment"}
	menutable[4] = { name = "Craft Item", buttonName = "Craft"}
	
	for i = 1, nummenus do
		
		local x = (buttonMenuR * math.cos(buttoncurAngle) + buttoncx) - buttoniconHW
		local y = (buttonMenuR * math.sin(buttoncurAngle) + buttoncy) - buttoniconHW
	
		local MenuSelectButton = vgui.Create( "DButton", WeaponWheelFrame ) // Create the button and parent it to the frame
		MenuSelectButton:SetText( menutable[i].buttonName )					// Set the text on the button
		MenuSelectButton:SetPos( x, y )					// Set the position on the frame
		MenuSelectButton:SetSize( buttoniconW, buttoniconW )					// Set the size
		MenuSelectButton:SetIsToggle( true )
		
		if (menutable[i] == InventoryType) then
			MenuSelectButton:SetToggle(true)
		else
			MenuSelectButton:SetToggle(false)
		end
		
		MenuSelectButton.DoClick = function()				// A custom function run when clicked ( note the . instead of : )
			InventoryType = menutable[i].name
			WeaponWheelFrame:Close()
			NewNewInventoryMenu()
		end
					

		buttoncurAngle = buttoncurAngle + buttondeltaAngle
	end


	
end

function ShowSettings(settingsX, settingsY)

	---------Enable Overlays--------------
			
	local overlayval = not LocalPlayer():GetNWBool("plyUseDefaultGasmarkPP")

	local OverlaySelect = vgui.Create( "DButton", WeaponWheelFrame ) // Create the button and parent it to the frame
	OverlaySelect:SetText( "Enable Gasmask Overlays" )					// Set the text on the button
	OverlaySelect:SizeToContents()
	OverlaySelect:SetPos( settingsX, settingsY )					// Set the position on the frame
	OverlaySelect:SetIsToggle( true )
	OverlaySelect:SetToggle( overlayval )
	OverlaySelect.DoClick = function()
		RunConsoleCommand("mf_enable_overlay")
		WeaponWheelFrame:Close()
	end
		
	settingsY = settingsY + (ScrH() / 15)
		
	---------Enable Weather Effects --------------
	
	local weatherval = LocalPlayer():GetNWBool("plyEnableWeather")

	local WeatherSelect = vgui.Create( "DButton", WeaponWheelFrame ) // Create the button and parent it to the frame
	WeatherSelect:SetText( "Enable Weather Effects" )					// Set the text on the button
	WeatherSelect:SizeToContents()
	WeatherSelect:SetPos( settingsX, settingsY )					// Set the position on the frame
	WeatherSelect:SetIsToggle( true )
	WeatherSelect:SetToggle( weatherval )
	WeatherSelect.DoClick = function()
		RunConsoleCommand("mf_enable_weather")
		WeaponWheelFrame:Close()
	end
	
	settingsY = settingsY + (ScrH() / 15)
	---------Show O2 Marker--------------
	
	local O2MarkerSelect = vgui.Create( "DButton", WeaponWheelFrame ) // Create the button and parent it to the frame
	O2MarkerSelect:SetText( "Show Oxygen Marker" )					// Set the text on the button
	O2MarkerSelect:SizeToContents()
	O2MarkerSelect:SetPos( settingsX, settingsY )					// Set the position on the frame
	O2MarkerSelect:SetIsToggle( true )
	O2MarkerSelect:SetToggle( CompassBlipShow.O2 )
	O2MarkerSelect.DoClick = function()
		CompassBlipShow.O2 = not CompassBlipShow.O2
		WeaponWheelFrame:Close()
	end
	
	settingsY = settingsY + (ScrH() / 15)
			
	---------Show Shop Marker--------------
			
	local ShopMarkerSelect = vgui.Create( "DButton", WeaponWheelFrame ) // Create the button and parent it to the frame
	ShopMarkerSelect:SetText( "Show Shop Marker" )					// Set the text on the button
	ShopMarkerSelect:SizeToContents()
	ShopMarkerSelect:SetPos( settingsX, settingsY )					// Set the position on the frame
	ShopMarkerSelect:SetIsToggle( true )
	ShopMarkerSelect:SetToggle( CompassBlipShow.Shop )
	ShopMarkerSelect.DoClick = function()
		CompassBlipShow.Shop = not CompassBlipShow.Shop
		WeaponWheelFrame:Close()
	end
	
	settingsY = settingsY + (ScrH() / 15)
			
	---------Show Airdrop Marker--------------
	
	local AirDropMarkerSelect = vgui.Create( "DButton", WeaponWheelFrame ) // Create the button and parent it to the frame
	AirDropMarkerSelect:SetText( "Show Airdrop Marker" )					// Set the text on the button
	AirDropMarkerSelect:SizeToContents()
	AirDropMarkerSelect:SetPos( settingsX, settingsY )					// Set the position on the frame
	AirDropMarkerSelect:SetIsToggle( true )
	AirDropMarkerSelect:SetToggle( CompassBlipShow.Airdrop )
	AirDropMarkerSelect.DoClick = function()
		CompassBlipShow.Airdrop = not CompassBlipShow.Airdrop
		WeaponWheelFrame:Close()
	end
	
	settingsY = settingsY + (ScrH() / 15)	
			
	---------Show Quest Marker--------------
	
	local QuestMarkerSelect = vgui.Create( "DButton", WeaponWheelFrame ) // Create the button and parent it to the frame
	QuestMarkerSelect:SetText( "Show Quest Marker" )					// Set the text on the button
	QuestMarkerSelect:SizeToContents()
	QuestMarkerSelect:SetPos( settingsX, settingsY )					// Set the position on the frame
	QuestMarkerSelect:SetIsToggle( true )
	QuestMarkerSelect:SetToggle( CompassBlipShow.Quest )
	QuestMarkerSelect.DoClick = function()
		CompassBlipShow.Quest = not CompassBlipShow.Quest
		WeaponWheelFrame:Close()
	end
	
	settingsY = settingsY + (ScrH() / 15)	
			
	---------Reset Character--------------
	
	local ResetCharacterButton = vgui.Create( "DButton", WeaponWheelFrame ) // Create the button and parent it to the frame
	ResetCharacterButton:SetText( "Reset Character? (Warning: Clears Progress)" )					// Set the text on the button
	ResetCharacterButton:SizeToContents()
	ResetCharacterButton:SetPos( settingsX, settingsY )					// Set the position on the frame
	ResetCharacterButton.DoClick = function()
			RunConsoleCommand("mf_character_reset")
	end

end

function NewNewInventoryMenu()

	InventoryWheelSelector()

	if (InventoryType == "Weapons") then
		DrawWeaponWheel()
	elseif (InventoryType == "Craft Ammo") then
		DrawAmmoWheel()
	elseif (InventoryType == "Equipment") then
		DrawApparelWheel()
	elseif (InventoryType == "Craft Item") then
		DrawCraftingWheel()
	end
	
	local settingsX = ScrW() / 20
	local settingsY = ScrH() / 15
	
	local SettingsButton = vgui.Create( "DButton", WeaponWheelFrame ) // Create the button and parent it to the frame
	SettingsButton:SetText( "Settings" )					// Set the text on the button
	SettingsButton:SizeToContents()
	SettingsButton:SetPos( settingsX, settingsY )					// Set the position on the frame
	SettingsButton:SetIsToggle( true )
	SettingsButton:SetToggle( false )
	SettingsButton.DoClick = function()

		if (!SettingsButton:GetToggle()) then
			settingsY = settingsY + (ScrH() / 15)
			ShowSettings(settingsX, settingsY)
			SettingsButton:SetToggle( true )
		end
	end

end

function CraftAmmo(displayName, ammoType, cost, amount)
	
	local metalprice = 0
	local pistolprice = 0
	local smgprice = 0
	local shotgunprice = 0

	if (ammoType == "Pistol") then
		metalprice = cost
	elseif (ammoType == "SMG1") then
		pistolprice = cost
	elseif (ammoType == "Buckshot") then
		smgprice = cost
	elseif (ammoType == "AR2") then
		shotgunprice = cost
	end
	
	local FrameDimensions ={
		x = ScrW() / 2.5,
		y = ScrH() / 2.5,
		w = ScrW() / 3,
		h = ScrH() / 7
	}

	local CraftFrame = vgui.Create( "DFrame" )
	CraftFrame:SetPos( FrameDimensions.x, FrameDimensions.y )
	CraftFrame:SetSize( FrameDimensions.w, FrameDimensions.h )
	CraftFrame:SetTitle( "Craft "..displayName.."?" )
	CraftFrame:SetVisible( true )
	CraftFrame:SetDraggable( true)
	CraftFrame:ShowCloseButton( true )
	CraftFrame:MakePopup()

	local CraftLabelDimensions = {
		x = FrameDimensions.w * 0.1,
		y = FrameDimensions.h * 0.5,
		w = FrameDimensions.w  * 0.3,
		h = FrameDimensions.h * 0.2		
	}
		
	local plyMetal = LocalPlayer():GetNWInt("plyMetal")
	local plyPistol = LocalPlayer():GetAmmoCount( "Pistol" )
	local plySMG = LocalPlayer():GetAmmoCount( "SMG1" )
	local plyShotgun = LocalPlayer():GetAmmoCount( "Buckshot" )
	local canCraft = (plyMetal >= metalprice and plyPistol >= pistolprice and plySMG >= smgprice and plyShotgun >= shotgunprice) 
	
	local CraftLabel = vgui.Create("DLabel", CraftFrame)
	CraftLabel:SetFont("HudHintTextLarge")
	CraftLabel:SetPos(CraftLabelDimensions.x, CraftLabelDimensions.y)
	if (canCraft) then
		CraftLabel:SetColor( Color( 0, 225, 102 ) )
	else
		CraftLabel:SetColor( Color( 255, 0, 0 ) )
	end

	CraftLabel:SetText( "Cost = "..plyMetal.."/"..metalprice.." Metal, "..plyPistol.."/"..pistolprice.." Pistol Ammo, "..plySMG.."/"..smgprice.." SMG Ammo, "..plyShotgun.."/"..shotgunprice.." Shotgun Shells" )
	CraftLabel:SizeToContents()

	local ButtonDimensions = {
		x = CraftLabelDimensions.x + CraftLabelDimensions.w,
		y = CraftLabelDimensions.y + CraftLabelDimensions.h,
		w = FrameDimensions.w  * 0.2,
		h = FrameDimensions.h * 0.2
		
	}
	
	if (canCraft) then
		DButton = vgui.Create( "DButton", CraftFrame)
		DButton:SetPos(ButtonDimensions.x, ButtonDimensions.y)
		DButton:SetSize(ButtonDimensions.w, ButtonDimensions.h)
		DButton:SetText( "Craft" )
		DButton.DoClick = function()
			RunConsoleCommand("inventory_craft_ammo", metalprice, pistolprice, smgprice, shotgunprice, 0, amount, ammoType, displayName )
			CraftFrame:Close()
		end
	end
	
	CraftFrame:SizeToContents()

end

function CraftItem(displayName, desc, classname, itemtype, metalcost, circuitcost, fuelcost)

	local FrameDimensions ={
		x = ScrW() / 2.5,
		y = ScrH() / 2.5,
		w = ScrW() / 3,
		h = ScrH() / 7
	}

	local CraftFrame = vgui.Create( "DFrame" )
	CraftFrame:SetPos( FrameDimensions.x, FrameDimensions.y )
	CraftFrame:SetSize( FrameDimensions.w, FrameDimensions.h )
	CraftFrame:SetTitle( "Craft "..displayName.."?" )
	CraftFrame:SetVisible( true )
	CraftFrame:SetDraggable( true)
	CraftFrame:ShowCloseButton( true )
	CraftFrame:MakePopup()

	local CraftLabelDimensions = {
		x = FrameDimensions.w * 0.1,
		y = FrameDimensions.h * 0.5,
		w = FrameDimensions.w  * 0.3,
		h = FrameDimensions.h * 0.2		
	}
		
	local plyFuel = LocalPlayer():GetNWInt("plyFuel")
	local plyCircuits = LocalPlayer():GetNWInt("plyCircuits")
	local plyMetal = LocalPlayer():GetNWInt("plyMetal")
	local canCraft = (plyFuel >= fuelcost and plyCircuits >= circuitcost and plyMetal >= metalcost) 
	
	local DescLabel = vgui.Create("DLabel", CraftFrame)
	DescLabel:SetFont("HudHintTextLarge")
	DescLabel:SetPos(CraftLabelDimensions.x, FrameDimensions.h * 0.3)
	DescLabel:SetColor( Color( 0, 225, 102 ) )
	DescLabel:SetText( displayName..": "..desc )
	DescLabel:SizeToContents()
	
	local CraftLabel = vgui.Create("DLabel", CraftFrame)
	CraftLabel:SetFont("HudHintTextLarge")
	CraftLabel:SetPos(CraftLabelDimensions.x, CraftLabelDimensions.y)
	if (canCraft) then
		CraftLabel:SetColor( Color( 0, 225, 102 ) )
	else
		CraftLabel:SetColor( Color( 255, 0, 0 ) )
	end

	CraftLabel:SetText( "Cost = "..plyMetal.."/"..metalcost.." Metal, "..plyCircuits.."/"..circuitcost.." Circuits, "..plyFuel.."/"..fuelcost.." Fuel" )
	CraftLabel:SizeToContents()

	local ButtonDimensions = {
		x = CraftLabelDimensions.x + CraftLabelDimensions.w,
		y = CraftLabelDimensions.y + CraftLabelDimensions.h,
		w = FrameDimensions.w  * 0.2,
		h = FrameDimensions.h * 0.2
		
	}
	
	if (canCraft) then
		DButton = vgui.Create( "DButton", CraftFrame)
		DButton:SetPos(ButtonDimensions.x, ButtonDimensions.y)
		DButton:SetSize(ButtonDimensions.w, ButtonDimensions.h)
		DButton:SetText( "Craft" )
		DButton.DoClick = function()
			RunConsoleCommand("mf_craft_item", displayName, classname, itemtype, metalcost, circuitcost, fuelcost )
			CraftFrame:Close()
		end
	end
	
	CraftFrame:SizeToContents()

end

function DropResourceAmmo(droptype, maxval)

	local ItemToDisplay = {}
	ItemToDisplay["Pistol"] = "Pistol Ammo"
	ItemToDisplay["SMG"] = "SMG Ammo"
	ItemToDisplay["Shotgun"] = "Shotgun Ammo"
	ItemToDisplay["Rifle"] = "Rifle Ammo"
	ItemToDisplay["Metal"] = "Metal"
	ItemToDisplay["Circuits"] = "Circuits"
	ItemToDisplay["Fuel"] = "Fuel"
	ItemToDisplay["Cash"] = "Cash"
	ItemToDisplay["O2"] = "O2"

	local FrameDimensions ={
		x = ScrW() / 3,
		y = ScrH() / 2,
		w = ScrW() / 5,
		h = ScrH() / 10
	}

	local DropResourceFrame = vgui.Create( "DFrame" )
	DropResourceFrame:SetPos( FrameDimensions.x, FrameDimensions.y )
	DropResourceFrame:SetSize( FrameDimensions.w, FrameDimensions.h )
	DropResourceFrame:SetTitle( "Drop "..ItemToDisplay[droptype].."?" )
	DropResourceFrame:SetVisible( true )
	DropResourceFrame:SetDraggable( true)
	DropResourceFrame:ShowCloseButton( true )
	DropResourceFrame:MakePopup()

	local NumberWangDimensions = {
		x = FrameDimensions.w * 0.1,
		y = FrameDimensions.h * 0.5,
		w = FrameDimensions.w  * 0.3,
		h = FrameDimensions.h * 0.2
		
	}
	
	local DNumberWangItem = vgui.Create( "DNumberWang" , DropResourceFrame)
	DNumberWangItem:SetPos(NumberWangDimensions.x, NumberWangDimensions.y)
	DNumberWangItem:SetSize(NumberWangDimensions.w, NumberWangDimensions.h)
	DNumberWangItem:SetMin( 1)
	DNumberWangItem:SetMax( maxval )
	DNumberWangItem:SetValue( 1 )

	local ButtonDimensions = {
		x = NumberWangDimensions.x + NumberWangDimensions.w,
		y = NumberWangDimensions.y,
		w = FrameDimensions.w  * 0.2,
		h = FrameDimensions.h * 0.2
		
	}
	
	DButton = vgui.Create( "DButton", DropResourceFrame)
	DButton:SetPos(ButtonDimensions.x, ButtonDimensions.y)
	DButton:SetSize(ButtonDimensions.w, ButtonDimensions.h)
	DButton:SetText( "Drop" )
	DButton.DoClick = function()
		RunConsoleCommand("mf_drop_item", droptype, DNumberWangItem:GetValue())
	end

	local DropAllButtonDimensions = {
		x = ButtonDimensions.x + ButtonDimensions.w,
		y = ButtonDimensions.y,
		w = ButtonDimensions.w,
		h = ButtonDimensions.h	
	}
	
	DButton = vgui.Create( "DButton", DropResourceFrame)
	DButton:SetPos(DropAllButtonDimensions.x, DropAllButtonDimensions.y)
	DButton:SetSize(DropAllButtonDimensions.w, DropAllButtonDimensions.h)
	DButton:SetText( "Drop All" )
	DButton.DoClick = function()
		RunConsoleCommand("mf_drop_item", droptype, maxval)
		DropResourceFrame:Close()
	end

end

--usermessage.Hook( "OpenNetMenu", NetMenu)
--.
