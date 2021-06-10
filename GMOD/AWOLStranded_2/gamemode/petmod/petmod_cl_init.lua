function PetMod_HUDPaint()
	local tr = utilx.GetPlayerTrace(LocalPlayer(), LocalPlayer():GetCursorAimVector())
	local trace = util.TraceLine(tr)
	if trace.Hit  then
		if trace.HitNonWorld then 
		local Entity = trace.Entity
			if(Entity:IsValid() and Entity:IsNPC() and Entity:GetNetworkedBool("IsPet") == true) then
				local Name = Entity:GetNetworkedString("Name")
				local Owner = Entity:GetNetworkedEntity("Player")
				local Age = Entity:GetNetworkedString("Age")
				local Gender = Entity:GetNetworkedString("Gender")
				
				local Pos = Entity:GetPos() - LocalPlayer():GetPos()
				local Alpha  = 255
				
				surface.SetFont("TargetID")
				local x, y = gui.MousePos()
				if(x == 0 and y == 0) then
					x = ScrW() / 2
					y = ScrH() / 2
				end
				
				draw.SimpleText("Name: "..Name, "ChatFont", x, y + 32, Color(255, 255, 255, Alpha), 1, 1)
				draw.SimpleText("Owner: "..Owner:Nick(), "ChatFont", x, y + 48, Color(255, 255, 255, Alpha), 1, 1)
				draw.SimpleText("Age: "..Age, "ChatFont", x, y + 64, Color(255, 255, 255, Alpha), 1, 1)
				draw.SimpleText("Gender: "..Gender, "ChatFont", x, y + 80, Color(255, 255, 255, Alpha), 1, 1)
			end
		end
	end
end
hook.Add("HUDPaint", "PetMod_HUDPaint", PetMod_HUDPaint)



PetFunctionsOpen = 0
function OpenPetFunctions()
	if PetFunctionsOpen == 0 then
		PetFunctionsOpen = 1
		local col = {255,180,0}
		local Selected = ""
		local clicksound = "ui/buttonclick.wav"
		PetFunctionsMenu_DFrame = vgui.Create ( "DFrame")
		local sw = ScrW()
		local sh = ScrH()
		local Height = 170
		local Width = 200
		gui.SetMousePos(205 + Width / 2 , Height / 2)
		PetFunctionsMenu_DFrame:SetPos(205 ,0)
		PetFunctionsMenu_DFrame:SetSize ( Width, Height)
		PetFunctionsMenu_DFrame:SetTitle (" ")
		PetFunctionsMenu_DFrame:SetVisible(true)
		PetFunctionsMenu_DFrame:SetDraggable(false)
		PetFunctionsMenu_DFrame:MakePopup()
		PetFunctionsMenu_DFrame:ShowCloseButton(false)
		PetFunctionsMenu_DFrame:SetKeyboardInputEnabled(false)
			PetFunctionsMenu_DFrame.Paint = function()
				draw.RoundedBox(6, 0, 0, PetFunctionsMenu_DFrame:GetWide(), PetFunctionsMenu_DFrame:GetTall(), Color(0,0,0,160))
				draw.RoundedBox(6, 5, 5, PetFunctionsMenu_DFrame:GetWide() - 10, PetFunctionsMenu_DFrame:GetTall() - 10, Color(180,180,180,160))
				surface.SetDrawColor(color_white)	
			end	

			
		
		
		--Graphical
		PetFunctionsMenu_DButton6 = vgui.Create( "DButton", PetFunctionsMenu_DFrame)
		PetFunctionsMenu_DButton6:SetPos(20, 10)
		PetFunctionsMenu_DButton6:SetSize(Width - 40, 25)
		PetFunctionsMenu_DButton6:SetText("ADOPT")
		PetFunctionsMenu_DButton6:SetVisible(true)
		PetFunctionsMenu_DButton6.DoClick = function ( btn )
			local Options123 = DermaMenu()
				local pets = {"headcrab", "headcrab_fast", "headcrab_black",  "antlion", "pigeon", "crow", "seagull",  "cscanner"}
			for k,v in pairs(pets) do 
				Options123:AddOption ("Adopt "..v ,function ()
					RunConsoleCommand("gms_pet_adopt",v)
					LocalPlayer():EmitSound(Sound(clicksound))
				end)
			end

			Options123:AddOption ("Nevermind" ,function ()
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			LocalPlayer():EmitSound(Sound(clicksound))
			Options123:Open()
			ClosePetFunctions()
		end
		
		PetFunctionsMenu_DButton6.Paint = function()
			if PetFunctionsMenu_DButton6.Hovered then
				draw.RoundedBox(8, 0, 0, PetFunctionsMenu_DButton6:GetWide(), PetFunctionsMenu_DButton6:GetTall(), Color(90,90,90,255))
			else
				draw.RoundedBox(8, 0, 0, PetFunctionsMenu_DButton6:GetWide(), PetFunctionsMenu_DButton6:GetTall(), Color(60,60,60,255))
			end
		end	
		
		--Drop
		PetFunctionsMenu_DButton2 = vgui.Create( "DButton", PetFunctionsMenu_DFrame)
		PetFunctionsMenu_DButton2:SetPos(20, 40)
		PetFunctionsMenu_DButton2:SetSize(Width - 40, 25)
		PetFunctionsMenu_DButton2:SetText("MENU")
		PetFunctionsMenu_DButton2:SetVisible(true)
		PetFunctionsMenu_DButton2.DoClick = function ( btn )
			AddNotification("Better menu is coming soon.","0,255,255")	
			LocalPlayer():EmitSound(Sound(clicksound))
			ClosePetFunctions()
		end
		
		PetFunctionsMenu_DButton2.Paint = function()
			if PetFunctionsMenu_DButton2.Hovered then
				draw.RoundedBox(8, 0, 0, PetFunctionsMenu_DButton2:GetWide(), PetFunctionsMenu_DButton2:GetTall(), Color(90,90,90,255))
			else
				draw.RoundedBox(8, 0, 0, PetFunctionsMenu_DButton2:GetWide(), PetFunctionsMenu_DButton2:GetTall(), Color(60,60,60,255))
			end
		end	
		
		--Make
		PetFunctionsMenu_DButton3 = vgui.Create( "DButton", PetFunctionsMenu_DFrame)
		PetFunctionsMenu_DButton3:SetPos(20, 70)
		PetFunctionsMenu_DButton3:SetSize(Width - 40, 25)
		PetFunctionsMenu_DButton3:SetText("ACTIONS")
		PetFunctionsMenu_DButton3:SetVisible(true)
		PetFunctionsMenu_DButton3.DoClick = function ( btn )
			local Options123 = DermaMenu()
			Options123:AddOption ("Name" ,function ()
				AddNotification("Please use gms_pet_name in console. Expect menu soon.","0,255,255")	
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			Options123:AddOption ("Move" ,function ()
				RunConsoleCommand("gms_pet_move")	
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			
			Options123:AddOption ("Follow" ,function ()
				RunConsoleCommand("gms_pet_follow")	
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			
			Options123:AddOption ("Stay" ,function ()
				RunConsoleCommand("gms_pet_stay")	
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			
			Options123:AddOption ("Wander" ,function ()
				RunConsoleCommand("gms_pet_wander")	
				LocalPlayer():EmitSound(Sound(clicksound))
			end)

			LocalPlayer():EmitSound(Sound(clicksound))
			Options123:Open()
			ClosePetFunctions()
		end
		
		PetFunctionsMenu_DButton3.Paint = function()
			if PetFunctionsMenu_DButton3.Hovered then
				draw.RoundedBox(8, 0, 0, PetFunctionsMenu_DButton3:GetWide(), PetFunctionsMenu_DButton3:GetTall(), Color(90,90,90,255))
			else
				draw.RoundedBox(8, 0, 0, PetFunctionsMenu_DButton3:GetWide(), PetFunctionsMenu_DButton3:GetTall(), Color(60,60,60,255))
			end
		end	
		
		
		--Other
		PetFunctionsMenu_DButton4 = vgui.Create( "DButton", PetFunctionsMenu_DFrame)
		PetFunctionsMenu_DButton4:SetPos(20, 100)
		PetFunctionsMenu_DButton4:SetSize(Width - 40, 25)
		PetFunctionsMenu_DButton4:SetText("FEED")
		PetFunctionsMenu_DButton4:SetVisible(true)
		PetFunctionsMenu_DButton4.DoClick = function ( btn )
			RunConsoleCommand("gms_pet_feed")	
			LocalPlayer():EmitSound(Sound(clicksound))
			ClosePetFunctions()
		end
		
		PetFunctionsMenu_DButton4.Paint = function()
			if PetFunctionsMenu_DButton4.Hovered then
				draw.RoundedBox(8, 0, 0, PetFunctionsMenu_DButton4:GetWide(), PetFunctionsMenu_DButton4:GetTall(), Color(90,90,90,255))
			else
				draw.RoundedBox(8, 0, 0, PetFunctionsMenu_DButton4:GetWide(), PetFunctionsMenu_DButton4:GetTall(), Color(60,60,60,255))
			end
		end	
		
		--CLOSE
		PetFunctionsMenu_DButton5 = vgui.Create( "DButton", PetFunctionsMenu_DFrame)
		PetFunctionsMenu_DButton5:SetPos(20, 130)
		PetFunctionsMenu_DButton5:SetSize(Width - 40, 25)
		PetFunctionsMenu_DButton5:SetText("CLOSE")
		PetFunctionsMenu_DButton5:SetVisible(true)
		PetFunctionsMenu_DButton5.DoClick = function ( btn )
			LocalPlayer():EmitSound(Sound(clicksound))
			ClosePetFunctions()
		end
		
		PetFunctionsMenu_DButton5.Paint = function()
			if PetFunctionsMenu_DButton5.Hovered then
				draw.RoundedBox(8, 0, 0, PetFunctionsMenu_DButton5:GetWide(), PetFunctionsMenu_DButton5:GetTall(), Color(90,90,90,255))
			else
				draw.RoundedBox(8, 0, 0, PetFunctionsMenu_DButton5:GetWide(), PetFunctionsMenu_DButton5:GetTall(), Color(60,60,60,255))
			end
		end	
	else
		ClosePetFunctions()
	end
end

function ClosePetFunctions()
	if PetFunctionsOpen == 1 then
		PetFunctionsOpen = 0
		PetFunctionsMenu_DFrame:SetVisible(false)
	end
end

concommand.Add("gms_petmenu",OpenPetFunctions)