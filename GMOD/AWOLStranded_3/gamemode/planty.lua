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
    Dtre:SetPos( 5, 140 )   
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