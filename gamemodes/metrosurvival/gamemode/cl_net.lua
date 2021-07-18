----------------------------------
--	Market Fog	
--	Programmer : LIFO/Tednesday		
--	Date : 15/10/2018		
----------------------------------

AlienWeaponFlag = false

InitShopHints = {
	Intro = true,
}

function ShopIntroTutorial()

	-- INITILISE THE TUTORIAL.	
	if (not InitShopHints.Intro) then return end	


	
	--/*
	-- INITILISE THE TUTORIAL.
	--timer.Create( CurTime().."ShopIntro", 2, 1, function()
	--	DisplayHint(HintEnum["ShopIntro"], 6)
		
	--	timer.Create( CurTime().."ShopMarket", 7, 1, function()
	--		DisplayHint(HintEnum["ShopResource"], 6)
			
	--		timer.Create( CurTime().."ShopArmour", 7, 1, function()
	--			DisplayHint(HintEnum["ShopArmour"], 6)
	--		end )
	--	end )
	--end )
	--*/
	
	InitShopHints.Intro = false
end


--- AMMO ENTRIES 

AmmoEntries = {}
AmmoEntry = {
name = "Pistol Bullets (x12)",
modelname = "models/Items/boxsrounds.mdl",
desc = "Makes your gun go bang bang", 
price = 450,
quantity = 12,
consolecommand = "shop_buy_ammo",
ammoname = "Pistol"
}
table.insert(AmmoEntries, AmmoEntry)
AmmoEntry = {
name = "Shotgun Shells (x6)",
modelname = "models/Items/boxbuckshot.mdl",
desc = "Makes it so you can't miss", 
price = 1100,
quantity = 6,
consolecommand = "shop_buy_ammo",
ammoname = "Buckshot"
}
table.insert(AmmoEntries, AmmoEntry)
AmmoEntry = {
name = "SMG ammo (x45)",
modelname = "models/Items/boxmrounds.mdl",
desc = "A smaller caliber used for small arms", 
price = 1250,
quantity = 45,
consolecommand = "shop_buy_ammo",
ammoname = "SMG1"
}
table.insert(AmmoEntries, AmmoEntry)
AmmoEntry = {
name = "Rifle ammo (x30)",
modelname = "models/Items/combine_rifle_cartridge01.mdl",
desc = "A high caliber round for the pulse rifle", 
price = 2100,
quantity = 30,
consolecommand = "shop_buy_ammo",
ammoname = "AR2"
}
table.insert(AmmoEntries, AmmoEntry)
AmmoEntry = {
name = "Impact Grenade",
modelname = "models/weapons/arccw/w_nade_impact.mdl",
desc = "A grenade. Hurl it at enemies.", 
price = 350,
quantity = 1,
consolecommand = "shop_buy_weapon",
classname = "arccw_nade_impact",
display = "Grenade"
}
table.insert(AmmoEntries, AmmoEntry)
AmmoEntry = {
name = "Frag Grenade",
modelname = "models/weapons/arccw/w_nade_frag.mdl",
desc = "A classic explosive present.", 
price = 450,
quantity = 1,
consolecommand = "shop_buy_weapon",
classname = "arccw_nade_frag",
display = "Grenade"
}
table.insert(AmmoEntries, AmmoEntry)
AmmoEntry = {
name = "Grenade Launcher Ammo (x1)",
modelname = "models/weapons/ar2_grenade.mdl",
desc = "Ammo for the grenade launcher", 
price = 2500,
quantity = 1,
consolecommand = "shop_buy_ammo",
ammoname = "SMG1_Grenade"
}
table.insert(AmmoEntries, AmmoEntry)
AmmoEntry = {
name = "Magnum Rounds",
modelname = "models/Items/357ammo.mdl",
desc = "From Gun-Nut, we bring you the Wristbreaker 3000 Deluxe rounds!", 
price = 500,
quantity = 15,
consolecommand = "shop_buy_ammo",
ammoname = "357"
}
table.insert(AmmoEntries, AmmoEntry)
AmmoEntry = {
name = "Large Sniper Rounds",
modelname = "models/Items/boxsniperrounds.mdl",
desc = "For your guns that compensate.", 
price = 1000,
quantity = 10,
consolecommand = "shop_buy_ammo",
ammoname = "SniperPenetratedAmmo"
}
table.insert(AmmoEntries, AmmoEntry)

function OpenNetMenu()

local frameX = ScrW() / 10
local frameY = ScrH() / 10
local frameW = ScrW() - (frameX * 2)
local frameH = ScrH() - (frameY * 2)

-- Now do the table positions that are local to the frame.

local numHeaders = 5

local headerX = frameW / 90;
local headerY = frameH / 30
local headerH = frameH / 50

local colw = frameW / numHeaders 

local itemX = headerX
local itemY = headerY + headerH
local itemH = frameH - 3* itemY

local Frame = vgui.Create( "DFrame" )
Frame:SetPos( frameX, frameY )
Frame:SetSize( frameW, frameH )
Frame:SetTitle( "Shop" )
Frame:SetVisible( true )
Frame:SetDraggable( true)
Frame:ShowCloseButton( true )
Frame:MakePopup()

local sheet = vgui.Create( "DPropertySheet", Frame )
sheet:Dock( FILL )

-- -------ITEM PANEL

local numItems = table.Count(ConfigInfo["MarketFog"].PurchaseItems)

local itemPanel = vgui.Create( "DPanel", sheet )
itemPanel.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 75, 75, 75, self:GetAlpha() ) ) end
sheet:AddSheet( "Items", itemPanel )

local panelW, panelH = itemPanel:GetSize( ) -- Get the size of the panel

	-- -------Headers

	local headerGrid = vgui.Create( "DGrid", itemPanel )
	headerGrid:SetPos( headerX, headerY )
	headerGrid:SetCols( numHeaders )
	headerGrid:SetColWide( colw )
	headerGrid:SetRowHeight( headerH )

	local DLabelItemHeader = vgui.Create( "DLabel" )
	DLabelItemHeader:SetText( "Item:" )
	DLabelItemHeader:SizeToContents()
	DLabelItemHeader:SetWrap( true )
	headerGrid:AddItem(DLabelItemHeader)

	local DLabelImageHeader = vgui.Create( "DLabel" )
	DLabelImageHeader:SetText( "Image:" )
	DLabelImageHeader:SizeToContents()
	DLabelImageHeader:SetWrap( true )
	headerGrid:AddItem(DLabelImageHeader)

	local DLabelDescHeader = vgui.Create( "DLabel" )
	DLabelDescHeader:SetText( "Desc:" )
	DLabelDescHeader:SizeToContents()
	DLabelDescHeader:SetWrap( true )
	headerGrid:AddItem(DLabelDescHeader)

	local DLabelPriceHeader = vgui.Create( "DLabel" )
	DLabelPriceHeader:SetText( "Price(Scrap):" )
	DLabelPriceHeader:SizeToContents()
	DLabelPriceHeader:SetWrap( true )
	headerGrid:AddItem(DLabelPriceHeader)

	local DLabelPurchaseHeader = vgui.Create( "DLabel" )
	DLabelPurchaseHeader:SetText( "Purchase:" )
	DLabelPurchaseHeader:SizeToContents()
	DLabelPurchaseHeader:SetWrap( true )
	headerGrid:AddItem(DLabelPurchaseHeader)

	-- --------ITEM GRID

	local grid = vgui.Create( "DGrid", itemPanel )
	grid:SetPos( itemX, itemY )
	grid:SetCols( numHeaders )
	grid:SetColWide( colw )
	grid:SetRowHeight( itemH / numItems )
			
	for i=1,table.Count(ConfigInfo["MarketFog"].PurchaseItems) do 
	
		local Label1 = vgui.Create( "DLabel" )
		Label1:SetText( ConfigInfo["MarketFog"].PurchaseItems[i].Name )
		Label1:SetSize(colw, itemH / numItems)
		Label1:SetWrap( true )
		grid:AddItem(Label1)

		local SpawnIcon1 = vgui.Create( "SpawnIcon")
		SpawnIcon1:SetModel( ConfigInfo["MarketFog"].PurchaseItems[i].DisplayModelName  )
		SpawnIcon1:SetSize( itemH / numItems, itemH / numItems )
		SpawnIcon1:RebuildSpawnIcon() 
		SpawnIcon1.DoClick = function()
		end
		grid:AddItem(SpawnIcon1)

		local Label1 = vgui.Create( "DLabel" )
		Label1:SetText( ConfigInfo["MarketFog"].PurchaseItems[i].Description )
		Label1:SetSize(colw, itemH / numItems)
		Label1:SetWrap( true )
		grid:AddItem(Label1)	

		local Label1 = vgui.Create( "DLabel" )
		Label1:SetText( ConfigInfo["MarketFog"].Gameplay.CashDisplaySymbol..ConfigInfo["MarketFog"].PurchaseItems[i].Price )
		Label1:SetSize(colw, itemH / numItems)
		Label1:SetWrap( true )
		grid:AddItem(Label1)	

		local DButton = vgui.Create( "DButton" )
		DButton:SetText( "Purchase!" )
		DButton:SetSize(itemH / numItems, itemH / numItems)
		DButton.DoClick = function()
		
			if (ConfigInfo["MarketFog"].PurchaseItems[i].ConsoleCommand == "shop_buy_weapon") then
				RunConsoleCommand("shop_buy_weapon", ConfigInfo["MarketFog"].PurchaseItems[i].Price, ConfigInfo["MarketFog"].PurchaseItems[i].Classname, ConfigInfo["MarketFog"].PurchaseItems[i].DisplayName)
			else
				RunConsoleCommand(ConfigInfo["MarketFog"].PurchaseItems[i].ConsoleCommand, ConfigInfo["MarketFog"].PurchaseItems[i].Price, ConfigInfo["MarketFog"].PurchaseItems[i].Quantity)			
			end	
		end
		grid:AddItem(DButton)		
	
	end 
		
-- -------AMMO PANEL
local numItems = 10
local weaponPanel = vgui.Create( "DPanel", sheet )
weaponPanel.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 75, 75, 75, self:GetAlpha() ) ) end
sheet:AddSheet( "Ammo", weaponPanel )

local panelW, panelH = weaponPanel:GetSize( ) -- Get the size of the panel

	-- -------Headers

	local headerGrid = vgui.Create( "DGrid", weaponPanel )
	headerGrid:SetPos( headerX, headerY )
	headerGrid:SetCols( numHeaders )
	headerGrid:SetColWide( colw )
	headerGrid:SetRowHeight( headerH )

	local DLabelItemHeader = vgui.Create( "DLabel" )
	DLabelItemHeader:SetText( "Item:" )
	DLabelItemHeader:SizeToContents()
	DLabelItemHeader:SetWrap( true )
	headerGrid:AddItem(DLabelItemHeader)

	local DLabelImageHeader = vgui.Create( "DLabel" )
	DLabelImageHeader:SetText( "Image:" )
	DLabelImageHeader:SizeToContents()
	DLabelImageHeader:SetWrap( true )
	headerGrid:AddItem(DLabelImageHeader)

	local DLabelDescHeader = vgui.Create( "DLabel" )
	DLabelDescHeader:SetText( "Desc:" )
	DLabelDescHeader:SizeToContents()
	DLabelDescHeader:SetWrap( true )
	headerGrid:AddItem(DLabelDescHeader)

	local DLabelPriceHeader = vgui.Create( "DLabel" )
	DLabelPriceHeader:SetText( "Price:" )
	DLabelPriceHeader:SizeToContents()
	DLabelPriceHeader:SetWrap( true )
	headerGrid:AddItem(DLabelPriceHeader)

	local DLabelPurchaseHeader = vgui.Create( "DLabel" )
	DLabelPurchaseHeader:SetText( "Purchase:" )
	DLabelPurchaseHeader:SizeToContents()
	DLabelPurchaseHeader:SetWrap( true )
	headerGrid:AddItem(DLabelPurchaseHeader)

	-- --------ITEM GRID

	local grid = vgui.Create( "DGrid", weaponPanel )
	grid:SetPos( itemX, itemY )
	grid:SetCols( numHeaders )
	grid:SetColWide( colw )
	grid:SetRowHeight( itemH / numItems )

	for i=1,table.Count(AmmoEntries) do 
	
		local Label1 = vgui.Create( "DLabel" )
		Label1:SetText( AmmoEntries[i].name )
		Label1:SetSize(colw, itemH / numItems )
		Label1:SetWrap( true )
		grid:AddItem(Label1)

		local SpawnIcon1 = vgui.Create( "SpawnIcon")
		SpawnIcon1:SetModel( AmmoEntries[i].modelname  )
		SpawnIcon1:SetSize( itemH / numItems, itemH / numItems )
		SpawnIcon1:RebuildSpawnIcon() 
		SpawnIcon1.DoClick = function()
		end
		grid:AddItem(SpawnIcon1)

		local Label1 = vgui.Create( "DLabel" )
		Label1:SetText( AmmoEntries[i].desc )
		Label1:SetSize(colw, itemH / numItems )
		Label1:SetWrap( true )
		grid:AddItem(Label1)

		local Label1 = vgui.Create( "DLabel" )
		Label1:SetText( ConfigInfo["MarketFog"].Gameplay.CashDisplaySymbol..AmmoEntries[i].price )
		Label1:SetSize(colw, itemH / numItems )
		Label1:SetWrap( true )
		grid:AddItem(Label1)

		local DButton = vgui.Create( "DButton" )
		DButton:SetText( "Buy!" )
		DButton:SetSize( itemH / numItems, itemH / numItems )
		DButton.DoClick = function()
		
			if (AmmoEntries[i].consolecommand == "shop_buy_ammo") then
				RunConsoleCommand("shop_buy_ammo", AmmoEntries[i].price, AmmoEntries[i].quantity, AmmoEntries[i].ammoname)
			else
				RunConsoleCommand(AmmoEntries[i].consolecommand, AmmoEntries[i].price, AmmoEntries[i].classname, AmmoEntries[i].display)
			end
		
		end
		grid:AddItem(DButton)		
	
	end 			

-- -------AMMO PANEL
local numItems = 0
for i=1, table.Count(ConfigInfo["MarketFog"].Weapon) do
	if (ConfigInfo["MarketFog"].Weapon[i].Buyable and not ConfigInfo["MarketFog"].Weapon[i].IsAlien) then numItems = numItems + 1 end	
end

local maxitems = 10
local numsheets = math.floor(numItems / (maxitems + 1)) + 1
local weaponsheets = {}

	for i=1, numsheets do

		weaponsheets[i] = {}
		
		weaponsheets[i].Panel =  vgui.Create( "DPanel", sheet )
		weaponsheets[i].Panel.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 75, 75, 75, self:GetAlpha() ) ) end
		sheet:AddSheet( "Weapons", weaponsheets[i].Panel )
		
		-- -------Headers

		local headerGrid = vgui.Create( "DGrid", weaponsheets[i].Panel )
		headerGrid:SetPos( headerX, headerY )
		headerGrid:SetCols( numHeaders )
		headerGrid:SetColWide( colw )
		headerGrid:SetRowHeight( headerH )

		local DLabelItemHeader = vgui.Create( "DLabel" )
		DLabelItemHeader:SetText( "Item:" )
		DLabelItemHeader:SizeToContents()
		headerGrid:AddItem(DLabelItemHeader)

		local DLabelImageHeader = vgui.Create( "DLabel" )
		DLabelImageHeader:SetText( "Image:" )
		DLabelImageHeader:SizeToContents()
		headerGrid:AddItem(DLabelImageHeader)

		local DLabelDescHeader = vgui.Create( "DLabel" )
		DLabelDescHeader:SetText( "Desc:" )
		DLabelDescHeader:SizeToContents()
		headerGrid:AddItem(DLabelDescHeader)

		local DLabelPriceHeader = vgui.Create( "DLabel" )
		DLabelPriceHeader:SetText( "Price("..ConfigInfo["MarketFog"].Gameplay.CashDisplaySymbol.."):" )
		DLabelPriceHeader:SizeToContents()
		headerGrid:AddItem(DLabelPriceHeader)

		local DLabelPurchaseHeader = vgui.Create( "DLabel" )
		DLabelPurchaseHeader:SetText( "Buy:" )
		DLabelPurchaseHeader:SizeToContents()
		headerGrid:AddItem(DLabelPurchaseHeader)
		
		weaponsheets[i].Grid = vgui.Create("DGrid", weaponsheets[i].Panel)
		weaponsheets[i].Grid:SetPos( itemX, itemY )
		weaponsheets[i].Grid:SetCols( numHeaders )
		weaponsheets[i].Grid:SetColWide( colw )
		weaponsheets[i].Grid:SetRowHeight( itemH / maxitems )
	end

	--------WEAPON PURCHASE 
	local weaponctr = 0
	local cursheetindex = 0
	
	for i=1, table.Count(ConfigInfo["MarketFog"].Weapon) do
		if (ConfigInfo["MarketFog"].Weapon[i].Buyable and not ConfigInfo["MarketFog"].Weapon[i].IsAlien) then
			
				weaponctr = weaponctr + 1
				cursheetindex = math.floor(weaponctr / (maxitems + 1)) + 1

				DLabelItemSuit = vgui.Create( "DLabel" )
				DLabelItemSuit:SetText( ConfigInfo["MarketFog"].Weapon[i].DisplayName )
				DLabelItemSuit:SetSize(colw, itemH / maxitems)
				DLabelItemSuit:SetWrap( true )
				weaponsheets[cursheetindex].Grid:AddItem(DLabelItemSuit)

					 DImageSuit = vgui.Create( "SpawnIcon")
				DImageSuit:SetModel( ConfigInfo["MarketFog"].Weapon[i].DisplayModelName  )
				DImageSuit:SetSize(itemH / maxitems, itemH / maxitems)
				DImageSuit:SetWrap( true )
				DImageSuit:RebuildSpawnIcon() 
				DImageSuit.DoClick = function()
				end
				weaponsheets[cursheetindex].Grid:AddItem(DImageSuit)

					 DLabelDescSuit = vgui.Create( "DLabel" )
				DLabelDescSuit:SetText( ConfigInfo["MarketFog"].Weapon[i].Description )
				DLabelDescSuit:SetSize(colw, itemH / maxitems)
				DLabelDescSuit:SetWrap( true )
				weaponsheets[cursheetindex].Grid:AddItem(DLabelDescSuit)

					 DLabelPriceSuit = vgui.Create( "DLabel" )
				DLabelPriceSuit:SetText( ConfigInfo["MarketFog"].Gameplay.CashDisplaySymbol..ConfigInfo["MarketFog"].Weapon[i].Price )
				DLabelPriceSuit:SetSize(colw, itemH / maxitems)
				DLabelPriceSuit:SetWrap( true )
				weaponsheets[cursheetindex].Grid:AddItem(DLabelPriceSuit)

					 DButton = vgui.Create( "DButton" )
				DButton:SetText( "Buy!" )
				DButton:SetSize(itemH / maxitems, itemH / maxitems)
				DButton.DoClick = function()
					RunConsoleCommand("shop_buy_weapon", ConfigInfo["MarketFog"].Weapon[i].Price, ConfigInfo["MarketFog"].Weapon[i].Name, ConfigInfo["MarketFog"].Weapon[i].DisplayName)
								end
				weaponsheets[cursheetindex].Grid:AddItem(DButton)
			
		end
	end
	
	
-- -------APPAREL PANEL

local numItems = table.Count(ConfigInfo["MarketFog"].Apparel)
numHeaders = 6
colw = frameW / numHeaders 
maxitems = 8
numsheets = math.floor(numItems / (maxitems + 1)) + 1
local apparelsheets = {}

	for i=1, numsheets do

		apparelsheets[i] = {}
		
		apparelsheets[i].Panel =  vgui.Create( "DPanel", sheet )
		apparelsheets[i].Panel.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 75, 75, 75, self:GetAlpha() ) ) end
		sheet:AddSheet( "Apparel", apparelsheets[i].Panel )
		
		-- -------Headers

		local headerGrid = vgui.Create( "DGrid", apparelsheets[i].Panel )
		headerGrid:SetPos( headerX, headerY )
		headerGrid:SetCols( numHeaders )
		headerGrid:SetColWide( colw )
		headerGrid:SetRowHeight( headerH )

		local DLabelItemHeader = vgui.Create( "DLabel" )
		DLabelItemHeader:SetText( "Item:" )
		DLabelItemHeader:SizeToContents()
		headerGrid:AddItem(DLabelItemHeader)

		local DLabelImageHeader = vgui.Create( "DLabel" )
		DLabelImageHeader:SetText( "Image:" )
		DLabelImageHeader:SizeToContents()
		headerGrid:AddItem(DLabelImageHeader)

		local DLabelDescHeader = vgui.Create( "DLabel" )
		DLabelDescHeader:SetText( "Desc:" )
		DLabelDescHeader:SizeToContents()
		headerGrid:AddItem(DLabelDescHeader)

		local DLabelPriceHeader = vgui.Create( "DLabel" )
		DLabelPriceHeader:SetText( "Price:" )
		DLabelPriceHeader:SizeToContents()
		headerGrid:AddItem(DLabelPriceHeader)

		local DLabelPurchaseHeader = vgui.Create( "DLabel" )
		DLabelPurchaseHeader:SetText( "Buy/Equip:" )
		DLabelPurchaseHeader:SizeToContents()
		headerGrid:AddItem(DLabelPurchaseHeader)
		
		local DLabelSellHeader = vgui.Create( "DLabel" )
		DLabelSellHeader:SetText( "Sell:" )
		DLabelSellHeader:SizeToContents()
		headerGrid:AddItem(DLabelSellHeader)
	
		apparelsheets[i].Grid = vgui.Create("DGrid", apparelsheets[i].Panel)
		apparelsheets[i].Grid:SetPos( itemX, itemY )
		apparelsheets[i].Grid:SetCols( numHeaders)
		apparelsheets[i].Grid:SetColWide( colw )
		apparelsheets[i].Grid:SetRowHeight( itemH / maxitems )
	end

	local curSuit = LocalPlayer():GetNWInt('plySuit');	
	
	-- --------ITEM GRID

	local apparelctr = 0
	local cursheetindex = 0
	
	for i=1,table.Count(ConfigInfo["MarketFog"].Apparel) do 
	
		apparelctr = apparelctr + 1
		cursheetindex = math.floor(apparelctr / (maxitems + 1)) + 1
	
		local Label1 = vgui.Create( "DLabel" )
		Label1:SetText( ConfigInfo["MarketFog"].Apparel[i].Name.." Armour (x1)" )
		Label1:SetSize(colw, itemH / maxitems )
		Label1:SetWrap( true )
		apparelsheets[cursheetindex].Grid:AddItem(Label1)

		local SpawnIcon1 = vgui.Create( "SpawnIcon")
		SpawnIcon1:SetModel( ConfigInfo["MarketFog"].Apparel[i].ModelName  )
		SpawnIcon1:SetSize( itemH / maxitems, itemH / maxitems )
		SpawnIcon1:RebuildSpawnIcon() 
		SpawnIcon1.DoClick = function()
		end
		apparelsheets[cursheetindex].Grid:AddItem(SpawnIcon1)

		local Label1 = vgui.Create( "DLabel" )
		Label1:SetText( ConfigInfo["MarketFog"].Apparel[i].ShopDesc )
		Label1:SetSize(colw, itemH / maxitems )
		Label1:SetWrap( true )
		apparelsheets[cursheetindex].Grid:AddItem(Label1)

		local Label1 = vgui.Create( "DLabel" )
		Label1:SetText( ConfigInfo["MarketFog"].Gameplay.CashDisplaySymbol..ConfigInfo["MarketFog"].Apparel[i].Price )
		Label1:SetSize(colw, itemH / maxitems )
		Label1:SetWrap( true )
		apparelsheets[cursheetindex].Grid:AddItem(Label1)

		local isOwned = (i == LocalPlayer():GetNWInt('plySuit'))
		for j=1,3 do
			local index = LocalPlayer():GetNWInt('plySuitStorage'..j)
			if (i == index) then
				isOwned = true
			end
		end

		local DButton = vgui.Create( "DButton" )
		if (isOwned) then
	
			if (LocalPlayer():GetNWInt('plySuit') == i) then
				DButton:SetText( "<You are wearing this>" )
			else
				DButton:SetText( "Equip!" )
			end
		else
			DButton:SetText( "Buy!" )
		end
		DButton:SetSize( itemH / maxitems, itemH / maxitems )
		DButton.DoClick = function()
			if (isOwned) then
				RunConsoleCommand("shop_equip_suit", i)			
			else
				RunConsoleCommand("shop_buy_suit", ConfigInfo["MarketFog"].Apparel[i].Price, i)
			end
			
			Frame:Close()
		end
		apparelsheets[cursheetindex].Grid:AddItem(DButton)	
	
		local SellButton = vgui.Create( "DButton" )
		SellButton:SetText( "Sell!" )
		SellButton:SetSize( itemH / maxitems, itemH / maxitems )
		SellButton.DoClick = function()
			RunConsoleCommand("shop_sell_suit", i, ConfigInfo["MarketFog"].Apparel[i].Price)
			Frame:Close()
		end
		apparelsheets[cursheetindex].Grid:AddItem(SellButton)	
	
	end 	

-- -------MARKET PANEL
local numItems = 3
local numMarketCol = 8
local marketPanel = vgui.Create( "DPanel", sheet )
marketPanel.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 75, 75, 75, self:GetAlpha() ) ) end
sheet:AddSheet( "Market", marketPanel )
	
		-- -------Headers

	local headerGrid = vgui.Create( "DGrid", marketPanel )
	headerGrid:SetPos( headerX, headerY )
	headerGrid:SetCols( numMarketCol )
	headerGrid:SetColWide( frameW / numMarketCol  )
	headerGrid:SetRowHeight( headerH )
	
	local DLabelItemHeader = vgui.Create( "DLabel" )
	DLabelItemHeader:SetText( "Resource:" )
	DLabelItemHeader:SizeToContents()
	headerGrid:AddItem(DLabelItemHeader)

	local DLabelImageHeader = vgui.Create( "DLabel" )
	DLabelImageHeader:SetText( "Image:" )
	DLabelImageHeader:SizeToContents()
	headerGrid:AddItem(DLabelImageHeader)

	local DLabelDescHeader = vgui.Create( "DLabel" )
	DLabelDescHeader:SetText( "Desc:" )
	DLabelDescHeader:SizeToContents()
	headerGrid:AddItem(DLabelDescHeader)

	local DLabelPriceHeader = vgui.Create( "DLabel" )
	DLabelPriceHeader:SetText( "Price:" )
	DLabelPriceHeader:SizeToContents()
	headerGrid:AddItem(DLabelPriceHeader)

		local DLabelQuantityHeader = vgui.Create( "DLabel" )
	DLabelQuantityHeader:SetText( "Quantity:" )
	DLabelQuantityHeader:SizeToContents()
	headerGrid:AddItem(DLabelQuantityHeader)
	
	local DLabelPurchaseHeader = vgui.Create( "DLabel" )
	DLabelPurchaseHeader:SetText( "Buy:" )
	DLabelPurchaseHeader:SizeToContents()
	headerGrid:AddItem(DLabelPurchaseHeader)
	
		local DLabelSellHeader = vgui.Create( "DLabel" )
	DLabelSellHeader:SetText( "Sell:" )
	DLabelSellHeader:SizeToContents()
	headerGrid:AddItem(DLabelSellHeader)
	
	local DLabelSellHeader = vgui.Create( "DLabel" )
	DLabelSellHeader:SetText( "Sell All:" )
	DLabelSellHeader:SizeToContents()
	headerGrid:AddItem(DLabelSellHeader)
	
		-- --------ITEM GRID

	local grid = vgui.Create( "DGrid", marketPanel )
	grid:SetPos( itemX, itemY )
	grid:SetCols( numMarketCol )
	grid:SetColWide( frameW / numMarketCol )
	grid:SetRowHeight( itemH / numItems )
	
		--------BUY METAL

		local DLabelItemSuit = vgui.Create( "DLabel" )
	DLabelItemSuit:SetText( "Metal Quantity(x"..Metal["Supply"]..")" )
	DLabelItemSuit:SetSize(frameW / numMarketCol, itemH / numItems)
	DLabelItemSuit:SetWrap( true )
	grid:AddItem(DLabelItemSuit)

		local DImageSuit = vgui.Create( "SpawnIcon")
	DImageSuit:SetModel( "models/props_c17/oildrumchunk01d.mdl"  )
	DImageSuit:SetSize( itemH / (numItems * 2), itemH / (numItems * 2) )
	DImageSuit:RebuildSpawnIcon() 
	DImageSuit.DoClick = function()
	end
	grid:AddItem(DImageSuit)

		local DLabelDescSuit = vgui.Create( "DLabel" )
	DLabelDescSuit:SetText( "Scrap metal" )
	DLabelDescSuit:SetSize(frameW / numMarketCol, itemH / numItems)
	DLabelDescSuit:SetWrap( true )
	grid:AddItem(DLabelDescSuit)

		local DLabelPriceSuit = vgui.Create( "DLabel" )
	DLabelPriceSuit:SetText( ConfigInfo["MarketFog"].Gameplay.CashDisplaySymbol..Metal["Price"]  )
	DLabelPriceSuit:SetSize(frameW / numMarketCol, itemH / numItems)
	DLabelPriceSuit:SetWrap( true )
	grid:AddItem(DLabelPriceSuit)
	
			local DNumberWangThingMetal = vgui.Create( "DNumberWang" )
	DNumberWangThingMetal:SetMin( 1)
	DNumberWangThingMetal:SetMax(100 )
	DNumberWangThingMetal:SetValue( 1 )
	grid:AddItem(DNumberWangThingMetal)
	
		local DButton = vgui.Create( "DButton" )
	DButton:SetText( "Buy" )
	DButton:SetSize(itemH / (2.0 * numItems), itemH / (2.0 * numItems) )
	DButton.DoClick = function()
		marketPanel:Refresh()
			
		RunConsoleCommand( "shop_buy_resource", DNumberWangThingMetal:GetValue(), "metal" ) 
					end
	grid:AddItem(DButton)
	
			local DButton = vgui.Create( "DButton" )
	DButton:SetText( "Sell" )
	DButton:SetSize( itemH / (2.0 * numItems), itemH / (2.0 * numItems))
	DButton.DoClick = function()
	
			marketPanel:Refresh()
			RunConsoleCommand( "shop_sell_resource", DNumberWangThingMetal:GetValue(), "metal" ) 
		
					end
	grid:AddItem(DButton)
	
				local DButton = vgui.Create( "DButton" )
	DButton:SetText( "Sell All" )
	DButton:SetSize( itemH / (2.0 * numItems), itemH / (2.0 * numItems) )
	DButton.DoClick = function()
	
			marketPanel:Refresh()
			RunConsoleCommand( "shop_sell_resource", LocalPlayer():GetNWInt('plyMetal'), "metal" ) 
		
					end
	grid:AddItem(DButton)
	
			--------BUY CIRCUITS

		local DLabelItemSuit = vgui.Create( "DLabel" )
	DLabelItemSuit:SetText( "Circuits Quantity(x"..Circuits["Supply"]..")"  )
	DLabelItemSuit:SetSize(frameW / numMarketCol, itemH / numItems)
	DLabelItemSuit:SetWrap( true )
	grid:AddItem(DLabelItemSuit)

		local DImageSuit = vgui.Create( "SpawnIcon")
	DImageSuit:SetModel( "models/props_lab/reciever01c.mdl"  )
	DImageSuit:SetSize(itemH / (numItems * 2), itemH / (numItems * 2))
	DImageSuit:RebuildSpawnIcon() 
	DImageSuit.DoClick = function()
	end
	grid:AddItem(DImageSuit)

		local DLabelDescSuit = vgui.Create( "DLabel" )
	DLabelDescSuit:SetText( "Advanced circuitry" )
	DLabelDescSuit:SetSize(frameW / numMarketCol, itemH / numItems)
	DLabelDescSuit:SetWrap( true )
	grid:AddItem(DLabelDescSuit)
	
		local DLabelPriceSuit = vgui.Create( "DLabel" )
	DLabelPriceSuit:SetText( ConfigInfo["MarketFog"].Gameplay.CashDisplaySymbol..Circuits["Price"] )
	DLabelPriceSuit:SetSize(frameW / numMarketCol, itemH / numItems)
	DLabelPriceSuit:SetWrap( true )
	grid:AddItem(DLabelPriceSuit)

		local DNumberWangThingCircuits = vgui.Create( "DNumberWang" )
	DNumberWangThingCircuits:SetMin( 1)
	DNumberWangThingCircuits:SetMax( 100 )
	DNumberWangThingCircuits:SetValue( 1 )
	grid:AddItem(DNumberWangThingCircuits)
	
		local DButton = vgui.Create( "DButton" )
	DButton:SetText( "Buy" )
	DButton:SetSize(itemH / (2.0 * numItems), itemH / (2.0 * numItems))
	DButton.DoClick = function()
			RunConsoleCommand( "shop_buy_resource", DNumberWangThingCircuits:GetValue(), "circuits" ) 
					end
	grid:AddItem(DButton)
	
				local DButton = vgui.Create( "DButton" )
	DButton:SetText( "Sell" )
	DButton:SetSize(itemH / (2.0 * numItems), itemH / (2.0 * numItems))
	DButton.DoClick = function()
		RunConsoleCommand( "shop_sell_resource", DNumberWangThingCircuits:GetValue(), "circuits" ) 
					end
	grid:AddItem(DButton)
	
					local DButton = vgui.Create( "DButton" )
	DButton:SetText( "Sell All" )
	DButton:SetSize(itemH / (2.0 * numItems), itemH / (2.0 * numItems))
	DButton.DoClick = function()
	
			marketPanel:Refresh()
			RunConsoleCommand( "shop_sell_resource", LocalPlayer():GetNWInt('plyCircuits'), "circuits" ) 
		
					end
	grid:AddItem(DButton)
	
				--------BUY FUEL

		DLabelItemSuit = vgui.Create( "DLabel" )
	DLabelItemSuit:SetText( "Fuel Quantity(x"..Fuel["Supply"]..")"  )
	DLabelItemSuit:SetSize(frameW / numMarketCol, itemH / numItems)
	DLabelItemSuit:SetWrap( true )
	grid:AddItem(DLabelItemSuit)

		DImageSuit = vgui.Create( "SpawnIcon")
	DImageSuit:SetModel( "models/props_junk/gascan001a.mdl"  )
	DImageSuit:SetSize(itemH / (numItems * 2), itemH / (numItems * 2))
	DImageSuit:RebuildSpawnIcon() 
	DImageSuit.DoClick = function()
	end
	grid:AddItem(DImageSuit)

		 DLabelDescSuit = vgui.Create( "DLabel" )
	DLabelDescSuit:SetText( "Rare and expensive" )
	DLabelDescSuit:SetSize(frameW / numMarketCol, itemH / numItems)
	DLabelDescSuit:SetWrap( true )
	grid:AddItem(DLabelDescSuit)

		DLabelPriceSuit = vgui.Create( "DLabel" )
	DLabelPriceSuit:SetText( ConfigInfo["MarketFog"].Gameplay.CashDisplaySymbol..Fuel["Price"] )
	DLabelPriceSuit:SetSize(frameW / numMarketCol, itemH / numItems)
	DLabelPriceSuit:SetWrap( true )
	grid:AddItem(DLabelPriceSuit)

		DNumberWangThingFuel = vgui.Create( "DNumberWang" )
	DNumberWangThingFuel:SetMin( 1)
	DNumberWangThingFuel:SetMax( 100 )
	DNumberWangThingFuel:SetValue( 1 )
	grid:AddItem(DNumberWangThingFuel)
	
		DButton = vgui.Create( "DButton" )
	DButton:SetText( "Buy" )
	DButton:SetSize(itemH / (2.0 * numItems), itemH / (2.0 * numItems))
	DButton.DoClick = function()
		RunConsoleCommand( "shop_buy_resource", DNumberWangThingFuel:GetValue(), "fuel" ) 
					end
	grid:AddItem(DButton)
	
				local DButton = vgui.Create( "DButton" )
	DButton:SetText( "Sell" )
	DButton:SetSize(itemH / (2.0 * numItems), itemH / (2.0 * numItems))
	DButton.DoClick = function()
		RunConsoleCommand( "shop_sell_resource", DNumberWangThingFuel:GetValue(), "fuel" ) 
					end
	grid:AddItem(DButton)
	
						local DButton = vgui.Create( "DButton" )
	DButton:SetText( "Sell All" )
	DButton:SetSize(itemH / (2.0 * numItems), itemH / (2.0 * numItems))
	DButton.DoClick = function()
	
			marketPanel:Refresh()
			RunConsoleCommand( "shop_sell_resource", LocalPlayer():GetNWInt('plyFuel'), "fuel" ) 
		
					end
	grid:AddItem(DButton)

-- Alien weapons
	
	if LocalPlayer():GetNWBool('plyHasAlienWeapons') then
		local numItems = 0
		for i=1, table.Count(ConfigInfo["MarketFog"].Weapon) do
			if (ConfigInfo["MarketFog"].Weapon[i].Buyable and ConfigInfo["MarketFog"].Weapon[i].IsAlien) then numItems = numItems + 1 end	
		end
		local weaponPanel = vgui.Create( "DPanel", sheet )
		weaponPanel.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 75, 75, 75, self:GetAlpha() ) ) end
		sheet:AddSheet( "Alien Weapons", weaponPanel )

		local panelW, panelH = weaponPanel:GetSize( ) -- Get the size of the panel

			-- -------Headers

			local headerGrid = vgui.Create( "DGrid", weaponPanel )
			headerGrid:SetPos( headerX, headerY )
			headerGrid:SetCols( 4 )
			headerGrid:SetColWide( colw )
			headerGrid:SetRowHeight( headerH )

			local DLabelItemHeader = vgui.Create( "DLabel" )
			DLabelItemHeader:SetText( "Item:" )
			DLabelItemHeader:SetSize(colw, headerH)
			headerGrid:AddItem(DLabelItemHeader)

			local DLabelDescHeader = vgui.Create( "DLabel" )
			DLabelDescHeader:SetText( "Desc:" )
			DLabelDescHeader:SizeToContents()
			headerGrid:AddItem(DLabelDescHeader)

			local DLabelPriceHeader = vgui.Create( "DLabel" )
			DLabelPriceHeader:SetText( "Price(Scrap):" )
			DLabelPriceHeader:SizeToContents()
			headerGrid:AddItem(DLabelPriceHeader)

			local DLabelPurchaseHeader = vgui.Create( "DLabel" )
			DLabelPurchaseHeader:SetText( "Purchase:" )
			DLabelPurchaseHeader:SizeToContents()
			headerGrid:AddItem(DLabelPurchaseHeader)

			-- --------ITEM GRID

			local grid = vgui.Create( "DGrid", weaponPanel )
			grid:SetPos( itemX, itemY )
			grid:SetCols( 4 )
			grid:SetColWide( colw )
			grid:SetRowHeight( itemH / numItems )
			
			--------ALIEN PURCHASE 

			for i=1, table.Count(ConfigInfo["MarketFog"].Weapon) do
				if (ConfigInfo["MarketFog"].Weapon[i].Buyable and ConfigInfo["MarketFog"].Weapon[i].IsAlien) then
					
						DLabelItemSuit = vgui.Create( "DLabel" )
						DLabelItemSuit:SetText( ConfigInfo["MarketFog"].Weapon[i].DisplayName )
						DLabelItemSuit:SetSize(colw, headerH)
						DLabelItemSuit:SetWrap( true )
						grid:AddItem(DLabelItemSuit)

							 DLabelDescSuit = vgui.Create( "DLabel" )
						DLabelDescSuit:SetText( ConfigInfo["MarketFog"].Weapon[i].Description )
						DLabelDescSuit:SetSize(colw, headerH)
						DLabelDescSuit:SetWrap( true )
						grid:AddItem(DLabelDescSuit)

							 DLabelPriceSuit = vgui.Create( "DLabel" )
						DLabelPriceSuit:SetText( ConfigInfo["MarketFog"].Gameplay.CashDisplaySymbol..ConfigInfo["MarketFog"].Weapon[i].Price )
						DLabelPriceSuit:SetSize(colw, headerH)
						DLabelPriceSuit:SetWrap( true )
						grid:AddItem(DLabelPriceSuit)

							 DButton = vgui.Create( "DButton" )
						DButton:SetText( "Purchase!" )
						DButton:SetSize(headerH, headerH)
						DButton.DoClick = function()
							RunConsoleCommand("shop_buy_weapon", ConfigInfo["MarketFog"].Weapon[i].Price, ConfigInfo["MarketFog"].Weapon[i].Name, ConfigInfo["MarketFog"].Weapon[i].DisplayName)
										end
						grid:AddItem(DButton)
					
				end
			end

	end

-- Sell weapons

		local wepTable = LocalPlayer():GetWeapons()
		local numItems = table.Count( wepTable )
		local weaponPanel = vgui.Create( "DPanel", sheet )
		weaponPanel.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 75, 75, 75, self:GetAlpha() ) ) end
		sheet:AddSheet( "Sell Weapons", weaponPanel )
	
		-- --------ITEM GRID
		local grid = vgui.Create( "DGrid", weaponPanel )
		grid:SetPos( itemX, itemY )
		grid:SetCols( 3 )
		grid:SetColWide( colw )
		grid:SetRowHeight( itemH / numItems )
		
		for k, v in pairs( wepTable ) do -- loop through them
			if (IsValid(v)) then

				local display = WeaponClassNameToDisplayName(v:GetClass())
				local model = WeaponClassNameToModelName(v:GetClass())
		
				if (v:GetClass() ~= "weapon_pwb_knife") then
			
					DLabelItemSuit = vgui.Create( "DLabel" )
					DLabelItemSuit:SetText( display )
					DLabelItemSuit:SetSize(colw, itemH / numItems)
					DLabelItemSuit:SetWrap( true )
					grid:AddItem(DLabelItemSuit)

					local price = WeaponClassNameToPrice(v:GetClass()) / 2
					DLabelPriceSuit = vgui.Create( "DLabel" )
					DLabelPriceSuit:SetText( "Sell Price "..ConfigInfo["MarketFog"].Gameplay.CashDisplaySymbol..price )
					DLabelPriceSuit:SetSize(colw, itemH / numItems)
					DLabelPriceSuit:SetWrap( true )
					grid:AddItem(DLabelPriceSuit)

						 DButton = vgui.Create( "DButton" )
					DButton:SetText( "Sell!" )
					DButton:SetSize(itemH / (numItems * 2), itemH / (numItems * 2))
					DButton.DoClick = function()
						RunConsoleCommand("shop_sell_weapon", price, v:GetClass(), display)
						Frame:Close()
									end
					grid:AddItem(DButton)	
				end
			end
		end
	
-- Storage Capability

	local storagePanel = vgui.Create( "DPanel", sheet )
	storagePanel.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 75, 75, 75, self:GetAlpha() ) ) end
	sheet:AddSheet( "Storage", storagePanel )
	
	local myweaponsheaderX = frameW / 30
	local headery = frameH / 30
	
	DLabelItemSuit = vgui.Create( "DLabel", storagePanel )
	DLabelItemSuit:SetPos(myweaponsheaderX, headery )
	DLabelItemSuit:SetText( "My Current Weapons" )
	DLabelItemSuit:SizeToContents()
	
	local storedweaponsheaderX = (frameW / 30) + (frameW / 2)
	
	DLabelItemSuit = vgui.Create( "DLabel",  storagePanel)
	DLabelItemSuit:SetPos(storedweaponsheaderX, headery )
	DLabelItemSuit:SetText( "My Stored Weapons" )
	DLabelItemSuit:SizeToContents()
	
	-- --------ITEM GRID
	local wepTable = LocalPlayer():GetWeapons()
	local totalWeapons = table.Count(wepTable)
	local gridw = (storedweaponsheaderX - myweaponsheaderX)
	local gridh = (frameH - headery)
	
	local myWeaponsGrid = vgui.Create( "DGrid", storagePanel )
	myWeaponsGrid:SetPos( myweaponsheaderX, headery * 2)
	myWeaponsGrid:SetCols( 3 )
	myWeaponsGrid:SetColWide( gridw / 3 )
	myWeaponsGrid:SetRowHeight( gridh / 7 )

	local myindex = 1
	for k, v in pairs( wepTable ) do
		
		local i = myindex
		
		local display = WeaponClassNameToDisplayName(v:GetClass())
		local model = WeaponClassNameToModelName(v:GetClass())
		local weptype = WeaponClassNameToWeaponType(v:GetClass())

		DLabelItemSuit = vgui.Create( "DLabel" )
		DLabelItemSuit:SetText( display )
		DLabelItemSuit:SetSize(gridw / 3, gridh / 7)
		DLabelItemSuit:SetWrap( true )
		myWeaponsGrid:AddItem(DLabelItemSuit)

		DImageSuit = vgui.Create( "SpawnIcon")
		DImageSuit:SetModel( model  )
		DImageSuit:SetSize(gridh / 14, gridh / 14)
		DImageSuit:RebuildSpawnIcon() 
		DImageSuit.DoClick = function()
		end
		myWeaponsGrid:AddItem(DImageSuit)

		DButton = vgui.Create( "DButton" )
		DButton:SetText( "Deposit" )
		DButton:SetSize(gridh / 14, gridh / 14)
		DButton.DoClick = function()
			RunConsoleCommand("storage_deposit_weapon", i, WeaponClassNameToIndex(v:GetClass()))
			Frame:Close()
				end
		myWeaponsGrid:AddItem(DButton)	
		
		myindex = myindex + 1
	end
	
	-- Now the set of 9 stored weapons
	
	local storageGrid = vgui.Create( "DGrid", storagePanel )
	storageGrid:SetPos( storedweaponsheaderX, headery * 2)
	storageGrid:SetCols( 2 )
	storageGrid:SetColWide( gridw / 2 )
	storageGrid:SetRowHeight( gridh / 12 )
	
	local display
	local model
	
	local index0 = LocalPlayer():GetNWInt("plyStorage0")
	if (index0 ~= 0) then
		model = ConfigInfo["MarketFog"].Weapon[index0].DisplayModelName
		display = ConfigInfo["MarketFog"].Weapon[index0].DisplayName
		DLabelItemSuit = vgui.Create( "DLabel" )
		DLabelItemSuit:SetText( display )
		DLabelItemSuit:SetSize(gridw / 2, gridh / 12)
		DLabelItemSuit:SetWrap( true )
		storageGrid:AddItem(DLabelItemSuit)
		
		DImageSuit = vgui.Create( "SpawnIcon")
		DImageSuit:SetModel( model  )
		DImageSuit:SetSize( gridh / 12, gridh / 12 )
		DImageSuit:RebuildSpawnIcon() 
		DImageSuit.DoClick = function()
			RunConsoleCommand("storage_withdraw_weapon", 0, index0)
			Frame:Close()
		end
		storageGrid:AddItem(DImageSuit)
	end
	
	index1 = LocalPlayer():GetNWInt("plyStorage1")
	if (index1 ~= 0) then
		model = ConfigInfo["MarketFog"].Weapon[index1].DisplayModelName
		display = ConfigInfo["MarketFog"].Weapon[index1].DisplayName
		DLabelItemSuit = vgui.Create( "DLabel" )
		DLabelItemSuit:SetText( display )
		DLabelItemSuit:SetSize(gridw / 2, gridh / 12)
		DLabelItemSuit:SetWrap( true )
		storageGrid:AddItem(DLabelItemSuit)
		
		DImageSuit = vgui.Create( "SpawnIcon")
		DImageSuit:SetModel( model  )
		DImageSuit:SetSize( gridh / 12, gridh / 12 )
		DImageSuit:RebuildSpawnIcon() 
		DImageSuit.DoClick = function()
			RunConsoleCommand("storage_withdraw_weapon", 1, index1)
			Frame:Close()
		end
		storageGrid:AddItem(DImageSuit)
	end
	
	index2 = LocalPlayer():GetNWInt("plyStorage2")
	if (index2 ~= 0) then
		model = ConfigInfo["MarketFog"].Weapon[index2].DisplayModelName
		display = ConfigInfo["MarketFog"].Weapon[index2].DisplayName
		DLabelItemSuit = vgui.Create( "DLabel" )
		DLabelItemSuit:SetText( display )
		DLabelItemSuit:SetSize(gridw / 2, gridh / 12)
		DLabelItemSuit:SetWrap( true )
		storageGrid:AddItem(DLabelItemSuit)
		
		DImageSuit = vgui.Create( "SpawnIcon")
		DImageSuit:SetModel( model  )
		DImageSuit:SetSize( gridh / 12, gridh / 12 )
		DImageSuit:RebuildSpawnIcon() 
		DImageSuit.DoClick = function()
			RunConsoleCommand("storage_withdraw_weapon", 2, index2)
			Frame:Close()
		end
		storageGrid:AddItem(DImageSuit)
	end	

	index3 = LocalPlayer():GetNWInt("plyStorage3")
	if (index3 ~= 0) then
		model = ConfigInfo["MarketFog"].Weapon[index3].DisplayModelName
		display = ConfigInfo["MarketFog"].Weapon[index3].DisplayName
		DLabelItemSuit = vgui.Create( "DLabel" )
		DLabelItemSuit:SetText( display )
		DLabelItemSuit:SetSize(gridw / 2, gridh / 12)
		DLabelItemSuit:SetWrap( true )
		storageGrid:AddItem(DLabelItemSuit)
		
		DImageSuit = vgui.Create( "SpawnIcon")
		DImageSuit:SetModel( model  )
		DImageSuit:SetSize( gridh / 12, gridh / 12 )
		DImageSuit:RebuildSpawnIcon() 
		DImageSuit.DoClick = function()
			RunConsoleCommand("storage_withdraw_weapon", 3, index3)
			Frame:Close()
		end
		storageGrid:AddItem(DImageSuit)
	end	
	
	index4 = LocalPlayer():GetNWInt("plyStorage4")
	if (index4 ~= 0) then
		model = ConfigInfo["MarketFog"].Weapon[index4].DisplayModelName
		display = ConfigInfo["MarketFog"].Weapon[index4].DisplayName
		DLabelItemSuit = vgui.Create( "DLabel" )
		DLabelItemSuit:SetText( display )
		DLabelItemSuit:SetSize(gridw / 2, gridh / 12)
		DLabelItemSuit:SetWrap( true )
		storageGrid:AddItem(DLabelItemSuit)
		
		DImageSuit = vgui.Create( "SpawnIcon")
		DImageSuit:SetModel( model  )
		DImageSuit:SetSize( gridh / 12, gridh / 12 )
		DImageSuit:RebuildSpawnIcon() 
		DImageSuit.DoClick = function()
			RunConsoleCommand("storage_withdraw_weapon", 4, index4)
			Frame:Close()
		end
		storageGrid:AddItem(DImageSuit)
	end
	
	index5 = LocalPlayer():GetNWInt("plyStorage5")
	if (index5 ~= 0) then
		model = ConfigInfo["MarketFog"].Weapon[index5].DisplayModelName
		display = ConfigInfo["MarketFog"].Weapon[index5].DisplayName
		DLabelItemSuit = vgui.Create( "DLabel" )
		DLabelItemSuit:SetText( display )
		DLabelItemSuit:SetSize(gridw / 2, gridh / 12)
		DLabelItemSuit:SetWrap( true )
		storageGrid:AddItem(DLabelItemSuit)
		
		DImageSuit = vgui.Create( "SpawnIcon")
		DImageSuit:SetModel( model  )
		DImageSuit:SetSize( gridh / 12, gridh / 12 )
		DImageSuit:RebuildSpawnIcon() 
		DImageSuit.DoClick = function()
			RunConsoleCommand("storage_withdraw_weapon", 5, index5)
			Frame:Close()
		end
		storageGrid:AddItem(DImageSuit)
	end

	index6 = LocalPlayer():GetNWInt("plyStorage6")
	if (index6 ~= 0) then
		model = ConfigInfo["MarketFog"].Weapon[index6].DisplayModelName
		display = ConfigInfo["MarketFog"].Weapon[index6].DisplayName
		DLabelItemSuit = vgui.Create( "DLabel" )
		DLabelItemSuit:SetText( display )
		DLabelItemSuit:SetSize(gridw / 2, gridh / 12)
		DLabelItemSuit:SetWrap( true )
		storageGrid:AddItem(DLabelItemSuit)
		
		DImageSuit = vgui.Create( "SpawnIcon")
		DImageSuit:SetModel( model  )
		DImageSuit:SetSize( gridh / 12, gridh / 12 )
		DImageSuit:RebuildSpawnIcon() 
		DImageSuit.DoClick = function()
			RunConsoleCommand("storage_withdraw_weapon", 6, index6)
			Frame:Close()
		end
		storageGrid:AddItem(DImageSuit)
	end
	
	index7 = LocalPlayer():GetNWInt("plyStorage7")
	if (index7 ~= 0) then
		model = ConfigInfo["MarketFog"].Weapon[index7].DisplayModelName
		display = ConfigInfo["MarketFog"].Weapon[index7].DisplayName
		DLabelItemSuit = vgui.Create( "DLabel" )
		DLabelItemSuit:SetText( display )
		DLabelItemSuit:SetSize(gridw / 2, gridh / 12)
		DLabelItemSuit:SetWrap( true )
		storageGrid:AddItem(DLabelItemSuit)
		
		DImageSuit = vgui.Create( "SpawnIcon")
		DImageSuit:SetModel( model  )
		DImageSuit:SetSize( gridh / 12, gridh / 12 )
		DImageSuit:RebuildSpawnIcon() 
		DImageSuit.DoClick = function()
			RunConsoleCommand("storage_withdraw_weapon", 7, index7)
			Frame:Close()
		end
		storageGrid:AddItem(DImageSuit)
	end

	index8 = LocalPlayer():GetNWInt("plyStorage8")
	if (index8 ~= 0) then
		model = ConfigInfo["MarketFog"].Weapon[index8].DisplayModelName
		display = ConfigInfo["MarketFog"].Weapon[index8].DisplayName
		DLabelItemSuit = vgui.Create( "DLabel" )
		DLabelItemSuit:SetText( display )
		DLabelItemSuit:SetSize(gridw / 2, gridh / 12)
		DLabelItemSuit:SetWrap( true )
		storageGrid:AddItem(DLabelItemSuit)
		
		DImageSuit = vgui.Create( "SpawnIcon")
		DImageSuit:SetModel( model  )
		DImageSuit:SetSize( gridh / 12, gridh / 12 )
		DImageSuit:RebuildSpawnIcon() 
		DImageSuit.DoClick = function()
			RunConsoleCommand("storage_withdraw_weapon", 8, index8)
			Frame:Close()
		end
		storageGrid:AddItem(DImageSuit)
	end
	
	
	ShopIntroTutorial()
	
	
end 

net.Receive("MFShopOpen", function( len, pl )
	OpenNetMenu()
end )

--.
