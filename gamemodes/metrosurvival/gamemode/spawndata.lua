----------------------------------
--	Market Fog	
--	Programmer : LIFO/Tednesday		
--	Date : 15/10/2018		
----------------------------------

-- Spawn Chances.

HintEnum={}
HintEnum["Test"] = 1
HintEnum["Help"] = 2
HintEnum["Intro1"] = 3
HintEnum["Intro2"] = 4
HintEnum["Intro3"] = 5
HintEnum["Intro4"] = 6
HintEnum["ShopIntro1"] = 7
HintEnum["ShopIntro2"] = 8
HintEnum["ShopIntro3"] = 9
HintEnum["GasTutorial1"] = 10
HintEnum["GasTutorial2"] = 11
HintEnum["GasTutorial3"] = 12
HintEnum["EntityDamageTutorial1"] = 13
HintEnum["NPCDamageTutorial1"] = 14
HintEnum["QuestTutorial1"] = 15
HintEnum["DyingTutorial1"] = 16
HintEnum["InventoryTutorial1"] = 17
HintEnum["SpawnPropTutorial1"] = 18
HintEnum["PhysgunTutorial1"] = 19
HintEnum["AmmoWarning1"] = 20
HintEnum["OxygenWarning1"] = 21
HintEnum["SafeZoneTutorial1"] = 22
HintEnum["LeavingSafeZoneTutorial1"] = 23
HintEnum["SprintAdvise"] = 24

HintTable={}
HintTable[HintEnum["Test"]] = "This is a test hint!"
HintTable[HintEnum["Help"]] = "Welcome to Market Fog! After a deadly chemical attack you and your fellow survivors have been forced to survive underground!"
HintTable[HintEnum["Intro1"]] = "The surface has been rendered uninhabitable without the use of suitable breathing equipment."
HintTable[HintEnum["Intro2"]] = "You'll need to scour the environment for useful items, particularly O2 tanks if you want to find a way to finally escape!"
HintTable[HintEnum["Intro3"]] = "You need money. You'll be rewarded for completing QUESTs or by selling resource commodities at the SHOP. These commodities will fluctuate in price."
HintTable[HintEnum["Intro4"]] = "If you're thinking of venturing to the surface, don't forget to replenish your OXYGEN at the OXYGEN dispenser."
HintTable[HintEnum["ShopIntro1"]] = "You can buy and sell items and resources in the SHOP."
HintTable[HintEnum["ShopIntro2"]] = "Upgrade your Apparel to carry more useful items and resources."
HintTable[HintEnum["ShopIntro3"]] = "Resources can be bought and sold at the Market. Prices will fluctuate based on their supply."
HintTable[HintEnum["GasTutorial1"]] = "You can refill your current Oxygen if you have a spare O2 tank to use."
HintTable[HintEnum["GasTutorial2"]] = "Hold down the RELOAD button until you hear a click, then let go of the RELOAD button to refill your Oxygen"
HintTable[HintEnum["GasTutorial3"]] = "Make sure you pay attention to your Oxygen levels and the amount of O2 tanks while on the surface."
HintTable[HintEnum["EntityDamageTutorial1"]] = "All spawnable entities can be destroyed with enough damage!"
HintTable[HintEnum["NPCDamageTutorial1"]] = "Killing enemies rewards you with Cash($). Hunting rare or very dangerous NPC's will reward you with large sums of money."
HintTable[HintEnum["QuestTutorial1"]] = "Completing QUESTs will net you a Cash("..ConfigInfo["MarketFog"].Gameplay.CashDisplaySymbol..") reward along with additional information about the City."
HintTable[HintEnum["DyingTutorial1"]] = "Don't die. Dying removes all your ammo, weapons and items as well as halving your available Cash("..ConfigInfo["MarketFog"].Gameplay.CashDisplaySymbol..")"
HintTable[HintEnum["InventoryTutorial1"]] = "Press TAB to access your inventory. Here you can view ammo, drop weapons and craft items. Click on the weapon's icon to drop a weapon."
HintTable[HintEnum["SpawnPropTutorial1"]] = "Spawning props costs METAL. Any props spawned can also be destroyed if they sustain sufficient damage."
HintTable[HintEnum["PhysgunTutorial1"]] = "Using a Physgun on an unowned prop will set you as the owner. This means only you can freeze and move this prop."
HintTable[HintEnum["AmmoWarning1"]] = "Ammo is rare but most importantly it's expensive. Sometimes it's better to avoid a fight rather than waste precious ammo."
HintTable[HintEnum["OxygenWarning1"]] = "You are dangerously low on Oxygen!"
HintTable[HintEnum["SafeZoneTutorial1"]] = "While in the Safe Zone, yourself and other players are unable to take damage."
HintTable[HintEnum["LeavingSafeZoneTutorial1"]] = "You have left the Safe Zone. This means you can take damage. Especially from other players!"
HintTable[HintEnum["SprintAdvise"]] = "Sprinting causes you intake more O2 from your oxygen tank! Be careful!"
--.