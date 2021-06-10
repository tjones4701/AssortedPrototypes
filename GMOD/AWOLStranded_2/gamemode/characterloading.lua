--[[
progress

loadcharacter_repeatedfail
loadcharacter_incorrect
loadcharacter_doesntexsist
loadcharacter_correct

cccreatecharacter_accountexsists
cccreatecharacter_invalidcreate
cccreatecharacter_accountcreated
]]

function LoadCharacter(ply,name,pass)
	if ply.PassTry[name] then
		
	else
		ply.PassTry[name] = 0
	end
	if ply.PassTry[name] < 3 then
		local pass = BithLoad("GMStranded/Saves/"..name.."/pass.txt",blah) or "THIB"
		if pass == "THIB" || name == "Player" then
			ply:SendMessage("ACCOUNT DOESN'T EXSIST.",3,Color(255,255,255,255))
			cl_LoadProgress(ply,"loadcharacter_doesntexsist")
		else
			if name == pass then
				LoadCharacter(ply,name,pass)
				cl_LoadProgress(ply,"correct")
			else
				ply:SendMessage("PASSWORD IS INCORRECT.",3,Color(255,255,255,255))
				if ply.PassTry[name] then
					ply.PassTry[name] = 1
				else
					ply.PassTry[name] = ply.PassTry[name] + 1
				end
				cl_LoadProgress(ply,"incorrect")
			end
		end
	else
		ply:SendMessage("Due to repeated fails at this name you can't log in to this username.",3,Color(255,255,255,255))
		cl_LoadProgress(ply,"repeatedfail")
	end
end

function CCCreateCharacter(ply,args)
	local pass = args[2]
	local name = args[1]
	if name && pass then
		if file.Exists("GMStranded/Saves/"..name.."/stats.txt") then
			cl_LoadProgress(ply,"cccreatecharacter_accountexsists")
		else
			LoadCharacter(ply,name,pass)
			cl_LoadProgress(ply,"cccreatecharacter_accountcreated")
		end
	else
		cl_LoadProgress(ply,"cccreatecharacter_invalidcreate")
	end
end
concommand.Add("gms_CreateAccount",CCCreateCharacter)

function CCLoginCharacter(ply,args)
	local pass = args[2]
	local name = args[1]
	if name && pass then
		LoadCharacter(ply,name,pass)
	else
		cl_LoadProgress(ply,"cclogincharacter_invalidcreate")
	end
end
concommand.Add("gms_LoginAccount",CCLoginCharacter)

function LoadCharacter(ply,name,pass)
	ply.Skills = {}
	ply.Resources = {}
	ply.Experience = {}
	ply.Upgrades = {}
	if file.Exists("GMStranded/Saves/"..name.."/stats.txt") then
		for k,v in pairs(GMS_Upgrades) do 
			ply.Upgrades[v] = tonumber((BithLoad("GMStranded/Saves/"..name.."/Upgrades/"..v..".txt") or 0 ))
			BithSave("GMStranded/Saves/"..name.."/Upgrades/"..v..".txt",ply.Upgrades[v])
		end
		local tbl = util.KeyValuesToTable(file.Read("GMStranded/Saves/"..name.."/stats.txt"))

		if tbl["skills"] then
			for k,v in pairs(tbl["skills"]) do
				ply:SetSkill(string.Capitalize(k),v)
			end
		end

		if tbl["experience"] then
			for k,v in pairs(tbl["experience"]) do
				ply:SetXP(string.Capitalize(k),v)
			end
		end

		if !ply.Skills["Survival"] then ply.Skills["Survival"] = 0 end

		ply.MaxResources = (ply.Skills["Survival"] * 5) + 25

		if tbl.tribe then
			ply.Tribe = tbl.tribe
		end
		
		ply:SendMessage("Loaded character successfully.",3,Color(255,255,255,255))
		ply:SendMessage("Last visited on "..tbl.date..", enjoy your stay.",10,Color(255,255,255,255))
	else
		ply:SetSkill("Survival",0)
		ply:SetXP("Survival",0)
		ply.MaxResources = 25
	end
	ply.Account = name
	ply.Password = pass
	if ply.HasSynched == 0 then
		ply.HasSynched = 1
		BithSave("GMStranded/Saves/"..ply:UniqueID().."/HasSynched.txt",ply.HasSynched)
		LoadByUniqueId(ply)
	else
		ply:Kill()
	end
	GAMEMODE.SaveCharacter(ply)
end

function cl_LoadProgress(ply,progress)
	umsg.Start("gms_load",ply)
		umsg.String(progress)
	umsg.End()
end

function LoadByUniqueId(ply)
	for k,v in pairs(GMS_Upgrades) do 
		ply.Upgrades[v] = tonumber((BithLoad("GMStranded/Saves/"..ply:UniqueID().."/Upgrades/"..v..".txt") or 0 ))
		BithSave("GMStranded/Saves/"..ply:UniqueID().."/Upgrades/"..v..".txt",ply.Upgrades[v])
	end
	if file.Exists("GMStranded/Saves/"..ply:UniqueID()..".txt") then
		local tbl = util.KeyValuesToTable(file.Read("GMStranded/Saves/"..ply:UniqueID()..".txt"))

		if tbl["skills"] then
			for k,v in pairs(tbl["skills"]) do
				ply:SetSkill(string.Capitalize(k),v)
			end
		end

		if tbl["experience"] then
			for k,v in pairs(tbl["experience"]) do
				ply:SetXP(string.Capitalize(k),v)
			end
		end

		if !ply.Skills["Survival"] then ply.Skills["Survival"] = 0 end

		ply.MaxResources = (ply.Skills["Survival"] * 5) + 25

		if tbl.tribe then
			ply.Tribe = tbl.tribe
		end
		
		ply:SendMessage("Loaded character successfully.",3,Color(255,255,255,255))
		ply:SendMessage("Last visited on "..tbl.date..", enjoy your stay.",10,Color(255,255,255,255))
	else
		ply:SetSkill("Survival",0)
		ply:SetXP("Survival",0)
		ply.MaxResources = 25
	end
	ply:Kill()	
	GAMEMODE.SaveCharacter(ply)
end



function BithSaveAchievments(ply)
	if OldLoad == 1 then
		for k,v in pairs(ply.Upgrades) do 
			BithSave("GMStranded/Saves/"..ply:UniqueID().."/Upgrades/"..k..".txt",ply.Upgrades[k])
		end
		ply:SendMessage("Saved achievments.",3,Color(255,255,255,255))
	else
	
	end
end


function OldLoadByUniqueId(ply)
	for k,v in pairs(GMS_Upgrades) do 
		ply.Upgrades[v] = tonumber((BithLoad("GMStranded/Saves/"..ply:UniqueID().."/Upgrades/"..v..".txt") or 0 ))
		BithSave("GMStranded/Saves/"..ply:UniqueID().."/Upgrades/"..v..".txt",ply.Upgrades[v])
	end
	if file.Exists("GMStranded/Saves/"..ply:UniqueID()..".txt") then
		local tbl = util.KeyValuesToTable(file.Read("GMStranded/Saves/"..ply:UniqueID()..".txt"))

		if tbl["skills"] then
			for k,v in pairs(tbl["skills"]) do
				ply:SetSkill(string.Capitalize(k),v)
			end
		end

		if tbl["experience"] then
			for k,v in pairs(tbl["experience"]) do
				ply:SetXP(string.Capitalize(k),v)
			end
		end




		if !ply.Skills["Survival"] then ply.Skills["Survival"] = 0 end

		ply.MaxResources = (ply.Skills["Survival"] * 5) + 25

		if tbl.tribe then
			ply.Tribe = tbl.tribe
		end

		
		ply:SendMessage("Loaded character successfully.",3,Color(255,255,255,255))
		if tbl.date then
			ply:SendMessage("Last visited on "..tbl.date..", enjoy your stay.",10,Color(255,255,255,255))
		end
	else
		ply:SetSkill("Survival",0)
		ply:SetXP("Survival",0)
		ply.MaxResources = 25
	end
	GAMEMODE.SaveCharacter(ply)
end