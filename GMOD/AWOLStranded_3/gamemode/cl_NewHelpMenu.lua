surface.CreateFont( "coolvetica", 20, 500, true, false, "AcFont1" )
surface.CreateFont( "coolvetica", 32, 500, true, false, "AcFont2" )

HelpTopics = {}
HelpTopics["WELCOME"] = [[Welcome to AWOL stranded.
AWOL thanks you for playing our server and hope that 
you have the best time while playing.

--AWOL MOTD: Check out the new Ranks System in the "UPDATE" section.

--LAST UPDATE: August, 28, 2010

For more information click on the buttons on the left
side of the screen.

Please read the rules section before playing so you
understand what we expect of players.

To close this menu click on close or press F4.
To re-open this menu at any time press F4.]]

HelpTopics["PETS"] = [[
The Pets menu will not be getting fixed...sorry.
]]


HelpTopics["LAG FREE BASES"] = [[Did you know that everytime you weld,axis,
nocollide or ballsocket something it creates an entity? 
For every entity there needs to be more data sent to the client, so if you have 
to many constraints it can lag out the server.
If your props are frozen, could you unweld them or even better use the 
Easy Precision tool's move option.

Mechanical Mind]]

HelpTopics["UPDATES"] = [[Updates listed to the server are placed below.

August 28, 2010
Added a AWOL rank system, type awol_menu in console for pop up.
Added several new maps.
Updated members List

Febuary, 13, 2010
--Other
I added a save/load feature for stranded. 
Now most interface changes will save and load on rejoin.

Febuary, 12, 2010
--More hud changes
I added gradients (thanks mech, lol). So the bars should look better.
--Other
I also added nibbles name to awol members. Lol soz for not adding earlier i was lazy.
I also added some stuff in the help menu sections.

----------------------------------------------------------
---Please remember that not all changes will be listed.
---Mainly because i am lazy lol.
]]

HelpTopics["AWOL"] = [[No matter what you are looking for AWOL is the place to start.
Click on AWOL MEMBERS for a list of our members and the admins.

Awol currently has 3 servers:
AWOLParkour IP: 118.127.19.41:27085
AWOLStranded IP: 118.127.19.41:27125
AWOLBuild IP: 203.31.191.140:27013
Ventrillo IP: 203.46.105.45:21010
Feel free to use them.

We are a bunch of Australian PC gamers who've been gaming with each 
other since December '07. We are not a clan that wars, but a 
clan that socializes.

AWOL was founded by 3 G-Mod players; Sylver, Easystreet and Cube. Since 
then the AWOL Community has had many members, some still with us and 
some that have left us.

Our Ventrilo server is open to the public, so feel free to 
have a chat with us.

Details can be found at www.teamawol.net]]

HelpTopics["HELP-MAIN"] = [[Stranded is a survival gamemode about gathering resources and building.

You have to manage your stats and gather resources to make it easier to survive.
First things first, F3 is your menu for everything.
Anything that F3 doesn't do either attack it or use it.

On stranded there are a few things that you will need to know before playing.
First is ask people. If you want you could just skip this help thing and
close this menu. Then you could just ask people how to play and they will
tell you. Or you could read this and get a basic understanding of the game.

I recommend you read each of the HELP sections, below is a list.
HELP-STATS
HELP-LEVELS
HELP-CREATE
HELP-WHATNOW
I recommend reading them in that order.

If you have an error see the FAQ
]]

HelpTopics["HELP-STATS"] = [[Stats are very important. If you don't monitor them your player will die.

HEALTH: This starts at half and your max health increases as your level does
To fill it you need to eat cooked food.

HUNGER: This decreases gradually and will hurt your health if it is at 0.
To fill your hunger you need to eat. Forage the ground (USE) and plant 
seeds that you find. Fruit will soon grow and use them to eat.

THIRST: This decreases gradually and will hurt your health if it is at 0.
To fill your thirst you need to either go in water and press E or 
press E while not in the water to get a waterbottle and drink that
by using the menu (F3, other).

SLEEP: This decreases gradually and will hurt you if it is at 0.
Use the menu (F3, other). Then go sleep. It will automaticly wakeup
but if you want to wakeup earlier do the same and wakeup.
You will also need to sleep under something otherwise you will take damage.

That is all you need to know about stats.
]]


HelpTopics["HELP-LEVELS"] = [[LEVELS allow the player to perform actions quicker and more effectivly.

As you perform an action like Mining or Foraging you gain EXP in a skill.
Once you level a skill you gain EXP in your survival level. Every 4 skills
you level up you will gain 1 Survival level.

I am not going to list the skills here because it is fun finding what skills
there are and also because if i list them horizontally they won't fit lol.

Remember the more you do it the better you get. Also if you level up some skills you 
will even discover new resources.

That is all you need to know about levels.]]

HelpTopics["HELP-CREATE"] = [[BUILDINGS
By creating buildings you can build better equipment and gain more resources.
To create a building, Press F3, go to menus and then go structures.
Click on the buildings name to see information about it.
Once that menu is open you can select a building to create.
Green names mean you have enough resources to construct it and blue 
means you have already built it before and don't need to build it again.

COMBINATIONS
To make a combination press F3 goto menus and then go combinations.
Combinations combine resources into other resources.

WEAPONS
Weapons allow you to perform actions more effective. To create a weapon do 
the same as a building but access the menu by pressing E on it.
Unlike buildings though you need the resources to create it. when you make it.

That is all you need to know about creating stuff.]]

HelpTopics["HELP-WHATNOW"] = [[Well what else? PLAY!

There is much more to learn but this is just the basics.
With the knowledge from this help you will be able to go into the big world
and survive.

Don't forget to read the rules and if you have forgotten how to close this
menu press F4 or click on the close Button.

Hope you enjoy our server and have fun.]]

HelpTopics["RULES"] = [[DO THESE AND GET PUNISHED

-PropPushing
Punishment: 1 day ban
-Glitch exploiting
Punishment: 7 day ban
-General being a dick
Punishment: Varies
-Mass Killing
Punishment: 7 day ban
-Mass Prop Killing
Punishment: 31 day ban

We can ban you for any reason remember that.
Also just because it isn't on the list doesn't mean we can't ban you.

Please behave and have fun.
We have a 3 strike system. 
First time offence is the punishment.
Second offence is double the punishment.
Third offence is Perma Ban. ]]

HelpTopics["AWOL FEATURES"] = [[
ACHIEVMENTS
Currently we have an inbuilt achievments system that works and
tracks your progress on all AWOL servers.
To access the 'ACHIEVMENTS' menu click the achievments button near close
or type "awol_menu" into console.
]]








NewHelpOpen = 0
function OpenNewHelp()
	if NewHelpOpen == 0 then
		NewHelpOpen = 1
		local col = {255,180,0}
		local Selected = ""
		local clicksound = "ui/buttonclick.wav"
		local sw = ScrW()
		local sh = ScrH()
		local Height = 500
		local Width = 700
		NewHelpMenu_DFrame_Background = vgui.Create ( "DFrame")
		NewHelpMenu_DFrame_Background:SetPos(0 ,0)
		NewHelpMenu_DFrame_Background:SetSize ( sw, sh)
		NewHelpMenu_DFrame_Background:SetTitle (" ")
		NewHelpMenu_DFrame_Background:SetVisible(true)
		NewHelpMenu_DFrame_Background:SetDraggable(false)
		NewHelpMenu_DFrame_Background:MakePopup()
		NewHelpMenu_DFrame_Background:ShowCloseButton(false)
		NewHelpMenu_DFrame_Background:SetKeyboardInputEnabled(false)
			NewHelpMenu_DFrame_Background.Paint = function()
				draw.RoundedBox(0, 0, 0, NewHelpMenu_DFrame_Background:GetWide(), NewHelpMenu_DFrame_Background:GetTall(), Color(0,0,0,255))
				surface.SetDrawColor(color_white)	
			end
		NewHelpMenu_BackText = vgui.Create( "DLabel", NewHelpMenu_DFrame_Background)
		NewHelpMenu_BackText:SetWrap( true )
		NewHelpMenu_BackText:SetPos(120, 60)
		NewHelpMenu_BackText:SetSize(Width - 30,Height - 100)
		NewHelpMenu_BackText:SetTextColor( color_white )
		NewHelpMenu_BackText:InvalidateLayout( true ) 
		NewHelpMenu_BackText:SetFont("AcFont1")
		NewHelpMenu_BackText:SetText("F4 TO CLOSE" ) 
		NewHelpMenu_BackText:SetColor(Color(0,0,255,255))
		
		NewHelpMenu_DFrame = vgui.Create ( "DFrame")
		NewHelpMenu_DFrame:SetPos(50 ,50)
		NewHelpMenu_DFrame:SetSize ( Width, Height)
		NewHelpMenu_DFrame:SetTitle (" ")
		NewHelpMenu_DFrame:SetVisible(true)
		NewHelpMenu_DFrame:SetDraggable(false)
		NewHelpMenu_DFrame:MakePopup()
		NewHelpMenu_DFrame:ShowCloseButton(false)
		NewHelpMenu_DFrame:SetKeyboardInputEnabled(false)
			NewHelpMenu_DFrame.Paint = function()
				draw.RoundedBox(0, 5, 5, NewHelpMenu_DFrame:GetWide() - 10, NewHelpMenu_DFrame:GetTall() - 10, Color(180,180,180,255))
				surface.SetDrawColor(color_white)	
			end
			
		local NewHelpMenu_DermaList = vgui.Create("DListView", NewHelpMenu_DFrame)
		NewHelpMenu_DermaList:SetPos(10,20)
		NewHelpMenu_DermaList:SetSize(100,Height - 40)
		NewHelpMenu_DermaList:SetMultiSelect(false)
		NewHelpMenu_DermaList:AddColumn("TOPICS")
		
		for k,v in pairs(HelpTopics) do 
			NewHelpMenu_DermaList:AddLine(k)
		end
		NewHelpMenu_DermaList:SortByColumn( 1 )
		
		NewHelpMenu_DermaList.OnClickLine = function(parent, line, isselected)
			NewHelpMenu_MainText:SetText(HelpTopics[line:GetValue(1)] ) 
			NewHelpMenu_SecondaryText:SetText(line:GetValue(1) ) 
		end 
		
		NewHelpMenu_SecondaryText = vgui.Create( "DLabel", NewHelpMenu_DFrame)
		NewHelpMenu_SecondaryText:SetWrap( true )
		NewHelpMenu_SecondaryText:SetPos(120, 20)
		NewHelpMenu_SecondaryText:SetSize(Width - 30,30)
		NewHelpMenu_SecondaryText:SetTextColor( color_white )
		NewHelpMenu_SecondaryText:InvalidateLayout( true ) 
		NewHelpMenu_SecondaryText:SetFont("AcFont2")
		NewHelpMenu_SecondaryText:SetText("WELCOME" ) 
		NewHelpMenu_SecondaryText:SetColor(Color(255,0,0,255))
		
		
		NewHelpMenu_MainText = vgui.Create( "DLabel", NewHelpMenu_DFrame)
		NewHelpMenu_MainText:SetWrap( true )
		NewHelpMenu_MainText:SetPos(120, 60)
		NewHelpMenu_MainText:SetSize(Width - 30,Height - 100)
		NewHelpMenu_MainText:SetTextColor( color_white )
		NewHelpMenu_MainText:InvalidateLayout( true ) 
		NewHelpMenu_MainText:SetFont("AcFont1")
		NewHelpMenu_MainText:SetText(HelpTopics["WELCOME"] ) 
		NewHelpMenu_MainText:SetColor(Color(0,0,255,255))
		
		local NewHelpMenu_CloseButton = vgui.Create( "DButton", NewHelpMenu_DFrame)
		NewHelpMenu_CloseButton:SetPos(Width - 10 - 50,10)
		NewHelpMenu_CloseButton:SetSize(50, 20)
		NewHelpMenu_CloseButton:SetText("CLOSE")
		NewHelpMenu_CloseButton.DoClick = function ( btn )
			CloseNewHelp()
			LocalPlayer():EmitSound(Sound(clicksound))
		end
		
		local NewHelpMenu_AchievmentButton = vgui.Create( "DButton", NewHelpMenu_DFrame)
		NewHelpMenu_AchievmentButton:SetPos(Width - 10 - 50 - 150,10)
		NewHelpMenu_AchievmentButton:SetSize(100, 20)
		NewHelpMenu_AchievmentButton:SetText("ACHIEVMENTS")
		NewHelpMenu_AchievmentButton.DoClick = function ( btn )
			CloseNewHelp()
			RunConsoleCommand("awol_menu")
			LocalPlayer():EmitSound(Sound(clicksound))
		end
		
		/*local NewHelpMenu_AchievmentButton = vgui.Create( "DButton", NewHelpMenu_DFrame)
		NewHelpMenu_AchievmentButton:SetPos(Width - 10 - 50 - 150 - 150,10)
		NewHelpMenu_AchievmentButton:SetSize(100, 20)
		NewHelpMenu_AchievmentButton:SetText("PET MENU")
		NewHelpMenu_AchievmentButton.DoClick = function ( btn )
			CloseNewHelp()
			RunConsoleCommand("gms_petmenu")
			LocalPlayer():EmitSound(Sound(clicksound))
		end*/
		
	else
		CloseNewHelp()
	end
end

function CloseNewHelp()
	if NewHelpOpen == 1 then
		NewHelpOpen = 0
		NewHelpMenu_DFrame:SetVisible(false)
		NewHelpMenu_DFrame_Background:SetVisible(false)
	end
end

concommand.Add("gms_NewHelps",OpenNewHelp)
