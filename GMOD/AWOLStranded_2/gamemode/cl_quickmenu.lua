
clicksound = "ui/buttonclick.wav"
local SRMenu = false
local CurMenu = {}
local Radius = 200
local Offset = 10
local LastSwitch = 0
local CenterX = ScrW()/2
local CenterY = ScrH()/2

function RadMenuPaint()
	if !CurMenu then return end
	if !SRMenu then return end
	local angspace = (1/table.Count(CurMenu))*360
	surface.SetFont("Default")
	surface.SetTextColor(255,255,255,255)
	CenterX = ScrW()/2
	CenterY = ScrH()/2

	for k,v in ipairs(CurMenu) do
		local x = (math.sin(math.rad((k*angspace)+Offset))*Radius) + CenterX
		local y = (math.cos(math.rad((k*angspace)+Offset))*Radius) + CenterY

		local w,h = surface.GetTextSize(v.name)
		x=x-(w/2)
		y=y-(h/2)
		surface.SetTextPos(x,y)
		draw.RoundedBox(8, x - Radius / 10, y- Radius / 10, w + Radius / 5, h + Radius / 5, Color(0,0,0,255))
		draw.RoundedBox(8, x - Radius / 20, y- Radius / 20, w + Radius / 10, h + Radius / 10, Color(90,90,90,255))
		surface.DrawText(v.name)
		local mx, my = gui.MousePos()
		w = w + Radius / 10
		h = h + Radius / 10
		x = x - Radius / 20
		y = y- Radius / 20
		if (mx < x+w and mx > x and my < y+h and my > y) and LastSwitch + 0.2 < CurTime() then
			LocalPlayer():EmitSound(Sound(clicksound))
			if v.sub == 1 then
				local num = 1
				CurMenu = {}
				for k2,v2 in pairs(SRItems) do 
					if v2.name then
						if v2.parent == v.name && v.name != v2.name then
							CurMenu[num] = v2
							num = num + 1
						end
					end
				end
				Offset = Offset + 10
				gui.SetMousePos(CenterX , CenterY)
			else
				v.command()
				StrandedRadialOff()
			end
			LastSwitch=CurTime()
		end
	end
end
hook.Add("HUDPaint", "SRMenu", RadMenuPaint)
SRItems = {}
function RegisterMenu(name,sub,command,parent)
	if SRItems[name] then
		print("ERROR ALREADY A COMMAND")
	else
		SRItems[name] = {}
		local item = SRItems[name]
		if sub == 1 then
			item.sub = 1
		else
			item.sub = 0
		end
		if parent != "NA" then
			if SRItems[parent] then
				if SRItems[parent].sub == 1 then
					item.parent = parent
					item.command = command
					item.name = name
				else
					print("INVALID PARENT")
				end
			else
				print("INVALID PARENT")
			end
		else
			item.command = command
			item.name = name
			item.parent = "NA"
		end
		if !(item.name && item.sub && item.command && item.parent) then
			SRItems[name] = {}
		end
	end
end


local HaxPanel;

function StrandedRadialOn(ply)
	HaxPanel = vgui.Create("DPanel")
	HaxPanel:SetPos(0,0)
	HaxPanel:SetSize(ScrW(),ScrH())
	HaxPanel:MakePopup()
	HaxPanel:SetKeyboardInputEnabled(false)
	HaxPanel.Paint = function()
		return
	end
	
	SRMenu = true
	CurMenu = {}
	local num = 1
	for k,v in pairs(SRItems) do 
		if v.name then
			if v.parent == "NA" then
				CurMenu[num] = v
				num = num + 1
			end
		end
	end
	CenterX=ScrW()/2
	CenterY=ScrH()/2
	gui.SetMousePos(CenterX , CenterY)
	RunConsoleCommand("-attack")	
	RunConsoleCommand("-use")	
	HaxPanelOpen = 1
	
end
concommand.Add("+srad", StrandedRadialOn)

function StrandedRadialOff(ply)
	SRMenu = false
	Offset = 10
	if !HaxPanel then return end
	HaxPanel:SetVisible(false)
	HaxPanelOpen = 0
end
concommand.Add("-srad", StrandedRadialOff)

function DEBUGSHIT(ply,cmd,args)
	PrintTable(SRItems)
	PrintTable(CurMenu)
end
concommand.Add("srad_debug", DEBUGSHIT)





--Name|| Whether it can have sub menus||command||if it is a subattribute then to which

--DROP
local col = {255,180,0}
RegisterMenu("Drop",1,0,"NA")
local function X ()
	LocalPlayer():ConCommand("gms_dropall")
end
RegisterMenu("All resources",0,X,"Drop")

local function X ()
	LocalPlayer():ConCommand("gms_OpenDropResourceWindow")
end
RegisterMenu("Resource Menu",0,X,"Drop")

local function X ()
	LocalPlayer():ConCommand("gms_dropweapon")
end
RegisterMenu("Weapon",0,X,"Drop")

--COMMANDS

--Actions
RegisterMenu("Actions",1,0,"NA")
local function X ()
	LocalPlayer():ConCommand("gms_sleep")
end
RegisterMenu("Sleep",0,X,"Actions")

local function X ()
	LocalPlayer():ConCommand("gms_gms_wakeup")
end
RegisterMenu("Wake up",0,X,"Actions")

local function X ()
	LocalPlayer():ConCommand("+attack")
end
RegisterMenu("+Attack",0,X,"Actions")
local function X ()
	LocalPlayer():ConCommand("+use")
end
RegisterMenu("+use",0,X,"Actions")

local function X ()
	LocalPlayer():ConCommand("gm_showspare2")
end
RegisterMenu("HELP ME",0,X,"Actions")

local function X ()
	LocalPlayer():ConCommand("gms_PVP")
end
RegisterMenu("Toggle PVP",0,X,"Actions")
--Planting

RegisterMenu("Planting",1,0,"NA")
local function X ()
	LocalPlayer():ConCommand("gms_plantmelon")
end
RegisterMenu("Melon",0,X,"Planting")

local function X ()
	LocalPlayer():ConCommand("gms_plantorange")
end
RegisterMenu("Orange",0,X,"Planting")

local function X ()
	LocalPlayer():ConCommand("gms_plantbanana")
end
RegisterMenu("Banana",0,X,"Planting")

local function X ()
	LocalPlayer():ConCommand("gms_plantbush")
end
RegisterMenu("Berries",0,X,"Planting")

local function X ()
	LocalPlayer():ConCommand("gms_planttree")
end
RegisterMenu("Tree",0,X,"Planting")

local function X ()
	LocalPlayer():ConCommand("gms_plantgrain")
end
RegisterMenu("Grain",0,X,"Planting")


RegisterMenu("Graphics",1,0,"NA")
local function X ()
	LocalPlayer():ConCommand("gms_DayNight")
end
RegisterMenu("Toggle Day and Night",0,X,"Graphics")

local function X ()
	LocalPlayer():ConCommand("gms_rain")
end
RegisterMenu("Toggle rain",0,X,"Graphics")

local function X ()
	RunConsoleCommand("gms_qmenu")	
end
RegisterMenu("Q Menu",0,X,"Graphics")

local function X ()
	RunConsoleCommand("gms_f3menu")	
end
RegisterMenu("F3Menu",0,X,"Graphics")

local function X ()
	if QuestStatus == 1 then
		QuestStatus = 0
		AddNotification("Quest message will not show.","0,0,255")
	else
		QuestStatus = 1
		AddNotification("Quest message will show.","0,0,255")	
	end
end


local function X ()
	if CanSobel == 1 then
		CanSobel = 0
		RunConsoleCommand("pp_sobel",0)
		AddNotification("Sobel effects can't be used when needed.","0,0,255")	
	else
		CanSobel = 1
		AddNotification("Sobel effects can be used when needed.","0,0,255")	
	end
end
RegisterMenu("Sobel",0,X,"Graphics")

RegisterMenu("Menus",1,0,"NA")

local function X ()
	LocalPlayer():ConCommand("gms_buildingscombi")
end
RegisterMenu("Structures",0,X,"Menus")

local function X ()
	LocalPlayer():ConCommand("gms_SpecialBuildingsCombi")
end
RegisterMenu("Special Buildings",0,X,"Menus")

local function X ()
	LocalPlayer():ConCommand("gms_TrophysCombi")
end
RegisterMenu("Trophys",0,X,"Menus")
local function X ()
	LocalPlayer():ConCommand("gms_genericcombi")
end
RegisterMenu("Combinations",0,X,"Menus")

local function X ()
	LocalPlayer():ConCommand("gms_openquest")
end
RegisterMenu("Quest",0,X,"Menus")

local function X ()
	LocalPlayer():ConCommand("ppro_friendsmenu")
end
RegisterMenu("Prop Protection",0,X,"Menus")

local function X ()
	LocalPlayer():ConCommand("gms_plantyplant")
end
RegisterMenu("Plant Menu",0,X,"Menus")







QuickFunctionsOpen = 0
function OpenQuickFunctions()
	if QuickFunctionsOpen == 0 then
		QuickFunctionsOpen = 1
		local col = {255,180,0}
		RunConsoleCommand("-attack")
		RunConsoleCommand("-use")
		local Selected = ""
		local clicksound = "ui/buttonclick.wav"
		QuickFunctionsMenu_DFrame = vgui.Create ( "DFrame")
		local sw = ScrW()
		local sh = ScrH()
		local Height = 170
		local Width = 200
		gui.SetMousePos(205 + Width / 2 , Height / 2)
		QuickFunctionsMenu_DFrame:SetPos(205 ,0)
		QuickFunctionsMenu_DFrame:SetSize ( Width, Height)
		QuickFunctionsMenu_DFrame:SetTitle (" ")
		QuickFunctionsMenu_DFrame:SetVisible(true)
		QuickFunctionsMenu_DFrame:SetDraggable(false)
		QuickFunctionsMenu_DFrame:MakePopup()
		QuickFunctionsMenu_DFrame:ShowCloseButton(false)
		QuickFunctionsMenu_DFrame:SetKeyboardInputEnabled(false)
			QuickFunctionsMenu_DFrame.Paint = function()
				draw.RoundedBox(6, 0, 0, QuickFunctionsMenu_DFrame:GetWide(), QuickFunctionsMenu_DFrame:GetTall(), Color(0,0,0,160))
				draw.RoundedBox(6, 5, 5, QuickFunctionsMenu_DFrame:GetWide() - 10, QuickFunctionsMenu_DFrame:GetTall() - 10, Color(180,180,180,160))
				surface.SetDrawColor(color_white)	
			end	

			
		
		
		--Graphical
		QuickFunctionsMenu_DButton6 = vgui.Create( "DButton", QuickFunctionsMenu_DFrame)
		QuickFunctionsMenu_DButton6:SetPos(20, 10)
		QuickFunctionsMenu_DButton6:SetSize(Width - 40, 25)
		QuickFunctionsMenu_DButton6:SetText("GRAPHICS")
		QuickFunctionsMenu_DButton6:SetVisible(true)
		QuickFunctionsMenu_DButton6.DoClick = function ( btn )
			local Options123 = DermaMenu()
			Options123:AddOption ("Toggle Day/Night" ,function ()
				RunConsoleCommand("gms_DayNight")
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			Options123:AddOption ("Toggle Clock" ,function ()
				RunConsoleCommand("gms_togglethetime")
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			Options123:AddOption ("Toggle Sobel" ,function ()
				if tobool(gms_CheckSettings("CanSobel")) == true then
					gms_SetSetting("CanSobel",false)
					RunConsoleCommand("pp_sobel",0)
					AddNotification("Sobel effects will not be used when needed.","0,0,255")		
				else
					gms_SetSetting("CanSobel",true)
					AddNotification("Sobel effects will be used when needed.","0,0,255")	
				end
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			Options123:AddOption ("Toggle Rain" ,function ()
				RunConsoleCommand("gms_rain")	
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			
			Options123:AddOption ("Toggle Player Names" ,function ()
				RunConsoleCommand("gms_TogglePlayerDisplay")	
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			
			Options123:AddOption ("Toggle Q Menu" ,function ()
				RunConsoleCommand("gms_qmenu")	
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			Options123:AddOption ("Toggle Quest Stats Bar" ,function ()
				if tobool(gms_CheckSettings("ShowQuestStatus")) == true then
					gms_SetSetting("ShowQuestStatus",false)
					AddNotification("Quest messages will not show.","0,0,255")	
				else
					gms_SetSetting("ShowQuestStatus",true)
					AddNotification("Quest messages will show.","0,0,255")
				end
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			Options123:AddOption ("Nevermind" ,function ()
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			LocalPlayer():EmitSound(Sound(clicksound))
			Options123:Open()
			CloseQuickFunctions()
		end
		
		QuickFunctionsMenu_DButton6.Paint = function()
			if QuickFunctionsMenu_DButton6.Hovered then
				draw.RoundedBox(8, 0, 0, QuickFunctionsMenu_DButton6:GetWide(), QuickFunctionsMenu_DButton6:GetTall(), Color(90,90,90,255))
			else
				draw.RoundedBox(8, 0, 0, QuickFunctionsMenu_DButton6:GetWide(), QuickFunctionsMenu_DButton6:GetTall(), Color(60,60,60,255))
			end
		end	
		
		--Drop
		QuickFunctionsMenu_DButton2 = vgui.Create( "DButton", QuickFunctionsMenu_DFrame)
		QuickFunctionsMenu_DButton2:SetPos(20, 40)
		QuickFunctionsMenu_DButton2:SetSize(Width - 40, 25)
		QuickFunctionsMenu_DButton2:SetText("DROP")
		QuickFunctionsMenu_DButton2:SetVisible(true)
		QuickFunctionsMenu_DButton2.DoClick = function ( btn )
			local Options123 = DermaMenu()
			Options123:AddOption ("Weapon" ,function ()
				RunConsoleCommand("gms_dropweapon")
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			Options123:AddOption ("All resources" ,function ()
				RunConsoleCommand("gms_dropall")	
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			Options123:AddOption ("Certain Resources" ,function ()
				RunConsoleCommand("gms_OpenDropResourceWindow")	
				AddNotification("Sometimes this menu doesn't work. Try it again.","0,0,255")	
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			Options123:AddOption ("Nevermind" ,function ()
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			LocalPlayer():EmitSound(Sound(clicksound))
			Options123:Open()
			CloseQuickFunctions()
		end
		
		QuickFunctionsMenu_DButton2.Paint = function()
			if QuickFunctionsMenu_DButton2.Hovered then
				draw.RoundedBox(8, 0, 0, QuickFunctionsMenu_DButton2:GetWide(), QuickFunctionsMenu_DButton2:GetTall(), Color(90,90,90,255))
			else
				draw.RoundedBox(8, 0, 0, QuickFunctionsMenu_DButton2:GetWide(), QuickFunctionsMenu_DButton2:GetTall(), Color(60,60,60,255))
			end
		end	
		
		--Make
		QuickFunctionsMenu_DButton3 = vgui.Create( "DButton", QuickFunctionsMenu_DFrame)
		QuickFunctionsMenu_DButton3:SetPos(20, 70)
		QuickFunctionsMenu_DButton3:SetSize(Width - 40, 25)
		QuickFunctionsMenu_DButton3:SetText("MENUS")
		QuickFunctionsMenu_DButton3:SetVisible(true)
		QuickFunctionsMenu_DButton3.DoClick = function ( btn )
			local Options123 = DermaMenu()
			Options123:AddOption ("Combinations" ,function ()
				RunConsoleCommand("gms_GenericCombi")	
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			Options123:AddOption ("Structures" ,function ()
				RunConsoleCommand("gms_BuildingsCombi")	
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			
			Options123:AddOption ("SpecialBuildings" ,function ()
				RunConsoleCommand("gms_SpecialBuildingsCombi")	
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			
			Options123:AddOption ("Trophys" ,function ()
				RunConsoleCommand("gms_TrophysCombi")	
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			
			Options123:AddOption ("Quest" ,function ()
				RunConsoleCommand("gms_OpenQuest")	
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			
			Options123:AddOption ("Drop Resource" ,function ()
				RunConsoleCommand("gms_OpenDropResourceWindow")	
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			
			Options123:AddOption ("Plant Menu" ,function ()
				RunConsoleCommand("gms_plantyplant")	
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			
			Options123:AddOption ("Prop Protection" ,function ()
				RunConsoleCommand("ppro_friendsmenu")	
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			if LocalPlayer():IsAdmin() then
				Options123:AddOption ("ADMIN PP menu" ,function ()
				RunConsoleCommand("ppro_settings")	
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			end
			Options123:AddOption ("Nevermind" ,function ()
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			LocalPlayer():EmitSound(Sound(clicksound))
			Options123:Open()
			CloseQuickFunctions()
		end
		
		QuickFunctionsMenu_DButton3.Paint = function()
			if QuickFunctionsMenu_DButton3.Hovered then
				draw.RoundedBox(8, 0, 0, QuickFunctionsMenu_DButton3:GetWide(), QuickFunctionsMenu_DButton3:GetTall(), Color(90,90,90,255))
			else
				draw.RoundedBox(8, 0, 0, QuickFunctionsMenu_DButton3:GetWide(), QuickFunctionsMenu_DButton3:GetTall(), Color(60,60,60,255))
			end
		end	
		
		
		--Other
		QuickFunctionsMenu_DButton4 = vgui.Create( "DButton", QuickFunctionsMenu_DFrame)
		QuickFunctionsMenu_DButton4:SetPos(20, 100)
		QuickFunctionsMenu_DButton4:SetSize(Width - 40, 25)
		QuickFunctionsMenu_DButton4:SetText("OTHER")
		QuickFunctionsMenu_DButton4:SetVisible(true)
		QuickFunctionsMenu_DButton4.DoClick = function ( btn )
			local Options123 = DermaMenu()
			Options123:AddOption ("Sleep" ,function ()
				RunConsoleCommand("gms_sleep")	
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			Options123:AddOption ("Wake up" ,function ()
				RunConsoleCommand("gms_wakeup")	
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			
			Options123:AddOption ("Drink water bottle" ,function ()
				RunConsoleCommand("gms_DrinkBottle")	
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			
			Options123:AddOption ("HELP ME" ,function ()
				RunConsoleCommand("gms_help")	
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			
			Options123:AddOption ("Toggle PVP" ,function ()
				RunConsoleCommand("gms_PVP")	
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			Options123:AddOption ("Toggle Prop damage" ,function ()
				RunConsoleCommand("gms_propdamage")	
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			Options123:AddOption ("+Use" ,function ()
				RunConsoleCommand("+use")	
				AddNotification("Started useing, to stop press F3.","0,0,255")	
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			Options123:AddOption ("+Attack" ,function ()
				RunConsoleCommand("+attack")
				AddNotification("Started attacking, to stop press f3.","0,0,255")	
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			Options123:AddOption ("Nevermind" ,function ()
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			LocalPlayer():EmitSound(Sound(clicksound))
			Options123:Open()
			CloseQuickFunctions()
		end
		
		QuickFunctionsMenu_DButton4.Paint = function()
			if QuickFunctionsMenu_DButton4.Hovered then
				draw.RoundedBox(8, 0, 0, QuickFunctionsMenu_DButton4:GetWide(), QuickFunctionsMenu_DButton4:GetTall(), Color(90,90,90,255))
			else
				draw.RoundedBox(8, 0, 0, QuickFunctionsMenu_DButton4:GetWide(), QuickFunctionsMenu_DButton4:GetTall(), Color(60,60,60,255))
			end
		end	
		
		--CLOSE
		QuickFunctionsMenu_DButton5 = vgui.Create( "DButton", QuickFunctionsMenu_DFrame)
		QuickFunctionsMenu_DButton5:SetPos(20, 130)
		QuickFunctionsMenu_DButton5:SetSize(Width - 40, 25)
		QuickFunctionsMenu_DButton5:SetText("CLOSE")
		QuickFunctionsMenu_DButton5:SetVisible(true)
		QuickFunctionsMenu_DButton5.DoClick = function ( btn )
			LocalPlayer():EmitSound(Sound(clicksound))
			CloseQuickFunctions()
		end
		
		QuickFunctionsMenu_DButton5.Paint = function()
			if QuickFunctionsMenu_DButton5.Hovered then
				draw.RoundedBox(8, 0, 0, QuickFunctionsMenu_DButton5:GetWide(), QuickFunctionsMenu_DButton5:GetTall(), Color(90,90,90,255))
			else
				draw.RoundedBox(8, 0, 0, QuickFunctionsMenu_DButton5:GetWide(), QuickFunctionsMenu_DButton5:GetTall(), Color(60,60,60,255))
			end
		end	
	else
		CloseQuickFunctions()
	end
end

function CloseQuickFunctions()
	if QuickFunctionsOpen == 1 then
		QuickFunctionsOpen = 0
		QuickFunctionsMenu_DFrame:SetVisible(false)
	end
end
F3Text = "QuickMenu"
function Quickmenu(ply)
	OpenQuickFunctions()
	F3Text = "QuickMenu"
end
concommand.Add("gms_quickmenu",Quickmenu)



