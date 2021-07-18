----------------------------------
--	Market Fog	
--	Programmer : LIFO/Tednesday		
--	Date : 19/10/2018		
----------------------------------


function draw.Circle( x, y, radius, seg )
	local cir = {}

	table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
	for i = 0, seg do
		local a = math.rad( ( i / seg ) * -360 )
		table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
	end

	local a = math.rad( 0 ) -- This is needed for non absolute segment counts
	table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

	surface.DrawPoly( cir )
end

function draw.Triangle(cx, cy)

	local triangle = {
	{ x = cx - 20, y = cy + 20 },
	{ x = cx, y = cy - 20 },
	{ x = cx + 20, y = cy + 20  }
	}

	surface.DrawPoly( triangle )

end

function CompassBlip(x, y, z, name, r, g, b)

	local pos = Vector(x, y, z)
	local screen = pos:ToScreen() 
	
	local uw = ScrW() - (ScrW() / 8)
	local lw = (ScrW() / 8)
	local uh = ScrH() - (ScrH() / 8)
	local lh = (ScrH() / 8)
	
	if (screen.x > uw) then
		screen.x = uw	
	end 
	if (screen.x < lw) then
		screen.x = lw	
	end 
	if (screen.y > uh) then
		screen.y = uh	
	end 
	if (screen.y < lh) then
		screen.y = lh	
	end 
	
	surface.SetDrawColor( 60, 60, 60, 230 )
	draw.NoTexture()
	draw.Triangle( screen.x, screen.y )
	draw.DrawText( name, "TargetID", screen.x, screen.y, Color( r, g, b, 230 ), TEXT_ALIGN_CENTER )

end

--.