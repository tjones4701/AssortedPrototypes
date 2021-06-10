
HelpOpen = 0
Help = {"PRESS F3 TO CLOSE THIS MENU.",
	"Read these 'dot points' and learn how to play.",
	"Want day and night system? Type gms_ToggleDn into console. Want it gone? Re-type it..",
	"Health (RED) is the amount of well... health you have.",
	"Hunger (GREEN) like in real life you need to eat. Eat some fruit (USE KEY).",
	"Thirst (BLUE) also like in real life you need to drink. Just go under water look up and drink (USE KEY).",
	"Fatigue (PINK/PURPLE) While bieng stranded you may feel tired. Eventually you will die. You might need to sleep at some stage. Easiest way is to type '!sleep', ('!wakeup' wakes up)",
	"A good way to obtain resources is by experimenting. Try useing stuff for resources and also try hitting stuff (rocks and trees are best :-D ).",
	"Like real life the more you do something the better you get. Continue to do stuff and you will level up.",
	"The Q - menu exists here to... It has just had a facial. It still works the same, but now has more features. ",
	"One of the best ways to find out how to get better is to ask people. You should try it.",
	"Oh yeah. DON'T MINGE!!!!.",
	"Please play fair.",
	"PRESS F3 TO CLOSE THIS MENU.",
	}

/*========================================================================================================================
========================================================================================================================
========================================================================================================================
========================================================================================================================

Bind is blocked you idiot god damnit.

========================================================================================================================
========================================================================================================================
========================================================================================================================*/

function gms_Help(ply)
surface.CreateFont( "coolvetica", 20, 500, true, false, "AcFont1" )
surface.CreateFont( "coolvetica", 32, 500, true, false, "AcFont2" )
if HelpOpen == 1 then
	HelpOpen = 0
		gms_Help_menu_F1:SetVisible(false)
		gms_Help_menu_F12:SetVisible(false)
else
	HelpOpen = 1
	local MainW = 500
	local MainH = 500
		gms_Help_menu_F1 = vgui.Create ( "DFrame")
		gms_Help_menu_F1:SetPos((( ScrW() /2)-(MainW/2)) ,100 )
		gms_Help_menu_F1:SetSize ( MainW, MainH)
		gms_Help_menu_F1:SetTitle ("")
		gms_Help_menu_F1:SetVisible(true)
		gms_Help_menu_F1:SetDraggable(false)
		gms_Help_menu_F1:MakePopup()
		gms_Help_menu_F1:ShowCloseButton(false)
		gms_Help_menu_F1:SetMouseInputEnabled(true)
		gms_Help_menu_F1:SetKeyboardInputEnabled(false)

		gms_Help_menu_F1.Paint = function()
			draw.RoundedBox(16, 0, 0, gms_Help_menu_F1:GetWide(), gms_Help_menu_F1:GetTall(), Color(0,0,0,180))
		end	
		
		gms_Help_menu_F12 = vgui.Create ( "DFrame")
		gms_Help_menu_F12:SetPos((( ScrW() /2)-(MainW/2)) - 50 ,10 )
		gms_Help_menu_F12:SetSize ( MainW + 100, 70)
		gms_Help_menu_F12:SetTitle ("")
		gms_Help_menu_F12:SetVisible(true)
		gms_Help_menu_F12:SetDraggable(false)
		gms_Help_menu_F12:MakePopup()
		gms_Help_menu_F12:ShowCloseButton(false)
		gms_Help_menu_F12:SetMouseInputEnabled(true)
		gms_Help_menu_F12:SetKeyboardInputEnabled(false)

		gms_Help_menu_F12.Paint = function()
			draw.RoundedBox(16, 0, 0, gms_Help_menu_F12:GetWide(), gms_Help_menu_F12:GetTall(), Color(0,0,0,255))
		end	
		
		local gms_Help_Menu_Background2 = vgui.Create( "DButton", gms_Help_menu_F12)
			gms_Help_Menu_Background2:SetPos(10, 10)
			gms_Help_Menu_Background2:SetSize(MainW + 80, 50)
			gms_Help_Menu_Background2:SetText("")
			gms_Help_Menu_Background2.DoClick = function ( btn )
			end
			
			gms_Help_Menu_Background2.Paint = function()
				draw.RoundedBox(16, 0, 0, gms_Help_Menu_Background2:GetWide(), gms_Help_Menu_Background2:GetTall(), Color(0,100,0,180))
			end
			
			Help_Text_F2 = vgui.Create( "DLabel", gms_Help_menu_F12)
	Help_Text_F2:SetWrap( true )
	Help_Text_F2:SetPos(20, 15)
	Help_Text_F2:SetSize(600,45)
	Help_Text_F2:SetTextColor( color_white )
	Help_Text_F2:InvalidateLayout( true ) 
	Help_Text_F2:SetFont("AcFont2")
	Help_Text_F2:SetText("WELCOME TO STRANDED! AWOL STYLE!" ) 
		
	local gms_Help_Menu_Background = vgui.Create( "DButton", gms_Help_menu_F1)
			gms_Help_Menu_Background:SetPos(10, 10)
			gms_Help_Menu_Background:SetSize(480, 480)
			gms_Help_Menu_Background:SetText("")
			gms_Help_Menu_Background.DoClick = function ( btn )
			end
			
			gms_Help_Menu_Background.Paint = function()
				draw.RoundedBox(16, 0, 0, gms_Help_Menu_Background:GetWide(), gms_Help_Menu_Background:GetTall(), Color(0,100,0,180))
			end
			
	gms_Helplist = vgui.Create("DPanelList",gms_Help_menu_F1)
		gms_Helplist:SetPos(20,20)
		gms_Helplist:SetSize(460,460)
		gms_Helplist:SetSpacing( 20 ) 
		gms_Helplist:EnableHorizontal( false ) 
		gms_Helplist:EnableVerticalScrollbar( true )
		gms_Helplist.Paint = function (self)
		end
		
		for k,v in pairs(Help) do
		
		local gms_Help_Menu_Button = {}
			gms_Help_Menu_Button[v] = vgui.Create( "DButton")
			gms_Help_Menu_Button[v]:SetPos(0, 0)
			gms_Help_Menu_Button[v]:SetSize(400, 100)
			gms_Help_Menu_Button[v]:SetText("")

			gms_Help_Menu_Button[v].DoClick = function ( btn )
			
			end
			gms_Help_Menu_Button[v].Paint = function()

					draw.RoundedBox(16, 0, 0, gms_Help_Menu_Button[v]:GetWide(), gms_Help_Menu_Button[v]:GetTall(), Color(0,60,0,180))
			end
			Help_Text_F1 = {}
			Help_Text_F1[v] = vgui.Create( "DLabel", gms_Help_Menu_Button[v])
			Help_Text_F1[v]:SetWrap( true )
			Help_Text_F1[v]:SetPos(20, 5)
			Help_Text_F1[v]:SetSize(390,90)
			Help_Text_F1[v]:SetTextColor( color_white )

			Help_Text_F1[v]:InvalidateLayout( true ) 
			Help_Text_F1[v]:SetFont("AcFont1")
			Help_Text_F1[v]:SetText( v )  
			
		button = gms_Help_Menu_Button[v]
		gms_Helplist:AddItem(button,Help_Text_F1[v])
		
		
		end
	
	
end
end
concommand.Add ("gms_NewHelps",gms_Help)