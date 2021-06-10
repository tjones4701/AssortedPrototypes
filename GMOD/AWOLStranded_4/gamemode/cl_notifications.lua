surface.CreateFont( "coolvetica", 18, 500, true, false, "MyFont1" )
surface.CreateFont( "coolvetica", 32, 500, true, false, "MyFont2" )
surface.CreateFont( "coolvetica", 12, 500, true, false, "MyFont3" )
surface.CreateFont( "coolvetica", 14, 500, true, false, "MyFont4" )
surface.CreateFont( "coolvetica", 16, 500, true, false, "MyFont5" )
surface.CreateFont( "coolvetica", 26, 500, true, false, "MyFont6" )
Notifications = {}
local n = Notifications
n.N = {}
n.OldN = {}
n.Fade = nil
n.X = 0
n.Y = -1
n.Width = 300
n.Spacing = 20
n.Active = 1
n.FadeTime = 5
n.Max = 4
n.FadeA = 1
n.BiggestWidth = 0
n.MoveSpeed = 5000

usermessage.Hook("gms_sendmessages2",function (um)
	local text = um:ReadString()
	local col = um:ReadString()
	AddNotification(text,col)
end)

function AddNotification(text,col)
	local str = string.Explode(",",col)
	local col = Color(tonumber(str[1]) or 255,tonumber(str[2])or 255,tonumber(str[3])or 255,tonumber(str[4])or 255)
	local tab = {}
	tab.Text = text
	tab.Time = CurTime() + n.FadeTime
	tab.Y = 0
	tab.H = 0
	tab.Col = col
	table.insert(n.N,1,tab)
	for k,v in pairs(n.N) do
		v.MSTime = CurTime() + 0.2
	end
	if gms_CheckSettings("OldNotifications") == false then
		if #n.N > n.Max + 1 then
			table.insert(n.OldN,n.N[n.Max + 2])
			table.remove(n.N,n.Max + 2)
		end
	else
	
	end
end

function ClearOldNotifications()
	n.OldN = {}
end
concommand.Add("gms_notifications_clearnotifications")

function NotificationFadeTime(ply,cmd,args)
	local amount = tonumber(args[1]) or nil
	if amount then
		n.FadeTime = amount
	end
end
concommand.Add("gms_notifications_fadetime",NotificationFadeTime)

function NotificationChangeVersion()
	if gms_CheckSettings("OldNotifications") == true then
		gms_SetSetting("OldNotifications",false)
		AddNotification("New Notification system.","0,255,255")		
	else
		gms_SetSetting("OldNotifications",true)
		AddNotification("Old Notification system.","0,255,255")	
	end
end
concommand.Add("gms_notifications_changeversion",NotificationChangeVersion)

function NotificationMax(ply,cmd,args)
	local amount = tonumber(args[1]) or nil
	if amount then
		n.Max = amount
	end
end
concommand.Add("gms_notifications_maxnotifications",NotificationMax)


hook.Add("HUDPaint","DrawNotifications",function ()
	local sw,sh = ScrW(),ScrH()
	local w,h = n.BiggestWidth,n.Max * n.Spacing + n.Spacing
	if gms_CheckSettings("OldNotifications") == true then
		local x,y = 0,sh - (sh / 3)
		for k,v in pairs(n.N) do
			local a,t = 1,v.Time - CurTime()
			if t <= 0 then
				table.remove(n.N,k)
				a = 0
			elseif t < 1 then
				a = t
			end
			local y2 = n.Spacing * k
			if v.Y == 0 then v.Y = y2 end
			if v.MSTime then
				local t = v.MSTime - CurTime()
				v.Y = v.Y + (y2 - v.Y) / t * FrameTime()
				v.H = v.H + (n.Spacing - v.H) / t * FrameTime()
				if t <= 0 then
					v.MSTime = nil
					v.Y = y2
					v.H = n.Spacing
				end
			end
			draw.SimpleText( v.Text, "MyFont1", x + 10 - ((a * n.MoveSpeed))+ n.MoveSpeed, v.Y + y - 1, v.Col, 0, 0 )
		end
	else
		local x,y = 0,sh - h
		draw.RoundedBox(4, x-5, y - 5,w + 10,h + 10, Color(30,30,30,180 * n.FadeA))
		draw.RoundedBox(4, x, y,w,h, Color(90,90,90,180 * n.FadeA))
		draw.SimpleText( "NOTIFICATIONS", "MyFont1", x + 5,y , Color(255,255,255,n.FadeA * 255), 0, 0 )
		if #n.N <= 0 then
			n.FadeA = math.max(n.FadeA - 0.1,0)
		else
			n.FadeA = math.min(n.FadeA + 0.1,1)
		end
		local Width, Height = surface.GetTextSize("NOTIFICATIONS")
		n.BiggestWidth = Width * 1.25
		for k,v in pairs(n.N) do
			local a,t = 1,v.Time - CurTime()
			if t <= 0 then
				table.remove(n.N,k)
				a = 0
			elseif t < 1 then
				a = t
			end
			local y2 = n.Spacing * k
			if v.Y == 0 then v.Y = y2 end
			if v.MSTime then
				local t = v.MSTime - CurTime()
				v.Y = v.Y + (y2 - v.Y) / t * FrameTime()
				v.H = v.H + (n.Spacing - v.H) / t * FrameTime()
				if t <= 0 then
					v.MSTime = nil
					v.Y = y2
					v.H = n.Spacing
				end
			end
			local Width, Height = surface.GetTextSize(v.Text)
			if Width * 1.25 > n.BiggestWidth then
				n.BiggestWidth = Width * 1.25
			end
			draw.RoundedBox(4, x + 5, y + v.Y - 2, w - 10, v.H-1, Color(255,255,255,180 * a))
			draw.SimpleText( v.Text, "MyFont1", x + 10, v.Y + y - 1, Color(0,0,0,255 * a), 0, 0 )
		end
	end
end)