/*---------------------------------------------------------

  Gmod Stranded

---------------------------------------------------------*/
DeriveGamemode( "sandbox" )
include( 'shared.lua' )
include( 'cl_scoreboard.lua' )
include( 'cl_NewHelpMenu.lua' )

--Custom panels
include( 'cl_panels.lua' )
--Unlocks
include( 'unlocks.lua' )
--Combis
include( 'combinations.lua' )

--Clientside player variables

--Colours(NeedHud, and 2 others)
StrandedColorTheme = Color(0,0,0,240)
StrandedBorderTheme = Color(0,0,0,180)

Tribes = {}
Skills = {}
Resources = {}
Experience = {}
FeatureUnlocks = {}
MaxResources = 25
Effects = 0
//Stuff for hud
HX = 0
HY = 0
sw = ScrW()
sh = ScrH()
ResHeight = 20
HudMenu = 0
GameLoaded = 1
surface.CreateFont( "coolvetica", 18, 500, true, false, "ResFont1" )
surface.CreateFont( "coolvetica", 32, 500, true, false, "ResFont2" )
surface.CreateFont( "coolvetica", 12, 500, true, false, "ResFont3" )
surface.CreateFont( "coolvetica", 14, 500, true, false, "ResFont4" )
surface.CreateFont( "coolvetica", 16, 500, true, false, "ResFont5" )

local PlayerMeta = FindMetaTable("Player")

/*---------------------------------------------------------
  General / utility
---------------------------------------------------------*/
--Hide other sandbox stuff
function GM:HUDShouldDraw(name)
    if name != "CHudHealth" and name != "CHudBattery" then
        return true
    end
end

function EffectsFuncUSMG( um )
	if Effects < 21 then
	local Effect = um:ReadString()
	local pos = um:ReadVector()
	local Height = um:ReadLong()
	local finalpos = pos + Vector(0,0,Height)

		local eff = EffectData()
		eff:SetOrigin(finalpos)
		util.Effect(Effect,eff)
		Effects = Effects + 1
	end
end

usermessage.Hook("EffectsFunc", EffectsFuncUSMG)

function GM:HUDPaint()
	self.BaseClass:HUDPaint()
	if ProcessCompleteTime then
		local wid = ScrW() / 3
		local hei = ScrH() / 30
		surface.SetDrawColor( 30, 30, 30,150 )
		surface.DrawRect( ScrW() * 0.5 - wid * 0.5, ScrH() / 30, wid, hei )

		local width = ( ( RealTime() - ProcessStart) / ProcessCompleteTime ) * wid
		if width > wid then GAMEMODE.StopProgressBar() end
		surface.SetDrawColor( 0, 200, 0, 255)
		surface.DrawRect( ScrW() * 0.5 - wid * 0.5, ScrH() / 30, width, hei )

		surface.SetDrawColor( 27, 167, 219,255 )
		surface.DrawOutlinedRect( ScrW() * 0.5 - wid * 0.5, ScrH() / 30, wid, hei )

		draw.SimpleText( CurrentProcess, "ScoreboardText", ScrW() * 0.5, hei * 1.5, Color( 255, 255, 255, 255 ), 1, 1 )
	end

end

function PlayerMeta:GetResource(resource)
	GetResource(resource)
	return Resources[resource] or 0
end

function PlayerMeta:SendMessage(Message,time,colour)
	print(message)
end
--Create the HUD
function GM.CreateHUD()
	Hunger = 1000
	Sleepiness = 1000
	Thirst = 1000
	Warmth = 50
	GAMEMODE.LoadingBar = vgui.Create("gms_LoadingBar")
	GAMEMODE.LoadingBar:SetVisible(false)
	GAMEMODE.SavingBar = vgui.Create("gms_SavingBar")
	GAMEMODE.SavingBar:SetVisible(false)
end

usermessage.Hook("gms_CreateInitialHUD",GM.CreateHUD)

--Make Progress bar
function GM.MakeProgressBar(um)
	CurrentProcess = um:ReadString()
	ProcessStart = RealTime()
	ProcessCompleteTime = um:ReadShort()
end

usermessage.Hook("gms_MakeProcessBar",GM.MakeProgressBar)

--Stop progress bar
function GM.StopProgressBar()
	ProcessCompleteTime = false
end

usermessage.Hook("gms_StopProcessBar",GM.StopProgressBar)

//Start a loading bar
function GM.MakeLoadingBar(um)
	GAMEMODE.LoadingBar:Show(um:ReadString())
end

usermessage.Hook("gms_MakeLoadingBar",GM.MakeLoadingBar)

//Stop loading bar
function GM.StopLoadingBar(um)
	GAMEMODE.LoadingBar:Hide()
end

usermessage.Hook("gms_StopLoadingBar",GM.StopLoadingBar)


//Start a saving bar
function GM.MakeSavingBar(um)
	GAMEMODE.SavingBar:Show(um:ReadString())
end

usermessage.Hook("gms_MakeSavingBar",GM.MakeSavingBar)

//Stop saving bar
function GM.StopSavingBar(um)
	GAMEMODE.SavingBar:Hide()
end

usermessage.Hook("gms_StopSavingBar",GM.StopSavingBar)

--Get skill
function GetSkill(skill)
	return Skills[skill] or 0
end

--Set skill
function GM.SetSkill(um)
	Skills[um:ReadString()] = um:ReadShort()

	MaxResources = 25 + (GetSkill("Survival") * 5)
end

usermessage.Hook("gms_SetSkill",GM.SetSkill)

--Get XP
function GetXP(skill)
	return Experience[skill] or 0
end

--Set XP
function GM.SetXP(um)
	Experience[um:ReadString()] = um:ReadShort()
end

usermessage.Hook("gms_SetXP",GM.SetXP)

--Get resource
function GetResource(resource)
	return Resources[resource] or 0
end

--Set Resource
function GM.SetResource(um)
	local res = um:ReadString()
	local amount = um:ReadShort()

	Resources[res] = amount
end

usermessage.Hook("gms_SetResource",GM.SetResource)

--Set max resources
function GM.SetMaxResources(um)
	MaxResources = um:ReadShort()
end

usermessage.Hook("gms_SetMaxResources",GM.SetMaxResources)

--Toggle skills menu
function GM.ToggleSkillsMenu(um)
	if HudMenu == 2 then
		HudMenu = 0
	else
		HudMenu = 2
	end
end

usermessage.Hook("gms_ToggleSkillsMenu",GM.ToggleSkillsMenu)

--Toggle Resources menu
function GM.ToggleResourcesMenu(um)
	if HudMenu == 1 then
		HudMenu = 0
	else
		HudMenu = 1
	end
end

usermessage.Hook("gms_ToggleResourcesMenu",GM.ToggleResourcesMenu)

--Open combi menu
function GM.OpenCombiMenu(um)
	OpenCombi(um:ReadString())
	
end

usermessage.Hook("gms_OpenCombiMenu",GM.OpenCombiMenu)

--Close combi menu
function GM.CloseCombiMenu(um)
	CloseCombi()
end

usermessage.Hook("gms_CloseCombiMenu",GM.CloseCombiMenu)

--Other stuff
function string.Capitalize(str)
	local str = string.Explode("_",str)
	for k,v in pairs(str) do
		str[k] = string.upper(string.sub(v,1,1))..string.sub(v,2)
	end

	str = string.Implode("_",str)
	return str
end

function TraceFromEyes(dist)
	local trace = {}
	trace.start = self:GetShootPos()
	trace.endpos = trace.start + (self:GetAimVector() * dist)
	trace.filter = self

	return util.TraceLine(trace)
end

--Derma Skin
function GM:ForceDermaSkin()
	return "StrandedDermaSkin"
end 

/*---------------------------------------------------------
  Stranded-Like info messages
---------------------------------------------------------*/
GM.InfoMessages = {}
GM.InfoMessageLine = 0

function GM.SendMessage(um)
	local text = um:ReadString()
	local dur = um:ReadShort()
	local col = um:ReadString()
	local str = string.Explode(",",col)
	local col = Color(tonumber(str[1]),tonumber(str[2]),tonumber(str[3]),tonumber(str[4]))

	for k,v in pairs(GAMEMODE.InfoMessages) do
		v.drawline = v.drawline + 1
	end

	local message = {}
	message.Text = text
	message.Col = col
	message.Tab = 5
	message.drawline = 1

	GAMEMODE.InfoMessages[#GAMEMODE.InfoMessages + 1] = message
	GAMEMODE.InfoMessageLine = GAMEMODE.InfoMessageLine + 1



	timer.Simple(dur,GAMEMODE.DropMessage,message)
end

usermessage.Hook("gms_sendmessage",GM.SendMessage)

function CheckName(ent,nametable)
	for k, v in pairs(nametable) do
		if ent:GetClass() == v then return true end		
	end
end

function GM.GMS_ResourceDropsHUD()
	local ply = LocalPlayer()
	local str = nil
	local draw_loc = nil
	local w, h = nil, nil
	local tr = nil
	local cent = nil
	local pos = ply:GetShootPos()

	for _, v in ipairs(ents.GetAll()) do
		match = CheckName(v,GMS.StructureEntities)
		if v:GetClass() == "gms_resourcedrop" then
			cent = v:LocalToWorld(v:OBBCenter())
			
			tr = {}
			tr.start = pos
			tr.endpos = cent
			tr.filter = ply

			if (cent-pos):Length() <= 200 and util.TraceLine(tr).Entity == v then
				str = (v.Res or "Loading")..": "..tostring(v.Amount or 0)
				draw_loc = cent:ToScreen()
				surface.SetFont("ChatFont")
				w, h = surface.GetTextSize(str)
 				draw.RoundedBox( 4, draw_loc.x-(w/2)-3, draw_loc.y-(h/2)-3, w+6, h+6, Color(50,50,50,200) )
				surface.SetTextColor( 255, 255, 255, 200 )
				surface.SetTextPos( draw_loc.x-(w/2), draw_loc.y-(h/2) )
				surface.DrawText( str )
			end
		end

		if match then
			
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
				surface.SetFont("ChatFont")
				w, h = surface.GetTextSize(str)
 				draw.RoundedBox( 4, draw_loc.x-(w/2)-3, draw_loc.y-(h/2)-3, w+6, h+6, Color(50,50,50,200) )
				surface.SetTextColor( 255, 255, 255, 200 )
				surface.SetTextPos( draw_loc.x-(w/2), draw_loc.y-(h/2) )
				surface.DrawText( str )
			end
		end
	end
end
hook.Add( "HUDPaint", "GMS_ResourceDropsHUD", GM.GMS_ResourceDropsHUD )

function GM.DrawMessages()
	for k,msg in pairs(GAMEMODE.InfoMessages) do
		local txt = msg.Text
		local line = ScrH() / 2 + (msg.drawline * 20)
		local tab = msg.Tab
		local col = msg.Col
		draw.SimpleTextOutlined(txt,"ScoreboardText",tab,line,col,0,0,0.5,Color(100,100,100,150))

		if msg.Fading then
			msg.Tab = msg.Tab - (msg.InitTab - msg.Tab - 0.05)

			if msg.Tab > ScrW() + 10 then
				GAMEMODE.RemoveMessage(msg)
			end
		end
	end
end

hook.Add("HUDPaint","gms_drawmessages",GM.DrawMessages)

function GM.DropMessage(msg)
	msg.InitTab = msg.Tab
	msg.Fading = true
end

function GM.RemoveMessage(msg)
	for k,v in pairs(GAMEMODE.InfoMessages) do
		if v == msg then
			GAMEMODE.InfoMessages[k] = nil
			GAMEMODE.InfoMessageLine = GAMEMODE.InfoMessageLine - 1
			table.remove(GAMEMODE.InfoMessages,k)
		end
	end
end
/*---------------------------------------------------------
  Prop fading
---------------------------------------------------------*/
GM.FadingProps = {}
function GM.AddFadingProp(um)
	local mdl = um:ReadString()
	local pos = um:ReadVector()
	local dir = um:ReadVector()
	local speed = um:ReadShort()

	if !mdl or !pos or !dir or !speed then return end

	local ent = ents.Create("prop_physics")
	ent:SetModel(mdl)
	ent:SetPos(pos)
	ent:SetAngles(dir:Angle())
	ent:Spawn()

	ent.Alpha = 255
	ent.Speed = speed

	table.insert(GAMEMODE.FadingProps,ent)
end

usermessage.Hook("gms_CreateFadingProp",GM.AddFadingProp)

function GM.FadeFadingProps()
	local GM = GAMEMODE

	for k,v in pairs(GM.FadingProps) do
		if v.Alpha <= 0 then
			v.Entity:Remove()
			table.remove(GM.FadingProps,k)
		else
			v.Alpha = v.Alpha - (1 * v.Speed)
			v.Entity:SetColor(255,255,255,v.Alpha)
		end
	end
end

hook.Add("Think","gms_FadeFadingPropsHook",GM.FadeFadingProps)


/*---------------------------------------------------------
  Achievement Messages
---------------------------------------------------------*/
GM.AchievementMessages = {}

function GM.SendAchievement(um)
	local text = um:ReadString()

	local tbl = {}
	tbl.Text = text
	tbl.Alpha = 255

	table.insert(GAMEMODE.AchievementMessages,tbl)
end

usermessage.Hook("gms_sendachievement",GM.SendAchievement)


function GM.DrawAchievementMessages()
	for k,msg in pairs(GAMEMODE.AchievementMessages) do
		msg.Alpha = msg.Alpha - 1
		draw.SimpleTextOutlined(msg.Text,"ScoreboardHead",ScrW() / 2,ScrH() / 2,Color(255,255,255,msg.Alpha),1,1,0.5,Color(100,100,100,msg.Alpha))

		if msg.Alpha <= 0 then
			table.remove(GAMEMODE.AchievementMessages,k)
		end
	end
end

hook.Add("HUDPaint","gms_drawachievementmessages",GM.DrawAchievementMessages)
/*---------------------------------------------------------
  Needs
---------------------------------------------------------*/
function GM.SetNeeds(um)
	Sleepiness = um:ReadShort()
	Hunger = um:ReadShort()
	Thirst = um:ReadShort()
	Warmth = um:ReadShort()
	Time = um:ReadShort()
	Light = um:ReadShort()
end
usermessage.Hook("gms_setneeds",GM.SetNeeds)

Time = 0
function GM.DecNeeds()
	if Sleepiness && Thirst && Hunger then
	
	else
		Sleepiness = 1000
		Thirst = 1000
		Hunger = 1000
	end
	Effects = 0
	Time = Time + 1
	if Time > 24 then
		Time = 0
	end
	
	if Sleepiness > 0 then Sleepiness = Sleepiness - 1 end
	if Thirst > 0 then Thirst = Thirst - 3 end
	if Hunger > 0 then Hunger = Hunger - 1 end
	timer.Simple(1,GAMEMODE.DecNeeds)

end
timer.Simple(1,GM.DecNeeds)
/*---------------------------------------------------------
  Help Menu
---------------------------------------------------------*/
function GM.OpenHelpMenu()
	local GM = GAMEMODE

	GM.HelpMenu = vgui.Create("DFrame")
	GM.HelpMenu:MakePopup()
	GM.HelpMenu:SetMouseInputEnabled(true)
	GM.HelpMenu:SetPos(50,50)
	GM.HelpMenu:SetSize(ScrW() - 100, ScrH() - 100)

	GM.HelpMenu:SetTitle("Welcome to GMStranded 2.2")

	GM.HelpMenu.HTML = vgui.Create("HTML",GM.HelpMenu)
	GM.HelpMenu.HTML:SetSize(GM.HelpMenu:GetWide() - 50, GM.HelpMenu:GetTall() - 50)
	GM.HelpMenu.HTML:SetPos(25,25)
	GM.HelpMenu.HTML:SetHTML(file.Read("../gamemodes/GMStranded/content/help/help2.htm"))
end

concommand.Add("gms_help",GM.OpenHelpMenu)

/*---------------------------------------------------------
  Sleep
---------------------------------------------------------*/
function GM.SleepOverlay()
	if !SleepFadeIn and !SleepFadeOut then return end

	if SleepFadeIn and SleepFade < 250 then
		SleepFade = SleepFade + 5
	elseif SleepFadeIn and SleepFade >= 255 then
		SleepFadeIn = false
	end

	if SleepFadeOut and SleepFade > 0 then
		SleepFade = SleepFade - 5
	elseif SleepFadeOut and SleepFade <= 0 then
		SleepFadeOut = false
	end

	surface.SetDrawColor(0,0,0,SleepFade)
	surface.DrawRect(0,0,ScrW(),ScrH())

	draw.SimpleText("Use the command \"!wakeup\" to wake up.","ScoreboardSub",ScrW() / 2, ScrH() / 2, Color(255,255,255,SleepFade),1,1)
end

hook.Add("HUDPaint","gms_sleepoverlay",GM.SleepOverlay)

function GM.StartSleep(um)
	SleepFadeIn = true
	SleepFade = 0
end

usermessage.Hook("gms_startsleep",GM.StartSleep)

function GM.StopSleep(um)
	SleepFadeOut = true
	SleepFade = 255
end

usermessage.Hook("gms_stopsleep",GM.StopSleep)


/*---------------------------------------------------------
 CacheSystem
---------------------------------------------------------*/
CResources = {}
function CacheInfo(um)
		local Res = um:ReadString()
		local amount = um:ReadLong()
		CResources[Res] = amount
		RunConsoleCommand("gms_CacheMenu")
end

usermessage.Hook("gms_ResourceCache", CacheInfo)


function ResetCacheInfo(um)
	CResources = {}
	for k,v in pairs (Resources) do
		CResources[k] = 0
	end
end

usermessage.Hook("gms_ResetCacheData", ResetCacheInfo)

/*---------------------------------------------------------
  AFK
---------------------------------------------------------*/

function GM.AFKOverlay()
	if !AFKFadeIn and !AFKFadeOut then return end

	if AFKFadeIn and AFKFade < 250 then
		AFKFade = AFKFade + 5
	elseif AFKFadeIn and AFKFade >= 255 then
		AFKFadeIn = false
	end

	if AFKFadeOut and AFKFade > 0 then
		AFKFade = AFKFade - 5
	elseif AFKFadeOut and AFKFade <= 0 then
		AFKFadeOut = false
	end

	surface.SetDrawColor(0,0,0,AFKFade)
	surface.DrawRect(0,0,ScrW(),ScrH())

	draw.SimpleText("Use the command \"!afk\" to stop being afk.","ScoreboardSub",ScrW() / 2, ScrH() / 2, Color(255,255,255,AFKFade),1,1)
end

hook.Add("HUDPaint","gms_afkoverlay",GM.AFKOverlay)

function GM.StartAFK(um)
	AFKFadeIn = true
	AFKFade = 0
end

usermessage.Hook("gms_startafk",GM.StartAFK)

function GM.StopAFK(um)
	AFKFadeOut = true
	AFKFade = 255
end

usermessage.Hook("gms_stopafk",GM.StopAFK)

/*---------------------------------------------------------
  Unlock system
---------------------------------------------------------*/
function GM.AddUnlock(um)
	local text = um:ReadString()
	local GM = GAMEMODE

	if !GM.UnlockWindow then GM.UnlockWindow = vgui.Create("GMS_UnlockWindow") end

	GM.UnlockWindow:SetMouseInputEnabled(true)
	GM.UnlockWindow:SetUnlock(text)
	GM.UnlockWindow:SetVisible(true)
end

usermessage.Hook("gms_AddUnlock",GM.AddUnlock)

/*---------------------------------------------------------
  Drop resource menu
---------------------------------------------------------*/
function GM.OpenDropResourceWindow()
	local GM = GAMEMODE

	if !GM.ResourceWindow then GM.ResourceWindow = vgui.Create("GMS_ResourceDropWindow") end

	GM.ResourceWindow:RefreshList()
	GM.ResourceWindow:SetVisible(!GM.ResourceWindow:IsVisible())
end

concommand.Add("gms_OpenDropResourceWindow",GM.OpenDropResourceWindow)

/*---------------------------------------------------------
  Admin menu
---------------------------------------------------------*/
function GM.OpenAdminMenu()
	if !LocalPlayer():IsAdmin() then return end
	local GM = GAMEMODE

	if !GM.AdminMenu then
	GM.AdminMenu = vgui.Create("GMS_AdminMenu")
	GM.AdminMenu:SetVisible(false)
	end
	

	GM.AdminMenu:SetVisible(!GM.AdminMenu:IsVisible())
end

concommand.Add("gms_admin",GM.OpenAdminMenu)

function GM.AddLoadGame(um)
	local GM = GAMEMODE
	if !GM.AdminMenu then GM.AdminMenu = vgui.Create("GMS_AdminMenu") end

	local str = um:ReadString()
	GM.AdminMenu.LoadGameEntry:AddItem(str,str)

	GM.AdminMenu:SetVisible(false)
end

usermessage.Hook("gms_AddLoadGameToList",GM.AddLoadGame)

function GM.RemoveLoadGame(um)
	local GM = GAMEMODE
	if !GM.AdminMenu then GM.AdminMenu = vgui.Create("GMS_AdminMenu") end

	local str = um:ReadString()
	GM.AdminMenu.LoadGameEntry:RemoveItem(str)

end

usermessage.Hook("gms_RemoveLoadGameFromList",GM.RemoveLoadGame)

/*---------------------------------------------------------
  Tribe menu
---------------------------------------------------------*/
function GM.OpenTribeMenu()
         local GM = GAMEMODE

         if !GM.TribeMenu then GM.TribeMenu = vgui.Create("GMS_TribeMenu") end

         GM.TribeMenu:SetVisible(!GM.TribeMenu:IsVisible())
end

concommand.Add("gms_tribemenu",GM.OpenTribeMenu)

/*---------------------------------------------------------
   Tribe system
---------------------------------------------------------*/
function GM.getTribes(data)
	team.SetUp(data:ReadShort(),data:ReadString(),Color(data:ReadShort(),data:ReadShort(),data:ReadShort(),255))
end
usermessage.Hook("recvTribes",GM.getTribes)

function GM.ReceiveTribe(data)
	local name = data:ReadString()
	local id = data:ReadShort()
	local red = data:ReadShort()
	local green = data:ReadShort()
	local blue = data:ReadShort()
	team.SetUp(id,name,Color(red,green,blue,255))
end
usermessage.Hook("newTribe",GM.ReceiveTribe)


timer.Create("gmshud",.1,1,function ()
	TiredCam()
	Light = 1
	CanDNEffect = 0
	for k,v in pairs(GMS.Resources) do
		Resources[v] = 0
	end
end)

function ToggleDN()
	if CanDNEffect == 1 then
		CanDNEffect = 0
		print("DN EFFECT OFF")
	else
		CanDNEffect = 1
		print("DN EFFECT ON")
	end
end
concommand.Add("gms_ToggleDN",ToggleDN)

function PrintTime()

	print("Print Time: "..Time)

end
concommand.Add("gms_PrintTime",PrintTime)

function TiredCam()
	local MainW = 500
		local MainH = 500
			sp_Sprint_menu_F1 = vgui.Create ( "DFrame")
			sp_Sprint_menu_F1:SetPos(0,0 )
			sp_Sprint_menu_F1:SetSize ( ScrH() * 2, ScrW() * 2)
			sp_Sprint_menu_F1:SetTitle ("")
			sp_Sprint_menu_F1:SetVisible(true)
			sp_Sprint_menu_F1:SetDraggable(false)
			sp_Sprint_menu_F1:MakePopup()
			sp_Sprint_menu_F1:ShowCloseButton(false)
			sp_Sprint_menu_F1:SetMouseInputEnabled(false)
			sp_Sprint_menu_F1:SetKeyboardInputEnabled(false)
			
			sp_Sprint_menu_F1.Paint = function()
				
				if CanDNEffect == 1 then
					draw.RoundedBox(0, 0, 0, sp_Sprint_menu_F1:GetWide(), sp_Sprint_menu_F1:GetTall(), Color(0,0,10,180 - Light))
				else
					draw.RoundedBox(0, 0, 0, sp_Sprint_menu_F1:GetWide(), sp_Sprint_menu_F1:GetTall(), Color(0,0,10,0))
				end
			end
end

--lua_openscript_cl autorun\client\sp_Hud.lua




SelectedResource = ""
CacheMenuOpen = 0
AllAmount = 0
YourAmount = 0
function gms_Cache(ply)
	if CacheMenuOpen == 0 then
		CacheMenuOpen = 1
		SelectedResource = ""
		AllAmount = 0
		YourAmount = 0
			CacheW = 500
			CacheH = 500
			gms_Cache_menu_F1 = vgui.Create ( "DFrame")
			gms_Cache_menu_F1:SetPos((( ScrW() /2)-(CacheW/2)) ,100 )
			gms_Cache_menu_F1:SetSize ( CacheW, CacheH)
			gms_Cache_menu_F1:SetTitle ("")
			gms_Cache_menu_F1:SetVisible(true)
			gms_Cache_menu_F1:SetDraggable(true)
			gms_Cache_menu_F1:MakePopup()
			gms_Cache_menu_F1:ShowCloseButton(false)
			gms_Cache_menu_F1:SetMouseInputEnabled(true)
			gms_Cache_menu_F1:SetKeyboardInputEnabled(true)

			gms_Cache_menu_F1.Paint = function()
				draw.RoundedBox(16, 0, 0, gms_Cache_menu_F1:GetWide(), gms_Cache_menu_F1:GetTall(), Color(0,0,0,180))
			end	
			
			local gms_Cache_Menu_Background = vgui.Create( "DButton", gms_Cache_menu_F1)
				gms_Cache_Menu_Background:SetPos(10, 10)
				gms_Cache_Menu_Background:SetSize(480, 480)
				gms_Cache_Menu_Background:SetText("")
				gms_Cache_Menu_Background.DoClick = function ( btn )
				end
				
				gms_Cache_Menu_Background.Paint = function()
					draw.RoundedBox(16, 0, 0, gms_Cache_Menu_Background:GetWide(), gms_Cache_Menu_Background:GetTall(), Color(0,100,0,180))
				end
				
				local gms_Cache_DermaList = vgui.Create("DListView", gms_Cache_menu_F1)
		gms_Cache_DermaList:SetPos(20,40)
		gms_Cache_DermaList:SetSize(460,360)
		gms_Cache_DermaList:SetMultiSelect(false)
		gms_Cache_DermaList:AddColumn("Resource")
		gms_Cache_DermaList:AddColumn("Cache")
		gms_Cache_DermaList:AddColumn("Inventory")
		
		for k,v in pairs(CResources) do 
			gms_Cache_DermaList:AddLine(k,v,Resources[k] or 0)
		end
	 
		gms_Cache_DermaList.OnClickLine = function(parent, line, isselected) //We override the function with our own  	
			SelectedResource = line:GetValue(1)
			Cache_Text_F2:SetText("SELECTED: ".. SelectedResource ) 
			AllAmount = line:GetValue(2)
			YourAmount = line:GetValue(3)
		end 
		
		Cache_Text_F2 = vgui.Create( "DLabel", gms_Cache_menu_F1)
		Cache_Text_F2:SetWrap( true )
		Cache_Text_F2:SetPos(20, 420)
		Cache_Text_F2:SetSize(460,20)
		Cache_Text_F2:SetTextColor( color_white )
		Cache_Text_F2:InvalidateLayout( true ) 
		Cache_Text_F2:SetFont("AcFont1")
		Cache_Text_F2:SetText("SELECTED: NONE" ) 
		
		local gms_Cache_Menu_Close = vgui.Create( "DButton", gms_Cache_menu_F1)
			gms_Cache_Menu_Close:SetPos(20, 15)
			gms_Cache_Menu_Close:SetSize(50, 20)
			gms_Cache_Menu_Close:SetText("CLOSE")
			gms_Cache_Menu_Close.DoClick = function ( btn )
				CacheMenuOpen = 0
				gms_Cache_menu_F1:SetVisible(false)
			end
			
				local gms_DropAmount_Dmenu = vgui.Create( "DButton", gms_Cache_menu_F1)
					gms_DropAmount_Dmenu:SetPos(200, 420)
					gms_DropAmount_Dmenu:SetSize(100, 50)
					gms_DropAmount_Dmenu:SetText("Get Amount")
					gms_DropAmount_Dmenu.DoClick = function ( btn )
						if SelectedResource != "" then
								local Options123 = DermaMenu()
									Options123:AddOption ("Get 1", function ()
										RunConsoleCommand ("gms_Cache" , "Get" ,SelectedResource, 1)
										CacheMenuOpen = 0
										gms_Cache_menu_F1:SetVisible(false)
									end)
									
									Options123:AddOption ("Get 5", function ()
										RunConsoleCommand ("gms_Cache" , "Get" ,SelectedResource, 5)
										CacheMenuOpen = 0
										gms_Cache_menu_F1:SetVisible(false)
									end)
									
									Options123:AddOption ("Get 10", function ()
										RunConsoleCommand ("gms_Cache" , "Get" ,SelectedResource, 10)
										CacheMenuOpen = 0
										gms_Cache_menu_F1:SetVisible(false)
									end)
									
									Options123:AddOption ("Get 25", function ()
										RunConsoleCommand ("gms_Cache" , "Get" ,SelectedResource, 25)
										CacheMenuOpen = 0
										gms_Cache_menu_F1:SetVisible(false)
									end)
									
									Options123:AddOption ("Get 50", function ()
										RunConsoleCommand ("gms_Cache" , "Get" ,SelectedResource, 50)
										CacheMenuOpen = 0
										gms_Cache_menu_F1:SetVisible(false)
									end)
									
									Options123:AddOption ("Get 100", function ()
										RunConsoleCommand ("gms_Cache" , "Get" ,SelectedResource, 100)
										CacheMenuOpen = 0
										gms_Cache_menu_F1:SetVisible(false)
									end)
									
									Options123:AddOption ("Get All", function ()
										RunConsoleCommand ("gms_Cache" , "Get" ,SelectedResource, AllAmount)
										CacheMenuOpen = 0
										gms_Cache_menu_F1:SetVisible(false)
									end)
							Options123:Open()
						else
						
							local Options123 = DermaMenu()
									Options123:AddOption ("YOU NEED TO SELECT A RESOURCE!", function ()
									end)
							Options123:Open()
						
						end
		
					end
					
					
					local gms_SetAmount_Dmenu = vgui.Create( "DButton", gms_Cache_menu_F1)
					gms_SetAmount_Dmenu:SetPos(305, 420)
					gms_SetAmount_Dmenu:SetSize(100, 50)
					gms_SetAmount_Dmenu:SetText("Set Amount")
					gms_SetAmount_Dmenu.DoClick = function ( btn )
						if SelectedResource != "" then
								local Options123 = DermaMenu()
									Options123:AddOption ("Set 1 "..SelectedResource, function ()
										RunConsoleCommand ("gms_Cache" , "Set" ,SelectedResource, 1)
										CacheMenuOpen = 0
										gms_Cache_menu_F1:SetVisible(false)
									end)
									
									Options123:AddOption ("Set 5 "..SelectedResource, function ()
										RunConsoleCommand ("gms_Cache" , "Set" ,SelectedResource, 5)
										CacheMenuOpen = 0
										gms_Cache_menu_F1:SetVisible(false)
									end)
									
									Options123:AddOption ("Set 10 "..SelectedResource, function ()
										RunConsoleCommand ("gms_Cache" , "Set" ,SelectedResource, 10)
										CacheMenuOpen = 0
										gms_Cache_menu_F1:SetVisible(false)
									end)
									
									Options123:AddOption ("Set 25 "..SelectedResource, function ()
										RunConsoleCommand ("gms_Cache" , "Set" ,SelectedResource, 25)
										CacheMenuOpen = 0
										gms_Cache_menu_F1:SetVisible(false)
									end)
									
									Options123:AddOption ("Set 50 "..SelectedResource, function ()
										RunConsoleCommand ("gms_Cache" , "Set" ,SelectedResource, 50)
										CacheMenuOpen = 0
										gms_Cache_menu_F1:SetVisible(false)
									end)
									
									Options123:AddOption ("Set 100 "..SelectedResource, function ()
										RunConsoleCommand ("gms_Cache" , "Set" ,SelectedResource, 100)
										CacheMenuOpen = 0
										gms_Cache_menu_F1:SetVisible(false)
									end)
									
									Options123:AddOption ("Set All "..SelectedResource, function ()
										RunConsoleCommand ("gms_Cache" , "Set" ,SelectedResource, YourAmount)
										CacheMenuOpen = 0
										gms_Cache_menu_F1:SetVisible(false)
									end)
							Options123:Open()
						else
						
							local Options123 = DermaMenu()
									Options123:AddOption ("YOU NEED TO SELECT A RESOURCE! ", function ()
									end)
							Options123:Open()
						
						end
		
					end
	end
	

	
	
	
end

concommand.Add ("gms_CacheMenu",gms_Cache)


function TestVGUI( )

    local DermaPanel = vgui.Create( "DFrame" ); //Create a frame
    DermaPanel:SetSize( 240, 200 ); //Set the size
	width = surface.ScreenWidth() / 2 - 170
	height = surface.ScreenHeight() / 2 - 100
    DermaPanel:SetPos( width, height ); //Move the frame to 100,100
    DermaPanel:SetVisible( true );  //Visible
    DermaPanel:MakePopup( ); //Make the frame
    DermaPanel:SetTitle( "Planting Menu" )   
    DermaPanel:MakePopup() -- Show the frame

    
    local DermaButton = vgui.Create( "DButton", DermaPanel )  
    DermaButton:SetText( "Melon" )   
    DermaButton:SetPos( 5, 40 )   
    DermaButton:SetSize( 100, 25 )   
    DermaButton.DoClick = function()   
        RunConsoleCommand( "gms_plantmelon" ) -- What happens when you left click the button
        DermaPanel:SetVisible( false )
    end  
    DermaButton.DoRightClick = function()   
        RunConsoleCommand( "gms_plantmelon" )
   end  
    
    local Dban = vgui.Create( "DButton", DermaPanel )  
    Dban:SetText( "Banana" )   
    Dban:SetPos( 5, 65 )   
    Dban:SetSize( 100, 25 )   
    Dban.DoClick = function()   
        RunConsoleCommand( "gms_plantBanana" ) -- What happens when you left click the button
        DermaPanel:SetVisible( false )
    end  
    Dban.DoRightClick = function()   
        RunConsoleCommand( "gms_plantBanana" )
   end

    local Dora = vgui.Create( "DButton", DermaPanel )  
    Dora:SetText( "Orange" )   
    Dora:SetPos( 5, 90 )   
    Dora:SetSize( 100, 25 )   
    Dora.DoClick = function()   
        RunConsoleCommand( "gms_plantOrange" ) -- What happens when you left click the button
        DermaPanel:SetVisible( false )
    end  
    Dora.DoRightClick = function()   
        RunConsoleCommand( "gms_plantOrange" )
   end

    local Dgra = vgui.Create( "DButton", DermaPanel )  
    Dgra:SetText( "Grain" )   
    Dgra:SetPos( 5, 115 )   
    Dgra:SetSize( 100, 25 )   
    Dgra.DoClick = function()   
        RunConsoleCommand( "gms_plantGrain" ) -- What happens when you left click the button
        DermaPanel:SetVisible( false )
    end  
    Dgra.DoRightClick = function()   
        RunConsoleCommand( "gms_plantGrain" )
   end

    local Dbus = vgui.Create( "DButton", DermaPanel )  
    Dbus:SetText( "Bush" )   
    Dbus:SetPos( 5, 140 )   
    Dbus:SetSize( 100, 25 )   
    Dbus.DoClick = function()   
        RunConsoleCommand( "gms_plantBush" ) -- What happens when you left click the button
        DermaPanel:SetVisible( false )
    end  
    Dbus.DoRightClick = function()   
        RunConsoleCommand( "gms_plantBush" )
   end

    local Dtre = vgui.Create( "DButton", DermaPanel )  
    Dtre:SetText( "Tree" )   
    Dtre:SetPos( 5, 165 )   
    Dtre:SetSize( 100, 25 )   
    Dtre.DoClick = function()   
        RunConsoleCommand( "gms_planttree" ) -- What happens when you left click the button
        DermaPanel:SetVisible( false )
    end  
    Dtre.DoRightClick = function()   
        RunConsoleCommand( "gms_planttree" )
   end

    local Dquick = vgui.Create( "DButton", DermaPanel )  
    Dquick:SetText( "Quick Plant" )   
    Dquick:SetPos( 120, 60 )   
    Dquick:SetSize( 100, 100 )   
    Dquick.DoClick = function()   
        RunConsoleCommand( "gms_plantmelon" )
        RunConsoleCommand( "gms_plantbanana" )
        RunConsoleCommand( "gms_plantorange" )
        RunConsoleCommand( "gms_plantgrain" )
        RunConsoleCommand( "gms_plantbush" )
        RunConsoleCommand( "gms_planttree" )
        DermaPanel:SetVisible( false )
    end


end
 
concommand.Add( "gms_plantyplant", TestVGUI );

Teleports = {}
TeleportsName = {}
ValidTeleports = 0
CurTeleport = 0
CurTeleName = "NA"
CurTele = 0
function gms_PrepareTele(um)
	Teleports = {}
	TeleportsName = {}
	TeleportsOwner = {}
	ValidTeleports = um:ReadShort()
	CurTeleport = 0
end
usermessage.Hook("gms_PrepareTele",gms_PrepareTele)

function gms_SendTeleData(um)
	CurTeleport = CurTeleport + 1
	Teleports[CurTeleport] = um:ReadLong()
	TeleportsName[CurTeleport] = um:ReadString()
	TeleportsOwner[CurTeleport] = um:ReadString()
end
usermessage.Hook("gms_SendTeleData",gms_SendTeleData)

function gms_OpenTele(um)
	CurTele = um:ReadLong()
	CurTeleName = um:ReadString()
end
usermessage.Hook("gms_OpenTele",gms_OpenTele)

TeleOpen = 0
function gms_OpenTele(um)
	CurTele = um:ReadLong()
	CurTeleName = um:ReadString()
	OpenTele()
end
usermessage.Hook("gms_OpenTele",gms_OpenTele)

function OpenTele()
	local clicksound = "ui/buttonclick.wav"
	local telename = 0
	TeleMenu_DFrame = vgui.Create ( "DFrame")
	local sw = ScrW()
	local sh = ScrH()
	local Height = 250
	local Width = 250
	TeleMenu_DFrame:SetPos(10 ,(ScrH() / 2)-(Height / 2))
	TeleMenu_DFrame:SetSize ( Width, Height)
	TeleMenu_DFrame:SetTitle ("TELEPORT: "..CurTeleName)
	TeleMenu_DFrame:SetVisible(true)
	TeleMenu_DFrame:SetDraggable(false)
	TeleMenu_DFrame:MakePopup()
	TeleMenu_DFrame:ShowCloseButton(true)
		TeleMenu_DFrame.Paint = function()
			draw.RoundedBox(6, 0, 0, TeleMenu_DFrame:GetWide(), TeleMenu_DFrame:GetTall(), Color(60,60,60,255))
			surface.SetDrawColor(color_white)
			surface.DrawOutlinedRect(0, 0, TeleMenu_DFrame:GetWide(), TeleMenu_DFrame:GetTall())	
		end	
	
	local TeleMenu_DListView = vgui.Create("DListView", TeleMenu_DFrame)
	TeleMenu_DListView:SetPos(5,20)
	TeleMenu_DListView:SetSize(Width - 10,Height - 110)
	TeleMenu_DListView:SetMultiSelect(false)
	TeleMenu_DListView:AddColumn("ID")
	TeleMenu_DListView:AddColumn("NAME")
	TeleMenu_DListView:AddColumn("OWNER")
	for k,v in pairs(Teleports) do
		TeleMenu_DListView:AddLine(Teleports[k],TeleportsName[k],TeleportsOwner[k]) 
	end
	TeleMenu_DListView.OnClickLine = function(parent, line, isselected) //We override the function with our own  	
		TeleMenu_DButton:SetVisible(true)
		TeleMenu_DFrame:SetTitle("Tele to "..line:GetValue(2).."/"..line:GetValue(1))
		LocalPlayer():EmitSound(Sound(clicksound))
		telename = line:GetValue(1)
	end 
	
	
	TeleMenu_DButton = vgui.Create( "DButton", TeleMenu_DFrame)
	TeleMenu_DButton:SetPos(20, (Height - 70))
	TeleMenu_DButton:SetSize(Width - 40, Height - 200)
	TeleMenu_DButton:SetText("OPTIONS")
	TeleMenu_DButton:SetVisible(true)
	TeleMenu_DButton.DoClick = function ( btn )
		local Options123 = DermaMenu()
		LocalPlayer():EmitSound(Sound(clicksound))
		Options123:AddOption ("Rename current teleport." ,function ()
			TeleMenu_DFrame:SetVisible(false)
			LocalPlayer():EmitSound(Sound(clicksound))
			RenameMenu()
		end)
		
		Options123:AddOption ("Toggle public." ,function ()
			TeleMenu_DFrame:SetVisible(false)
			LocalPlayer():EmitSound(Sound(clicksound))
			RunConsoleCommand("gms_tglpubtele",CurTele)
		end)
		
		if telename != 0 then
			Options123:AddOption ("Teleport" ,function ()
				LocalPlayer():EmitSound(Sound(clicksound))
				TeleMenu_DFrame:SetVisible(false)
				RunConsoleCommand("gms_hidden","tele",telename)
			end)
		end
		Options123:Open()
	end
	TeleMenu_DButton.Paint = function()
		if MouseOverPanel(TeleMenu_DButton) then
			draw.RoundedBox(16, 0, 0, TeleMenu_DButton:GetWide(), TeleMenu_DButton:GetTall(), Color(30,30,30,255))
		else
			draw.RoundedBox(16, 0, 0, TeleMenu_DButton:GetWide(), TeleMenu_DButton:GetTall(), Color(0,0,0,255))
		end
	end	
end

function RenameMenu()
	local clicksound = "ui/buttonclick.wav"
	TeleRenameMenu_DFrame = vgui.Create ( "DFrame")
	local sw = ScrW()
	local sh = ScrH()
	local Height = 100
	local Width = 250
	TeleRenameMenu_DFrame:SetPos(10 ,(ScrH() / 2)-(Height / 2))
	TeleRenameMenu_DFrame:SetSize ( Width, Height)
	TeleRenameMenu_DFrame:SetTitle ("Rename Tele")
	TeleRenameMenu_DFrame:SetVisible(true)
	TeleRenameMenu_DFrame:SetDraggable(false)
	TeleRenameMenu_DFrame:MakePopup()
	TeleRenameMenu_DFrame:ShowCloseButton(true)
		TeleRenameMenu_DFrame.Paint = function()
			draw.RoundedBox(6, 0, 0, TeleRenameMenu_DFrame:GetWide(), TeleRenameMenu_DFrame:GetTall(), Color(60,60,60,255))
			surface.SetDrawColor(color_white)
			surface.DrawOutlinedRect(0, 0, TeleRenameMenu_DFrame:GetWide(), TeleRenameMenu_DFrame:GetTall())	
		end	
		
		// myParent = a panel
	TeleRenameMenu_DText= vgui.Create("DTextEntry", TeleRenameMenu_DFrame)
	TeleRenameMenu_DText:SetPos(10,25)
	TeleRenameMenu_DText:SetText("Name goes here.")
	TeleRenameMenu_DText:SetWidth(Width - 20)
	TeleRenameMenu_DText:SetHeight(20)

	
	TeleRenameMenu_DButton = vgui.Create( "DButton", TeleRenameMenu_DFrame)
	TeleRenameMenu_DButton:SetPos(20, 50)
	TeleRenameMenu_DButton:SetSize(Width - 40, 40)
	TeleRenameMenu_DButton:SetText("Rename")
	TeleRenameMenu_DButton:SetVisible(true)
	TeleRenameMenu_DButton.DoClick = function ( btn )
		if TeleRenameMenu_DText:GetValue() != "Name goes here." then
			RunConsoleCommand("gms_nametele",CurTele,TeleRenameMenu_DText:GetValue())
			LocalPlayer():EmitSound(Sound(clicksound))
			TeleRenameMenu_DFrame:SetVisible(false)
		else
			TeleRenameMenu_DButton:SetText("You need to name it.")
			LocalPlayer():EmitSound(Sound(clicksound))
		end
	end
	TeleRenameMenu_DButton.Paint = function()
		if MouseOverPanel(TeleRenameMenu_DButton) then
			draw.RoundedBox(16, 0, 0, TeleRenameMenu_DButton:GetWide(), TeleRenameMenu_DButton:GetTall(), Color(30,30,30,255))
		else
			draw.RoundedBox(16, 0, 0, TeleRenameMenu_DButton:GetWide(), TeleRenameMenu_DButton:GetTall(), Color(0,0,0,255))
		end
	end	
end

function PlyPrint(um)
	msg = um:ReadString()
	print(msg)
end
usermessage.Hook("PlayerConPrint",PlyPrint)

--lua_openscript_cl autorun\client\sp_Hud.lua


function DrawHud()
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
		
		//FrontStats
		local H = (LocalPlayer():Health() / 200) * 160
		local Hung = ( Hunger / 1000) * 160
		local Thir = ( Thirst/ 1000) * 160
		local sleep = ( Sleepiness/ 1000) * 160
		draw.RoundedBox(2, 20 + HX, 14 + HY, H, 12, Color(255,0,0,160))
		draw.RoundedBox(2, 20 + HX, 15 + HY, H, 8, Color(255,0,0,180))
		draw.RoundedBox(2, 20 + HX, 16 + HY, H, 4, Color(180,0,0,255))
		draw.SimpleText("Health","ResFont3",95 + HX, HY +20, Color(255,255,255,255),1,1)
		
		draw.RoundedBox(2, 20 + HX, 39 + HY, Hung, 12, Color(0,255,0,160))
		draw.RoundedBox(2, 20 + HX, 40 + HY, Hung, 8, Color(0,255,0,180))
		draw.RoundedBox(2, 20 + HX, 41 + HY, Hung, 4, Color(0,180,0,255))
		draw.SimpleText("Hunger","ResFont3",95 + HX, HY +45, Color(255,255,255,255),1,1)
		
		draw.RoundedBox(2, 20 + HX, 64 + HY, Thir, 12, Color(0,0,255,160))
		draw.RoundedBox(2, 20 + HX, 65 + HY, Thir, 8, Color(0,0,255,180))
		draw.RoundedBox(2, 20 + HX, 66 + HY, Thir, 4, Color(0,0,180,255))
		draw.SimpleText("Thirst","ResFont3",95 + HX, HY +70, Color(255,255,255,255),1,1)
		
		draw.RoundedBox(2, 20 + HX, 89 + HY, sleep, 12, Color(255,0,255,160))
		draw.RoundedBox(2, 20 + HX, 90 + HY, sleep, 8, Color(255,0,255,255))
		draw.RoundedBox(2, 20 + HX, 91 + HY, sleep, 4, Color(180,0,180,255))
		draw.SimpleText("Sleep","ResFont3",95 + HX, HY +95, Color(255,255,255,255),1,1)
		
		if HudMenu == 1 then	
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
		
		elseif HudMenu == 2 then
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
				
				draw.RoundedBox(0, 15 + HX, HY + 150 + (Height * 1.05), Width, 15,	Color(0,255,0,160))
				draw.SimpleText(Experience[k].. "/100","ResFont1",95 + HX, (HY + 160) + (Height * 1.05), Color(255,255,255,255),1,1)
				Height = Height + SectionHeight
			end
		elseif HudMenu == 0 then
			draw.RoundedBox(4, HX, HY + 120, 200, 50 , Color(0,0,0,160))	
			draw.RoundedBox(4, HX + 5, HY + 125, 190, 40 , Color(180,180,180,160))	
			draw.SimpleText("SKILLS: F1","ResFont1",95 + HX, HY + 135, Color(255,255,255,255),1,1)
			draw.SimpleText("RESOURCES: F2","ResFont1",95 + HX, HY + 155, Color(255,255,255,255),1,1)
		end
end

hook.Add("HUDPaint", "DrawHud", DrawHud)

CombiOpen = 0

function OpenCombi(str)
	if CombiOpen == 0 then
		CombiOpen = 1
		local Selected = ""
		local clicksound = "ui/buttonclick.wav"
		CombiMenu_DFrame = vgui.Create ( "DFrame")
		local sw = ScrW()
		local sh = ScrH()
		local Height = 250
		local Width = 600
		CombiMenu_DFrame:SetPos(10 ,(ScrH() / 2)-(Height / 2))
		CombiMenu_DFrame:SetSize ( Width, Height)
		CombiMenu_DFrame:SetTitle (str)
		CombiMenu_DFrame:SetVisible(true)
		CombiMenu_DFrame:SetDraggable(false)
		CombiMenu_DFrame:MakePopup()
		CombiMenu_DFrame:ShowCloseButton(false)
			CombiMenu_DFrame.Paint = function()
				draw.RoundedBox(6, 0, 0, CombiMenu_DFrame:GetWide(), CombiMenu_DFrame:GetTall(), Color(60,60,60,255))
				surface.SetDrawColor(color_white)
				surface.DrawOutlinedRect(0, 0, CombiMenu_DFrame:GetWide(), CombiMenu_DFrame:GetTall())	
			end	
		
		local CombiMenu_DListView = vgui.Create("DListView", CombiMenu_DFrame)
		CombiMenu_DListView:SetPos(5,20)
		CombiMenu_DListView:SetSize(Width - 400,Height - 110)
		CombiMenu_DListView:SetMultiSelect(false)
		CombiMenu_DListView:AddColumn("Name")
		for k,v in pairs(GMS.Combinations[str]) do
			CombiMenu_DListView:AddLine(k) 
		end
		CombiMenu_DListView.OnClickLine = function(parent, line, isselected) //We override the function with our own  	
			CombiMenu_DButton:SetVisible(true)
			local tbl = GMS.Combinations[str][line:GetValue(1)]
			CombiMenu_DLabel:SetText(tbl.Name)
			CombiMenu_DLabel2:SetText(tbl.Description)
			LocalPlayer():EmitSound(Sound(clicksound))
			Selected = line:GetValue(1)
		end 
		
		CombiMenu_DLabel = vgui.Create( "DLabel", CombiMenu_DFrame)
		CombiMenu_DLabel:SetPos(Width - 380, 20)
		CombiMenu_DLabel:SetSize(370, 20)
		CombiMenu_DLabel:SetText("")
		
		CombiMenu_DLabel2 = vgui.Create( "DLabel", CombiMenu_DFrame)
		CombiMenu_DLabel2:SetPos(Width - 380, 45)
		CombiMenu_DLabel2:SetSize(370, 100)
		CombiMenu_DLabel2:SetMultiline(true)

		CombiMenu_DLabel2:SetText("")
		
		
		CombiMenu_DButton = vgui.Create( "DButton", CombiMenu_DFrame)
		CombiMenu_DButton:SetPos(20, (Height - 70))
		CombiMenu_DButton:SetSize(Width - 40, Height - 200)
		CombiMenu_DButton:SetText("CREATE")
		CombiMenu_DButton:SetVisible(true)
		CombiMenu_DButton.DoClick = function ( btn )
			LocalPlayer():EmitSound(Sound(clicksound))
			RunConsoleCommand("gms_makecombination",str,Selected)
			CloseCombi()
		end
		CombiMenu_DButton.Paint = function()
			if MouseOverPanel(CombiMenu_DButton) then
				draw.RoundedBox(16, 0, 0, CombiMenu_DButton:GetWide(), CombiMenu_DButton:GetTall(), Color(30,30,30,255))
			else
				draw.RoundedBox(16, 0, 0, CombiMenu_DButton:GetWide(), CombiMenu_DButton:GetTall(), Color(0,0,0,255))
			end
		end	
		
		CombiMenu_DButton2 = vgui.Create( "DButton", CombiMenu_DFrame)
		CombiMenu_DButton2:SetPos(Width - 60, 5)
		CombiMenu_DButton2:SetSize(50,20)
		CombiMenu_DButton2:SetText("CLOSE")
		CombiMenu_DButton2:SetVisible(true)
		CombiMenu_DButton2.DoClick = function ( btn )
			LocalPlayer():EmitSound(Sound(clicksound))
			CloseCombi()
		end
	end
end

function CloseCombi()
	if CombiOpen == 1 then
		CombiOpen = 0
		CombiMenu_DFrame:SetVisible(false)
	end
end





