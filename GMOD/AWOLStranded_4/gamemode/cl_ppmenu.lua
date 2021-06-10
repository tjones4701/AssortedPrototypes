function PPMenu()
	PPMenu_DFrame = vgui.Create ( "DFrame")
	PPMenu_DFrame:SetPos(ScrW() / 2 - 62 ,10)
	PPMenu_DFrame:SetSize ( (ScrW() / 2 - 62) + 100, (ScrH() / 1.01))
	PPMenu_DFrame:SetTitle (" ")
	PPMenu_DFrame:SetVisible(true)
	PPMenu_DFrame:SetDraggable(true)
	PPMenu_DFrame:MakePopup()
	PPMenu_DFrame:ShowCloseButton(false)
	PPMenu_DFrame.Paint = function()
		draw.RoundedBox(6, 5, 5, PPMenu_DFrame:GetWide() - 10, PPMenu_DFrame:GetTall() - 10, Color(0,0,0,255))
	end	

	
	PPPanel = vgui.Create( "stranded_SPPMenu2", PPMenu_DFrame );
	PPPanel:SetPos( 0,0 );

end

concommand.Add("gms_ppmenu",PPMenu)

function closeppmenu()
	if PPMenu_DFrame then
		PPMenu_DFrame:SetVisible(false)
	end
end
concommand.Add("gms_closeppmenu",closeppmenu)
/*---------------------------------------------------------
  DSPP Menu
---------------------------------------------------------*/
cl_pp_buddies = {}
local PANEL = {}

PANEL.ACommands = {}
PANEL.ACommands["SPropProtection_toggle"] = "Prop Protection On/Off"
PANEL.ACommands["SPropProtection_admin"] = "Admins Can Do Everything On/Off"
PANEL.ACommands["SPropProtection_use"] = "Use Protection On/Off"
PANEL.ACommands["SPropProtection_edmg"] = "Entity Damage Protection On/Off"
PANEL.ACommands["SPropProtection_pgr"] = "Physgun Reload Protection On/Off"
PANEL.ACommands["SPropProtection_awp"] = "Admins Can Touch World Props On/Off"
PANEL.ACommands["SPropProtection_dpd"] = "Disconnect Prop Deletion On/Off"
PANEL.ACommands["SPropProtection_dae"] = "Delete Admin Entities On/Off"

PANEL.Sliders = {};
PANEL.Sliders["SPropProtection_delay"] = "Deletion Delay in seconds"

PANEL.AButtons = {};

PANEL.PlCBoxes = {};

PANEL.pnlCanvas = nil;

PANEL.LastThink = CurTime();


function PANEL:Init()
	CreateClientConVar("SPropProtection_toggle", 1, false, true)
	CreateClientConVar("SPropProtection_admin", 1, false, true)
	CreateClientConVar("SPropProtection_use", 1, false, true)
	CreateClientConVar("SPropProtection_edmg", 1, false, true)
	CreateClientConVar("SPropProtection_pgr", 1, false, true)
	CreateClientConVar("SPropProtection_awp", 1, false, true)
	CreateClientConVar("SPropProtection_dpd", 1, false, true)
	CreateClientConVar("SPropProtection_dae", 0, false, true)
	CreateClientConVar("SPropProtection_delay", 120, false, true)
	self.pnlCanvas = vgui.Create( "DPanel", self)
	self.pnlCanvas:SetPos( 25,25 )
	self.pnlCanvas:SetSize(ScrW() / 2 - 62, 2000)--ScrH() - 104
	self.pnlCanvas.Paint = function() 
		surface.SetDrawColor(0,0,0,255)
		surface.DrawRect( 0, 0, self.pnlCanvas:GetWide(), self.pnlCanvas:GetTall() ) 
	end 
	
	self.VBar = vgui.Create("DVScrollBar", self);
	self.VBar:SetPos( (ScrW() / 2)  - 32, 25 ) 
	self.VBar:SetSize( 16,  ScrH() - 130 )
	self.VBar:SetUp( self.VBar:GetTall(), self.pnlCanvas:GetTall() ) 

	
	

	--self.pnlCanvas:SetSpacing( 0 )
	--self.pnlCanvas:EnableHorizontal( true )
	--self.pnlCanvas:EnableVerticalScrollbar( true )

	
	
	local line = 25
	local size = ScrH() / 35
	/*
	------------------------------------------------------------------------------------------------------Admin-----------------------------------------------------------------------------------------------------
	*/
	
	if(LocalPlayer():IsAdmin() or LocalPlayer():IsSuperAdmin())then
		for cmd,txt in pairs(self.ACommands) do
	        local cbox = vgui.Create("DCheckBoxLabel",self.pnlCanvas)
	        cbox:SetSize(self.pnlCanvas:GetWide() / 2, 100)
	        cbox:SetPos(self.pnlCanvas:GetWide() / 2, line)
	        cbox:SetConVar(cmd)
	        cbox:SetText(txt)
		cbox:SetValue(1);
	             
	        line = line + 30 + 10
	    end
		
		for cmd,txt in pairs(self.Sliders) do
	        local slider = vgui.Create("DNumSlider",self.pnlCanvas)
	        slider:SetSize(200, 100)
	        slider:SetPos(self.pnlCanvas:GetWide() / 2, line)
	        slider:SetConVar(cmd)
	        slider:SetText(txt)
			slider:SetValue(600);
			slider:SetMin(0);
			slider:SetMax(1200);
			slider:SetDecimals(0);
	             
	        line = line + 50 + 10
	    end
		--print("Line nach Admincheckboxen: " ..line);
		AplAdmin = vgui.Create("gms_CommandButton",self.pnlCanvas)
		AplAdmin:SetSize(self.pnlCanvas:GetWide() / 2.5, size)
		AplAdmin:SetPos(self.pnlCanvas:GetWide() / 2, line)
		AplAdmin:SetConCommand("SPropProtection_ApplyAdminSettings\n")
		AplAdmin:SetText("Apply Admin Settings");
		line = line + AplAdmin:GetTall() + 10
		
		RelAdmin = vgui.Create("gms_CommandButton",self.pnlCanvas)
		RelAdmin:SetSize(self.pnlCanvas:GetWide() / 4, size)
		RelAdmin:SetPos(self.pnlCanvas:GetWide() / 2, line)
		RelAdmin:SetConCommand("SPropProtection_AdminReload\n")
		RelAdmin:SetText("Reload Settings");
		line = line + RelAdmin:GetTall() + 10
		
		
		line = 25;
		
		for k, ply in pairs(player.GetAll()) do
			if(ply and ply:IsValid())then
				PANEL.AButtons[k] = vgui.Create("gms_CommandButton",self.pnlCanvas)
		        PANEL.AButtons[k]:SetSize(self.pnlCanvas:GetWide() / 3, size)
		        PANEL.AButtons[k]:SetPos(10, line)
		        PANEL.AButtons[k]:SetConCommand("SPropProtection_CleanupProps " ..ply:GetNWString("SPPSteamID") .."\n")
		        PANEL.AButtons[k]:SetText("Cleanup " ..ply:Nick())
				
		        line = line + PANEL.AButtons[k]:GetTall() + 10
			end
		end
		local a = table.getn(PANEL.AButtons)+1;
		PANEL.AButtons[a] = vgui.Create("gms_CommandButton",self.pnlCanvas)
		PANEL.AButtons[a]:SetSize(self.pnlCanvas:GetWide() / 3, size)
		PANEL.AButtons[a]:SetPos(10, line)
		PANEL.AButtons[a]:SetConCommand("SPropProtection_CleanupDisconnectedProps\n")
		PANEL.AButtons[a]:SetText("Cleanup Disconnected");
		line = line + PANEL.AButtons[a]:GetTall() + 10
		
		if(line<550)then
			line = 550;
		end
	end
	
	/*
	-----------------------------------------------------------------------------------------------------Client-----------------------------------------------------------------------------------------------------
	*/
	AplBuddy = vgui.Create("gms_CommandButton",self.pnlCanvas)
	AplBuddy:SetSize(self.pnlCanvas:GetWide() / 4, size)
	AplBuddy:SetPos(self.pnlCanvas:GetWide() / 2, 550)
	AplBuddy:SetConCommand("SPropProtection_ApplyBuddySettings\n")
	AplBuddy:SetText("Apply Settings");
	
	ClBuddy = vgui.Create("gms_CommandButton",self.pnlCanvas)
	ClBuddy:SetSize(self.pnlCanvas:GetWide() / 4, size)
	ClBuddy:SetPos(self.pnlCanvas:GetWide() / 2, 550 + AplBuddy:GetTall() + 10)
	ClBuddy:SetConCommand("SPropProtection_ClearBuddies\n")
	ClBuddy:SetText("Clear All Buddies");
	
	ClBuddy2 = vgui.Create("gms_CommandButton",self.pnlCanvas)
	ClBuddy2:SetSize(self.pnlCanvas:GetWide() / 4, size)
	ClBuddy2:SetPos(self.pnlCanvas:GetWide() / 2, 550 + ClBuddy:GetTall() + AplBuddy:GetTall() + 20)
	ClBuddy2:SetConCommand("gms_closeppmenu")
	ClBuddy2:SetText("CLOSE PP MENU");
	
	local Players = player.GetAll()

	for k, ply in pairs(player.GetAll()) do
			if(ply and ply:IsValid() and ply != LocalPlayer()) then
				local BCommand = "SPropProtection_BuddyUp_"..ply:GetNWString("SPPSteamID")
				if !cl_pp_buddies[BCommand] then
					cl_pp_buddies[BCommand] = 0
				end
				if(!LocalPlayer():GetInfo(BCommand)) then
					CreateClientConVar(BCommand, 0, false, true)
				end
				PANEL.PlCBoxes[k] = vgui.Create("DCheckBoxLabel",self.pnlCanvas)
		        PANEL.PlCBoxes[k]:SetPos(10, line)
		        PANEL.PlCBoxes[k]:SetConVar(BCommand)
		        PANEL.PlCBoxes[k]:SetText(ply:Nick())
				PANEL.PlCBoxes[k]:SetValue(LocalPlayer():GetInfo(BCommand));
				PANEL.PlCBoxes[k]:SizeToContents();
		             
		        line = line + 30 + 10
			end
		end
	

	

end

function PANEL:Think()

	
end


function PANEL:PerformLayout( )
	self:StretchToParent( 1, 1, 1, 1 )
end

function PANEL:OnVScroll( iOffset ) 
	self.pnlCanvas:SetPos( 25, 25 + iOffset )
end 

function PANEL:OnMouseWheeled( dlta ) 
	if ( self.VBar ) then 
		return self.VBar:OnMouseWheeled( dlta ) 
	end
end 

vgui.Register("stranded_SPPMenu2",PANEL,"DPanel")