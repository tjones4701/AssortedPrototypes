surface.CreateFont( "coolvetica", 18, 500, true, false, "MyFont1" )
surface.CreateFont( "coolvetica", 32, 500, true, false, "MyFont2" )
surface.CreateFont( "coolvetica", 12, 500, true, false, "MyFont3" )
surface.CreateFont( "coolvetica", 14, 500, true, false, "MyFont4" )
surface.CreateFont( "coolvetica", 16, 500, true, false, "MyFont5" )
surface.CreateFont( "coolvetica", 26, 500, true, false, "MyFont6" )


--Toggle skills menu
HudMenuA = {}
HudMenuA.Skills = 0
HudMenuA.Res = 0
function GM.ToggleResMenu(um)
	if HudMenuA.Res == 1 then
		HudMenuA.Res = 0
	else
		HudMenuA.Res = 1
	end
end
--Toggle Resources menu
function GM.ToggleSkillMenu(um)
	if HudMenuA.Skills == 1 then
		HudMenuA.Skills = 0
	else
		HudMenuA.Skills = 1
	end
end
usermessage.Hook("gms_ToggleSkillsMenu",GM.ToggleSkillMenu)
usermessage.Hook("gms_ToggleResourcesMenu",GM.ToggleResMenu)
local tex = surface.GetTextureID("VGUI/gradient_down.vmt") -- Texture for gradients
local tex2 = surface.GetTextureID("VGUI/gradient_up.vmt") -- Texture for gradients
function DrawHud()
	if Hunger && Thirst && Sleepiness then
	//Main
		draw.RoundedBox(8, 0 + HX, 0 + HY, 200, 115, Color(0,0,0,160))
		draw.RoundedBox(8, 5 + HX, 5 + HY, 190, 105, Color(180,180,180,160))
		//BackStats
		draw.RoundedBox(2, 15 + HX, 10 + HY, 170, 20, Color(0,0,0,160))
		draw.RoundedBox(2, 15 + HX, 35 + HY, 170, 20, Color(0,0,0,160))
		draw.RoundedBox(2, 15 + HX, 60 + HY, 170, 20, Color(0,0,0,160))
		draw.RoundedBox(2, 15 + HX, 85 + HY, 170, 20, Color(0,0,0,160))
		
		draw.RoundedBox(2, 20 + HX, 14 + HY, 160, 12, Color(0,0,0,180))
		draw.RoundedBox(2, 20 + HX, 39 + HY, 160, 12, Color(0,0,0,180))
		draw.RoundedBox(2, 20 + HX, 64 + HY, 160, 12, Color(0,0,0,180))
		draw.RoundedBox(2, 20 + HX, 89 + HY, 160, 12, Color(0,0,0,180))
		if QuickFunctionsOpen then
			if QuickFunctionsOpen == 0 then
				local x,y,w,h = 205,0,200,40
				draw.RoundedBox(8, x, y, w, h, Color(0,0,0,160))
				draw.RoundedBox(8, x + 5, y + 5, w - 10, h - 10, Color(180,180,180,160))
				draw.SimpleText(F3Text.. " (F3)","ResFont1",x +(w / 2), y + 20, Color(255,255,255,255),1,1)
			end
		end


		
		//FrontStats
		local H = math.Clamp((LocalPlayer():Health() / 400) * 160,0,160)
		local Hung = math.Clamp(( Hunger / 1000) * 160,0,160)
		local Thir = math.Clamp(( Thirst/ 1000) * 160,0,160)
		local sleep = math.Clamp(( Sleepiness/ 1000) * 160,0,160)
		draw.RoundedBox(2, 20 + HX, 14 + HY, H, 12, Color(200,0,0,255))
		--------TEXTURE PART
		surface.SetDrawColor(100,0,0,255) -- Set colour
		surface.SetTexture(tex) -- change texture
		surface.DrawTexturedRect( 20 + HX, 14 + HY, H, 12 / 2) -- Draw the bar
		surface.SetTexture(tex2) -- change texture
		surface.DrawTexturedRect( 20 + HX, 14 + HY + (12 / 2), H, 12 / 2) -- Draw the bar
		---------------------------
		draw.SimpleText("Health","ResFont3",95 + HX, HY +20, Color(255,255,255,255),1,1)
		------------------------------------------------------------------------------------------
		draw.RoundedBox(2, 20 + HX, 39 + HY, Hung, 12, Color(0,200,0,255))
		--------TEXTURE PART
		surface.SetDrawColor(0,100,0,255) -- Set colour
		surface.SetTexture(tex) -- change texture
		surface.DrawTexturedRect( 20 + HX, 39 + HY, Hung, 12 / 2) -- Draw the bar
		surface.SetTexture(tex2) -- change texture
		surface.DrawTexturedRect( 20 + HX, 39 + HY + (12 / 2), Hung, 12 / 2) -- Draw the bar
		---------------------------
		draw.SimpleText("Hunger","ResFont3",95 + HX, HY +45, Color(255,255,255,255),1,1)
		------------------------------------------------------------------------------------------
		draw.RoundedBox(2, 20 + HX, 64 + HY, Thir, 12, Color(0,0,200,255))
		--------TEXTURE PART
		surface.SetDrawColor(0,0,100,255) -- Set colour
		surface.SetTexture(tex) -- change texture
		surface.DrawTexturedRect( 20 + HX, 64 + HY, Thir, 12 / 2) -- Draw the bar
		surface.SetTexture(tex2) -- change texture
		surface.DrawTexturedRect( 20 + HX, 64 + HY + (12 / 2), Thir, 12 / 2) -- Draw the bar
		---------------------------
		draw.SimpleText("Thirst","ResFont3",95 + HX, HY +70, Color(255,255,255,255),1,1)
		---------------------------------------------------------------------------------------------------------------------------------------
		draw.RoundedBox(2, 20 + HX, 89 + HY, sleep, 12, Color(200,0,200,255))
		--------TEXTURE PART
		surface.SetDrawColor(100,0,100,255) -- Set colour
		surface.SetTexture(tex) -- change texture
		surface.DrawTexturedRect( 20 + HX, 89+ HY, sleep, 12 / 2) -- Draw the bar
		surface.SetTexture(tex2) -- change texture
		surface.DrawTexturedRect( 20 + HX, 89 + HY + (12 / 2), sleep, 12 / 2) -- Draw the bar
		---------------------------
		draw.SimpleText("Sleep","ResFont3",95 + HX, HY +95, Color(255,255,255,255),1,1)
		
		if HudMenuA.Skills == 0 && HudMenuA.Res == 1 then	
			local Height = 0
			local MaxHeight = 10
			local Amount = 0
			local restotal = 0
			for k,v in pairs(Resources) do 
				if v > 0 then
					MaxHeight = MaxHeight + ResHeight
					Amount = Amount + 1
					restotal = restotal + v
				end
			end		
			if Amount > 0 then
				draw.RoundedBox(4, 0 + HX, 120 + HY, 200, MaxHeight + 10, Color(0,0,0,160))	
				draw.RoundedBox(2, 5 + HX, 125 + HY, 190, MaxHeight, Color(180,180,180,160))
				
				for k,v in pairs(Resources) do 
					if v > 0 then
						Height = Height + ResHeight
						draw.RoundedBox(0, 5 + HX, HY + 110 + Height, 190, ResHeight, Color(0,0,0,160))
						draw.SimpleText(k ..": " .. v,"ResFont1",10 + HX, HY + 120 + Height, Color(255,255,255,255),0,1)
					end
				end	
				draw.RoundedBox(2, 0 + HX, HY + 128 + MaxHeight, 110, 40, Color(0,0,0,160))	
				draw.RoundedBox(2, 5 + HX, HY + 135 + MaxHeight, 100, 30, Color(180,180,180,160))
				draw.SimpleText(restotal.."/".. MaxResources,"ResFont2",10 + HX, HY + 150 + MaxHeight, Color(255,255,255,255),0,1)
				
			else
				draw.RoundedBox(4, 0 + HX, 120 + HY, 200, 40, Color(0,0,0,160))	
				draw.RoundedBox(2, 5 + HX, 125 + HY, 190, 30, Color(180,180,180,160))		
				draw.SimpleText("No resources.","ResFont1",10 + HX, (HY + 130) + 10 + Height, Color(255,255,255,255),0,1)
			end
		
		elseif HudMenuA.Res == 0 && HudMenuA.Skills == 1 then
			local MaxHeight = 0
			local Height = 0
			local Amount = 0
			local SectionHeight = 50
			for k,v in pairs(Skills) do 
				MaxHeight = MaxHeight + SectionHeight
			end
			
			draw.RoundedBox(4, HX, HY + 120, 200, (MaxHeight * 1.05) + 10 , Color(0,0,0,160))	
			
			for k,v in pairs(Skills) do 
				draw.RoundedBox(0, 5 + HX, HY + 125 + (Height * 1.05), 190, SectionHeight ,	Color(180,180,180,160))
				draw.RoundedBox(0, 10 + HX, HY + 145 + (Height * 1.05), 180, 25 ,	Color(0,0,0,160))
				draw.RoundedBox(0, 15 + HX, HY + 150 + (Height * 1.05), 170, 15,	Color(0,0,0,100))
				draw.SimpleText(k..": "..v,"ResFont1",10 + HX, (HY + 135) + (Height * 1.05), Color(255,255,255,255),0,1)
				local Width = 0
				local Width = (Experience[k] / 100) * 175
				
				draw.RoundedBox(0, 15 + HX, HY + 150 + (Height * 1.05), Width, 15,	Color(0,220,0,255))
				--------TEXTURE PART
				surface.SetDrawColor(0,160,0,255) -- Set colour
				surface.SetTexture(tex) -- change texture
				surface.DrawTexturedRect( 15 + HX, HY + 150 + (Height * 1.05), Width, 15 / 2) -- Draw the bar
				surface.SetTexture(tex2) -- change texture
				surface.DrawTexturedRect( 15 + HX, HY + 150 + (Height * 1.05) + (15 / 2), Width, 15 / 2) -- Draw the bar
				---------------------------
				draw.SimpleText(Experience[k].. "/100","ResFont1",95 + HX, (HY + 160) + (Height * 1.05), Color(255,255,255,255),1,1)
				Height = Height + SectionHeight
			end
		elseif HudMenuA.Res == 1 && HudMenuA.Skills == 1 then
			--Resource
			local MaxHeight = 0
			local Height = 0
			local Amount = 0
			local SectionHeight = 50
			local X = HX 
			for k,v in pairs(Skills) do 
				MaxHeight = MaxHeight + SectionHeight
			end
			
			draw.RoundedBox(4, X, HY + 120, 200, (MaxHeight * 1.05) + 10 , Color(0,0,0,160))	
			
			for k,v in pairs(Skills) do 
				draw.RoundedBox(0, 5 + X, HY + 125 + (Height * 1.05), 190, SectionHeight ,	Color(180,180,180,160))
				draw.RoundedBox(0, 10 + X, HY + 145 + (Height * 1.05), 180, 25 ,	Color(0,0,0,160))
				draw.RoundedBox(0, 15 + X, HY + 150 + (Height * 1.05), 170, 15,	Color(0,0,0,100))
				draw.SimpleText(k..": "..v,"ResFont1",10 + X, (HY + 135) + (Height * 1.05), Color(255,255,255,255),0,1)
				local Width = 0
				local Width = (Experience[k] / 100) * 175
				
				draw.RoundedBox(0, 15 + X, HY + 150 + (Height * 1.05), Width, 15,	Color(0,220,0,255))
				--------TEXTURE PART
				surface.SetDrawColor(0,160,0,255) -- Set colour
				surface.SetTexture(tex) -- change texture
				surface.DrawTexturedRect( 15 + X, HY + 150 + (Height * 1.05), Width, 15 / 2) -- Draw the bar
				surface.SetTexture(tex2) -- change texture
				surface.DrawTexturedRect( 15 + X, HY + 150 + (Height * 1.05) + (15 / 2), Width, 15 / 2) -- Draw the bar
				---------------------------
				draw.SimpleText(Experience[k].. "/100","ResFont1",95 + X, (HY + 160) + (Height * 1.05), Color(255,255,255,255),1,1)
				Height = Height + SectionHeight
			end
			
			--Res
			local X = HX + 200
			local Y = HY + 0
			local Height = 0
			local MaxHeight = 10
			local Amount = 0
			local restotal = 0
			for k,v in pairs(Resources) do 
				if v > 0 then
					MaxHeight = MaxHeight + ResHeight
					Amount = Amount + 1
					restotal = restotal + v
				end
			end		
			if Amount > 0 then
				draw.RoundedBox(4, 0 + X, 120 + Y, 200, MaxHeight + 10, Color(0,0,0,160))	
				draw.RoundedBox(2, 5 + X, 125 + Y, 190, MaxHeight, Color(180,180,180,160))
				
				for k,v in pairs(Resources) do 
					if v > 0 then
						Height = Height + ResHeight
						draw.RoundedBox(0, 5 + X, Y + 110 + Height, 190, ResHeight, Color(0,0,0,160))
						draw.SimpleText(k ..": " .. v,"ResFont1",10 + X, Y + 120 + Height, Color(255,255,255,255),0,1)
					end
				end	
				draw.RoundedBox(2, 0 + X, Y + 128 + MaxHeight, 110, 40, Color(0,0,0,160))	
				draw.RoundedBox(2, 5 + X, Y + 135 + MaxHeight, 100, 30, Color(180,180,180,160))
				draw.SimpleText(restotal.."/".. MaxResources,"ResFont2",10 + X, Y + 150 + MaxHeight, Color(255,255,255,255),0,1)
				
			else
				draw.RoundedBox(4, 0 + X, 120 + Y, 200, 40, Color(0,0,0,160))	
				draw.RoundedBox(2, 5 + X, 125 + Y, 190, 30, Color(180,180,180,160))		
				draw.SimpleText("No resources.","ResFont1",10 + X, (Y + 130) + 10 + Height, Color(255,255,255,255),0,1)
			end
			
		else
			draw.RoundedBox(4, HX, HY + 120, 200, 50 , Color(0,0,0,160))	
			draw.RoundedBox(4, HX + 5, HY + 125, 190, 40 , Color(180,180,180,160))	
			draw.SimpleText("SKILLS: F1","ResFont1",95 + HX, HY + 135, Color(255,255,255,255),1,1)
			draw.SimpleText("RESOURCES: F2","ResFont1",95 + HX, HY + 155, Color(255,255,255,255),1,1)
		end
	else
		Hunger = 1000
		Thirst = 1000
		Sleepiness = 1000
	end
	if tobool(gms_CheckSettings("DrawClock")) == true then
		draw.RoundedBox( 0, ScrW()-148, 20, 128, 46, Color( 25, 25, 25, 255 ) )
		draw.RoundedBox( 20, ScrW()-148, 20, 128, 46, Color( 125, 125, 125, 125 ) )
		draw.SimpleText(os.date( "%a, %I:%M:%S %p" ), "Default", ScrW()-130, 24, Color( 255, 104, 86, 255 ),0,0)
		draw.SimpleText(os.date( "%d/%m/20%y" ), "Default", ScrW()-110, 44, Color( 255, 104, 86, 255 ),0,0)
	end
end

hook.Add("HUDPaint", "DrawHud", DrawHud)
concommand.Add("gms_togglethetime",function(ply)
	if tobool(gms_CheckSettings("DrawClock")) == true then
		gms_SetSetting("DrawClock",false)
		AddNotification("The timer won't show.","0,255,255")	
	else
		gms_SetSetting("DrawClock",true)
		AddNotification("The timer will show.","0,255,255")	
	end
end)




PlayerDisplay = 1
function TogglePlayerDisplay()
	if tobool(gms_CheckSettings("DrawOtherPlayerNames")) == false then
		gms_SetSetting("DrawOtherPlayerNames",true)
		AddNotification("You will now see players names.","0,255,255")	
	else
		gms_SetSetting("DrawOtherPlayerNames",false)
		AddNotification("You won't see players names.","0,255,255")	
	end
end
concommand.Add("gms_TogglePlayerDisplay",TogglePlayerDisplay)

function GM.GMS_ResourceDropsHUD()
	local ply = LocalPlayer()
	local str = nil
	local draw_loc = nil
	local w, h = nil, nil
	local tr = nil
	local cent = nil
	local pos = ply:GetShootPos()

	for _, v in ipairs(ents.GetAll()) do
		if v == LocalPlayer() then
		
		else
			if v:IsWeapon() then

			elseif v:IsPlayer() then
				if tobool(gms_CheckSettings("DrawOtherPlayerNames")) == true then
					local distance = (v:GetPos() - LocalPlayer():GetPos()):Length()
					if distance < 500 then
						local pos = v:GetShootPos()
						local str = ""
						draw_pos = pos:ToScreen()
						surface.SetFont("ResFont1")
						w, h = surface.GetTextSize(str)
						if draw_pos.x - ((w + 10) / 2)  < 0 then
							draw_pos.x = 24
							str = "Player"
						elseif draw_pos.x + ((w + 10) / 2) > ScrW() then
							draw_pos.x = ScrW() - 24
							str = "Player"
						end
						if draw_pos.y - ((h + 10) / 2)  < 0 then
							draw_pos.y = 18
							str = "Player"
						elseif draw_pos.y + ((h + 10) / 2) > ScrH() then
							draw_pos.y = ScrH() - 18
							str = "Player"
						end
						if v:Alive() and str == "" then
							str = ("Player: "..v:Nick())
						elseif str == "" then
							str = ("[--R.I.P--]  "..v:Nick())
						end
						if !(str == "") then
							w, h = surface.GetTextSize(str)
							draw.RoundedBox( 4, draw_pos.x-(w/2)-5, draw_pos.y-(h/2)-5, w+10, h+10, Color(0,0,0,160) )
							draw.RoundedBox( 4, draw_pos.x-(w/2)-3, draw_pos.y-(h/2)-3, w+6, h+6, Color(180,180,180,160) )
							surface.SetTextColor( 255, 180, 0, 200 )
							surface.SetTextPos( draw_pos.x-(w/2), draw_pos.y-(h/2) )
							surface.DrawText( str )
						end
					end
					if ValidEntity(v:GetActiveWeapon()) then
						v = v:GetActiveWeapon()
						cent = v:GetPos()
						local minimum = v:LocalToWorld(v:OBBMins())
						local maximum = v:LocalToWorld(v:OBBMaxs())
						local loc = Vector(0,0,0)
						local distance = (maximum - minimum):Length()
						if distance < 200 then distance = 200 end
						
						tr2 = {}
						tr2.start = pos
						tr2.endpos = Vector(cent.x,cent.y,pos.z)
						tr2.filter = ply
						


						if (cent-pos):Length() <= 200 and (util.TraceLine(tr2).Entity == v or !util.TraceLine(tr2).Hit) then
							local amount = math.floor((v:GetNetworkedInt("WaterAmount") or 0))
							if amount > 100 then
								amount = 100
							elseif amount < 0 then
								amount = 0
							end
							str = (v:GetClass())
							if minimum.z <= maximum.z then
								if pos.z > maximum.z then
									loc.z = maximum.z
								elseif pos.z < minimum.z then
									loc.z = minimum.z
								else
									loc.z = pos.z
								end
							else
								if pos.z < maximum.z then
									loc.z = maximum.z
								elseif pos.z > minimum.z then
									loc.z = minimum.z
								else
									loc.z = pos.z
								end
							end
							draw_loc = Vector(cent.x,cent.y,cent.z):ToScreen()
							surface.SetFont("ResFont1")
							w, h = surface.GetTextSize(str)
							draw.RoundedBox( 4, draw_loc.x-(w/2)-5, draw_loc.y-(h/2)-5, w+10, h+10, Color(0,0,0,160) )
							draw.RoundedBox( 4, draw_loc.x-(w/2)-3, draw_loc.y-(h/2)-3, w+6, h+6, Color(180,180,180,160) )
							surface.SetTextColor( 255, 255, 0, 200 )
							surface.SetTextPos( draw_loc.x-(w/2), draw_loc.y-(h/2) )
							surface.DrawText( str )
						end
					end
				end
			elseif ValidEntity(v) then
				if v:GetClass() == "gms_resourcedrop" then
					cent = v:LocalToWorld(v:OBBCenter())
					
					tr = {}
					tr.start = pos
					tr.endpos = cent
					tr.filter = ply

					if (cent-pos):Length() <= 200 and util.TraceLine(tr).Entity == v then
						str = (v.Res or "Loading")..": "..tostring(v.Amount or 0)
						draw_loc = cent:ToScreen()
						surface.SetFont("ResFont1")
						w, h = surface.GetTextSize(str)
						draw.RoundedBox( 4, draw_loc.x-(w/2)-5, draw_loc.y-(h/2)-5, w+10, h+10, Color(0,0,0,160) )
						draw.RoundedBox( 4, draw_loc.x-(w/2)-3, draw_loc.y-(h/2)-3, w+6, h+6, Color(180,180,180,160) )
						surface.SetTextColor( 255, 255, 255, 200 )
						surface.SetTextPos( draw_loc.x-(w/2), draw_loc.y-(h/2) )
						surface.DrawText( str )
					end
				elseif string.find(v:GetClass(),"gms_waterf") then
					cent = v:LocalToWorld(v:OBBCenter())
					local minimum = v:LocalToWorld(v:OBBMins())
					local maximum = v:LocalToWorld(v:OBBMaxs())
					local loc = Vector(0,0,0)
					local distance = (maximum - minimum):Length()
					if distance < 200 then distance = 200 end
					
					tr2 = {}
					tr2.start = pos
					tr2.endpos = Vector(cent.x,cent.y,pos.z)
					tr2.filter = ply
					


					if (cent-pos):Length() <= distance and (util.TraceLine(tr2).Entity == v or !util.TraceLine(tr2).Hit) then
						local amount = math.floor((v:GetNetworkedInt("WaterAmount") or 0))
						if amount > 100 then
							amount = 100
						elseif amount < 0 then
							amount = 0
						end
						str = ("Drinking Fountain: "..amount.."%")
						if minimum.z <= maximum.z then
							if pos.z > maximum.z then
								loc.z = maximum.z
							elseif pos.z < minimum.z then
								loc.z = minimum.z
							else
								loc.z = pos.z
							end
						else
							if pos.z < maximum.z then
								loc.z = maximum.z
							elseif pos.z > minimum.z then
								loc.z = minimum.z
							else
								loc.z = pos.z
							end
						end
						draw_loc = Vector(cent.x,cent.y,loc.z):ToScreen()
						surface.SetFont("ResFont1")
						w, h = surface.GetTextSize(str)
						draw.RoundedBox( 4, draw_loc.x-(w/2)-5, draw_loc.y-(h/2)-5, w+10, h+10, Color(0,0,0,160) )
						draw.RoundedBox( 4, draw_loc.x-(w/2)-3, draw_loc.y-(h/2)-3, w+6, h+6, Color(0,0,180,160) )
						surface.SetTextColor( 255, 255, 255, 200 )
						surface.SetTextPos( draw_loc.x-(w/2), draw_loc.y-(h/2) )
						surface.DrawText( str )
					end
				elseif string.find(v:GetClass(),"gms_") && !(v:GetClass() == "gms_resourcedrop") then
					
					cent = v:LocalToWorld(v:OBBCenter())
					local minimum = v:LocalToWorld(v:OBBMins())
					local maximum = v:LocalToWorld(v:OBBMaxs())
					local loc = Vector(0,0,0)
					local distance = (maximum - minimum):Length()
					if distance < 200 then distance = 200 end
					
					tr2 = {}
					tr2.start = pos
					tr2.endpos = Vector(cent.x,cent.y,pos.z)
					tr2.filter = ply
					


					if (cent-pos):Length() <= distance and (util.TraceLine(tr2).Entity == v or !util.TraceLine(tr2).Hit) then
						str = (v:GetNetworkedString('Name') or "Loading")
						if str == "" or str == " " then
							str = v:GetClass()
						end
						if v:GetClass() == "gms_buildsite" then
							str = str..v:GetNetworkedString('Resources')
						end
						if minimum.z <= maximum.z then
							if pos.z > maximum.z then
								loc.z = maximum.z
							elseif pos.z < minimum.z then
								loc.z = minimum.z
							else
								loc.z = pos.z
							end
						else
							if pos.z < maximum.z then
								loc.z = maximum.z
							elseif pos.z > minimum.z then
								loc.z = minimum.z
							else
								loc.z = pos.z
							end
						end
						draw_loc = Vector(cent.x,cent.y,loc.z):ToScreen()
						surface.SetFont("ResFont1")
						w, h = surface.GetTextSize(str)
						draw.RoundedBox( 4, draw_loc.x-(w/2)-5, draw_loc.y-(h/2)-5, w+10, h+10, Color(0,0,0,160) )
						draw.RoundedBox( 4, draw_loc.x-(w/2)-3, draw_loc.y-(h/2)-3, w+6, h+6, Color(180,180,180,160) )
						surface.SetTextColor( 255, 255, 255, 200 )
						surface.SetTextPos( draw_loc.x-(w/2), draw_loc.y-(h/2) )
						surface.DrawText( str )
					end
				end
			end
		end
	end
end
hook.Add( "HUDPaint", "GMS_ResourceDropsHUD", GM.GMS_ResourceDropsHUD )