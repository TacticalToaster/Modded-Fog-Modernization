----------------------------------
--	Market Fog	
--	Programmer : LIFO/Tednesday		
--	Date : 15/10/2018		
----------------------------------

HintTable = {}
HintEnum = {}

MessageStack={}

MessageBeingDisplayedFlag = false

function DisplayHint(hintid, timeout)

	local hint = HintTable[hintid]
	
	-- Bubble container size
	local framew = ScrW() / 4
	local frameh = ScrH() / 6
	local framex = ScrW() / 10
	local framey = ScrH() / 2
		
	if (MessageBeingDisplayedFlag) then

		local Message = {
			id = hintid,
			t = timeout	
		}
		table.insert(MessageStack, Message)	
	else
		surface.PlaySound("buttons/combine_button1.wav")
		BGPanel = vgui.Create( "DPanel" )
		BGPanel:SetSize( framew, frameh )
		BGPanel:SetBackgroundColor( Color( 64, 255, 102, 0 ) )
		BGPanel:SetPos(framex, framey)		
		BGPanel:MakePopup()
		BGPanel:MoveToFront()
		BGPanel:SetMouseInputEnabled(false)
		BGPanel:SetKeyboardInputEnabled(false)
	
		
		bubble = vgui.Create( "DBubbleContainer", BGPanel )
		
		local bubblew = framew * 0.9
		local bubbleh = frameh * 0.9
		
		bubble:SetBackgroundColor( Color( 32, 32, 32, 220 ) )
		bubble:OpenForPos( bubblew * 0.2, 5, bubblew, bubbleh)
	
		-- Add text to bubble
		local lbl = vgui.Create( "DLabel", bubble )
		lbl:SetPos( bubblew * 0.05, 0 )
		lbl:SetSize( bubblew * 0.8, bubbleh)
		lbl:SetWrap( true )
		lbl:SetFont( "GModNotify" )
		lbl:SetText( hint )
		lbl:SetTextColor( Color( 0, 255, 102 ) )

		MessageBeingDisplayedFlag = true
		
		if (timeout == 0) then timeout = 15 end
		timer.Create( CurTime().."HintTimeout", timeout, 1,
			function()
				BGPanel:Remove()
				local tablecount = table.Count(MessageStack)
				MessageBeingDisplayedFlag = false
				if (tablecount > 0) then
				
					local id = MessageStack[tablecount].id
					local t = MessageStack[tablecount].t
					print("Playing stacked message "..id.." "..t )
					table.remove(MessageStack)
					DisplayHint(id, t)
				end
	
			end )		
	end
		
end

net.Receive("SendHintId", function(len, ply)    
	DisplayHint(net.ReadUInt( 32 ), net.ReadUInt(32))
end)

net.Receive("SendHintIdTable", function(len, ply)    
	HintTable = net.ReadTable() 
	HintEnum = net.ReadTable()
end)

function DisplayHelp()

	local Frame = vgui.Create( "DFrame" )
	Frame:SetPos( frameX, frameY )
	Frame:SetSize( frameW, frameH )
	Frame:SetTitle( "Help" )
	Frame:SetVisible( true )
	Frame:SetDraggable( true) 
	Frame:ShowCloseButton( true )
	Frame:MakePopup()

	local sheet = vgui.Create( "DPropertySheet", Frame )
	sheet:Dock( FILL )

	-- -------Intro PANEL

	local IntroSheet = vgui.Create( "DPanel", sheet )
	IntroSheet.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 75, 75, 75, self:GetAlpha() ) ) end
	sheet:AddSheet( "Intro", IntroSheet )

end


function DisplayLabWarning(len, ply)

	local lbl = vgui.Create( "DLabel" )
	lbl:SetPos( ScrW() * 0.4, ScrH() * 0.35 )
	lbl:SetFont( "DermaLarge" )
	lbl:SetText( "Somebody has entered the mysterious lab!" )
	lbl:SetTextColor( Color( 0, 255, 102 ) )
	lbl:SizeToContents()

	surface.PlaySound("ambient/alarms/warningbell1.wav")
	
	timer.Create( CurTime().."LabLabelWarningTimeout", 10, 1,
	function()
		lbl:Remove()
	end )
	
end

net.Receive("SendLabWarningMessage", DisplayLabWarning)



function DisplaySelfDestructWarning(len, ply)

	local lbl = vgui.Create( "DLabel" )
	lbl:SetPos( ScrW() * 0.20, ScrH() * 0.35 )
	lbl:SetFont( "DermaLarge" )
	lbl:SetText( "The self-destruct protocol has been activated. Make your way to the evac zone before the count down ends!" )
	lbl:SetTextColor( Color( 0, 255, 102 ) )
	lbl:SizeToContents()

	
	
	surface.PlaySound("ambient/alarms/siren.wav")
	
	timer.Create( CurTime().."LabLabelWarningTimeout", 20, 1,
	function()
		lbl:Remove()
	end )

	CountDownLabel = vgui.Create("DLabel")
	CountDownLabel:SetPos(ScrW() * 0.41, ScrH() * 0.2)
	CountDownLabel:SetFont( "DermaLarge" )
	CountDownLabel:SetText( "Countdown till self-destruct: 0 seconds" )
	CountDownLabel:SetTextColor( Color( 0, 255, 102 ) )
	CountDownLabel:SizeToContents()
		
	--RunConsoleCommand("pp_earthquake_magnitude", 0.01)
	--RunConsoleCommand("pp_earthquake", 1)
	
	LevelData.GasColour.x = 77
	LevelData.GasColour.y = 17
	LevelData.GasColour.z = 17
	
	ClientSelfDestructFlag = true
		
	CompassBlipShow.Evac = true	
end
net.Receive("SendSelfDestructWarningMessage", DisplaySelfDestructWarning)

function UpdateCountDown()

	local timeout = net.ReadInt(10)
	CountDownLabel:SetText( "Self-destruct in: "..timeout.." seconds" )
	CountDownLabel:SizeToContents()

	if (timeout == 98) then		
		surface.PlaySound("music/HL2_song1.mp3")	
	end
	
end
net.Receive("SendSelfDestructCountdown", UpdateCountDown)

function InEvacMessage()

		InEvacLabel = vgui.Create("DLabel")
		InEvacLabel:SetPos(ScrW() * 0.28, ScrH() * 0.25)
		InEvacLabel:SetFont( "DermaLarge" )
		InEvacLabel:SetText( "Remain in the Evac Zone until the countdown ends to survive!" )
		InEvacLabel:SetTextColor( Color( 0, 255, 102 ) )
		InEvacLabel:SizeToContents()
		CompassBlipShow.Evac = false

end
net.Receive("SendInEvac", InEvacMessage)

function NotInEvacMessage()

	if (InEvacLabel ~= nil) then
		InEvacLabel:Remove()
	end
	
	CompassBlipShow.Evac = true
end
net.Receive("SendNotInEvac", NotInEvacMessage)


Credits = {}
Credits[1] = { Label = nil, Text = "A Game by LIFO/Tednesday", Pos = 0.25 }
Credits[2] = { Label = nil, Text = "Special thanks to anyone who got this far!", Pos = 0.25 }
Credits[3] = { Label = nil, Text = "And anyone who has supported Market Fog in any capacity", Pos = 0.25 }
Credits[4] = { Label = nil, Text = "Thanks to little bro for the outro song", Pos = 0.25 }
Credits[5] = { Label = nil, Text = "The End", Pos = 0.25 }

function ClientSelfDestruct()

	local survivedflag = net.ReadBool()

	RunConsoleCommand("pp_earthquake", 0)
	
	game.CleanUpMap() 
	
	if (InEvacLabel ~= nil) then InEvacLabel:Remove() end
	if (CountDownLabel ~= nil) then CountDownLabel:Remove() end
	
	survive = vgui.Create("DLabel")
	survive:SetPos(ScrW() * 0.32, ScrH() * 0.35)
	survive:SetFont( "DermaLarge" )

	if (survivedflag) then
		survive:SetText( "You escaped! You've unlocked access to Alien Weapons!" )
		survive:SetTextColor( Color( 0, 255, 102 ) )
		survive:SizeToContents()	
	else
		survive:SetText( "You didn't manage to escape! You succumbed to the fog!" )
		survive:SetTextColor( Color( 0, 255, 102 ) )
		survive:SizeToContents()	
	end
	

	surface.PlaySound("dontleave.wav")	
	
	timer.Create( CurTime().."SelfResetTimer", 180, 1,
		function()
			ClientSelfDestructFlag = false
		end)
		
	timer.Create( CurTime().."CreditTimer", 8, 1,
		function()
			survive:Remove()
			Credits[1].Label = vgui.Create("DLabel")
			Credits[1].Label:SetPos(ScrW() * Credits[1].Pos, ScrH() * 0.35)
			Credits[1].Label:SetFont( "DermaLarge" )
			Credits[1].Label:SetText( Credits[1].Text)
			Credits[1].Label:SetTextColor( Color( 0, 255, 102 ) )
			Credits[1].Label:SizeToContents()	
			
			timer.Create( CurTime().."CreditTimer1", 10, 1,
				function()		
					Credits[1].Label:Remove()
					Credits[2].Label = vgui.Create("DLabel")
					Credits[2].Label:SetPos(ScrW() * Credits[2].Pos, ScrH() * 0.35)
					Credits[2].Label:SetFont( "DermaLarge" )
					Credits[2].Label:SetText( Credits[2].Text)
					Credits[2].Label:SetTextColor( Color( 0, 255, 102 ) )
					Credits[2].Label:SizeToContents()				
					timer.Create( CurTime().."CreditTimer2", 10, 1,
						function()		
							Credits[2].Label:Remove()
							Credits[3].Label = vgui.Create("DLabel")
							Credits[3].Label:SetPos(ScrW() * Credits[3].Pos, ScrH() * 0.35)
							Credits[3].Label:SetFont( "DermaLarge" )
							Credits[3].Label:SetText( Credits[3].Text)
							Credits[3].Label:SetTextColor( Color( 0, 255, 102 ) )
							Credits[3].Label:SizeToContents()				
							timer.Create( CurTime().."CreditTimer3", 10, 1,
								function()		
									Credits[3].Label:Remove()
									Credits[4].Label = vgui.Create("DLabel")
									Credits[4].Label:SetPos(ScrW() * Credits[4].Pos, ScrH() * 0.35)
									Credits[4].Label:SetFont( "DermaLarge" )
									Credits[4].Label:SetText( Credits[4].Text)
									Credits[4].Label:SetTextColor( Color( 0, 255, 102 ) )
									Credits[4].Label:SizeToContents()				
									timer.Create( CurTime().."CreditTimer4", 10, 1,
										function()		
											Credits[4].Label:Remove()
											Credits[5].Label = vgui.Create("DLabel")
											Credits[5].Label:SetPos(ScrW() * Credits[5].Pos, ScrH() * 0.35)
											Credits[5].Label:SetFont( "DermaLarge" )
											Credits[5].Label:SetText( Credits[5].Text)
											Credits[5].Label:SetTextColor( Color( 0, 255, 102 ) )
											Credits[5].Label:SizeToContents()				
										timer.Create( CurTime().."CreditTimer5", 20, 1,
											function()	
												Credits[5].Label:Remove()
											end)
										end)								
								end)						
						end)
				end)
		end)	
	
	
end
net.Receive("SendSelfDestruct", ClientSelfDestruct)

--.


















































































































































