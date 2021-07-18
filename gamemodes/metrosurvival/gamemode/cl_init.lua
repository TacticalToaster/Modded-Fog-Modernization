----------------------------------
--	Market Fog	
--	Programmer : LIFO/Tednesday		
--	Date : 15/10/2018		
----------------------------------

include( "shared.lua" )
include("cl_net.lua")
include ("cl_inventory.lua")
include ("cl_quest1.lua")
include ("cl_misc.lua")
include ("cl_gm.lua")
include ("cl_shapes.lua")

Questx = 0
Questy = 0
Questz = 0

AirdropPos = Vector(0, 0, 0)

Metal = {}
Metal["Price"] = 5
Metal["Supply"] = 2000

Circuits = {}
Circuits["Price"] = 50
Circuits["Supply"] = 1000

Fuel = {}
Fuel["Price"] = 150
Fuel["Supply"] = 500

LevelData={}
GUIMarkerData={}
CurrentHunterMission={}
KeyCodes={}


-- Recieve all the level data
net.Receive("SendLevelDataTable", function(len, ply)    
	LevelData = net.ReadTable() 
end)

-- Recieve client marker data.
net.Receive("SendClientGUIMarkerTable", function(len, ply)    
	GUIMarkerData = net.ReadTable() 
end)

-- Recieve Hunter Mission Data.
net.Receive("SendCurrentHunterMission", function(len, ply)    
	CurrentHunterMission = net.ReadTable() 	
end)

-- Recieve Key Code Data.
net.Receive("SendKeyCodes", function(len, ply)    
	KeyCodes = net.ReadTable() 
end)

-- Start gas mask sound
net.Receive("GasMaskSoundStart", function(len, ply)
     surface.PlaySound("gasmask1.wav")	 
end)
  
-- Update global resource prices.
net.Receive("UpdateResource", function(len, ply)
     
	 Metal["Price"] = net.ReadUInt( 32 ) 
	 Metal["Supply"] = net.ReadUInt( 32 ) 
	 Circuits["Price"] = net.ReadUInt( 32 ) 
	 Circuits["Supply"] = net.ReadUInt( 32 ) 
	 Fuel["Price"] = net.ReadUInt( 32 ) 
	 Fuel["Supply"] = net.ReadUInt( 32 ) 
end)
 

-- Update airdrop position
net.Receive("UpdateAirdrop", function(len, ply)
     
	 AirdropPos = net.ReadVector()
	print(AirdropPos)
end)

-- Update config info.
ConfigInfo = {}
ConfigInfo["MarketFog"] = { Gameplay = {}, Weapon = {}, Apparel = {}, PurchaseItems = {}}

net.Receive("SendConfigInfo_Gameplay", function(len, ply)    
	ConfigInfo["MarketFog"].Gameplay = net.ReadTable() 
end)

net.Receive("SendConfigInfo_Weapons", function(len, ply)    
	ConfigInfo["MarketFog"].Weapon = net.ReadTable() 
end)

net.Receive("SendConfigInfo_Apparel", function(len, ply)    
	ConfigInfo["MarketFog"].Apparel = net.ReadTable() 
end)

net.Receive("SendConfigInfo_Items", function(len, ply)    
	ConfigInfo["MarketFog"].PurchaseItems = net.ReadTable() 
end)

function MF_StartRain()

	if (LocalPlayer():GetNWBool("plyEnableWeather")) then
		RunConsoleCommand( "pp_rain_splash", "0" ) 
		RunConsoleCommand( "pp_rain_radius", "256" )
		RunConsoleCommand( "pp_rain_magnitude", "80" ) 	
		RunConsoleCommand( "pp_tickrate", "0.28" ) 
		RunConsoleCommand( "pp_rain", "1" ) 
	end
end
concommand.Add( "mf_start_rain", MF_StartRain, nil, "Starts the rain storm for the client") 

function MF_EndRain()

	if (LocalPlayer():GetNWBool("plyEnableWeather")) then
		RunConsoleCommand( "pp_rain", "0" ) 
		RunConsoleCommand( "pp_tickrate", "1.0" ) 
		RunConsoleCommand( "pp_rain_magnitude", "0" ) 	
		RunConsoleCommand( "pp_rain_radius", "0" )
	end
end
concommand.Add( "mf_end_rain", MF_EndRain, nil, "Ends the rain storm for the client") 

--.