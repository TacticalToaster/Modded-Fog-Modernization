----------------------------------
--	Market Fog	
--	Programmer : LIFO/Tednesday		
--	Date : 19/10/2018		
----------------------------------
				 

function GM:Initialize()
	util.PrecacheSound("gasmask1.wav") 
	util.PrecacheSound("kaching.wav") 
	util.PrecacheSound("dontleave.wav")
end

function GM:PreGamemodeLoaded() 
	--print("pre")
	-- Remove all that shit from the crappy context menu

	hook.Remove( "PopulateMenuBar", "DisplayOptions_MenuBar" )
	hook.Remove( "PopulateMenuBar", "NPCOptions_MenuBar")
end

hook.Add( "ContextMenuCreated", "test", function( ply, property, ent )
	print("contextmenucreated")
end )

function GM:PostGamemodeLoaded() 
--	local dlist = list.Get( "DesktopWindows" )
--	table.Empty( dlist ) 
end

function GM:InitPostEntity()
	print("post int")

	Questx = GUIMarkerData.QuestIntroMarker.x
	Questy = GUIMarkerData.QuestIntroMarker.y
	Questz = GUIMarkerData.QuestIntroMarker.z
	
	-- Set up the weather settings


end

function GM:SetupWorldFog() 

	local state = LocalPlayer():GetNWInt( 'plyState')

	if state == 1 then
		render.FogStart( 0 ) 
		render.FogColor(LevelData.GasColour.x, LevelData.GasColour.y, LevelData.GasColour.z)
		render.FogEnd(LevelData.GasDist)
		render.FogMaxDensity( 1 ) 	
		
		--render.FogEnd(GetGlobalInt("OutsideFogEnd")) 
	else
		render.FogStart( 0 ) 
		render.FogColor(LevelData.GasColour.x, LevelData.GasColour.y, LevelData.GasColour.z)
		render.FogEnd(2000) 
	end
	
	render.FogMode(MATERIAL_FOG_LINEAR)

	return true

 end
 
local PhysgunTutFlag = true
function GM:DrawPhysgunBeam( ply, physgun, enabled, target, physBone, hitPos ) 

	if PhysgunTutFlag then
		DisplayHint(HintEnum["PhysgunTutorial1"] ,10)
		PhysgunTutFlag = false
	end
	return true
end

local GasMaskTutorialFlag = true
local OxygenWarningTutorialFlag = false
CompassBlipShow ={
	O2 = true,
	Shop = true,
	Quest = true,
	Airdrop = true,
	Evac = false
}
function HudPaint()

	local health = LocalPlayer():Health()
	local armor = LocalPlayer():Armor();
	local state = LocalPlayer():GetNWInt( 'plyState')
	local scrOffsetX = ScrW() / 20;
	local scrOffsetY = ScrH() / 12;
	local healthWidth = ScrW() / 10;
	local healthHeight = ScrH() / 30;

	local greyBoxWidth = healthWidth * 1.05
	local greyBoxHeight = healthHeight * 1.2;
	local greyBoxOffsetX = scrOffsetX - ((greyBoxWidth - healthWidth) / 2)
	local greyBoxOffsetY = (ScrH() - scrOffsetY) - ((greyBoxHeight - healthHeight) / 2)
	
	local armourHeight = ScrH() / 200
	local armourOffsetY = ScrH() - scrOffsetY  - armourHeight
	
	local healthLabelX = scrOffsetX + (healthWidth / 20)
	local healthLabelY = (ScrH() - scrOffsetY) + (healthHeight / 2) - 8
	
	local waterCircleR = healthHeight
	local waterCircleX = greyBoxOffsetX + greyBoxWidth + waterCircleR + (ScrW() / 100)
	local waterCircleY = healthLabelY
	
	local water = LocalPlayer():GetNWInt( 'plyO2');
	local innerWaterCircleMaxR = waterCircleR * 0.8
	local innerWaterR = (innerWaterCircleMaxR / 100) * water
	local innerWaterCircleX = waterCircleX
	local innerWaterCircleY = waterCircleY

-- Health and Armour
	
	draw.RoundedBox(5, greyBoxOffsetX, greyBoxOffsetY, greyBoxWidth, greyBoxHeight, Color(75,75,75,255))
	draw.RoundedBox(5, scrOffsetX, ScrH() - scrOffsetY, health * (healthWidth / 100), healthHeight, Color(255,79,80,220))
	draw.RoundedBox(0, scrOffsetX, armourOffsetY, armor * (healthWidth / 100), armourHeight, Color(255,253,105,255))
	draw.SimpleText("HP:", "Trebuchet18", healthLabelX, healthLabelY, Color(255,255,255,255))
	draw.SimpleText(health, "Trebuchet18", healthLabelX + 20, healthLabelY, Color(255,255,255,255))
	
	surface.SetDrawColor( 75,75, 75, 255 )
	draw.NoTexture()
	-- if the player is inside
	if (state == 0) then
		draw.Circle( waterCircleX, waterCircleY, waterCircleR, 8 )
	else -- if the player is outside
	
		-- If Sprinting
		if (LocalPlayer():KeyDown(IN_SPEED)) then
			draw.Circle( waterCircleX, waterCircleY, waterCircleR, math.sin( CurTime() ) * 6 + 9  )
		else
			draw.Circle( waterCircleX, waterCircleY, waterCircleR, math.sin( CurTime() ) * 5 + 9  )
		end
	end
	
	surface.SetDrawColor( 119,192,216, 255 )
	draw.NoTexture()
	if (state == 0) then
		draw.Circle( innerWaterCircleX, innerWaterCircleY, innerWaterR, 8 )
		draw.SimpleText("O2: "..water.."%", "Trebuchet18", innerWaterCircleX - 12, innerWaterCircleY - 2, Color(255,255,255,255))
	else -- if the player is outside
	
		if (LocalPlayer():KeyDown(IN_SPEED)) then
			draw.Circle( innerWaterCircleX, innerWaterCircleY, innerWaterR, math.sin( CurTime() ) * 6 + 9  )
			draw.SimpleText("O2: "..water.."%--", "Trebuchet18", innerWaterCircleX - 12, innerWaterCircleY - 2, Color(255,0,0,255))
		else
			draw.Circle( innerWaterCircleX, innerWaterCircleY, innerWaterR, math.sin( CurTime() ) * 5 + 9  )
			draw.SimpleText("O2: "..water.."%-", "Trebuchet18", innerWaterCircleX - 12, innerWaterCircleY - 2, Color(255,255,255,255))
		end		
	end

	
-- Resource amounts

	local curMetal = LocalPlayer():GetNWInt( 'plyMetal');
	local curCircuits = LocalPlayer():GetNWInt( 'plyCircuits');
	local curFuel = LocalPlayer():GetNWInt( 'plyFuel');
	local curMoney = LocalPlayer():GetNWInt( 'plyMoney');
	local maxMetal = LocalPlayer():GetNWInt( 'plyMaxMetal');
	local maxCircuits = LocalPlayer():GetNWInt( 'plyMaxCircuits');
	local maxFuel = LocalPlayer():GetNWInt( 'plyMaxFuel');
	local curO2 = LocalPlayer():GetNWInt( 'plyO2Canisters');
	local maxO2 = LocalPlayer():GetNWInt( 'plyMaxO2Canisters');
	draw.SimpleText("O2 Tanks: "..curO2.."/"..maxO2, "Trebuchet18", greyBoxOffsetX, greyBoxOffsetY - 40, Color(119,192,216,255))
	draw.SimpleText("Cash "..ConfigInfo["MarketFog"].Gameplay.CashDisplaySymbol..curMoney, "Trebuchet18", greyBoxOffsetX, greyBoxOffsetY - 60, Color(255,255,255,255))
	draw.SimpleText("Metal: "..curMetal.."/"..maxMetal, "Trebuchet18", greyBoxOffsetX, greyBoxOffsetY - 80, Color(255,255,255,255))
	draw.SimpleText("Circuits: "..curCircuits.."/"..maxCircuits, "Trebuchet18", greyBoxOffsetX, greyBoxOffsetY - 100, Color(255,255,255,255))
	draw.SimpleText("Fuel: "..curFuel.."/"..maxFuel, "Trebuchet18", greyBoxOffsetX, greyBoxOffsetY - 120, Color(255,255,255,255))

	-- Gas tutorial message
	if ((water == 25 or water == 24 or water == 23) and GasMaskTutorialFlag and not LocalPlayer():GetNWBool('plyO2Tut')) then
	
		timer.Create( CurTime().."GasTutorial1", 2, 1, function()
			DisplayHint(HintEnum["GasTutorial1"], 8)
		
			timer.Create( CurTime().."GasTutorial2", 7, 1, function()
				DisplayHint(HintEnum["GasTutorial2"], 8)
				
				timer.Create( CurTime().."GasTutorial3", 7, 1, function()
					GasMaskTutorialFlag = true
					DisplayHint(HintEnum["GasTutorial3"], 8)		
				end )
			end )
		end )
		GasMaskTutorialFlag = false
	elseif (water == 17 and not OxygenWarningTutorialFlag) then
		DisplayHint(HintEnum["OxygenWarning1"], 5)	
		OxygenWarningTutorialFlag = true
		timer.Create( CurTime().."OxygenWarning1", 5, 1, function()
			OxygenWarningTutorialFlag = false		
		end )
	end
	
	
	
-- Cross hair
	local tr = util.TraceLine( {
	start = LocalPlayer():EyePos(),
	endpos = LocalPlayer():EyePos() + LocalPlayer():EyeAngles():Forward() * 100,
	filter = function( ent ) 

		if (ent:GetClass() == "item_hbattery" or ent:GetClass() == "item_hmagnumammo1" or ent:GetClass() == "item_hrifleammo" or
		ent:IsWeapon() or ent:GetClass() == "item_hshotgunammo1" or ent:GetClass() == "item_hsmgammo" or ent:GetClass() == "item_hpistolammo"
		or ent:GetClass() == "item_hcrossbowbolt"or ent:GetClass() == "prop_dynamic" or ent:GetClass() == "oxygen_dispenser" or ent:GetClass() == "item_o2canister" or
		 ent:GetClass() == "item_metal" or ent:GetClass() == "item_circuits" or ent:GetClass() == "item_fuel" or ent:GetClass() == "item_chest"
		 or ent:GetClass() == "oxygen_generator" or ent:GetClass() == "item_money") then

			surface.SetDrawColor( 200, 200, 200, 175 )
			draw.NoTexture()
			draw.Circle( ScrW() / 2, ScrH() / 2, 20, math.sin( CurTime() ) * 5 + 9 )
			
		elseif (ent:GetClass() == "circuit_generator") then
			
			local screen = ent:GetPos():ToScreen() 	
			if (ent:GetNWInt("haspower")) then
				draw.DrawText( "Circuits Generator "..ent:GetNWInt("resourceamount").."/"..ent:GetNWInt("maxresourceamount"), "TargetID", screen.x, screen.y, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
			else
				draw.DrawText( "(NO POWER) Circuits Generator "..ent:GetNWInt("resourceamount").."/"..ent:GetNWInt("maxresourceamount"), "TargetID", screen.x, screen.y, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER ) 
			end	
		elseif (ent:GetClass() == "metal_generator") then
			
			local screen = ent:GetPos():ToScreen() 		
			if (ent:GetNWInt("haspower")) then
				draw.DrawText( "Metal Generator "..ent:GetNWInt("resourceamount").."/"..ent:GetNWInt("maxresourceamount"), "TargetID", screen.x, screen.y, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
			else
				draw.DrawText( "(NO POWER) Metal Generator "..ent:GetNWInt("resourceamount").."/"..ent:GetNWInt("maxresourceamount"), "TargetID", screen.x, screen.y, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
			end
		elseif (ent:GetClass() == "fuel_generator") then
			
			local screen = ent:GetPos():ToScreen() 	
			if (ent:GetNWInt("haspower")) then
				draw.DrawText( "Fuel Generator "..ent:GetNWInt("resourceamount").."/"..ent:GetNWInt("maxresourceamount"), "TargetID", screen.x, screen.y, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
			else
				draw.DrawText( "(NO POWER) Fuel Generator "..ent:GetNWInt("resourceamount").."/"..ent:GetNWInt("maxresourceamount"), "TargetID", screen.x, screen.y, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
			end	
		elseif (ent:GetClass() == "power_generator") then
			
			local screen = ent:GetPos():ToScreen() 	
			
			if (ent:GetPos().z <= LevelData.GasHeight) then
				draw.DrawText( "This must be on the surface to produce power.", "TargetID", screen.x, screen.y, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )			
			else
			
				draw.DrawText( "Power "..ent:GetNWInt("curpower").."/"..ent:GetNWInt("maxpower"), "TargetID", screen.x, screen.y, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )	
			end
		elseif (ent:GetClass() == "oxygen_generator") then
			
			local screen = ent:GetPos():ToScreen() 	
			if (ent:GetNWInt("haspower")) then
				draw.DrawText( "Oxygen Generator", "TargetID", screen.x, screen.y, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
			else
				draw.DrawText( "(NO POWER) Oxygen Generator", "TargetID", screen.x, screen.y, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
			end	
		else
	
			--surface.SetDrawColor( 200, 200, 200, 255 )
			--draw.NoTexture()
			--draw.Circle( ScrW() / 2, ScrH() / 2, 3, 20 )
		end
		
	end

	} )
	
	
	

	
-- Ammo
	
	if LocalPlayer():GetActiveWeapon():IsValid() then --and LocalPlayer():GetActiveWeapon():Clip1() >= 0 then
	
		local clipAmmo = LocalPlayer():GetActiveWeapon():Clip1()  
		local maxClip = LocalPlayer():GetActiveWeapon():GetMaxClip1()
		local reserveAmmo = LocalPlayer():GetAmmoCount( LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType() )
		
		local offsetX = ScrW() - (ScrW() / 10)
		local offsetY = ScrH() - (ScrH() / 10)
		local maxRadius = ScrW() / 30
		local minRadius = ScrW() / 50
		
		local radius = ((maxClip / 45) * (maxRadius - minRadius)) + minRadius;
		
		
		surface.SetDrawColor( 100, 100, 100, 255 )
		draw.NoTexture()
		draw.Circle( offsetX, offsetY, radius * 1.1, (clipAmmo / maxClip) * maxClip + 5 )
		
		surface.SetDrawColor( 255, 221, 60, 255 )
		draw.NoTexture()
		draw.Circle( offsetX, offsetY, (clipAmmo / maxClip) * radius, (clipAmmo / maxClip) * maxClip + 5 )
		
		surface.SetDrawColor( 75, 75, 75, 255 )
		draw.NoTexture()
		draw.Circle( offsetX + maxRadius * 0.8, offsetY + maxRadius * 0.8, maxRadius / 2.2, 5 )
		
		
		draw.SimpleText(clipAmmo, "Trebuchet18", offsetX - 5, offsetY - 8, Color( 	0, 	0, 	0,255));
		draw.SimpleText(reserveAmmo, "Trebuchet18", offsetX - 5  + (maxRadius * 0.8), offsetY - 8 + (maxRadius * 0.8), Color( 	255, 	255, 	255,255));
	
		
	end

-- Draw Scoreboard Map
	
	if (scoreBoardOpen) then

	end

	
-- Draw Compass;
		 
	if (CompassBlipShow.Shop) then CompassBlip(GUIMarkerData.ShopMarker.x, GUIMarkerData.ShopMarker.y, GUIMarkerData.ShopMarker.z, "SHOP", 0, 225, 102) end
	if (CompassBlipShow.O2 and water < 100) then CompassBlip(GUIMarkerData.O2Marker.x, GUIMarkerData.O2Marker.y, GUIMarkerData.O2Marker.z, "OXYGEN", 0, 225, 102) end	 
	if (CompassBlipShow.Airdrop) then CompassBlip(AirdropPos.x, AirdropPos.y, AirdropPos.z, "AIRDROP", 0, 225, 102) end
	if (CompassBlipShow.Quest) then CompassBlip(Questx, Questy, Questz, "QUEST", 0, 225, 102) end
	if (CompassBlipShow.Evac) then CompassBlip(GUIMarkerData.QuestEvacMarker.x, GUIMarkerData.QuestEvacMarker.y, GUIMarkerData.QuestEvacMarker.z, "EVAC", 255, 0, 0) end
	if (CurrentHunterMission.CurrentlyOngoing) then CompassBlip(CurrentHunterMission.Position.x, CurrentHunterMission.Position.y, CurrentHunterMission.Position.z, "HUNT", 0, 225, 102) end

	
	

end
hook.Add("HUDPaint", "MyHudName", HudPaint)
 
 

function HideHud(name)

	for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo", "CHudCrosshair"})do
		if name == v then return false end
	end

	--for k, v in pairs({"CHudHealth", "CHudBattery", "CHudCrosshair", "CHudAmmo", "CHudSecondaryAmmo"})do
	--	if name == v then return false end
	--end
end
hook.Add("HUDShouldDraw", "HideOurHud:D", HideHud)

ClientSelfDestructFlag = false
nextcleantime = 0
function GM:Think()

	if (CurTime() > nextcleantime and not ClientSelfDestructFlag) then
		game.CleanUpMap() 
		nextcleantime = nextcleantime + 300
	end	
end	

scoreBoardOpen = false
function GM:ScoreboardShow() 

	NewNewInventoryMenu()
	InventoryMenuOpen = true
end

function GM:ScoreboardHide() 
	-- Frame
	scoreBoardOpen = false
	InventoryMenuOpen = false
	if (IsValid(WeaponWheelFrame)) then
			WeaponWheelFrame:Close()
	end

	--MapFrame:Hide();

end

function GM:RenderScreenspaceEffects()

	local state = LocalPlayer():GetNWInt( 'plyState')	
	local usingdefaulteffect = LocalPlayer():GetNWBool("plyUseDefaultGasmarkPP")
	local overlayconvar = GetConVar("pp_mat_overlay")
	local overlayrefract = GetConVar("pp_mat_overlay_refractamount")
	
	if state == 1 then
	
		if (usingdefaulteffect) then
			overlayconvar:SetString( "" ) 	
			DrawToyTown( 5, ScrH()/2 )
		else
		
			local health = LocalPlayer():Health()
			local materialname
			local refractamount
			for k, v in pairs(ConfigInfo["MarketFog"].Gameplay.GasMaskPP) do
			
				if (v.HealthThreshold <= health) then	
							
					materialname = v.PPMaterialName
					refractamount = v.PPRefractAmount
					break
				end				
			end
			
			if (materialname == nil) then
				overlayconvar:SetString( "" ) 	
				DrawToyTown( 5, ScrH()/2 )
			else
				overlayconvar:SetString( materialname ) 
				overlayrefract:SetFloat(refractamount)
			end
				
		end
		
	elseif (not usingdefaulteffect) then	
	
		overlayconvar:SetString( "" ) 	
	end

end
 
 --.
 