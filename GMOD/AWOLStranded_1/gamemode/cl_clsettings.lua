
gms_Settings = {}
function LoadSetting(option,value)
	if !gms_quickoption:GetOption(option) then
		gms_quickoption:SetOption(option,value)
	end
	gms_Settings[option] = gms_quickoption:GetOption(option)
end
function LoadSettings()
	LoadSetting("DrawClock",true)
	LoadSetting("CanSobel",false)
	LoadSetting("Raining",false)
	LoadSetting("DNEffect",false)
	LoadSetting("ShowQuestStatus",true)
	LoadSetting("OldNotifications",false)
	LoadSetting("OldStrandedMenu",false)
	LoadSetting("RadialF3Menu",false)
end
function gms_SetSetting(option,val)
	gms_quickoption:SetOption(option,val)
	gms_Settings[option] = val
end
function gms_CheckSettings(option)
	return gms_Settings[option] 
end

function setoption(self,opt,val)
	local txt = ""
	if file.Exists(self.path) then
		txt = file.Read(self.path)
		txt = txt:gsub(opt .. "=([^=\n]+)\n","")
	end
	txt = Format("%s%s=%s\n",txt,opt,tostring(val))
	file.Write(self.path,txt)
end

function getoption(self,opt)
	if file.Exists(self.path) then
		local txt = file.Read(self.path)
		return txt:gmatch(opt .. "=([^=\n]+)\n")()
	end
end

function MakeQuickOption(path)
	if !path then return end
	local tab = {}
	tab.path = path
	tab.GetOption = getoption
	tab.SetOption = setoption
	return tab
end
gms_quickoption = MakeQuickOption("stranded_options.txt")
LoadSettings()
