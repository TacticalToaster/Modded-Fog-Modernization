----------------------------------
--	Market Fog	
--	Programmer : LIFO/Tednesday		
--	Date : 15/10/2018		
----------------------------------
				 

LabDeniedkeypad =  "<booting...> \n\z
					<...> \n\z
					<...> \n\z
					<...> \n\z
				   <entry has been denied. lab is without power.>"

							 

							 
Labkeypad =  "<booting...> \n\z
					<...> \n\z
					<...> \n\z
					<...> \n\z
				   <enter encryption keycode to verify authenticity>"

QuestTutorialFlag = false
				   
function IntroMenu()

local Quest0SubwayTerminal

	if (LevelData.CityRuinsFlag == 1) then
	Quest0SubwayTerminal = "To anyone unlucky enough to read this. \n\n\z
								 I write this as the last surviving member of our research group.\n\n\z
								 I knew we'd made a mistake. When the bombs fell a part of me, deep down, knew it was the end. \n\z
								 I just hoped to God that it wouldn't be like this. Stuck in the dark, trapped in the tunnels like a rat. \n\n\z
								 We aren't and weren't survivors. That much is clear to me now. Even though we could synthesize our own \n\z
								 oxygen and had access to the network's commercial dispenser we just couldn't hack it on the surface. \n\z
								 Anna, John, Graham...all of them dead or missing. \n\n\z
								 We had a chance to make a home here. Put up lights and erect shelter.\n\z
								 But now with Jeff gone, we can't finish what we started. \n\n\z
								 I shouldn't have been so hard on him. He seems so fixated on stopping us at every hurdle, but he doesn't realise \n\z
								 that everything has changed. \n\z
								 I have the second encryption key. That means he'll have to come back if he knows what's good for him. \n\n\z
								 Where could he have gone? Maybe I should data mine his old subway terminal? \n\z
								 If I can just make it to the end of this tunnel then we might all still have a chance... \n\n\z
								 - Bill (0x"..bit.tohex( KeyCodes["BillKey"] )..")" 
	else
	Quest0SubwayTerminal = "To anyone unlucky enough to read this. \n\n\z
								 I write this as the last surviving member of our research group.\n\n\z
								 I knew we'd made a mistake. When the bombs fell a part of me, deep down, knew it was the end. \n\z
								 I just hoped to God that it wouldn't be like this. Stuck in the dark, trapped in the basement like a rat. \n\n\z
								 We aren't and weren't survivors. That much is clear to me now. Even though we could synthesize our own \n\z
								 oxygen and had access to the network's commercial dispenser we just couldn't hack it on the surface. \n\z
								 Anna, John, Graham...all of them dead or missing. \n\n\z
								 We had a chance to make a home here. Put up lights and erect shelter.\n\z
								 But now with Jeff gone, we can't finish what we started. \n\n\z
								 I shouldn't have been so hard on him. He seems so fixated on stopping us at every hurdle, but he doesn't realise \n\z
								 that everything has changed. \n\z
								 I have the second encryption key. That means he'll have to come back if he knows what's good for him. \n\n\z
								 Where could he have gone? Maybe I should data mine his old terminal? \n\z
								 - Bill (0x"..bit.tohex( KeyCodes["BillKey"] )..")" 
	end

	if (not QuestTutorialFlag) then
		DisplayHint(HintEnum["QuestTutorial1"], 12)
		QuestTutorialFlag = true
	end
							 
	local queststage = 	LocalPlayer():GetNWInt( 'plyQuestStage')
	if (queststage == 0) then
		RunConsoleCommand("increment_quest", 1)
		Questx = GUIMarkerData.QuestSubwayMarker.x
		Questy = GUIMarkerData.QuestSubwayMarker.y
		Questz = GUIMarkerData.QuestSubwayMarker.z
	end	

	local gridX = frameW / 10
	local gridY = frameH / 10
	local gridW = frameW - (2 * gridX)
	local gridH = frameH - (2 * gridY)
		
	local Frame = vgui.Create( "DFrame" )
	Frame:SetTitle( "Bill's Terminal" )
	Frame:SetSize( frameW, frameH )
	Frame:Center()
	Frame:MakePopup()
	Frame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
		draw.RoundedBox( 0, 0, 0, w, h, Color( 60, 60, 60, 150 ) ) -- Draw a red box instead of the frame
		draw.DrawText( Quest0SubwayTerminal, "HudHintTextLarge", gridX, gridY, Color( 0, 225, 102, 230 ), TEXT_ALIGN_LEFT )
	end
end 
net.Receive("MFQuestIntro", IntroMenu )							 

function TerminalSubwayMenu()

	local Quest1SubwayTerminal

	if (LevelData.CityRuinsFlag == 1) then
		Quest1SubwayTerminal = "I knew we were too late. The shelling took us by complete surprise. \n\z  
                 		     It was too soon, none of us expected it. We tried to get as many people down \n\z
						     into the subway as soon possible, as per protocol, but by the time we had mobilised \n\z
						     the surface was pretty much uninhabitable. All those people. Dead. \n\n\z
							 We didn't have the time to perfect it. If the others hadn't... \n\z
							 There's no point dwelling on the past. If I can find Anna's old logs, I might be able to put all of this to bed. \n\z
							 Before the bombs went off she was stationed at her research facility on 5th street. Maybe I should try looking there? \n\n\z
							 I need to leave. It's selfish but it's the only chance everyone has. If I can just remove the grate \n\z
							 below my feet I can escape through the sewer tunnels. If you are reading this...I know what did. \n\n\n\z
							 Signing off. \n\z
							 \tDr Jeff. "		
	else
		Quest1SubwayTerminal = "I knew we were too late. The shelling took us by complete surprise. \n\z
                 		     It was too soon, none of us expected it. We tried to get as many people down \n\z
						     into the bunker as soon as possible, as per protocol, but by the time we had mobilised \n\z
						     the surface was pretty much uninhabitable. All those people. Dead. \n\n\z
							 We didn't have the time to perfect it. If the others hadn't... \n\z
							 There's no point dwelling on the past. If I can find Anna's old logs, I might be able to put all of this to bed. \n\z
							 Before the bombs went off her and the others were stuck at the gas station getting fuel. Maybe I should try looking there? \n\n\z
							 I need to leave. It's selfish but it's the only chance everyone has. If I can just remove the grate \n\z
							 Signing off. \n\z
							 \tDr Jeff. "	
	end

	local queststage = 	LocalPlayer():GetNWInt( 'plyQuestStage')
	if (queststage == 1) then
		RunConsoleCommand("increment_quest", 2)
		Questx = GUIMarkerData.QuestStreetMarker.x
		Questy = GUIMarkerData.QuestStreetMarker.y
		Questz = GUIMarkerData.QuestStreetMarker.z
	end
							 
	local gridX = frameW / 10
	local gridY = frameH / 10
	local gridW = frameW - (2 * gridX)
	local gridH = frameH - (2 * gridY)
		
	local Frame = vgui.Create( "DFrame" )
	Frame:SetTitle( "Jeff's Terminal" )
	Frame:SetSize( frameW, frameH )
	Frame:Center()
	Frame:MakePopup()
	Frame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
		draw.RoundedBox( 0, 0, 0, w, h, Color( 60, 60, 60, 150 ) ) -- Draw a red box instead of the frame
		draw.DrawText( Quest1SubwayTerminal, "HudHintTextLarge", gridX, gridY, Color( 0, 225, 102, 230 ), TEXT_ALIGN_LEFT )
	end
end 
net.Receive("MFQuestSubway", TerminalSubwayMenu )	

function TerminalStreetMenu()

	local Quest2StreetTerminal

	if (LevelData.CityRuinsFlag == 1) then
		Quest2StreetTerminal = "This is Anna (0x"..bit.tohex( KeyCodes["AnnaKey"] )..") The bombs are falling now. I'm hoping this building will hold out. \n\z
							 I should be close enough to the subway that I shouldn't be effected by it. I just need to wait it out. \n\n\z
							 I need to start thinking about myself now. Otherwise I'm not going to make it. The soldiers look terrified \n\z
							 They've heard the stories. Their willingness to tear an area apart. The way they use fear as a weapon. \n\z
							 I just didn't expect a Combine attack to happen this soon. We still have a chance if I can find the others. \n\n\z
							 I'm still tracking Graham's terminal. When this blows over I'll head down to the subway and if that doesn't work \n\z
							 I can still find Graham."	
	else
		Quest2StreetTerminal = "This is Anna (0x"..bit.tohex( KeyCodes["AnnaKey"] )..") The bombs are falling now. I'm hoping this building will hold out. \n\z
							 I should be close enough to the bunker that I should be able to make it. I just need to wait it out. \n\n\z
							 I need to start thinking about myself now. The soldiers look terrified \n\z
							 They've heard the stories. Their willingness to tear an area apart. The way they use fear as a weapon. \n\z
							 I just didn't expect a Combine attack to happen this soon. We still have a chance if I can find the others. \n\n\z
							 I'm still tracking Graham's terminal. When this blows over I'll head down to the bunker and if that doesn't work \n\z
							 I can still find Graham."	
	end

	local queststage = 	LocalPlayer():GetNWInt( 'plyQuestStage')
	if (queststage == 2) then
		RunConsoleCommand("increment_quest", 3)
		Questx = GUIMarkerData.QuestParkingMarker.x
		Questy = GUIMarkerData.QuestParkingMarker.y
		Questz = GUIMarkerData.QuestParkingMarker.z
	end
	
	local gridX = frameW / 10
	local gridY = frameH / 10
	local gridW = frameW - (2 * gridX)
	local gridH = frameH - (2 * gridY)
		
	local Frame = vgui.Create( "DFrame" )
	Frame:SetTitle( "Anna's Terminal" )
	Frame:SetSize( frameW, frameH )
	Frame:Center()
	Frame:MakePopup()
	Frame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
		draw.RoundedBox( 0, 0, 0, w, h, Color( 60, 60, 60, 150 ) ) -- Draw a red box instead of the frame
		draw.DrawText( Quest2StreetTerminal, "HudHintTextLarge", gridX, gridY, Color( 0, 225, 102, 230 ), TEXT_ALIGN_LEFT )
	end
end 
net.Receive("MFQuestStreet", TerminalStreetMenu )	

function TerminalParkingMenu()

	local Quest3ParkingTerminal

	if (LevelData.CityRuinsFlag == 1) then
		Quest3ParkingTerminal = "I finally found it! Thank God! I knew Graham hadn't lost his encryption key. Yet he was so adamant that he had. \n\z
                             I've made a copy, (0x"..bit.tohex( KeyCodes["GrahamKey"])..") so that I've got a clear backup of the third encryption key on record. \n\z
							 It's a shame I had to do what I had to do. Why can't the others see that this is the only way? \n\n\z
							 Especially Anna. She shouldn't have left. Once she found out I had taken it, she should have been happy. Not angry \n\z
							 It is simply safer in my hands. \n\n\z
							 John is calling me. Seems like he needs some help at the grocery store. Maybe I can convince him to see things my \n\z
							 way?"
	else
		Quest3ParkingTerminal = "I finally found it! Thank God! I knew Graham hadn't lost his encryption key. Yet he was so adamant that he had. \n\z
                             I've made a copy, (0x"..bit.tohex( KeyCodes["GrahamKey"] )..") so that I've got a clear backup of the third encryption key on record. \n\z
							 It's a shame I had to do what I had to do. Why can't the others see that this is the only way? \n\n\z
							 Especially Anna. She shouldn't have left. Once she found out I had taken it, she should have been happy. Not angry \n\z
							 It is simply safer in my hands. \n\n\z
							 John is calling me. Seems like he needs some help at the grocery store. Maybe I can convince him to see things my \n\z
							 way?"
	end

	local queststage = 	LocalPlayer():GetNWInt( 'plyQuestStage')
	if (queststage == 3) then
		RunConsoleCommand("increment_quest", 4)
		Questx = GUIMarkerData.QuestShopMarker.x
		Questy = GUIMarkerData.QuestShopMarker.y
		Questz = GUIMarkerData.QuestShopMarker.z
	end
	
	local gridX = frameW / 10
	local gridY = frameH / 10
	local gridW = frameW - (2 * gridX)
	local gridH = frameH - (2 * gridY)
		
	local Frame = vgui.Create( "DFrame" )
	Frame:SetTitle( "Bill's Terminal" )
	Frame:SetSize( frameW, frameH )
	Frame:Center()
	Frame:MakePopup()
	Frame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
		draw.RoundedBox( 0, 0, 0, w, h, Color( 60, 60, 60, 150 ) ) -- Draw a red box instead of the frame
		draw.DrawText( Quest3ParkingTerminal, "HudHintTextLarge", gridX, gridY, Color( 0, 225, 102, 230 ), TEXT_ALIGN_LEFT )
	end
end 
net.Receive("MFQuestParking", TerminalParkingMenu )	

function TerminalShopMenu()

	local Quest4ShopTerminal
				 
	if (LevelData.CityRuinsFlag == 1) then
		Quest4ShopTerminal =  "My time is short. There is no way Bill can get to me before I bleed to death.\n\z
                             I don't know why Anna left. Was it to stop us from going through with it? \n\z
							 With the amount of evacuees below ground and survivors still up top there isn't a better opportunity. \n\z
							 The Combine won't know what hit them. \n\n\z
							 Who am I kidding? Anna's too soft. For godsake, she chose to be last so when it came to a vote we'd already know the outcome before \n\z
							 she had to burden herself with the responsibility. \n\z
							 If only I hadn't lost my key at the plaza. We'll need some serious fire power to break down those Combine defences. \n\z
							 Well, not me...\n\n\z
							 Fuck the Combine. I hope to God we can beat them...\n\n\z
							 - John (0x"..bit.tohex( KeyCodes["JohnKey"] )..")"
	else
		Quest4ShopTerminal =  "My time is short. There is no way Bill can get to me before I bleed to death.\n\z
                             I don't know why Anna left. Was it to stop us from going through with it? \n\z
							 With the amount of evacuees below ground and survivors still up top there isn't a better opportunity. \n\z
							 The Combine won't know what hit them. \n\n\z
							 Who am I kidding? Anna's too soft. For godsake, she chose to be last so when it came to a vote we'd already know the outcome before \n\z
							 she had to burden herself with the responsibility. \n\z
							 If only I hadn't lost my key running from the combine at the power station. We'll need some serious fire power to break down those Combine defences. \n\z
							 Well, not me...\n\n\z
							 Fuck the Combine. I hope to God we can beat them...\n\n\z
							 - John (0x"..bit.tohex( KeyCodes["JohnKey"] )..")"
	end
							 
	local queststage = 	LocalPlayer():GetNWInt( 'plyQuestStage')
	if (queststage == 4) then
		RunConsoleCommand("increment_quest", 5)
		Questx = GUIMarkerData.QuestPlazaMarker.x
		Questy = GUIMarkerData.QuestPlazaMarker.y
		Questz = GUIMarkerData.QuestPlazaMarker.z
	end

	local gridX = frameW / 10
	local gridY = frameH / 10
	local gridW = frameW - (2 * gridX)
	local gridH = frameH - (2 * gridY)
		
	local Frame = vgui.Create( "DFrame" )
	Frame:SetTitle( "John's Terminal" )
	Frame:SetSize( frameW, frameH )
	Frame:Center()
	Frame:MakePopup()
	Frame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
		draw.RoundedBox( 0, 0, 0, w, h, Color( 60, 60, 60, 150 ) ) -- Draw a red box instead of the frame
		draw.DrawText( Quest4ShopTerminal, "HudHintTextLarge", gridX, gridY, Color( 0, 225, 102, 230 ), TEXT_ALIGN_LEFT )
	end
end 
net.Receive("MFQuestShop", TerminalShopMenu )	

function TerminalPlazaMenu()

	local Quest5PlazaTerminal

	if (LevelData.CityRuinsFlag == 1) then
		Quest5PlazaTerminal =  "I know you strangled Graham to death. Was it worth it? \n\n\z
							 By the time you get here the Combine will have completely fortified this position. Even if you're reading this \n\z
							 you'll still have to find me to get the first encryption key. There is no way I'm letting you gain access to the rest of the chemical. \n\z
							 It's completely untested. Releasing it now would be catastrophic. Do you have any idea the level of mayhem you'll cause? \n\z
							 We are talking about a massive amount of stable, genetic alteration at a cellular level in a way none of us comprehend. \n\n\z
							 Is that an acceptable risk to save a city that has already been pounded into ruin? \n\n \z
							 If what Anna said is true then we need to talk. Why the hell did you expose yourself to our only sample? You need\n\z
							 immediate medical attention. God forbid if it's true, I'll know you'll have no problem dealing with the Combine.\n\n\z
							 If you know what's good for you then meet me in the apartment across the street. \n\n\z
							 - Jeff"
	else
		Quest5PlazaTerminal =  "I know you strangled Graham to death. Was it worth it? \n\n\z
							 By the time you get here the Combine will have completely fortified this position. Even if you're reading this \n\z
							 you'll still have to find me to get the first encryption key. There is no way I'm letting you gain access to the rest of the chemical. \n\z
							 It's completely untested. Releasing it now would be catastrophic. Do you have any idea the level of mayhem you'll cause? \n\z
							 We are talking about a massive amount of stable, genetic alteration at a cellular level in a way none of us comprehend. \n\n\z
							 Is that an acceptable risk to save all of us? \n\n \z
							 If what Anna said is true then we need to talk. Why the hell did you expose yourself to our only sample? You need\n\z
							 immediate medical attention. God forbid if it's true, I'll know you'll have no problem dealing with the Combine.\n\n\z
							 If you know what's good for you then meet me in the apartment across the street. \n\n\z
							 - Jeff"
	end


	local queststage = 	LocalPlayer():GetNWInt( 'plyQuestStage')
	if (queststage == 5) then
		RunConsoleCommand("increment_quest", 6)
		Questx = GUIMarkerData.QuestApartmentMarker.x
		Questy = GUIMarkerData.QuestApartmentMarker.y
		Questz = GUIMarkerData.QuestApartmentMarker.z
	end

	local gridX = frameW / 10
	local gridY = frameH / 10
	local gridW = frameW - (2 * gridX)
	local gridH = frameH - (2 * gridY)
		
	local Frame = vgui.Create( "DFrame" )
	Frame:SetTitle( "Jeff's Plaza Terminal" )
	Frame:SetSize( frameW, frameH )
	Frame:Center()
	Frame:MakePopup()
	Frame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
		draw.RoundedBox( 0, 0, 0, w, h, Color( 60, 60, 60, 150 ) ) -- Draw a red box instead of the frame
		draw.DrawText( Quest5PlazaTerminal, "HudHintTextLarge", gridX, gridY, Color( 0, 225, 102, 230 ), TEXT_ALIGN_LEFT )
	end
end 
net.Receive("MFQuestPlaza", TerminalPlazaMenu )	


function TerminalApartmentMenu()

	local Quest6ApartmentTerminal

	if (LevelData.CityRuinsFlag == 1) then
		Quest6ApartmentTerminal =  "<username: drj key: 0x"..bit.tohex( KeyCodes["JeffKey"] ).."> \n\z
							<this recording has been audio transcribed> \n\n\z
							 Man: ... \n\z
							 Man: ...Bill is that you?\n\z
							 <unintelligible garble> \n \z
							 Man: Oh my god what's happened to you?...You..you need immediate medical attention- \n\z
							 Unknown: Arghhggh <unintelligible> - help me-\n\z
							 Man: Stand back, stay where you are I can't help you if- \n\z
							 Unknown: <screaming> HEL..HELP ME! \n\z
							 Man: Stop! Don't come any clos- No Stop! What are you doing? Sto- \n\z
							 Unknown: arrghgh \n\z
							 Man: JESUS! Help me please don't <unintelligible> ARHGHHHAHHF - <crack> - \n\z
							 ... \n\z
							 ... \n\z
							 <this audio transcription has now ended>"
	else
		Quest6ApartmentTerminal =  "<username: drj key: 0x"..bit.tohex( KeyCodes["JeffKey"] ).."> \n\z
							<this recording has been audio transcribed> \n\n\z
							 Man: ... \n\z
							 Man: ...Bill is that you?\n\z
							 <unintelligible garble> \n \z
							 Man: Oh my god what's happened to you?...You..you need immediate medical attention- \n\z
							 Unknown: Arghhggh <unintelligible> - help me-\n\z
							 Man: Stand back, stay where you are I can't help you if- \n\z
							 Unknown: <screaming> HEL..HELP ME! \n\z
							 Man: Stop! Don't come any clos- No Stop! What are you doing? Sto- \n\z
							 Unknown: arrghgh \n\z
							 Man: JESUS! Help me please don't <unintelligible> ARHGHHHAHHF - <crack> - \n\z
							 ... \n\z
							 ... \n\z
							 <this audio transcription has now ended>"
	end
	
	local queststage = 	LocalPlayer():GetNWInt( 'plyQuestStage')
	if (queststage == 6) then
		RunConsoleCommand("increment_quest", 7)
	end

	local gridX = frameW / 10
	local gridY = frameH / 10
	local gridW = frameW - (2 * gridX)
	local gridH = frameH - (2 * gridY)
		
	local Frame = vgui.Create( "DFrame" )
	Frame:SetTitle( "Jeff's Terminal" )
	Frame:SetSize( frameW, frameH )
	Frame:Center()
	Frame:MakePopup()
	Frame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
		draw.RoundedBox( 0, 0, 0, w, h, Color( 60, 60, 60, 150 ) ) -- Draw a red box instead of the frame
		draw.DrawText( Quest6ApartmentTerminal, "HudHintTextLarge", gridX, gridY, Color( 0, 225, 102, 230 ), TEXT_ALIGN_LEFT )
	end
end 
net.Receive("MFQuestApartment", TerminalApartmentMenu )	


function KeypadMenu()

	-- This stuff is pretty easy to cheat so please don't!!

	local choicemade = GetGlobalInt("LabChoiceMade") 

	if (choicemade == 0) then

		local jeffkey = tostring(KeyCodes["JeffKey"])
		local billkey = tostring(KeyCodes["BillKey"])
		local grahamkey = tostring(KeyCodes["GrahamKey"])
		local johnkey = tostring(KeyCodes["JohnKey"])
		local annakey = tostring(KeyCodes["AnnaKey"])

		local passcode = jeffkey .. billkey .. grahamkey .. johnkey .. annakey
		
		local gridX = frameW / 10
		local gridY = frameH / 10
		local gridW = frameW - (2 * gridX)
		local gridH = frameH - (2 * gridY)
			
		local Frame = vgui.Create( "DFrame" )
		Frame:SetTitle( "Lab Keypad" )
		Frame:SetSize( frameW, frameH )
		Frame:Center()
		Frame:MakePopup()
		Frame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
			draw.RoundedBox( 0, 0, 0, w, h, Color( 60, 60, 60, 220 ) ) -- Draw a red box instead of the frame
			draw.DrawText( Labkeypad, "HudHintTextLarge", gridX, gridY, Color( 0, 225, 102, 230 ), TEXT_ALIGN_LEFT )
			-- draw.DrawText( passcode, "HudHintTextLarge", gridX, gridY + 150, Color( 0, 225, 102, 230 ), TEXT_ALIGN_LEFT )
			--	draw.DrawText( jeffkey, "HudHintTextLarge", gridX, gridY + 180, Color( 0, 225, 102, 230 ), TEXT_ALIGN_LEFT )
			--		draw.DrawText( billkey, "HudHintTextLarge", gridX, gridY + 210, Color( 0, 225, 102, 230 ), TEXT_ALIGN_LEFT )
			--			draw.DrawText( grahamkey, "HudHintTextLarge", gridX, gridY + 240, Color( 0, 225, 102, 230 ), TEXT_ALIGN_LEFT )
			--				draw.DrawText( johnkey, "HudHintTextLarge", gridX, gridY + 270, Color( 0, 225, 102, 230 ), TEXT_ALIGN_LEFT )
			--					draw.DrawText( annakey, "HudHintTextLarge", gridX, gridY + 300, Color( 0, 225, 102, 230 ), TEXT_ALIGN_LEFT )
		end
		
		local buttonStartX = frameW / 3
		local buttonStartY = frameH / 2
		local buttonGridWidth = frameW - (2 * buttonStartX)
		local buttonGridHeight = frameH / 3
		
		local grid = vgui.Create( "DGrid", Frame )
		grid:SetPos( buttonStartX, buttonStartY )
		grid:SetCols( 3 )
		grid:SetColWide( buttonGridWidth / 3 )
		grid:SetRowHeight( buttonGridHeight / 4 )
			
		local TextEntry = vgui.Create( "DTextEntry", Frame ) -- create the form as a child of frame
		TextEntry:SetPos( buttonStartX, buttonStartY - 80 )
		TextEntry:SetSize( buttonGridWidth, 60 )
		TextEntry:SetNumeric( true )

		--/TextEntry.OnEnter = function( self )	
		--/end
			
		local DermaButton = vgui.Create( "DButton", Frame ) -- Create the button and parent it to the frame
		DermaButton:SetText( "1" )					-- Set the text on the button
		DermaButton:SetSize( buttonGridWidth / 4, buttonGridHeight / 5 )					-- Set the size
		DermaButton.DoClick = function()				-- A custom function run when clicked ( note the . instead of : )
			surface.PlaySound( "buttons/button1.wav" )
			TextEntry:SetValue(TextEntry:GetValue()..1)
		end
		grid:AddItem(DermaButton)
		
			local DermaButton = vgui.Create( "DButton", Frame ) -- Create the button and parent it to the frame
		DermaButton:SetText( "2" )					-- Set the text on the button
		DermaButton:SetSize( buttonGridWidth / 4, buttonGridHeight / 5 )					-- Set the size
		DermaButton.DoClick = function()				-- A custom function run when clicked ( note the . instead of : )
			surface.PlaySound( "buttons/button1.wav" )
			TextEntry:SetValue(TextEntry:GetValue()..2)
		end
		grid:AddItem(DermaButton)
		
			local DermaButton = vgui.Create( "DButton", Frame ) -- Create the button and parent it to the frame
		DermaButton:SetText( "3" )					-- Set the text on the button
		DermaButton:SetSize( buttonGridWidth / 4, buttonGridHeight / 5 )					-- Set the size
		DermaButton.DoClick = function()				-- A custom function run when clicked ( note the . instead of : )
			surface.PlaySound( "buttons/button1.wav" )
			TextEntry:SetValue(TextEntry:GetValue()..3)
		end
		grid:AddItem(DermaButton)
		
		
			local DermaButton = vgui.Create( "DButton", Frame ) -- Create the button and parent it to the frame
		DermaButton:SetText( "4" )					-- Set the text on the button
		DermaButton:SetSize( buttonGridWidth / 4, buttonGridHeight / 5 )					-- Set the size
		DermaButton.DoClick = function()				-- A custom function run when clicked ( note the . instead of : )
			surface.PlaySound( "buttons/button1.wav" )
			TextEntry:SetValue(TextEntry:GetValue()..4)
		end
		grid:AddItem(DermaButton)
		
		
			local DermaButton = vgui.Create( "DButton", Frame ) -- Create the button and parent it to the frame
		DermaButton:SetText( "5" )					-- Set the text on the button
		DermaButton:SetSize( buttonGridWidth / 4, buttonGridHeight / 5 )					-- Set the size
		DermaButton.DoClick = function()				-- A custom function run when clicked ( note the . instead of : )
			surface.PlaySound( "buttons/button1.wav" )
			TextEntry:SetValue(TextEntry:GetValue()..5)
		end
		grid:AddItem(DermaButton)
		
		
			local DermaButton = vgui.Create( "DButton", Frame ) -- Create the button and parent it to the frame
		DermaButton:SetText( "6" )					-- Set the text on the button
		DermaButton:SetSize( buttonGridWidth / 4, buttonGridHeight / 5 )					-- Set the size
		DermaButton.DoClick = function()				-- A custom function run when clicked ( note the . instead of : )
			surface.PlaySound( "buttons/button1.wav" )
			TextEntry:SetValue(TextEntry:GetValue()..6)
		end
		grid:AddItem(DermaButton)
		
		
			local DermaButton = vgui.Create( "DButton", Frame ) -- Create the button and parent it to the frame
		DermaButton:SetText( "7" )					-- Set the text on the button
		DermaButton:SetSize( buttonGridWidth / 4, buttonGridHeight / 5 )					-- Set the size
		DermaButton.DoClick = function()				-- A custom function run when clicked ( note the . instead of : )
			surface.PlaySound( "buttons/button1.wav" )
			TextEntry:SetValue(TextEntry:GetValue()..7)
		end
		grid:AddItem(DermaButton)
		
				local DermaButton = vgui.Create( "DButton", Frame ) -- Create the button and parent it to the frame
		DermaButton:SetText( "8" )					-- Set the text on the button
		DermaButton:SetSize( buttonGridWidth / 4, buttonGridHeight / 5 )					-- Set the size
		DermaButton.DoClick = function()				-- A custom function run when clicked ( note the . instead of : )
			surface.PlaySound( "buttons/button1.wav" )
			TextEntry:SetValue(TextEntry:GetValue()..8)
		end
		grid:AddItem(DermaButton)
		
				local DermaButton = vgui.Create( "DButton", Frame ) -- Create the button and parent it to the frame
		DermaButton:SetText( "9" )					-- Set the text on the button
		DermaButton:SetSize( buttonGridWidth / 4, buttonGridHeight / 5 )					-- Set the size
		DermaButton.DoClick = function()				-- A custom function run when clicked ( note the . instead of : )
			surface.PlaySound( "buttons/button1.wav" )
			TextEntry:SetValue(TextEntry:GetValue()..9)
		end
		grid:AddItem(DermaButton)
		
					local DermaButton = vgui.Create( "DButton", Frame ) -- Create the button and parent it to the frame
		DermaButton:SetText( "0" )					-- Set the text on the button
		DermaButton:SetSize( buttonGridWidth / 4, buttonGridHeight / 5 )					-- Set the size
		DermaButton.DoClick = function()				-- A custom function run when clicked ( note the . instead of : )
			surface.PlaySound( "buttons/button1.wav" )
			TextEntry:SetValue(TextEntry:GetValue()..0)
		end
		grid:AddItem(DermaButton)
		
						local DermaButton = vgui.Create( "DButton", Frame ) -- Create the button and parent it to the frame
		DermaButton:SetText( "Enter" )					-- Set the text on the button
		DermaButton:SetSize( buttonGridWidth / 4, buttonGridHeight / 5 )					-- Set the size
		DermaButton.DoClick = function()				-- A custom function run when clicked ( note the . instead of : )
			surface.PlaySound( "buttons/button1.wav" )
			
			if (passcode == TextEntry:GetValue()) then
				surface.PlaySound( "buttons/combine_button1.wav" )	
				Frame:Close()
				LabAccessMenu(passcode)
			else
				surface.PlaySound( "player/suit_denydevice.wav" )	
				
			end
			
			--TextEntry:SetValue(TextEntry:GetValue()..0)
		end
		grid:AddItem(DermaButton)
	
	else
	
		local gridX = frameW / 10
		local gridY = frameH / 10
		local gridW = frameW - (2 * gridX)
		local gridH = frameH - (2 * gridY)
	
		local Frame = vgui.Create( "DFrame" )
		Frame:SetTitle( "Lab Keypad" )
		Frame:SetSize( frameW, frameH )
		Frame:Center()
		Frame:MakePopup()
		Frame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
			draw.RoundedBox( 0, 0, 0, w, h, Color( 60, 60, 60, 220 ) ) -- Draw a red box instead of the frame
			draw.DrawText( LabDeniedkeypad, "HudHintTextLarge", gridX, gridY, Color( 0, 225, 102, 230 ), TEXT_ALIGN_LEFT )

		end
	
	end

end 
net.Receive("MFKeypadOpen", KeypadMenu )	

function LabAccessMenu(passcode)

local labaccess =  "<username: annaj key: "..passcode.."> \n\n\z
					<welcome back annaj> \n\z
					<loading user profile...> \n\z
					<what would you like to do?>"
					
	local gridX = frameW / 10
	local gridY = frameH / 10
	local gridW = frameW - (2 * gridX)
	local gridH = frameH - (2 * gridY)
		
	local Frame = vgui.Create( "DFrame" )
	Frame:SetTitle( "Lab Terminal" )
	Frame:SetSize( frameW, frameH )
	Frame:Center()
	Frame:MakePopup()
	Frame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
		draw.RoundedBox( 0, 0, 0, w, h, Color( 60, 60, 60, 220 ) ) -- Draw a red box instead of the frame
		draw.DrawText( labaccess, "HudHintTextLarge", gridX, gridY, Color( 0, 225, 102, 230 ), TEXT_ALIGN_LEFT )
	end
	
	local DermaButton = vgui.Create( "DButton", Frame ) -- Create the button and parent it to the frame
	DermaButton:SetPos( (frameW / 2) - (frameW / 8),  (frameH / 2) - (frameH / 3))	
	if (LevelData.TeleportSafeRoom == 1) then
		DermaButton:SetText( "Begin Teleportation Protocol" )	
	else
		DermaButton:SetText( "Open Lab Doors" )	
	end	
	DermaButton:SetSize( frameW / 4, frameH / 6 )					-- Set the size
	DermaButton.DoClick = function()				-- A custom function run when clicked ( note the . instead of : )
		surface.PlaySound( "ambient/levels/labs/teleport_preblast_suckin1.wav" )
		RunConsoleCommand("teleport_to_lab")
		Frame:Close()
	end
end 

function TerminalLab01Menu()

lab01 =  "<latest entry> \n\z							
							 It was never possible to fight the Combine. That's obvious. You can't win a conventional war against an army that possess technology \n\z
							 radically more advanced than your own. \n\n\z
							 Even Protocol 7, our genetic bomb, means nothing when \n\z
							 we are fighting a genetically diverse force. \n\n\z
							 That's where Protocol 8 was supposed to come in. A chemical weapon, specifically tailored to \n\z
							 engineer our own citizens into living weapons. \n\z 
							 But now that I've released it, what did it cost? I've created an uninhabitable hell, fit for nothing but monsters. \n\n\z
							 I always knew Jeff would never agree to activate Protocol 8. Even before the bombs fell. \n\z 
							 That's why I always had a back door. Now I realise that he \n\z
							 was right. But I played the game to well. Bill was the perfect distraction. A control freak by nature. \n\z 
							 I knew he could get pushed over the edge. But willingly exposing himself \n\z
							 to the chemical? That's something I didn't predict. \n\n\z
							 So now I'm stuck here. Stuck with an impossible problem. None of us can leave until we eliminate Protocol 8 from the atmosphere. \n\z
							 The longer we leave it, the higher the chance the Combine discover what has happened here.\n\z
							 If the Combine get their hands on Protocol 8, humanity will be doomed.\n\n\z
							 I thought Protocol 8 would solve everything...Maybe there is something down here that can help me.\n\n\z
							  - Anna"


	local gridX = frameW / 10
	local gridY = frameH / 10
	local gridW = frameW - (2 * gridX)
	local gridH = frameH - (2 * gridY)
		
	local Frame = vgui.Create( "DFrame" )
	Frame:SetTitle( "Anna's Terminal" )
	Frame:SetSize( frameW, frameH )
	Frame:Center()
	Frame:MakePopup()
	Frame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
		draw.RoundedBox( 0, 0, 0, w, h, Color( 60, 60, 60, 200 ) ) -- Draw a red box instead of the frame
		draw.DrawText( lab01, "HudHintTextLarge", gridX, gridY, Color( 0, 225, 102, 230 ), TEXT_ALIGN_LEFT )
	end
end 
net.Receive("MFQuestLab01", TerminalLab01Menu )	


function TerminalLab02Menu()

lab02 =  "<technical entry 01> \n\z							
		 I found a way out. I can't believe none of us found this while we were working down here. \n\z
		 This facility has a set of emergency, self destruct protocols, that could be activated upon the research here being compromised. \n\z
		 This was before everything. Before the Combine, before the war... I guess whoever previously worked here was deathly \n\z 
		 afraid of their work getting into the wrong hands. Which is certainly ironic, given the circumstances. \n\n\z
		 Along with the self destruct is a teleportation protocol. However this teleport is located a substantial distance away from the lab. It requires \n\z
		 the user standing in a location in the wilderness until the teleport is initiated. At which time they will be beamed to safety. \n\z
		 The problem is I will not be able to survive this journey to the teleport given my lack of usuable oxygen canisters. \n\z
		 So I have two choices. Wait here and die, or sacrifice myself and everyone and destroy us and Protocol 8 for good.\n\z
         I am far to cowardly to decide my own fate... \n\n\z
		  - Anna"


	local gridX = frameW / 10
	local gridY = frameH / 10
	local gridW = frameW - (2 * gridX)
	local gridH = frameH - (2 * gridY)
		
	local Frame = vgui.Create( "DFrame" )
	Frame:SetTitle( "Anna's Technical Terminal" )
	Frame:SetSize( frameW, frameH )
	Frame:Center()
	Frame:MakePopup()
	Frame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
		draw.RoundedBox( 0, 0, 0, w, h, Color( 60, 60, 60, 200 ) ) -- Draw a red box instead of the frame
		draw.DrawText( lab02, "HudHintTextLarge", gridX, gridY, Color( 0, 225, 102, 230 ), TEXT_ALIGN_LEFT )
	end
end 
net.Receive("MFQuestLab02", TerminalLab02Menu )	

function TerminalLab03Menu()

lab03 =  "<utility bench> \n\z							
		 I uncovered the self destruct protocol of the lab. This can change everything. \n\n\z
		 Upon activation, a countdown will begin. When this count down reaches zero the lab, the surface, Protocol 8 and everything will be destroyed.\n\z
		 However, an evacuation teleport will be created somewhere on the surface. If this is reached before the countdown ends, then whoever is in its vicinity \n\z
		 will be teleported to safety. \n\n\z
		 You have a choice now. Destroy everything, prevent the Combine getting their hands on Protocol 8 and finally escape. OR \n\z
		 return to the surface and continue to survive and fight the Combine and keep the knowledge of this self destruct protocol to yourself. \n\n\z
		 The choice is yours."


	local gridX = frameW / 10
	local gridY = frameH / 10
	local gridW = frameW - (2 * gridX)
	local gridH = frameH - (2 * gridY)
		
	local Frame = vgui.Create( "DFrame" )
	Frame:SetTitle( "Power Router Terminal" )
	Frame:SetSize( frameW, frameH )
	Frame:Center()
	Frame:MakePopup()
	Frame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
		draw.RoundedBox( 0, 0, 0, w, h, Color( 60, 60, 60, 200 ) ) -- Draw a red box instead of the frame
		draw.DrawText( lab03, "HudHintTextLarge", gridX, gridY, Color( 0, 225, 102, 230 ), TEXT_ALIGN_LEFT )
	end
	
		local DermaButton = vgui.Create( "DButton", Frame ) -- Create the button and parent it to the frame
	DermaButton:SetPos( (frameW / 2) - (frameW / 8),  (frameH / 1.5))	
	DermaButton:SetText( "Activate Self Destruct" )			
	DermaButton:SetSize( frameW / 4, frameH / 6 )					-- Set the size
	DermaButton.DoClick = function()				-- A custom function run when clicked ( note the . instead of : )
		surface.PlaySound( "ambient/levels/labs/teleport_postblast_winddown1.wav" )
		net.Start( "MFActivateSelfDestruct" )
		net.SendToServer()
		Frame:Close()
	end
		
end 
net.Receive("MFQuestLab03", TerminalLab03Menu )	

function HuntersTerminal()

local HuntersTerminalStr = {}

local introstr = "<Hunter's Terminal>: \n\n\z
					It's me again scrub. I'll keep you posted on any jobs available. What with the fog and all, I need guys who are willing to risk their neck out there. \n\z
					If you're up for dying for a good cause then by all means. Plus the pay ain't half bad either... \n\n\z
					New Job: \n\z"
					
local endstr = "\n\n\z
					I don't care who does it. I'm sending this out as a global alert. So if you end up killing each other on the way there, then that is just part of the job. \n\z
					Don't expect me to cry about it. Just do the work."

HuntersTerminalStr[1] = "It's time for a big game hunt. The bastard antlion has got a real hard on for killing my guys. I'll give you an easy "..ConfigInfo["MarketFog"].Gameplay.CashDisplaySymbol..CurrentHunterMission.Reward.." for the trouble. \n\z
						This bull won't play nice, so make sure you're packing heat. Comprende? \n\z
						I'll send you the coordinates of it's last known location.\n\n\z
						- Hunter"
						
HuntersTerminalStr[2] = "I've heard rumours about this guy. Not many people have seen it in the flesh. Those that have, end up going crazy and I gotta put 'em down. \n\z
						Keep your wits about you on this one. I don't want to be feeding you through a straw and wiping your arse every 4-6 hours after you get back. \n\z
						I'm paying a lot. "..ConfigInfo["MarketFog"].Gameplay.CashDisplaySymbol..CurrentHunterMission.Reward..". So get it done.\n\z
						I'll send you the coordinates of it's last known location. \n\n\z
						- Hunter"
						
HuntersTerminalStr[3] = "This guy. This guy is a bad dude. Don't know where this little guy came from, but don't get close. \n\z
						Keep 'em at range and you'll be fine. The reward is "..ConfigInfo["MarketFog"].Gameplay.CashDisplaySymbol..CurrentHunterMission.Reward..". \n\z
						I'll send you the coordinates of it's last known location. \n\n\z
						- Hunter"
						
HuntersTerminalStr[99] = "What ever that fog brought with it is nothing compared to this dude. Guy went rogue. Grabbed a chainsaw and sliced through four of my guys. Turns out the real monster is inside each one of us. \n\z
						This is less about the money and more about revenge. I don't know what's got into him but I don't give a shit. I want him dead. \n\z
						The payout is "..ConfigInfo["MarketFog"].Gameplay.CashDisplaySymbol..CurrentHunterMission.Reward..". \n\z
						I'll send you the coordinates of it's last known location. \n\n\z
						- Hunter"
						
HuntersTerminalStr[4] = "This guy is a ghost. Some say that he preys on those lost in the fog. That he can't be killed. All I know is that the deader a ghost is the better. \n\z
						Just don't get cleaved by his axe. It's an easy "..ConfigInfo["MarketFog"].Gameplay.CashDisplaySymbol..CurrentHunterMission.Reward.." if you can come back with your head still on your shoulders \n\z
						I'll send you the coordinates of it's last known location. \n\n\z
						- Hunter"
						
HuntersTerminalStr[5] = "There are some crazy, crazy survivors out there. Normally I wouldn't give a shit, but when they bother my men it's a different story. \n\z
						This guy has killed every man I've sent after him. He doesn't mess around. Even though he prances around with a wooden club. \n\z
						Get it done and the "..ConfigInfo["MarketFog"].Gameplay.CashDisplaySymbol..CurrentHunterMission.Reward.." is yours. \n\z
						I'll send you the coordinates of it's last known location. \n\n\z
						- Hunter"	 
		 
	local gridX = frameW / 10
	local gridY = frameH / 10
	local gridW = frameW - (2 * gridX)
	local gridH = frameH - (2 * gridY)
		
	local Frame = vgui.Create( "DFrame" )
	Frame:SetTitle( "Hunter's Computer" )
	Frame:SetSize( frameW, frameH )
	Frame:Center()
	Frame:MakePopup()
	Frame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
		draw.RoundedBox( 0, 0, 0, w, h, Color( 60, 60, 60, 200 ) ) -- Draw a red box instead of the frame
		draw.DrawText( introstr.. HuntersTerminalStr[CurrentHunterMission.HuntMission]..endstr, "HudHintTextLarge", gridX, gridY, Color( 0, 225, 102, 230 ), TEXT_ALIGN_LEFT )
		if (CurrentHunterMission.CurrentlyOngoing) then draw.DrawText( "The Hunt has already started! Follow the marker on your map!", "HudHintTextLarge", (frameW / 2) - (frameW / 8), (frameH / 1.5), Color( 0, 225, 102, 230 ), TEXT_ALIGN_LEFT ) end
	end
	
	
	if (not CurrentHunterMission.CurrentlyOngoing) then
	
		local DermaButton = vgui.Create( "DButton", Frame ) -- Create the button and parent it to the frame
		DermaButton:SetPos( (frameW / 2) - (frameW / 8),  (frameH / 1.5))	
		DermaButton:SetText( "Start the Hunt!" )			
		DermaButton:SetSize( frameW / 4, frameH / 6 )					-- Set the size
		DermaButton.DoClick = function()				-- A custom function run when clicked ( note the . instead of : )
			--surface.PlaySound( "ambient/levels/labs/teleport_postblast_winddown1.wav" )
			RunConsoleCommand("mf_start_hunt")
			Frame:Close()
		end
	
	end
	

	
end              
net.Receive("MFHunterMenu", HuntersTerminal )	  


--.