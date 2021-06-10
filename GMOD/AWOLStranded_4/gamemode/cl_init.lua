/*---------------------------------------------------------

  Gmod Stranded

---------------------------------------------------------*/
DeriveGamemode( "sandbox" )
include( 'shared.lua' )
include( 'cl_ppmenu.lua' )
include( 'cl_scoreboard.lua' )
include( 'cl_NewHelpMenu.lua' )
include( 'cl_quickmenu.lua' )
include( 'cl_notifications.lua' )
include( 'cl_hud.lua' )
include( 'cl_clsettings.lua' )
include( "petmod/petmod_shared_config.lua" )
include( "petmod/petmod_cl_init.lua" )

--Custom panels
include( 'cl_panels.lua' )
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
QuestStatus = 1
//Stuff for hud
HX = 0
HY = 0
sw = ScrW()
sh = ScrH()
ResHeight = 20
GameLoaded = 1
surface.CreateFont( "coolvetica", 18, 500, true, false, "ResFont1" )
surface.CreateFont( "coolvetica", 32, 500, true, false, "ResFont2" )
surface.CreateFont( "coolvetica", 12, 500, true, false, "ResFont3" )
surface.CreateFont( "coolvetica", 14, 500, true, false, "ResFont4" )
surface.CreateFont( "coolvetica", 16, 500, true, false, "ResFont5" )
surface.CreateFont( "coolvetica", 26, 500, true, false, "ResFont6" )

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
	if Effects then
		if Effects < 100 then
		local Effect = um:ReadString()
		local pos = um:ReadVector()
		local Height = um:ReadLong()
		local finalpos = pos + Vector(0,0,Height)

			local eff = EffectData()
			eff:SetOrigin(finalpos)
			util.Effect(Effect,eff)
			Effects = Effects + 1
		end
	else
		Effects = 0
	end
end

usermessage.Hook("EffectsFunc", EffectsFuncUSMG)

function EffectsFunc( pos,height,name )
	if Effects then
		if Effects < 100 then
			local Effect = name
			local pos = pos
			local Height = height
			local finalpos = pos + Vector(0,0,Height)
			local eff = EffectData()
			eff:SetOrigin(finalpos)
			util.Effect(Effect,eff)
			Effects = Effects + 1
		end
	else
		Effects = 0
	end
end


function GM:HUDPaint()
	self.BaseClass:HUDPaint()
	local SH = ScrH()
	local SW = ScrW()
	
	if ProcessCompleteTime then
		local w = SW / 12
		local h = SH / 12
		local w2,h2 = surface.GetTextSize(CurrentProcess)
		local x = (ScrW()) - (w * 1.2) - (w2 / 2.5)
		local y = (ScrH()) - (h * 1.2)
		local centx = x + w/2
		local centy = y + h/2
		local height = (SH / 28)
		local radius = (w + h) / (3.2 * 2)
		draw.RoundedBox(16, x - 5, y - 5, w + 10, h + 10, Color(0,0,0,180))
		
		if (w2 * 2) < w + (w /4) then
			w2 = w + (w /4)
		else
			w2 = w2*2
		end
		draw.RoundedBox(16, centx- (w2 / 2), y - (h / 2), w2, h + (h / 1.5), Color(0,0,0,180))
		
		draw.RoundedBox(16, x, y, w, h, Color(180,180,180,180))
		
		draw.RoundedBox(4, centx - ((w/ 10) / 2), centy - ((h / 10) / 2), (w/ 10), (h / 10), Color(0,0,0,255))
		
		draw.SimpleText( CurrentProcess, "ResFont6", centx, y - (h / 4) , Color( 255, 255, 255, 255 ), 1, 1 )
		local second = ( RealTime() - ProcessStart)
		x = centx - (math.sin(math.rad(-second * (360 /ProcessCompleteTime))) * radius)
		y = centy- (math.cos(math.rad(second * (360 /ProcessCompleteTime))) * radius)
		local bw = w / 5
		local bh = h / 5
		draw.RoundedBox( 4, x - (bw / 2), y - (bh / 2), bw, bh, Color( 0, 255, 0, 255 ) )
	end
	local Q = Quest
	local pos = Q["Pos"]
	if HudPaintTimer < CurTime() then
		HudPaintTimer = CurTime() + .01
		if Q["Active"] == 1 && pos < 200 then
			Quest["Pos"] = pos + 5
		elseif Q["Active"] == 0 && pos > 0 then
			Quest["Pos"] = pos - 5
		end
	end
	if Q["Pos"] > 0 && tobool(gms_CheckSettings("ShowQuestStatus")) == true then
		local colour = Color(180,180,180,160)
		if Resources[Q["Resource"]] then
			if Resources[Q["Resource"]] >= Q["Amount"] then
				colour = Color(0,180,0,160)
			end
		end
		local width = 200
		local height = 50
		draw.RoundedBox(4, (SW - pos) + 5 , (SH / 2) - (height / 2), width, height, Color(0,0,0,160))
		draw.RoundedBox(4, (SW - pos) + 10 , (SH / 2) - (height / 2) + 5, width - 10, height - 10, colour)
		local text = Q["Amount"].." " ..Q["Resource"]
		draw.SimpleText( text, "ResFont6",(SW - pos) + 20 , (SH / 2) - (height / 2) + ((height) / 2 ), Color( 255, 255, 255, 255 ), 0, 1 )
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
//function GM:ForceDermaSkin()
	//return "StrandedDermaSkin"
//end 

/*---------------------------------------------------------
  Stranded-Like info messages
---------------------------------------------------------*/


function CheckName(ent,nametable)
	for k, v in pairs(nametable) do
		if ent:GetClass() == v then return true end		
	end
end



function GM.DropMessage(msg)
	msg.InitTab = msg.Tab
	msg.Fading = true
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
		if ent then
		ent:SetModel(mdl)
		ent:SetPos(pos)
		ent:SetAngles(dir:Angle())
		ent:Spawn()

		ent.Alpha = 255
		ent.Speed = speed

		table.insert(GAMEMODE.FadingProps,ent)
	end
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
	
	if PlayerUpgrades["Mr_Survival"] == 1 then
		Scale = .25
	elseif PlayerUpgrades["Wild_Man"] == 1 then
		Scale = .5
	else
		Scale = 1
	end
	if Sleepiness > 0 then 
		Sleepiness = Sleepiness - (1 * Scale) 
	else
		Sleepiness = 0
	end
	if Thirst > 0 then 
		Thirst = Thirst - (2 * Scale) 
	else
		Thirst = 0
	end
	if Hunger > 0 then 
		Hunger = Hunger - (1 * Scale) 
	else
		Hunger = 0
	end

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
	for k,v in pairs(GMS.Resources) do
		Resources[v] = 0
	end
end)

function ToggleDN()
	local col = {255,180,0}
	if tobool(gms_CheckSettings("DNEffect")) == true then
		gms_SetSetting("DNEffect",false)
		AddNotification("Day/Night effects are off.","0,255,255")			
	else
		gms_SetSetting("DNEffect",true)
		AddNotification("Day/Night effects are on.","0,255,255")			
	end
end
concommand.Add("gms_DayNight",ToggleDN)

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
		if tobool(gms_CheckSettings("DNEffect")) == true then
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
			if v && Resources[k] then
				if Resources[k] > 0 || v > 0 then
					gms_Cache_DermaList:AddLine(k,v,Resources[k] or 0)
				end
			end
		end
		gms_Cache_DermaList:SortByColumn( 2 )
	 
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
		if TeleMenu_DButton.Hovered then
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
		if TeleRenameMenu_DButton.Hovered then
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



PlayerUpgrades = {}
function RecieveUpgrades(um)
	local name = um:ReadString()
	local amount = tonumber(um:ReadShort()) or 0
	if GMS_LevelReq[name] then
		PlayerUpgrades[name] = amount
	end
end
usermessage.Hook("Trophy",RecieveUpgrades)
 CombiOpen = 0

function OpenCombi(str)
	if CombiOpen == 0 then
		CombiOpen = 1
		local Selected = ""
		local clicksound = "ui/buttonclick.wav"
		CombiMenu_DFrame = vgui.Create ( "DFrame")
		local sw = ScrW()
		local sh = ScrH()
		local Height = 400
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
		CombiTable = {}
		CombiEnough = {}
		if str == "SpecialBuildings" then		
			for k,v in pairs(GMS.Combinations[str]) do 
				local i = CombiMenu_DListView:AddLine(v.Name) 
				CombiTable[v.Name] = k
				if PlayerUpgrades && v.Trophy then
					if PlayerUpgrades[v.Trophy] then
						if PlayerUpgrades[v.Trophy] == 1 then
							i.Paint = function()
								if ( i.Hovered ) then
									Col = Color( 70, 70, 255, 255 )
								elseif ( i.m_bAlt ) then
									Col = Color( 0,0,180, 255 )
								else
									Col = Color( 0,0,255, 255 )
								end
								surface.SetDrawColor( Col.r, Col.g, Col.b, Col.a )
								surface.DrawRect( 0, 0, i:GetWide(), i:GetTall() )
							end
						end
					end	
				else
					i.Paint = function()
						if ( i.Hovered ) then
							Col = Color( 70, 70, 255, 255 )
						elseif ( i.m_bAlt ) then
							Col = Color( 50,50,50, 255 )
						else
							Col = Color( 30,30,30, 255 )
						end
					end
				end		
			end
		else		
			for k,v in pairs(GMS.Combinations[str]) do
				local i = CombiMenu_DListView:AddLine(v.Name) 
				CombiTable[v.Name] = k
				local tbl = v
				CombiEnough[v.Name] = 1
				local NVM = 0
					if GMS_UpgradeEnt then
						for k2,v2 in pairs(GMS_UpgradeEnt) do 
							if v2 == v.Results then
								if CombiEnough[v.Name] == 1 then
									NVM = 1
									if PlayerUpgrades[k2] then
										if PlayerUpgrades[k2] == 1 then
											CombiEnough[v.Name] = 2
										else
											NVM = 0
										end
									else
										NVM = 0
									end
								end
							end
						end
					end
					if NVM == 0 then
						for k2,v2 in pairs(v.Req) do 
							if Resources[k2] then
								if Resources[k2] < v2 then
									CombiEnough[v.Name] = 0
								end
							else
								CombiEnough[v.Name] = 0
							end
						end
					end
					i.Paint = function()
						if ( i.Hovered ) then
							Col = Color( 70, 70, 255, 255 )
						elseif CombiEnough[v.Name] == 2 then
							Col = Color( 0,0,255, 255 )
						elseif CombiEnough[v.Name] == 1 then
							Col = Color( 0,180,0, 255 )
						elseif ( i.m_bAlt ) then
							Col = Color( 50,50,50, 255 )
						else
							Col = Color( 30,30,30, 255 )
						end
						surface.SetDrawColor( Col.r, Col.g, Col.b, Col.a )
						surface.DrawRect( 0, 0, i:GetWide(), i:GetTall() )
					end	
			end
		end
		CombiMenu_DListView:SortByColumn( 1 )
		CombiMenu_DListView.OnClickLine = function(parent, line, isselected) //We override the function with our own  	
			CombiMenu_DButton:SetVisible(true)
			local tbl = GMS.Combinations[str][CombiTable[line:GetValue(1)]]
			CombiMenu_DLabel:SetText(tbl.Name)
			CombiMenu_DLabel2:SetText(tbl.Description)
			LocalPlayer():EmitSound(Sound(clicksound))
			Selected = CombiTable[line:GetValue(1)]
		end 
		
		CombiMenu_DLabel = vgui.Create( "DLabel", CombiMenu_DFrame)
		CombiMenu_DLabel:SetPos(Width - 380, 10)
		CombiMenu_DLabel:SetSize(370, 20)
		CombiMenu_DLabel:SetText("")
		
		CombiMenu_DLabel2 = vgui.Create( "DLabel", CombiMenu_DFrame)
		CombiMenu_DLabel2:SetPos(Width - 380, 30)
		CombiMenu_DLabel2:SetSize(370, 230)
		CombiMenu_DLabel2:SetMultiline(true)

		CombiMenu_DLabel2:SetText("")
		
		
		CombiMenu_DButton = vgui.Create( "DButton", CombiMenu_DFrame)
		CombiMenu_DButton:SetPos(20, (Height - 70))
		CombiMenu_DButton:SetSize(Width - 40, 50)
		CombiMenu_DButton:SetText("CREATE")
		CombiMenu_DButton:SetVisible(true)
		CombiMenu_DButton.DoClick = function ( btn )
			LocalPlayer():EmitSound(Sound(clicksound))
			RunConsoleCommand("gms_makecombination",str,Selected)
			CloseCombi()
		end
		CombiMenu_DButton.Paint = function()
			if CombiMenu_DButton.Hovered then
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

	CloneMachine = {}
	C_Upgrades = {}
		C_Upgrades["MaxCapacity"] = 1
		C_Upgrades["CurrentCapacity"] = 1
		C_Upgrades["TimeLapse"] = 1
		C_Upgrades["Rate"] = 1
		C_Upgrades["FuelRate"] = 1
		C_Upgrades["MaxFuel"] = 1
	
function gms_PrepareCloneMenu(um)
	CloneMachine = {}
	local c = CloneMachine
	c["MaxCapacity"]= um:ReadShort()
	c["Resource"]= um:ReadString()
	c["CurrentCapacity"]= um:ReadShort()
	c["TimeLapse"]= um:ReadShort()
	c["Rate"]= um:ReadShort()
	c["Fuel"]= um:ReadShort()
	c["FuelRate"]= um:ReadShort()
	c["MaxFuel"]= um:ReadShort()
	c["EntId"]= um:ReadShort()
	OpenClone()
end
usermessage.Hook("gms_PrepareCloneMenu",gms_PrepareCloneMenu)

function gms_Clone_RecieveUpgradeData(um)
	C_Upgrades = {}
	C_Upgrades["MaxCapacity"] = um:ReadShort()
	C_Upgrades["CurrentCapacity"] = um:ReadShort()
	C_Upgrades["TimeLapse"] = um:ReadShort()
	C_Upgrades["Rate"] = um:ReadShort()
	C_Upgrades["FuelRate"] = um:ReadShort()
	C_Upgrades["MaxFuel"] = um:ReadShort()
end
usermessage.Hook("gms_Clone_SendUpgradeData",gms_Clone_RecieveUpgradeData)

Quest = {}
Quest["Quest"] = "NA"
Quest["Resource"] = "NA"
Quest["Amount"] = 0
Quest["Complete"] = 0
Quest["Active"] = 0
Quest["Pos"] = 0
HudPaintTimer = CurTime()
function gms_RecieveQuestInfo(um)
	Quest["Quest"] = um:ReadString()
	Quest["Resource"] = um:ReadString()
	Quest["Amount"] = um:ReadShort()
	Quest["Complete"] = um:ReadShort()
	Quest["Active"] = um:ReadShort()
	Quest["Pos"] = 200 * Quest["Complete"]
end
usermessage.Hook("QuestInfo",gms_RecieveQuestInfo)


--lua_openscript_cl autorun\client\sp_Hud.lua
CloneOpen = 0
function OpenClone()
	if CloneOpen == 0 then
		CloneOpen = 1
		local clicksound = "ui/buttonclick.wav"
		local sw = ScrW()
		local sh = ScrH()
		local Height = 360
		local Width = 360
		local c = CloneMachine
		local upgradepos = {}
		local u = upgradepos
		u["MaxCapacity"] = "Resource Capacity"
		u["TimeLapse"] = "Creation Rate"
		u["Rate"] = "Creation Amount"
		u["FuelRate"] = "Fuel Consumption"
		u["MaxFuel"] =  "Fuel Capacity"
		
		CloneMenu_DFrame = vgui.Create ( "DFrame")
		CloneMenu_DFrame:SetPos(10 ,(ScrH() / 2)-(Height / 2))
		CloneMenu_DFrame:SetSize ( Width, Height)
		CloneMenu_DFrame:SetTitle ("CLONE MACHINE, Resouce: ".. c["Resource"])
		CloneMenu_DFrame:SetVisible(true)
		CloneMenu_DFrame:SetFont("ResFont1")
		CloneMenu_DFrame:SetDraggable(false)
		CloneMenu_DFrame:MakePopup()
		CloneMenu_DFrame:ShowCloseButton(false)
			CloneMenu_DFrame.Paint = function()
				draw.RoundedBox(6, 0, 0, CloneMenu_DFrame:GetWide(), CloneMenu_DFrame:GetTall(), Color(60,60,60,255))
				surface.SetDrawColor(color_white)
				surface.DrawOutlinedRect(0, 0, CloneMenu_DFrame:GetWide(), CloneMenu_DFrame:GetTall())	
			end	
			

		
		--StatChanging
		CloneMenu_DLabel = vgui.Create( "DLabel", CloneMenu_DFrame)
		CloneMenu_DLabel:SetPos(5, 30)
		CloneMenu_DLabel:SetSize(100, 20)
		CloneMenu_DLabel:SetText("Upgrading")
		CloneMenu_DLabel:SetFont("ResFont1")
		
		local CloneMenu_DListView = vgui.Create("DListView", CloneMenu_DFrame)
		CloneMenu_DListView:SetPos(5,50)
		CloneMenu_DListView:SetSize(350,105)
		CloneMenu_DListView:SetMultiSelect(false)
		CloneMenu_DListView:AddColumn("Name")
		CloneMenu_DListView:AddColumn("Stat")
		CloneMenu_DListView:AddColumn("Upgrade Cost")
		if C_Upgrades["MaxCapacity"] < 5 then
			local text = GMS_CloneUpgrades["MaxCapacity"][C_Upgrades["MaxCapacity"]]["Cost"] .. " " .. GMS_CloneUpgrades["MaxCapacity"][C_Upgrades["MaxCapacity"]]["Res"]
			CloneMenu_DListView:AddLine("Resource Capacity",c["MaxCapacity"],text) 
		else
			CloneMenu_DListView:AddLine("Resource Capacity",c["MaxCapacity"],"Fully Upgraded") 
		end
		
		if C_Upgrades["TimeLapse"] < 5 then
			text = GMS_CloneUpgrades["TimeLapse"][C_Upgrades["TimeLapse"]]["Cost"] .. " " .. GMS_CloneUpgrades["TimeLapse"][C_Upgrades["TimeLapse"]]["Res"]
			CloneMenu_DListView:AddLine("Creation Rate (Secs)",c["TimeLapse"],text) 
		else
			CloneMenu_DListView:AddLine("Creation Rate (Secs)",c["TimeLapse"],"Fully Upgraded") 
		end
		
		if C_Upgrades["Rate"] < 5 then
			text = GMS_CloneUpgrades["Rate"][C_Upgrades["Rate"]]["Cost"] .. " " .. GMS_CloneUpgrades["Rate"][C_Upgrades["Rate"]]["Res"]
			CloneMenu_DListView:AddLine("Creation Amount",c["Rate"],text) 
		else
			CloneMenu_DListView:AddLine("Creation Amount",c["Rate"],"Fully Upgraded") 
		end
		
		if C_Upgrades["FuelRate"] < 5 then
			text = GMS_CloneUpgrades["FuelRate"][C_Upgrades["FuelRate"]]["Cost"] .. " " .. GMS_CloneUpgrades["FuelRate"][C_Upgrades["FuelRate"]]["Res"]
			CloneMenu_DListView:AddLine("Fuel Consumption",c["FuelRate"],text) 
		else
			CloneMenu_DListView:AddLine("Fuel Consumption",c["FuelRate"],"Fully Upgraded") 
		end
		
		if C_Upgrades["MaxFuel"] < 5 then
			text = GMS_CloneUpgrades["MaxFuel"][C_Upgrades["MaxFuel"]]["Cost"] .. " " .. GMS_CloneUpgrades["MaxFuel"][C_Upgrades["MaxFuel"]]["Res"]
			CloneMenu_DListView:AddLine("Fuel Capacity",c["MaxFuel"],text) 
		else
			CloneMenu_DListView:AddLine("Fuel Capacity",c["MaxFuel"],"Fully Upgraded") 
		end
		
		
		--Upgrades
		CloneMenu_DLabe2 = vgui.Create( "DLabel", CloneMenu_DFrame)
		CloneMenu_DLabe2:SetPos(5, 160)
		CloneMenu_DLabe2:SetSize(370, 20)
		CloneMenu_DLabe2:SetText("Statistics")
		CloneMenu_DLabe2:SetFont("ResFont1")
		
		local CloneMenu_DListView = vgui.Create("DListView", CloneMenu_DFrame)
		local c = CloneMachine
		CloneMenu_DListView:SetPos(5,180)
		CloneMenu_DListView:SetSize(350,100)
		CloneMenu_DListView:SetMultiSelect(false)
		CloneMenu_DListView:AddColumn("Name")
		CloneMenu_DListView:AddColumn("Info")
		CloneMenu_DListView:AddLine("Current Resource",c["Resource"]) 
		CloneMenu_DListView:AddLine("Current Capacity",c["CurrentCapacity"].."/"..c["MaxCapacity"]) 
		CloneMenu_DListView:AddLine("Current Fuel",c["Fuel"].."/"..c["MaxFuel"]) 
		CloneMenu_DListView:AddLine("Ent id",c["EntId"]) 

	
		CloneMenu_DListView.OnClickLine = function(parent, line, isselected) //We override the function with our own  	

		end 
		

		
		CloneMenu_DButton_ = vgui.Create( "DButton", CloneMenu_DFrame)
		CloneMenu_DButton_:SetPos((350 / 2) + 15, 290)
		CloneMenu_DButton_:SetSize((350 / 2) - 10,20)
		CloneMenu_DButton_:SetText("Options")
		CloneMenu_DButton_:SetVisible(true)
		CloneMenu_DButton_.DoClick = function ( btn )
			local Options123 = DermaMenu()
			Options123:AddOption ("Refuel" ,function ()
				if CloneOpen == 1 then
					CloneOpen = 0
					CloneMenu_DFrame:SetVisible(false)
				end
				RunConsoleCommand("gms_Clone_Refuel",c["EntId"])
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			
			Options123:AddOption ("Take resources/Empty" ,function ()
				if CloneOpen == 1 then
					CloneOpen = 0
					CloneMenu_DFrame:SetVisible(false)
				end
				RunConsoleCommand("gms_Clone_Empty",c["EntId"])	
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			LocalPlayer():EmitSound(Sound(clicksound))
			Options123:Open()
		end
		
		
		
		CloneMenu_DButton_ = vgui.Create( "DButton", CloneMenu_DFrame)
		CloneMenu_DButton_:SetPos((350 / 2) + 15, 320)
		CloneMenu_DButton_:SetSize((350 / 2) - 10,20)
		CloneMenu_DButton_:SetText("CLOSE")
		CloneMenu_DButton_:SetVisible(true)
		CloneMenu_DButton_.DoClick = function ( btn )
			if CloneOpen == 1 then
				CloneOpen = 0
				CloneMenu_DFrame:SetVisible(false)
			end
			LocalPlayer():EmitSound(Sound(clicksound))
		end
		
		CloneMenu_DButton_ChangeRes = vgui.Create( "DButton", CloneMenu_DFrame)
		CloneMenu_DButton_ChangeRes:SetPos(5, 290)
		CloneMenu_DButton_ChangeRes:SetSize((350 / 2) - 10,20)
		CloneMenu_DButton_ChangeRes:SetText("Change Resource")
		CloneMenu_DButton_ChangeRes:SetVisible(true)
		CloneMenu_DButton_ChangeRes.DoClick = function ( btn )
			local Options123 = DermaMenu()
			for k,v in pairs(Resources) do
				if v > 0 then
					Options123:AddOption (k ,function ()
						if CloneOpen == 1 then
							CloneOpen = 0
							CloneMenu_DFrame:SetVisible(false)
						end
						RunConsoleCommand("gms_Clone_ChangeResource",c["EntId"],k)
						LocalPlayer():EmitSound(Sound(clicksound))
					end)
				end
			end
			Options123:AddOption ("No Resource/Turn off" ,function ()
				if CloneOpen == 1 then
					CloneOpen = 0
					CloneMenu_DFrame:SetVisible(false)
				end
				RunConsoleCommand("gms_Clone_ChangeResource",c["EntId"],"NA")
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			LocalPlayer():EmitSound(Sound(clicksound))
			Options123:Open()
		end
		
		CloneMenu_DButton_Upgrade = vgui.Create( "DButton", CloneMenu_DFrame)
		CloneMenu_DButton_Upgrade:SetPos(5, 320)
		CloneMenu_DButton_Upgrade:SetSize((350 / 2) - 10,20)
		CloneMenu_DButton_Upgrade:SetText("Upgrade")
		CloneMenu_DButton_Upgrade:SetVisible(true)
		CloneMenu_DButton_Upgrade.DoClick = function ( btn )
			local Options123 = DermaMenu()
			for k,v in pairs(upgradepos) do
				Options123:AddOption (v ,function ()
					if CloneOpen == 1 then
						CloneOpen = 0
						CloneMenu_DFrame:SetVisible(false)
					end	
					RunConsoleCommand("gms_Clone_Upgrade",c["EntId"],k)
					LocalPlayer():EmitSound(Sound(clicksound))
				end)
			end
			Options123:AddOption ("None" ,function ()
				if CloneOpen == 1 then
					CloneOpen = 0
					CloneMenu_DFrame:SetVisible(false)
				end
				LocalPlayer():EmitSound(Sound(clicksound))
			end)
			LocalPlayer():EmitSound(Sound(clicksound))
			Options123:Open()
		end
	end
end

QuestOpen = 0
function OpenQuest()
	if QuestOpen == 0 then
		QuestOpen = 1
		local clicksound = "ui/buttonclick.wav"
		local sw = ScrW()
		local sh = ScrH()
		local Height = 130
		local Width = 360
		
		QuestMenu_DFrame = vgui.Create ( "DFrame")
		QuestMenu_DFrame:SetPos(10 ,(ScrH() / 2)-(Height / 2))
		QuestMenu_DFrame:SetSize ( Width, Height)
		QuestMenu_DFrame:SetTitle ("QUEST")
		QuestMenu_DFrame:SetVisible(true)
		QuestMenu_DFrame:SetFont("ResFont1")
		QuestMenu_DFrame:SetDraggable(false)
		QuestMenu_DFrame:MakePopup()
		QuestMenu_DFrame:ShowCloseButton(false)
			QuestMenu_DFrame.Paint = function()
				draw.RoundedBox(6, 0, 0, QuestMenu_DFrame:GetWide(), QuestMenu_DFrame:GetTall(), Color(60,60,60,255))
				surface.SetDrawColor(color_white)
				surface.DrawOutlinedRect(0, 0, QuestMenu_DFrame:GetWide(), QuestMenu_DFrame:GetTall())	
			end	
		
		--StatChanging
		QuestMenu_DLabel = vgui.Create( "DLabel", QuestMenu_DFrame)
		QuestMenu_DLabel:SetPos(5, 30)
		QuestMenu_DLabel:SetSize(Width - 10, 60)
		if Quest["Quest"] == "NA" then
			QuestMenu_DLabel:SetText("You currently don't have a quest")
		elseif Quest["Complete"] == 1 then
			QuestMenu_DLabel:SetText("You have already done me a favour thank you.")
		else
			QuestMenu_DLabel:SetText(Quest["Quest"])
		end	
		QuestMenu_DLabel:SetFont("ResFont1")
		QuestMenu_DLabel:SetWrap( true )
		
		QuestMenu_DButton_ = vgui.Create( "DButton", QuestMenu_DFrame)
		QuestMenu_DButton_:SetPos(Width - 60, 10)
		QuestMenu_DButton_:SetSize(50,20)
		QuestMenu_DButton_:SetText("CLOSE")
		QuestMenu_DButton_:SetVisible(true)
		QuestMenu_DButton_.DoClick = function ( btn )
			if QuestOpen == 1 then
				QuestOpen = 0
				QuestMenu_DFrame:SetVisible(false)
			end
			LocalPlayer():EmitSound(Sound(clicksound))
		end
		
		QuestMenu_DButton_AcceptQuest = vgui.Create( "DButton", QuestMenu_DFrame)
		QuestMenu_DButton_AcceptQuest:SetPos(5, 100)
		QuestMenu_DButton_AcceptQuest:SetSize((350 / 2) - 10,20)
		QuestMenu_DButton_AcceptQuest:SetText("")
		QuestMenu_DButton_AcceptQuest:SetVisible(true)
		QuestMenu_DButton_AcceptQuest.DoClick = function ( btn )
			if QuestOpen == 1 then
				QuestOpen = 0
				QuestMenu_DFrame:SetVisible(false)
			end
			RunConsoleCommand("gms_acceptquest")
			LocalPlayer():EmitSound(Sound(clicksound))
		end
		
		if Quest["Quest"] == "NA" then
			QuestMenu_DButton_AcceptQuest:SetText("No Quest Active")
			QuestMenu_DButton_AcceptQuest.DoClick = function ( btn )
				if QuestOpen == 1 then
					QuestOpen = 0
					QuestMenu_DFrame:SetVisible(false)
				end
				LocalPlayer():EmitSound(Sound(clicksound))
			end
		elseif Quest["Complete"] == 1 then
			QuestMenu_DButton_AcceptQuest:SetText("Quest Completed")
			QuestMenu_DButton_AcceptQuest.DoClick = function ( btn )
				if QuestOpen == 1 then
					QuestOpen = 0
					QuestMenu_DFrame:SetVisible(false)
				end
				LocalPlayer():EmitSound(Sound(clicksound))
			end
		elseif Quest["Active"] == 1 then
			QuestMenu_DButton_AcceptQuest:SetText("Complete Quest")
			QuestMenu_DButton_AcceptQuest.DoClick = function ( btn )
				if QuestOpen == 1 then
					QuestOpen = 0
					QuestMenu_DFrame:SetVisible(false)
				end
				RunConsoleCommand("gms_completequest")
				LocalPlayer():EmitSound(Sound(clicksound))
			end
		else
			QuestMenu_DButton_AcceptQuest:SetText("Accept Quest")
			QuestMenu_DButton_AcceptQuest.DoClick = function ( btn )
				if QuestOpen == 1 then
					QuestOpen = 0
					QuestMenu_DFrame:SetVisible(false)
				end
				RunConsoleCommand("gms_acceptquest")
				LocalPlayer():EmitSound(Sound(clicksound))
			end
		end	
	end
	
end
concommand.Add("gms_OpenQuest",OpenQuest)
MarketOpen = 0
function OpenMarket()
	if MarketOpen == 0 then
		MarketOpen = 1
		local clicksound = "ui/buttonclick.wav"
		local sw = ScrW()
		local sh = ScrH()
		local Height = 360
		local Width = 360
		local possiblesales = {1,5,10,25,50,100,"All"}
		local selected = "NA"
		
		MarketMenu_DFrame = vgui.Create ( "DFrame")
		MarketMenu_DFrame:SetPos(10 ,(ScrH() / 2)-(Height / 2))
		MarketMenu_DFrame:SetSize ( Width, Height)
		MarketMenu_DFrame:SetTitle ("Market")
		MarketMenu_DFrame:SetVisible(true)
		MarketMenu_DFrame:SetFont("ResFont1")
		MarketMenu_DFrame:SetDraggable(false)
		MarketMenu_DFrame:MakePopup()
		MarketMenu_DFrame:ShowCloseButton(false)
			MarketMenu_DFrame.Paint = function()
				draw.RoundedBox(6, 0, 0, MarketMenu_DFrame:GetWide(), MarketMenu_DFrame:GetTall(), Color(60,60,60,255))
				surface.SetDrawColor(color_white)
				surface.DrawOutlinedRect(0, 0, MarketMenu_DFrame:GetWide(), MarketMenu_DFrame:GetTall())	
			end	
		
		
		
		--Upgrades
		MarketMenu_DLabe2 = vgui.Create( "DLabel", MarketMenu_DFrame)
		MarketMenu_DLabe2:SetPos(5, 30)
		MarketMenu_DLabe2:SetSize(370, 20)
		MarketMenu_DLabe2:SetText("Stock")
		MarketMenu_DLabe2:SetFont("ResFont1")
		
		local MarketMenu_DListView = vgui.Create("DListView", MarketMenu_DFrame)
		local c = QuestMachine
		MarketMenu_DListView:SetPos(5,50)
		MarketMenu_DListView:SetSize(350,230)
		MarketMenu_DListView:SetMultiSelect(false)
		MarketMenu_DListView:AddColumn("Name")
		MarketMenu_DListView:AddColumn("Stock")
		MarketMenu_DListView:AddColumn("Buy Price")
		MarketMenu_DListView:AddColumn("Inventory")
		MarketMenu_DListView:AddColumn("Sell Price")
		for k,v in pairs(Resources) do 
			if v > 0 || Resources[k] > 0 then
				MarketMenu_DListView:AddLine(k,0,0,v,10) 
			end
		end
	
		MarketMenu_DListView.OnClickLine = function(parent, line, isselected) //We override the function with our own  	
			selected = line:GetValue(1)
			MarketMenu_DLabe2:SetText("Stock    Selected Resource: "..selected)
			LocalPlayer():EmitSound(Sound(clicksound))
		end 
		

		
		MarketMenu_DButton_ = vgui.Create( "DButton", MarketMenu_DFrame)
		MarketMenu_DButton_:SetPos((350 / 2) + 15, 290)
		MarketMenu_DButton_:SetSize((350 / 2) - 10,20)
		MarketMenu_DButton_:SetText("Sell Resource")
		MarketMenu_DButton_:SetVisible(true)
		MarketMenu_DButton_.DoClick = function ( btn )
			local Options123 = DermaMenu()
			for k,v in pairs(possiblesales) do
				Options123:AddOption ("Sell: "..v ,function ()
					if MarketOpen == 1 then
						MarketOpen = 0
						MarketMenu_DFrame:SetVisible(false)
					end
					RunConsoleCommand("gms_Market_Sell",res,v)
					LocalPlayer():EmitSound(Sound(clicksound))
				end)
			end
			LocalPlayer():EmitSound(Sound(clicksound))
			Options123:Open()
		end
		
		
		
		MarketMenu_DButton_ = vgui.Create( "DButton", MarketMenu_DFrame)
		MarketMenu_DButton_:SetPos((350 / 2) + 15, 320)
		MarketMenu_DButton_:SetSize((350 / 2) - 10,20)
		MarketMenu_DButton_:SetText("CLOSE")
		MarketMenu_DButton_:SetVisible(true)
		MarketMenu_DButton_.DoClick = function ( btn )
			if MarketOpen == 1 then
				MarketOpen = 0
				MarketMenu_DFrame:SetVisible(false)
			end
			LocalPlayer():EmitSound(Sound(clicksound))
		end
		
		MarketMenu_DButton_ChangeRes = vgui.Create( "DButton", MarketMenu_DFrame)
		MarketMenu_DButton_ChangeRes:SetPos(5, 290)
		MarketMenu_DButton_ChangeRes:SetSize((350 / 2) - 10,20)
		MarketMenu_DButton_ChangeRes:SetText("Buy Resource")
		MarketMenu_DButton_ChangeRes:SetVisible(true)
		MarketMenu_DButton_ChangeRes.DoClick = function ( btn )
			local Options123 = DermaMenu()
			for k,v in pairs(possiblesales) do
				Options123:AddOption ("Buy: "..v ,function ()
					if MarketOpen == 1 then
						MarketOpen = 0
						MarketMenu_DFrame:SetVisible(false)
					end
					RunConsoleCommand("gms_Market_Buy",res,v)
					LocalPlayer():EmitSound(Sound(clicksound))
				end)
			end
			LocalPlayer():EmitSound(Sound(clicksound))
			Options123:Open()
		end
		
		MarketMenu_DButton_Upgrade = vgui.Create( "DButton", MarketMenu_DFrame)
		MarketMenu_DButton_Upgrade:SetPos(5, 320)
		MarketMenu_DButton_Upgrade:SetSize((350 / 2) - 10,20)
		MarketMenu_DButton_Upgrade:SetText("Quest Menu")
		MarketMenu_DButton_Upgrade:SetVisible(true)
		MarketMenu_DButton_Upgrade.DoClick = function ( btn )
			local Options123 = DermaMenu()
			if MarketOpen == 1 then
				MarketOpen = 0
				MarketMenu_DFrame:SetVisible(false)
			end
			RunConsoleCommand("gms_OpenQuest")
			LocalPlayer():EmitSound(Sound(clicksound))
			Options123:Open()
		end
	end
end















--Think--
Timer = 0
Timer2 = 0
PunchTime = 0
SaveTimer = 0
Effect = 0
EffectTime = 0
EffectStage = 0
CanSobel = 0
raintime = 0
raintimechange = .01
Sobel = 0
EffectOn = 0
function gms_togglerain(ply)
	local col = {255,180,0}
	if tobool(gms_CheckSettings("Raining")) == true then
		gms_SetSetting("Raining",false)
		AddNotification("It has stopped raining.","0,255,255")		
	else
		gms_SetSetting("Raining",true)
		AddNotification("It has started raining.","0,255,255")			
	end
end
concommand.Add("gms_rain",gms_togglerain)
function GM:Think()
	if Timer < CurTime() then
		Timer = CurTime() + .01
		if EffectTime > 0 then
			local EffectMin = (MaxEffect / 10)
			if EffectMin < 1 then
				EffectMin = 1
			end
			if Effect > EffectMin && EffectStage == 1 then
				Effect = Effect - 1
			else
				EffectStage = 2
			end
			if Effect < MaxEffect && EffectStage == 2 then
				Effect = Effect + 1
			else
				EffectStage = 1
			end
			EffectTime = EffectTime - .05
			RunConsoleCommand("pp_sharpen_contrast",Effect)
			RunConsoleCommand("pp_sharpen_distance",Effect)
			EffectOn = 1
		else
			EffectStage = 0
			EffectTime = 0
			if EffectOn == 1 then
				RunConsoleCommand("pp_sharpen_contrast",0)
				RunConsoleCommand("pp_sharpen_distance",0)
				EffectOn = 0
			end
		end
		
		if EffectStage == 1 then
			Effect = Effect - 1
			RunConsoleCommand("pp_sharpen",1)
			if tobool(gms_CheckSettings("CanSobel")) == true then
				RunConsoleCommand("pp_sobel",1)
				Sobel = 1
			else
				RunConsoleCommand("pp_sobel",0)
			end
			local thresh = MaxEffect / Effect 
			RunConsoleCommand("pp_sobel_threshold",thresh)
		elseif EffectStage == 2 then
			Effect = Effect + 1
			RunConsoleCommand("pp_sharpen",1)
			if tobool(gms_CheckSettings("CanSobel")) == true then
				RunConsoleCommand("pp_sobel",1)
				Sobel = 1
			else
				RunConsoleCommand("pp_sobel",0)
			end
			local thresh = MaxEffect / Effect 
			RunConsoleCommand("pp_sobel_threshold",thresh)
		else
			if Effect > .5 then
				Effect = Effect / 2
			else
				Effect = 0
				if Sobel == 1 then
					Sobel = 0
					RunConsoleCommand("pp_sharpen",0)
					RunConsoleCommand("pp_sobel",0)
				end
			end
		end
	end
	if tobool(gms_CheckSettings("Raining")) == true then
		if raintime < CurTime() then
			local trace = {}
				trace.start = LocalPlayer():GetShootPos()
				trace.endpos = trace.start + (LocalPlayer():GetUp() * 300)
				trace.filter = LocalPlayer()

				local tr = util.TraceLine(trace)

			if !tr.HitWorld and !tr.HitNonWorld then
				EffectsFunc( LocalPlayer():GetPos(),0,"gms_rain" )
			end
			raintime = CurTime() + raintimechange
		end
	end
end

local eyeangle = Angle(0,90,0)
DrugViewX = 0 
DrugViewY = 0 
DrugViewZ = 0 
function GM:CalcView( ply, origin, angles, fov )
	
	if	EffectTime > 0 then
		local view = {}
		if PunchTime < CurTime() then
			PunchTime = CurTime() + 5
			DrugViewX = 0
			DrugViewY = 90
			DrugViewZ = math.random(-180,180)
		end
		DrugViewX =  DrugViewX + ((math.random(-100,100) /100) * Effect /10)
		DrugViewY =  DrugViewY + ((math.random(-100,100) /100) * Effect /10)
		DrugViewZ = DrugViewZ + ((math.random(-100,100) /100) * Effect /10)
		view.angles = Angle(DrugViewX,DrugViewY,DrugViewZ)
		ply:SetEyeAngles(eyeangle)
		return view
	end
	
	local Vehicle = ply:GetVehicle()
	local wep = ply:GetActiveWeapon()

	
	if ( ValidEntity( Vehicle ) && 
		 gmod_vehicle_viewmode:GetInt() == 1 
		 /*&& ( !ValidEntity(wep) || !wep:IsWeaponVisible() )*/
		) then
		
		return GAMEMODE:CalcVehicleThirdPersonView( Vehicle, ply, origin*1, angles*1, fov )
		
	end

	local ScriptedVehicle = ply:GetScriptedVehicle()
	if ( ValidEntity( ScriptedVehicle ) ) then
	
		// This code fucking sucks.
		local view = ScriptedVehicle.CalcView( ScriptedVehicle:GetTable(), ply, origin, angles, fov )
		if ( view ) then return view end

	end

	local view = {}
	view.origin 	= origin
	view.angles		= angles
	view.fov 		= fov
	
	// Give the active weapon a go at changing the viewmodel position
	
	if ( ValidEntity( wep ) ) then
	
		local func = wep.GetViewModelPosition
		if ( func ) then
			view.vm_origin,  view.vm_angles = func( wep, origin*1, angles*1 ) // Note: *1 to copy the object so the child function can't edit it.
		end
		
		local func = wep.CalcView
		if ( func ) then
			view.origin, view.angles, view.fov = func( wep, ply, origin*1, angles*1, fov ) // Note: *1 to copy the object so the child function can't edit it.
		end
	
	end
	
	return view
	
end

function HudEffect(time2,int)
	if time2 && int then
		local amount = tonumber(int) or 0
		local time = tonumber(time2) or 0
		if time > 0 && int > 0 then
			EffectStage = 1
			EffectTime = time
			Effect = .25
			MaxEffect = int
			RunConsoleCommand("pp_sharpen",1)
			RunConsoleCommand("pp_sharpen_contrast",amount)
			RunConsoleCommand("pp_sharpen_distance",amount)
			if tobool(gms_CheckSettings("CanSobel")) == true then
				RunConsoleCommand("pp_sobel",1)
			else
				RunConsoleCommand("pp_sobel",0)
			end
		end
	end
end

function TestEffect(ply,cmd,args)
	local amount = tonumber(args[1]) or 0
	local time = tonumber(args[2]) or 0
	HudEffect(time,amount)
end

concommand.Add("gms_TestDrugEffect",TestEffect)

function SendHudEffect(um)
	local time = um:ReadShort()
	local int = um:ReadShort()
	HudEffect(time,int)
end
usermessage.Hook("SendHudEffect",SendHudEffect)

CsayText = {}
CsayTime = 0
CsayCurrent = 0
CsayTimer = 0
CsayFinal = 0
function AdminCsay(ply,cmd,args)
	CsayText = {}
	CsayFinal = 0
	if #args > 2 then
		for k,v in pairs(args) do 
			if k == 1 then
				CsayTime = tonumber(v) or 1
			else
				CsayText[k-1] = v
				CsayFinal = CsayFinal + 1
			end
		end
		CsayTimer = 0
		CsayCurrent = 1
	end
end
concommand.Add("bith_csayanimation",AdminCsay)

function CsayThink()
	if CsayTimer < CurTime() then
		if CsayCurrent != 0 && CsayFinal then
		CsayTimer = CurTime() + CsayTime
		RunConsoleCommand("ulx","csay",CsayText[CsayCurrent])
		CsayCurrent = CsayCurrent + 1
			if CsayCurrent > CsayFinal then
				CsayCurrent = 0
			end
		end
	end
end

hook.Add("Think","CsayThink",CsayThink)

function KillMenuTabs()
	local QMenu = g_SpawnMenu
	if(!g_SpawnMenu) then return end
	QMenu.CreateMenu[4].Panel = nil
	QMenu.CreateMenu[5].Panel = nil
	QMenu.CreateMenu[4].Tab:Remove()
	QMenu.CreateMenu[5].Tab:Remove()
	QMenu.CreateMenu[4].Tab = nil
	QMenu.CreateMenu[5].Tab = nil
	QMenu.CreateMenu[4] = nil
	QMenu.CreateMenu[5] = nil
end

function KillMenuEntries()
	local SpawnTabs = spawnmenu.GetCreationTabs()
	SpawnTabs.Weapons = nil
	SpawnTabs.Entities = nil
end

KillMenuTabs()
KillMenuEntries()

























