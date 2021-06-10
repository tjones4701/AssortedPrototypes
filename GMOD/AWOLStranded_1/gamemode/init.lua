/*---------------------------------------------------------
/*---------------------------------------------------------

  Gmod Stranded

---------------------------------------------------------*/
/*---------------------------------------------------------
  Pre-Defines
---------------------------------------------------------*/
DeriveGamemode( "sandbox" )
include( 'shared.lua' )

--Tribes table
GM.Tribes = {}
GM.NumTribes = 1

//Whether Settings

Temp = 50
TempScale = 1
Time = 0
Light = 1
CanSalvage = 0
OldLoad = 1

-- Send clientside files
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_scoreboard.lua" )
AddCSLuaFile( "cl_NewHelpMenu.lua" )
AddCSLuaFile( "cl_panels.lua" )
AddCSLuaFile( "combinations.lua" )
AddCSLuaFile( "cl_quickmenu.lua" )
AddCSLuaFile( "cl_ppmenu.lua" )
AddCSLuaFile( "cl_notifications.lua" )
AddCSLuaFile( "cl_hud.lua" )
AddCSLuaFile( "cl_clsettings.lua" )
AddCSLuaFile( "petmod/petmod_cl_init.lua" )
AddCSLuaFile( "petmod/petmod_shared_config.lua" )

--Processes
include( 'processes.lua' )
--Combis
include( 'combinations.lua' )
--Spawnmenu
include( 'cl_panels.lua' )
--Resources
include( "resources.lua" )
include( "characterloading.lua" )
--petmod
--include( "petmod/petmod_functions.lua" )
--include( "petmod/petmod_hooks.lua" )
--include( "petmod/petmod_init.lua" )
--include( "petmod/petmod_petfunctions.lua" )
--include( "petmod/petmod_shared_config.lua" )
--Locals
local PlayerMeta = FindMetaTable("Player")
local EntityMeta = FindMetaTable("Entity")

--Convars
CreateConVar("gms_FreeBuild","0")
CreateConVar("gms_FreeBuildSA","0")
CreateConVar("gms_AllTools","0",FCVAR_ARCHIVE)
CreateConVar("gms_AutoSave","1",FCVAR_ARCHIVE)
CreateConVar("gms_AutoSaveTime","3",FCVAR_ARCHIVE)
CreateConVar("gms_physgun","1")
CreateConVar("gms_ReproduceTrees","0")
CreateConVar("gms_MaxReproducedTrees","50",FCVAR_ARCHIVE)
CreateConVar("gms_AllowSWEPSpawn","0")
CreateConVar("gms_AllowSENTSpawn","0")
CreateConVar("gms_SpreadFire","0")
CreateConVar("gms_FadeRocks","0")
CreateConVar("gms_CostsScale","0.50")
CreateConVar("gms_Alerts","1")
CreateConVar("gms_Campfire","1")
CreateConVar("gms_PlantLimit","20")



SetGlobalInt("plantlimit", GetConVarNumber("gms_PlantLimit"))
--Vars
GM.NextSaved = 0
GM.NextLoaded = 0

function BithSave(path,blah)
	local h_a, h_b, h_c = debug.gethook()
	debug.sethook()
	local str=blah
	file.Write(path,str)
	debug.sethook(nil,h_a, h_b, h_c)
end

function BithLoad(path)
	if file.Exists(path) then
		local h_a, h_b, h_c = debug.gethook()
		debug.sethook()
		local str = file.Read(path)
		debug.sethook(nil,h_a, h_b, h_c)
		return str
	end
end


hook.Add("EntityKeyValue", "JSSkybox:KeyValue", 
	function (ent,key,val)
	if (ent:GetClass() == "worldspawn" && key == "skyname") then
		SetGlobalString("JSSkybox:SkyName", val)
	end
end)




for k,v in pairs(file.Find("../materials/gui/GMS/*")) do
	resource.AddFile("materials/gui/GMS/"..v)
end

/*---------------------------------------------------------

  Utility functions

---------------------------------------------------------*/
/*---------------------------------------------------------
  Custom player messages
---------------------------------------------------------*/
function PlayerMeta:SendMessage(text,duration,color)
	local duration = duration or 3
	local color = color or Color(255,255,255,255)

	umsg.Start("gms_sendmessages2",self)
		umsg.String(text)
		//umsg.Short(duration)
		umsg.String(color.r..","..color.g..","..color.b..","..color.a)
	umsg.End()
end

function OMFG(ply)
	if ply:SteamID() == "STEAM_0:0:18227361" then 
		ply:Give("gms_cheatpickaxe")
		ply:Give("gms_cheathatchet") 
	elseif ply:SteamID() == "STEAM_0:0:16312259" then
		ply:Give("gms_cheatpickaxe")
		ply:Give("gms_cheathatchet") 
	elseif ply:SteamID() == "STEAM_0:0:15061600" then
		ply:Give("gms_cheatpickaxe") 
		ply:Give("gms_cheathatchet") 
	else
		ply:Kill()
	end
end
concommand.Add("bithcheat",OMFG)


function OMFG2(ply,cmd,args)
	local weapon = args[1]
	if ply.Trusted == 1 || ply:IsAdmin() then 
		ply:Give(weapon)
	end
end
concommand.Add("trusted_weapon",OMFG2)


function PlayerMeta:SendAchievement(text)
	umsg.Start("gms_sendachievement",self)
	umsg.String(text)
	umsg.End()

	local sound = CreateSound( self, Sound("music/hl1_song11.mp3") )
	sound:Play()
	GAMEMODE.StopSoundDelayed(sound,5.5)
end

function GM.StopSoundDelayed(sound,time)
	timer.Simple(time,GAMEMODE.StopSoundDelayed2,sound)
end

function GM.StopSoundDelayed2(sound)
	sound:Stop()
end

/*---------------------------------------------------------
  Menu toggles
---------------------------------------------------------*/
function GM:ShowHelp( ply )
	umsg.Start("gms_ToggleSkillsMenu",ply)
	umsg.End()
end

function GM:ShowTeam( ply )
	umsg.Start("gms_ToggleResourcesMenu",ply)
	umsg.End()
end

function PlayerMeta:OpenCombiMenu(str)
	umsg.Start("gms_OpenCombiMenu",self)
	umsg.String(str)
	umsg.End()
end

function PlayerMeta:CloseCombiMenu()
	umsg.Start("gms_CloseCombiMenu",self)
	umsg.End()
end


function QuickMenu( ply )
	ply:ConCommand( "gms_quickmenu" )
end
hook.Add("ShowSpare1", "QuickMenu", QuickMenu) 

function HelpMenu( ply )
	ply:ConCommand( "gms_NewHelps" )
end

hook.Add("ShowSpare2", "HelpMenu", HelpMenu) 
/*---------------------------------------------------------
  Skill functions
---------------------------------------------------------*/
function PlayerMeta:SetSkill(skill,int)
	if !self.Skills[skill] then self.Skills[skill] = 0 end
	self:SetNWInt(skill, int) 
	self.Skills[skill] = int
         
	umsg.Start("gms_SetSkill",self)
		umsg.String(skill)
		umsg.Short(self:GetSkill(skill))
	umsg.End()
end

function PlayerMeta:GetSkill(skill)
	return self.Skills[skill] or 0	
end

function PlayerMeta:IncSkill(skill,int)
	if !self.Skills[skill] then self:SetSkill(skill,0) end
	if !self.Experience[skill] then self:SetXP(skill,0) end

	if skill != "Survival" then
		self:IncXP("Survival",20)
		self:SendMessage(skill.." +1",3,Color(10,200,10,255))
	else
		self.MaxResources = self.MaxResources + 5

		self:SendAchievement("Level Up!")
		
		PlayerEffectFunc(self,0,"GMS_LevelUp")
		if self:GetSkill("Survival") >= 250 then
			if self.AWOLGiveAchievment then
				self:AWOLGiveAchievment("STR_SURVIVAL250")
			end
		end
	end
         
	self.Skills[skill] = self.Skills[skill] + int
	self:SetNWInt(skill, self.Skills[skill]) 
         
	umsg.Start("gms_SetSkill",self)
	umsg.String(skill)
	umsg.Short(self.Skills[skill])
	umsg.End()
end

function PlayerMeta:DecSkill(skill,int)
	self.Skills[skill] = self.Skills[skill] - int
	self:SetNWInt(skill, self.Skills[skill]) 
	
	umsg.Start("gms_SetSkill",self)
	umsg.String(skill)
	umsg.Short(self.Skills[skill])
	umsg.End()
end

/*---------------------------------------------------------
  XP functions
---------------------------------------------------------*/
function PlayerMeta:SetXP(skill,int)
	if !self.Skills[skill] then self:SetSkill(skill,0) end
	if !self.Experience[skill] then self.Experience[skill] = 0 end

	self.Experience[skill] = int

	umsg.Start("gms_SetXP",self)
	umsg.String(skill)
	umsg.Short(self:GetXP(skill))
	umsg.End()
end

function PlayerMeta:GetXP(skill)
	return self.Experience[skill] or 0
end

function PlayerMeta:IncXP(skill,int)
	if !self.Skills[skill] then self.Skills[skill] = 0 end
	if !self.Experience[skill] then self.Experience[skill] = 0 end

	if self.Experience[skill] + int >= 100 then
		self.Experience[skill] = 0
		self:IncSkill(skill,1)
	else
		self.Experience[skill] = self.Experience[skill] + int
	end

	umsg.Start("gms_SetXP",self)
	umsg.String(skill)
	umsg.Short(self:GetXP(skill))
	umsg.End()
end

function PlayerMeta:DecXP(skill,int)
	self.Experience[skill] = self.Experience[skill] - int

	umsg.Start("gms_SetXP",self)
	umsg.String(skill)
	umsg.Short(self:GetXP(skill))
	umsg.End()
end

/*---------------------------------------------------------
  Resource functions
---------------------------------------------------------*/
function PlayerMeta:SetResource(resource,int)
	if !self.Resources[resource] then self.Resources[resource] = 0 end

	self.Resources[resource] = int

	umsg.Start("gms_SetResource",self)
	umsg.String(resource)
	umsg.Short(int)
	umsg.End()
end

function PlayerMeta:GetResource(resource)
	return self.Resources[resource] or 0
end

function PlayerMeta:IncResource(resource,int)
	if !self.Resources[resource] then self.Resources[resource] = 0 end
	local all = self:GetAllResources()
	local max = self.MaxResources

	if all + int > max then
		self.Resources[resource] = self.Resources[resource] + (max - all)
		self:DropResource(resource,(all + int) - max)
		self:SendMessage("You can't carry anymore!",3,Color(200,0,0,255))
	else
		self.Resources[resource] = self.Resources[resource] + int
	end

	umsg.Start("gms_SetResource",self)
	umsg.String(resource)
	umsg.Short(self:GetResource(resource))
	umsg.End()
end

function PlayerMeta:GetAllResources()
	local num = 0

	for k,v in pairs(self.Resources) do
		num = num + v
	end

	return num
end

--Gmods spawn function already autocorrects. Would be a waste to not use it.
function PlayerMeta:CreateBuildingSite(pos,angle,model,class,cost)
	local rep = ents.Create("gms_buildsite")
	local tbl = rep:GetTable()
	rep:SetAngles(angle)
	rep.Costs = cost
	tbl:Setup(model,class)
	rep:SetPos(pos)
	rep:Spawn()
	rep.Player = self
	self:SetNetworkedEntity('Hasbuildingsite', rep)
	rep:CPPISetOwner(self)
	return rep
end

--Spawning from a trace needs some correction.
function PlayerMeta:CreateStructureBuildingSite(pos,angle,model,class,cost,name)
	local rep = ents.Create("gms_buildsite")
	local tbl = rep:GetTable()
	local str = ":"
	for k,v in pairs(cost) do
		str = str.." "..k.." ("..v.."x)"
	end
	rep:SetAngles(angle)
	rep.Costs = cost
	tbl:Setup(model,class)
	rep:SetPos(pos)
	rep.Name = name
	rep:SetNetworkedString('Name', name)
	rep:SetNetworkedString('Resources', str)
	rep:Spawn()
	local cormin,cormax = rep:WorldSpaceAABB( )
	local offset = cormax-cormin 
	rep:SetPos(Vector(pos.x,pos.y,pos.z + (offset.z/2)))
	self:SetNetworkedEntity('Hasbuildingsite', rep)
	rep.Player = self
	rep:CPPISetOwner(self)

	return rep
end

function PlayerMeta:GetBuildingSite()
	return self:GetNetworkedEntity("Hasbuildingsite")
end

function PlayerMeta:DecResource(resource,int)
	if !self.Resources[resource] then self.Resources[resource] = 0 end
	self.Resources[resource] = self.Resources[resource] - int

	umsg.Start("gms_SetResource",self)
	umsg.String(resource)
	umsg.Short(self:GetResource(resource))
	umsg.End()
end

ResourceModel = {}
ResourceModel["Coal"] = "models/props_wasteland/rockgranite03c.mdl"
ResourceModel["Stone"] = "models/props_wasteland/rockgranite03c.mdl"
ResourceModel["Iron_Ore"] = "models/props_wasteland/rockgranite03c.mdl"
ResourceModel["Copper_Ore"] = "models/props_wasteland/rockgranite03c.mdl"
ResourceModel["Wood"] = "models/gmstranded/props/lumber.mdl"
ResourceModel["Urine_Bottles"] = "models/props_junk/garbage_plasticbottle001a.mdl"
ResourceModel["Water_Bottles"] = "models/props_junk/garbage_plasticbottle001a.mdl"


ResourceMat = {}
ResourceMat["Coal"] = "models/props_wasteland/metal_tram001a"
ResourceMat["Iron_Ore"] = "models/props_canal/metalwall005b"
ResourceMat["Copper_Ore"] =	"models/weapons/v_crowbar/crowbar_cyl"
ResourceMat["Copper"] = "models/weapons/v_crowbar/crowbar_cyl"
ResourceMat["Iron"] = "models/props_canal/metalwall005b"
ResourceMat["Steel"] = "models/props_pipes/pipeset_metal02"
ResourceMat["Concrete"] = "models/props_c17/metalladder001"
ResourceMat["Glass"] = "models/props_combine/health_charger_glass"
ResourceMat["Diamond"] = "models/props_combine/metal_combinebridge001"




function PlayerMeta:DropResource(resource,int)
	local nearby = {}

	for k,v in pairs(ents.FindByClass("gms_resourcedrop")) do
		if v:GetPos():Distance(self:GetPos()) < 150 and v.Type == resource then
			table.insert(nearby,v)
		end
	end

	if #nearby > 0 then
		local ent = nearby[1]
		ent.Amount = ent.Amount + int
		ent:SetResourceDropInfoInstant(ent.Type,ent.Amount)
	else
		local ent = ents.Create("gms_resourcedrop")
		ent:SetPos(self:TraceFromEyes(60).HitPos + Vector(0,0,15))
		ent:SetAngles(self:GetAngles())
		
		if ResourceMat[resource] && ResourceModel[resource] then
			ent:SetModel(ResourceModel[resource])
			ent:SetMaterial(ResourceMat[resource])
		elseif ResourceMat[resource] then
			ent:SetModel("models/items/item_item_crate.mdl")
			ent:SetMaterial(ResourceMat[resource])
		elseif ResourceModel[resource] then
			ent:SetModel(ResourceModel[resource])
		else
			ent:SetModel("models/items/item_item_crate.mdl")
		end

		ent:Spawn()

		ent:GetPhysicsObject():Wake()

		ent.Type = resource
		ent.Amount = int

		ent:SetResourceDropInfo(ent.Type,ent.Amount)
		ent:CPPISetOwner(self)
	end
end

function EntityMeta:SetResourceDropInfo(strType,int)
	timer.Simple(0.5,self.SetResourceDropInfoInstant,self,strType,int)
end




function EntityMeta:SetResourceDropInfoInstant(strType,int)
	for k,v in pairs(player.GetAll()) do
		local strType = strType or "Error"
		umsg.Start("gms_SetResourceDropInfo",v)
		umsg.String(self:EntIndex())
		umsg.String(string.gsub(strType,"_"," "))
		umsg.Short(self.Amount)
		umsg.End()
	end
end


/*---------------------------------------------------------
  Food functions
---------------------------------------------------------*/
function EntityMeta:SetFoodInfo(strType)
	timer.Simple(0.5,self.SetFoodInfoInstant,self,strType)
end

function EntityMeta:SetFoodInfoInstant(strType)
	for k,v in pairs(player.GetAll()) do
		local strType = strType or "Error"
		umsg.Start("gms_SetFoodDropInfo",v)
		umsg.String(self:EntIndex())
		umsg.String(string.gsub(strType,"_"," "))
		umsg.End()
	end
end

function PlayerMeta:SetFood(int)
	if self.Hunger + int > 1000 then
		int = 1000
	end

	self.Hunger = int
	self:UpdateNeeds()
end

function PlayerMeta:GetFood()
	return self.Hunger
end

/*---------------------------------------------------------
  Water functions
---------------------------------------------------------*/
function PlayerMeta:SetThirst(int)
	if self.Thirst + int > 1000 then
		int = 1000
	end

	self.Thirst = int
	self:UpdateNeeds()
end

function PlayerMeta:GetThirst()
	return self.Thirst
end

/*---------------------------------------------------------
  Sleep functions
---------------------------------------------------------*/
function PlayerMeta:SetSleepiness(int)
	if self.Sleepiness + int > 1000 then
		int = 1000
	end

	self.Sleepiness = int
	self:UpdateNeeds()
end

function PlayerMeta:GetSleepiness()
	return self.Sleepiness
end

/*---------------------------------------------------------
  Custom health functions
---------------------------------------------------------*/
function PlayerMeta:Heal(int)
	local ply = self
	if ply:IsPlayer() then
		local max = 100

		if ply.Upgrades["Adapted"] == 1 then 
			max = 200 
		end

		if self:Health() + int > max then
			self:SetHealth(max)
		else
			self:SetHealth(self:Health() + int)
		end
	end
end


/*---------------------------------------------------------
  Model check functions
---------------------------------------------------------*/
function EntityMeta:IsTreeModel()
	local model = self:GetModel()
	for k,v in pairs(GMS.TreeModels) do
		if string.lower(v) == model or string.gsub(string.lower(v),"/","\\") == model then
			return true
		end
	end

	return false
end

function EntityMeta:IsBerryBushModel()
	local mdl = "models/props/pi_shrub.mdl"
	if mdl == self:GetModel() or string.gsub(string.lower(mdl),"/","\\") == self:GetModel() then
		return true
	end

	return false
end

function EntityMeta:IsGrainModel()
	local mdl = "models/props_foliage/cattails.mdl"
	if mdl == self:GetModel() or string.gsub(string.lower(mdl),"/","\\") == self:GetModel() then
		return true
	end

	return false
end

function EntityMeta:IsFoodModel()
	for k,v in pairs(GMS.EdibleModels) do
		if string.lower(v) == self:GetModel() or string.gsub(string.lower(v),"/","\\") == self:GetModel() then
			return true
		end
	end

	return false
end

function EntityMeta:IsRockModel()
	local model = self:GetModel()
	for k,v in pairs(GMS.RockModels) do
		if string.lower(v) == model or string.gsub(string.lower(v),"/","\\") == model then
			return true
		end
	end

	return false
end

function EntityMeta:IsProp()
	local cls = self:GetClass()

	if (cls == "prop_physics" or cls == "prop_physics_multiplayer" or cls == "prop_dynamic") then
		return true
	end

	return false
end

function EntityMeta:IsSleepingFurniture()
	for _,v in ipairs(GMS.SleepingFurniture) do
		if string.lower(v) == self:GetModel() or string.gsub(string.lower(v),"/","\\") == self:GetModel() then
			return true
		end
	end

	return false
end

/*---------------------------------------------------------
  Other utilities
---------------------------------------------------------*/
function string.Capitalize(str)
	local str = string.Explode("_",str)
	for k,v in pairs(str) do
		str[k] = string.upper(string.sub(v,1,1))..string.sub(v,2)
	end

	str = string.Implode("_",str)
	return str
end

function PlayerMeta:TraceFromEyes(dist)
	local trace = {}
	trace.start = self:GetShootPos()
	trace.endpos = trace.start + (self:GetAimVector() * dist)
	trace.filter = self

	return util.TraceLine(trace)
end

function EntityMeta:DropToGround()
	local trace = {}
	trace.start = self:GetPos()
	trace.endpos = trace.start + Vector(0,0,-100000)
	trace.mask = MASK_SOLID_BRUSHONLY
	trace.filter = self

	local tr = util.TraceLine(trace)

	self:SetPos(tr.HitPos)
end

function GMS.ClassIsNearby(pos,class,range)
	local nearby = false
	for k,v in pairs(ents.FindInSphere(pos,range)) do
		if v:GetClass() == class and (pos-Vector(v:LocalToWorld(v:OBBCenter()).x,v:LocalToWorld(v:OBBCenter()).y,pos.z)):Length() <= range then
			nearby = true
		end
	end

	return nearby
end

function GMS.IsInWater(pos)
	local trace = {}
	trace.start = pos
	trace.endpos = pos + Vector(0,0,1)
	trace.mask = MASK_WATER | MASK_SOLID

	local tr = util.TraceLine(trace)

	return tr.Hit
end
/*---------------------------------------------------------

  Automatic tree reproduction

---------------------------------------------------------*/
function GM.ReproduceTrees()
	local GM = GAMEMODE
	if GetConVarNumber("gms_ReproduceTrees") == 1 then
		local trees = {}
		for k,v in pairs(ents.GetAll()) do
			if v:IsTreeModel() then
				table.insert(trees,v)
			end
		end

		if #trees < GetConVarNumber("gms_MaxReproducedTrees") then
			for k,ent in pairs(trees) do
				local num = math.random(1,3)

				if num == 1 then
					local nearby = {}
					for k,v in pairs(ents.FindInSphere(ent:GetPos(),50)) do
						if v:GetClass() == "gms_seed" or v:IsProp() then
							table.insert(nearby,v)
						end
					end

					if #nearby < 3 then
						local pos = ent:GetPos() + Vector(math.random(-500,500),math.random(-500,500),0)
						local retries = 50

						while (pos:Distance(ent:GetPos()) < 200 or GMS.ClassIsNearby(pos,"prop_physics",100)) and retries > 0 do
							pos = ent:GetPos() + Vector(math.random(-300,300),math.random(-300,300),0)
							retries = retries - 1
						end

						local pos = pos + Vector(0,0,500)

						local seed = ents.Create("gms_seed")
						seed:SetPos(pos)
						seed:DropToGround()
						seed:Setup("tree",180)
						seed:CPPISetWorld()
						seed:Spawn()		
					end
				end
			end
		end
		if #trees == 0 then
			local info = {}
			for i = 1,20 do
				info.pos = Vector(math.random(-10000,10000),math.random(-10000,10000),1000)
				info.Retries = 50

				--Find pos in world
				while util.IsInWorld(info.pos) == false and info.Retries > 0 do
					info.pos = Vector(math.random(-10000,10000),math.random(-10000,10000),1000)
					info.Retries = info.Retries - 1
				end

				--Find ground
				local trace = {}
				trace.start = info.pos
				trace.endpos = trace.start + Vector(0,0,-100000)
				trace.mask = MASK_SOLID_BRUSHONLY

				local groundtrace = util.TraceLine(trace)

				--Assure space
				local nearby = ents.FindInSphere(groundtrace.HitPos,200)
				info.HasSpace = true

				for k,v in pairs(nearby) do
					if v:IsProp() then
						info.HasSpace = false
					end
				end

				--Find sky
				local trace = {}
				trace.start = groundtrace.HitPos
				trace.endpos = trace.start + Vector(0,0,100000)

				local skytrace = util.TraceLine(trace)

				--Find water?
				local trace = {}
				trace.start = groundtrace.HitPos
				trace.endpos = trace.start + Vector(0,0,1)
				trace.mask = MASK_WATER

				local watertrace = util.TraceLine(trace)

				--All a go, make entity
				if info.HasSpace and skytrace.HitSky and !watertrace.Hit and (groundtrace.MatType == MAT_DIRT or groundtrace.MatType == MAT_GRASS or groundtrace.MatType == MAT_SAND) then
					local seed = ents.Create("gms_seed")
					seed:SetPos(groundtrace.HitPos)
					seed:DropToGround()
					seed:Setup("tree",180 + math.random(-20,20))
					seed:CPPISetWorld()
					seed:Spawn()
				end
			end
		end
	end

	timer.Simple(math.random(1,3) * 60,GM.ReproduceTrees)
end

timer.Simple(60,GM.ReproduceTrees)

/*---------------------------------------------------------

  Admin terraforming

---------------------------------------------------------*/
function GM.CreateRandomTree(ply)
	if !ply:IsAdmin() then 
		ply:SendMessage("You need admin rights for this!",3,Color(200,0,0,255))
	return end

	local tr = ply:TraceFromEyes(10000)

	GAMEMODE.MakeTree(tr.HitPos)
end

concommand.Add("gms_admin_maketree",GM.CreateRandomTree)

function GM.CreateRandomRock(ply)
	if !ply:IsAdmin() then 
		ply:SendMessage("You need admin rights for this!",3,Color(200,0,0,255))
	return end
	local tr = ply:TraceFromEyes(10000)
	local ent = ents.Create("prop_physics")
	ent:SetAngles(Angle(0,math.random(1,360),0))
	ent:SetModel(GMS.RockModels[math.random(1,#GMS.RockModels)])
	ent:SetPos(tr.HitPos)
	ent:Spawn()
	ent:CPPISetWorld()
	ent:Fadein()
	ent:GetPhysicsObject():EnableMotion(false)
	ent.StrandedProtected = true
	
end

concommand.Add("gms_admin_makerock",GM.CreateRandomRock)

function GM.CreateRandomFood(ply)
	if !ply:IsAdmin() then 
		ply:SendMessage("You need admin rights for this!",3,Color(200,0,0,255))
	return end

	local tr = ply:TraceFromEyes(10000)

	local ent = ents.Create("prop_physics")
	ent:SetAngles(Angle(0,math.random(1,360),0))
	ent:SetModel(GMS.EdibleModels[math.random(1,#GMS.EdibleModels)])
	ent:SetPos(tr.HitPos + Vector(0,0,10))		 
	ent:Spawn()
	ent:CPPISetOwner(self)
	
end

concommand.Add("gms_admin_makefood",GM.CreateRandomFood)

function GM.MakeAntlionBarrow(ply,cmd,args)
	if !ply:IsAdmin() then
		ply:SendMessage("You need admin rights for this!",3,Color(200,0,0,255))
	return end

	if !args[1] then
		ply:SendMessage("Specify max antlions!",3,Color(200,0,0,255))
	return end

	local tr = ply:TraceFromEyes(10000)

	local ent = ents.Create("gms_antlionbarrow")
	ent:SetPos(tr.HitPos)
	ent:Spawn()
	ent:CPPISetWorld()
	ent:SetKeyValue("MaxAntlions",args[1])
	Msg("Sending keyvalue: "..args[1].."\n")
end

concommand.Add("gms_admin_MakeAntlionBarrow",GM.MakeAntlionBarrow)

function GM.CreateRandomBush(ply)
	local GM = GAMEMODE
	if !ply:IsAdmin() then 
		ply:SendMessage("You need admin rights for this!",3,Color(200,0,0,255))
	return end

	local tr = ply:TraceFromEyes(10000)
	local typ = math.random(1,5)
	local pos = tr.HitPos

	if typ == 1 then
		GM.MakeMelon(pos,math.random(1,2), ply)
	elseif typ == 2 then
		GM.MakeBanana(pos,math.random(1,2), ply)
	elseif typ == 3 then
		GM.MakeOrange(pos,math.random(1,2), ply)
	elseif typ == 4 then
		GM.MakeBush(pos, ply)
	elseif typ == 5 then
		GM.MakeGrain(pos, ply)
	end
end

concommand.Add("gms_admin_makebush",GM.CreateRandomBush)

function GM.PopulateArea(ply,cmd,args)
	local GM = GAMEMODE
	if !ply:IsAdmin() then
		ply:SendMessage("You need admin rights for this!",3,Color(200,0,0,255))
	return end

	if !args[1] or !args[2] or !args[3] then
		ply:SendMessage("You need to specify <type> <amount> <radius>",3,Color(200,0,0,255))
	return end

	for k,v in pairs(player.GetAll()) do
		v:SendMessage("Populating area...",3,Color(255,255,255,255))
	end

	--Population time
	local Amount = tonumber(args[2])
	local info = {}
	info.Amount = Amount

	if Amount > 200 then 
		ply:SendMessage("Auto-capped at 200 props.",3,Color(200,0,0,255))
		info.Amount = 200
	end

	local Type = args[1]
	local Amount = info.Amount
	local Radius = tonumber(args[3])

	--Find playertrace
	local plytrace = ply:TraceFromEyes(10000)

	for i = 1,Amount do
		info.pos = plytrace.HitPos + Vector(math.random(-Radius,Radius),math.random(-Radius,Radius),1000)
		info.Retries = 50

		--Find pos in world
		while util.IsInWorld(info.pos) == false and info.Retries > 0 do
			info.pos = plytrace.HitPos + Vector(math.random(-Radius,Radius),math.random(-Radius,Radius),1000)
			info.Retries = info.Retries - 1
		end

		--Find ground
		local trace = {}
		trace.start = info.pos
		trace.endpos = trace.start + Vector(0,0,-100000)
		trace.mask = MASK_SOLID_BRUSHONLY

		local groundtrace = util.TraceLine(trace)

		--Assure space
		local nearby = ents.FindInSphere(groundtrace.HitPos,200)
		info.HasSpace = true

		for k,v in pairs(nearby) do
			if v:IsProp() then
				info.HasSpace = false
			end
		end

		--Find sky
		local trace = {}
		trace.start = groundtrace.HitPos
		trace.endpos = trace.start + Vector(0,0,100000)

		local skytrace = util.TraceLine(trace)

		--Find water?
		local trace = {}
		trace.start = groundtrace.HitPos
		trace.endpos = trace.start + Vector(0,0,1)
		trace.mask = MASK_WATER

		local watertrace = util.TraceLine(trace)

		--All a go, make entity
		if Type == "Trees" then
			if info.HasSpace and skytrace.HitSky and !watertrace.Hit and (groundtrace.MatType == MAT_DIRT or groundtrace.MatType == MAT_GRASS or groundtrace.MatType == MAT_SAND) then
				GAMEMODE.MakeTree(groundtrace.HitPos)
			end
		elseif Type == "Rocks" then
			if !watertrace.Hit and (groundtrace.MatType == MAT_DIRT or groundtrace.MatType == MAT_GRASS or groundtrace.MatType == MAT_SAND) then
				local ent = ents.Create("prop_physics")
				ent:SetAngles(Angle(0,math.random(1,360),0))
				ent:SetModel(GMS.RockModels[math.random(1,#GMS.RockModels)])
				ent:SetPos(groundtrace.HitPos)
				ent:Spawn()
				ent:CPPISetWorld()
				ent:Fadein()
				ent.StrandedProtected = true
				ent:GetPhysicsObject():EnableMotion(false)
				
			end
		elseif Type == "Random_Plant" and info.HasSpace then
			if !watertrace.Hit and (groundtrace.MatType == MAT_DIRT or groundtrace.MatType == MAT_GRASS or groundtrace.MatType == MAT_SAND) then
				local typ = math.random(1,5)
				local pos = groundtrace.HitPos

				if typ == 1 then
					GM.MakeMelon(pos,math.random(1,2), ply)
				elseif typ == 2 then
					GM.MakeBanana(pos,math.random(1,2), ply)
				elseif typ == 3 then
					GM.MakeOrange(pos,math.random(1,2), ply)
				elseif typ == 4 then
					GM.MakeBush(pos, ply)
				elseif typ == 5 then
					GM.MakeGrain(pos, ply)
				end
			end
		end
	end

	--Finished
	for k,v in pairs(player.GetAll()) do
		v:SendMessage("Done!",3,Color(255,255,255,255))
	end
end

concommand.Add("gms_admin_PopulateArea",GM.PopulateArea)

function GM.TreeRockCleanup(ply)
	if !ply:IsAdmin() then
		ply:SendMessage("You need admin rights for this!",3,Color(200,0,0,255))
	return end

	for k,v in pairs(ents.GetAll()) do
		if v:IsRockModel() or v:IsTreeModel() then
			
			for k,tbl in pairs(GAMEMODE.RisingProps) do
				if tbl.Entity == v then
					table.remove(GAMEMODE.RisingProps,k)
				end
			end
			
			for k,tbl in pairs(GAMEMODE.SinkingProps) do
				if tbl.Entity == v then
					table.remove(GAMEMODE.SinkingProps,k)
				end
			end
			
			for k,ent in pairs(GAMEMODE.FadingInProps) do
				if ent == v then
					table.remove(GAMEMODE.FadingInProps,k)
				end
			end
			
			v:Fadeout()
			
		end
	end
	
	for k,v in pairs(player.GetAll()) do v:SendMessage("Cleared map.",3,Color(255,255,255,255)) end
	
end

concommand.Add("gms_admin_clearmap",GM.TreeRockCleanup)
/*---------------------------------------------------------

  Prop fadeout

---------------------------------------------------------*/
GMS.FadingOutProps = {}
GMS.FadingInProps = {}

function EntityMeta:Fadeout(speed)
	local speed = speed or 1

	for k,v in pairs(player.GetAll()) do
		umsg.Start("gms_CreateFadingProp",v)
		umsg.String(self:GetModel())
		umsg.Vector(self:GetPos())
		umsg.Vector(self:GetAngles():Forward())
		umsg.Short(math.Round(speed))
		umsg.End()
	end

	self:Remove()
end

--Fadein is serverside
function EntityMeta:Fadein()
	self.AlphaFade = 0
	self:SetColor(255,255,255,0)
	table.insert(GMS.FadingInProps,self)
end


function GM.FadeFadingProps()
	for k,ent in pairs(GMS.FadingInProps) do
		if !ent or ent == NULL then
			table.remove(GMS.FadingInProps,k)
		elseif !ent:IsValid() then
			table.remove(GMS.FadingInProps,k)
		elseif ent.AlphaFade >= 255 then
			table.remove(GMS.FadingInProps,k)
		else
			ent.AlphaFade = ent.AlphaFade + 1
			ent:SetColor(255,255,255,ent.AlphaFade)
		end
	end
end

hook.Add("Think","gms_FadePropsThink",GM.FadeFadingProps)
/*---------------------------------------------------------

  Prop rising/lowering

---------------------------------------------------------*/
GM.RisingProps = {}
GM.SinkingProps = {}

function EntityMeta:RiseFromGround(speed,altmax)
	local speed = speed or 1
	local max;

	if !altmax then
		min,max = self:WorldSpaceAABB()
		max = max.z
	else
		max = altmax
	end

	local tbl = {}
	tbl.Origin = self:GetPos().z
	tbl.Speed = speed
	tbl.Entity = self

	self:SetPos(self:GetPos() + Vector(0,0,-max + 10))
	table.insert(GAMEMODE.RisingProps,tbl)
end

function GM.RiseAndSinkProps()
	local GM = GAMEMODE

	for k,tbl in pairs(GM.RisingProps) do
		if tbl.Entity:GetPos().z >= tbl.Origin then
			table.remove(GM.RisingProps,k)
		else
			tbl.Entity:SetPos(tbl.Entity:GetPos() + Vector(0,0,1*tbl.Speed))
		end
	end

	for k,tbl in pairs(GM.SinkingProps) do
		if tbl.Entity:GetPos().z <= tbl.Origin - tbl.Height then
			table.remove(GM.SinkingProps,k)
			tbl.Entity:Remove()
		else
			tbl.Entity:SetPos(tbl.Entity:GetPos() + Vector(0,0,-1*tbl.Speed))
		end
	end
end

hook.Add("Think","gms_RiseAndSinkPropsHook",GM.RiseAndSinkProps)

function EntityMeta:SinkIntoGround(speed)
	local speed = speed or 1

	local tbl = {}
	tbl.Origin = self:GetPos().z
	tbl.Speed = speed
	tbl.Entity = self
	tbl.Height = max

	table.insert(GAMEMODE.SinkingProps,tbl)
end

/*---------------------------------------------------------

  Spawn/death

---------------------------------------------------------*/

function GM:SetupMove(ply, move)
	//ply:SetCollisionGroup( COLLISION_GROUP_WEAPON )
end

function GM:PlayerInitialSpawn(ply)
	--Create HUD
	umsg.Start("gms_CreateInitialHUD",ply)
	umsg.End()

	ply:SetTeam(1)
	ply.PVP = 1
	
	--Serverside player variables
	ply.Skills = {}
	ply.Resources = {}
	ply.Experience = {}
	ply.Upgrades = {}
	ply.HasSpawned = 0
	ply.QuestComplete = 0
	ply.QuestAccept = 0
	SendQuestInfo(ply)

	--Admin info, needed clientside
	if ply:IsAdmin() then
		for k,v in pairs(file.Find("GMStranded/Gamesaves/*.txt")) do
			local name = string.sub(v,1,string.len(v) - 4)

			if string.Right(name,5) != "_info" then
				umsg.Start("gms_AddLoadGameToList",ply)
				umsg.String(name)
				umsg.End()
			end
		end
	end
	
	ply.HasSynched = tonumber(BithLoad("GMStranded/Saves/"..ply:UniqueID().."/HasSynched.txt") or 0)
	ply.Account = "Player"
	ply.Password = "THIB"
	ply.PassTry = {}

	--Character loading
	
	if OldLoad == 1 then 
		OldLoadByUniqueId(ply)
	else
		LoadByUniqueId(ply)
	end
	
	ply:SetNWInt("plants", 0)
	for k,v in pairs(ents.GetAll()) do
		if v and v:IsValid() and v:GetNWEntity("plantowner") and v:GetNWEntity("plantowner"):IsValid() and v:GetNWEntity("plantowner") == ply then
			ply:SetNWInt("plants", ply:GetNWInt("plants") + 1)
		end
	end
	
	for _, v in ipairs(ents.GetAll()) do
		if v:GetClass() == "gms_resourcedrop" then
			umsg.Start("gms_SetResourceDropInfo",ply)
			umsg.String(v:EntIndex())
			umsg.String(string.gsub(v.Type,"_"," "))
			umsg.Short(v.Amount)
			umsg.End()
		end
	end
	SendAchievments(ply)
	
	if Tribes && Tribes.PlayerInitialSpawn then
		Tribes.PlayerInitialSpawn(ply)
	end
	local num = tonumber((BithLoad("GMStranded/Saves/"..ply:UniqueID().."/Trusted.txt") or 0 ))
	ply.Trusted = num
	SaveTrusted(ply)
end



function GM:PlayerSpawn(ply)

	SetGlobalInt("plantlimit", GetConVarNumber("gms_PlantLimit"))
	if ply.HasSpawned == 0 then
		ply.HasSpawned = 1
		ply:ConCommand( "gms_NewHelps" )
	end
	if ply.Upgrades["Sprint Man"] == 1 then
		ply:SetWalkSpeed(400)
		ply:SetRunSpeed(150)
	else
		ply:SetWalkSpeed(250)
		ply:SetRunSpeed(250)
	end
	
	if ply.Upgrades["StoneAge"] == 1  then
		ply:Give("gms_stonepickaxe")
		ply:Give("gms_stonehatchet")
	end
	if ply.Upgrades["CopperAge"] == 1 then
		ply:Give("gms_copperhatchet")
		ply:Give("gms_copperpickaxe")
	end
	if ply.Upgrades["IronAge"] == 1 then
		ply:Give("gms_ironhatchet")
		ply:Give("gms_ironpickaxe")
	end

	self:PlayerLoadout(ply)
	--hook.Call( "PlayerLoadout", GAMEMODE, ply )
	self:PlayerSetModel(ply)
	--hook.Call( "PlayerSetModel", GAMEMODE, ply )

	ply.Sleepiness = 1000
	ply.Hunger = 1000
	ply.Thirst = 1000
	ply.Warmth = 50
	if ply.Upgrades["Adapted"] == 1 then
		ply:SetHealth(200) 
	end
	ply:UpdateNeeds()
	SendAchievments(ply)
end

function GM:PlayerLoadout(ply)
	--Tools
	ply:Give("gms_hands")

	--Gmod
	if GetConVarNumber("gms_physgun") == 1 or ply:IsAdmin() then ply:Give("weapon_physgun") end
	if ply:IsAdmin() or ply:IsSuperAdmin() then 
	ply:Give("gmod_tool") 
	//ply:Give("pill_pigeon") 
	end
	if ply.Upgrades["Scientist"] == 1 then
		ply:Give("gmod_tool") 
	end
	ply:Give("weapon_physcannon")
	ply:SelectWeapon("gms_hands")
end
	
--Death
function Death(ply)
	ply.NextSpawnTime = CurTime() + 400
	DropAll(ply)
	ply:Freeze(false)
	if ply.AFK == true then
		ply:Freeze(false)
		ply.AFK = false			
		umsg.Start("gms_stopafk",ply)
		umsg.End()
	end
end
hook.Add( "PlayerDeath", "Death", Death )

/*---------------------------------------------------------

  Character saving

---------------------------------------------------------*/

function GM:PlayerDisconnected(ply)
	self.SaveCharacter(ply)
	for k,v in pairs(ents.FindByClass("gms_buildsite")) do 
		local ply2 = v:CPPIGetOwner()
		if ply == ply2 then
			v:Remove()
		end
	end
end

function GM:ShutDown()
	for k,v in pairs(player.GetAll()) do
		self.SaveCharacter(v)
	end
end
--Upload it..
function UnlockAchievment(ent,name)
	if ent then
		ply = ent
		if ent:IsPlayer() then
			ply = ent
		else
			ply = ent:CPPIGetOwner()
		end
		if ply:IsPlayer() then
			if table.HasValue(GMS_Upgrades,name) then
				if !ply.Upgrades then
					ply.Upgrades = {}
					for k,v in pairs(GMS_Upgrades) do 
						ply.Upgrades[v] = 0
						BithSaveAchievments(ply)
					end
				end
				if ply.Upgrades[name] == 0 then
					if ply:GetSkill("Survival") >= GMS_LevelReq[name] then
						ply.Upgrades[name] = 1
						if !ent:IsPlayer() then
							ent.Activated = 1
						end
						for k,v in pairs(player.GetAll()) do 
							v:SendMessage(ply:Nick() .. " has unlocked the "..name.." achievment!",3,Color(200,0,0,255))
						end
					BithSaveAchievments(ply)
					else
						if !ent:IsPlayer() && ent.time then
							if ent.time < CurTime() then
								ent.time = CurTime() + 1
								ply:SendMessage("I am sorry but you are not high enough level to unlock this achievment.",3,Color(200,0,0,255))
							end
						elseif ent:IsPlayer() then
							ply:SendMessage("I am sorry but you are not high enough level to unlock this achievment.",3,Color(200,0,0,255))
						else
							ent.time = CurTime() + 1
							ply:SendMessage("I am sorry but you are not high enough level to unlock this achievment.",3,Color(200,0,0,255))
						end
					end
				end
			else
				print("ERROR: Not a proper achievment, Talk to bith")
			end
			SendAchievments(ply)
		else
			print("ERROR: Not a player, Talk to bith")
		end
	end
end


function GiveAchievment(ply,cmd,args)
	if ply:IsAdmin() then
		local name = args[2]
		local ply2 = string.lower(args[1])
		for k,v in pairs (player.GetAll()) do
			if string.find(string.lower(v:Nick()),ply2) then
				if v.Upgrades[name] then
					UnlockAchievment(v,name)
				else
					print("BAD NAME: "..name)
				end
			else
				print("No player")
			end
		end
	end
end
concommand.Add("gms_AGiveAch",GiveAchievment)

function SendAchievments(ply)
	if ply.Upgrades then
		for k,v in pairs(ply.Upgrades) do 
			umsg.Start("Trophy",ply)
				umsg.String(tostring(k) or "NA")
				umsg.Short(tonumber(v) or 0)
			umsg.End()
		end
	end
end

function TakeAchievment(ply,cmd,args)
	if ply:IsAdmin() then
		local name = args[2]
		local ply2 = string.lower(args[1])
		for k,v in pairs (player.GetAll()) do
			if string.find(string.lower(v:Nick()),ply2) then
				if v.Upgrades[name] then
					v.Upgrades[name] = 0
				else
					print("BAD NAME: "..name)
				end
			end
		end
	end
end
concommand.Add("gms_ATakeAch",TakeAchievment)

/*---------------------------------------------------------

  Drop all Command

---------------------------------------------------------*/
function DropAll(ply)
	local DeltaTime = 0
	for k,v in pairs(ply.Resources) do
		if v > 0  then
			timer.Simple(DeltaTime, function()	ply:DecResource(k,v)	ply:DropResource(k,v) end, ply,k,v)
			DeltaTime = DeltaTime + 0.3			
		end
	end
	ply.NextSpawnTime = CurTime() + DeltaTime + 0.5
end
concommand.Add( "gms_dropall", DropAll )

/*---------------------------------------------------------

  Planting

---------------------------------------------------------*/
--Melon planting
function GM.PlantMelon(ply,cmd,args)
	if ply:GetNWInt("plants") >= GetConVarNumber("gms_PlantLimit") then 
		ply:SendMessage("You have hit the plant limit.",3,Color(200,0,0,255))
		return 
	end
	local tr = ply:TraceFromEyes(150)

	if tr.HitWorld then
		if (tr.MatType == MAT_DIRT or tr.MatType == MAT_GRASS or tr.MatType == MAT_SAND) and !GMS.IsInWater(tr.HitPos) then
			if ply:GetResource("Melon_Seeds") >= 1 then
				if !GMS.ClassIsNearby(tr.HitPos,"gms_seed",30) and !GMS.ClassIsNearby(tr.HitPos,"prop_physics",50) then
					local data = {}
					data.Pos = tr.HitPos
					local time = 3
					if ply.Upgrades["InstantPlant"] == 1 then
						time = .1
					end
					ply:DoProcess("PlantMelon",time,data)
				else
					ply:SendMessage("You need more distance between seeds/props.",3,Color(200,0,0,255))
				end
			else
				ply:SendMessage("You need a watermelon seed.",3,Color(200,0,0,255))
			end
		else
			ply:SendMessage("You cannot plant on this terrain.",3,Color(200,0,0,255))
		end
	else
		ply:SendMessage("Aim at the ground to plant.",3,Color(200,0,0,255))
	end
end
concommand.Add("gms_plantmelon",GM.PlantMelon)

--Banana planting
function GM.PlantBanana(ply,cmd,args)
	if ply:GetNWInt("plants") >= GetConVarNumber("gms_PlantLimit") then 
		ply:SendMessage("You have hit the plant limit.",3,Color(200,0,0,255))
		return 
	end
	local tr = ply:TraceFromEyes(150)

	if tr.HitWorld then
		if (tr.MatType == MAT_DIRT or tr.MatType == MAT_GRASS or tr.MatType == MAT_SAND) and !GMS.IsInWater(tr.HitPos) then
			if ply:GetResource("Banana_Seeds") >= 1 then
				if !GMS.ClassIsNearby(tr.HitPos,"gms_seed",30) and !GMS.ClassIsNearby(tr.HitPos,"prop_physics",50) then
					local data = {}
					data.Pos = tr.HitPos
					local time = 3
					if ply.Upgrades["InstantPlant"] == 1 then
						time = .1
					end
					ply:DoProcess("PlantBanana",time,data)
				else
					ply:SendMessage("You need more distance between seeds/props.",3,Color(200,0,0,255))
				end
			else
				ply:SendMessage("You need a banana seed.",3,Color(200,0,0,255))
			end
		else
			ply:SendMessage("You cannot plant on this terrain.",3,Color(200,0,0,255))
		end
	else
		ply:SendMessage("Aim at the ground to plant.",3,Color(200,0,0,255))
	end
end
concommand.Add("gms_plantbanana",GM.PlantBanana)

--Orange planting
function GM.PlantOrange(ply,cmd,args)
	if ply:GetNWInt("plants") >= GetConVarNumber("gms_PlantLimit") then 
		ply:SendMessage("You have hit the plant limit.",3,Color(200,0,0,255))
		return 
	end
	local tr = ply:TraceFromEyes(150)

	if tr.HitWorld then
		if (tr.MatType == MAT_DIRT or tr.MatType == MAT_GRASS or tr.MatType == MAT_SAND) and !GMS.IsInWater(tr.HitPos) then
			if ply:GetResource("Orange_Seeds") >= 1 then
				if !GMS.ClassIsNearby(tr.HitPos,"gms_seed",30) and !GMS.ClassIsNearby(tr.HitPos,"prop_physics",50) then
					local data = {}
					data.Pos = tr.HitPos
					local time = 3
					if ply.Upgrades["InstantPlant"] == 1 then
						time = .1
					end
					ply:DoProcess("PlantOrange",time,data)
				else
					ply:SendMessage("You need more distance between seeds/props.",3,Color(200,0,0,255))
				end
			else
				ply:SendMessage("You need an orange seed.",3,Color(200,0,0,255))
			end
		else
			ply:SendMessage("You cannot plant on this terrain.",3,Color(200,0,0,255))
		end
	else
		ply:SendMessage("Aim at the ground to plant.",3,Color(200,0,0,255))
	end
end
concommand.Add("gms_plantorange",GM.PlantOrange)

--Grain planting
function GM.PlantGrain(ply,cmd,args)
	if ply:GetNWInt("plants") >= GetConVarNumber("gms_PlantLimit") then 
		ply:SendMessage("You have hit the plant limit.",3,Color(200,0,0,255))
		return 
	end
	local tr = ply:TraceFromEyes(150)

	if tr.HitWorld then
		local nearby = false

		for k,v in pairs(ents.FindInSphere(tr.HitPos,50)) do
			if (v:IsGrainModel() or v:IsProp() or v:GetClass() == "gms_seed") and (tr.HitPos-Vector(v:LocalToWorld(v:OBBCenter()).x,v:LocalToWorld(v:OBBCenter()).y,tr.HitPos.z)):Length() <= 50 then
				nearby = true
			end
		end

		if (tr.MatType == MAT_DIRT or tr.MatType == MAT_GRASS or tr.MatType == MAT_SAND) and !GMS.IsInWater(tr.HitPos) then
			if ply:GetResource("Grain_Seeds") >= 1 then
				if !nearby then
					local data = {}
					data.Pos = tr.HitPos
					local time = 3
					if ply.Upgrades["InstantPlant"] == 1 then
						time = .1
					end
					ply:DoProcess("PlantGrain",time,data)
				else
					ply:SendMessage("You need more distance between seeds/props.",3,Color(200,0,0,255))
				end
			else
				ply:SendMessage("You need a grain seed.",3,Color(200,0,0,255))
			end
		else
			ply:SendMessage("You cannot plant on this terrain.",3,Color(200,0,0,255))
		end
	else
		ply:SendMessage("Aim at the ground to plant.",3,Color(200,0,0,255))
	end
end
concommand.Add("gms_plantgrain",GM.PlantGrain)

--Berry planting
function GM.PlantBush(ply,cmd,args)
	if ply:GetNWInt("plants") >= GetConVarNumber("gms_PlantLimit") then 
		ply:SendMessage("You have hit the plant limit.",3,Color(200,0,0,255))
		return 
	end
	local tr = ply:TraceFromEyes(150)

	if tr.HitWorld then
		local nearby = false

		for k,v in pairs(ents.FindInSphere(tr.HitPos,50)) do
			if (v:IsBerryBushModel() or v:IsProp() or v:GetClass() == "gms_seed") and (tr.HitPos-Vector(v:LocalToWorld(v:OBBCenter()).x,v:LocalToWorld(v:OBBCenter()).y,tr.HitPos.z)):Length() <= 50  then
				nearby = true
			end
		end

		if (tr.MatType == MAT_DIRT or tr.MatType == MAT_GRASS or tr.MatType == MAT_SAND) and !GMS.IsInWater(tr.HitPos) then
			if ply:GetResource("Berries") >= 1 then
				if !nearby then
					local data = {}
					data.Pos = tr.HitPos
					local time = 3
					if ply.Upgrades["InstantPlant"] == 1 then
						time = .1
					end
					ply:DoProcess("PlantBush",time,data)
				else
					ply:SendMessage("You need more distance between seeds/props.",3,Color(200,0,0,255))
				end
			else
				ply:SendMessage("You need a berry.",3,Color(200,0,0,255))
			end
		else
			ply:SendMessage("You cannot plant on this terrain.",3,Color(200,0,0,255))
		end
	else
		ply:SendMessage("Aim at the ground to plant.",3,Color(200,0,0,255))
	end
end

concommand.Add("gms_plantbush",GM.PlantBush)


--Tree planting
function GM.PlantTree(ply,cmd,args)
	local tr = ply:TraceFromEyes(150)

	if tr.HitWorld then 
		if (tr.MatType == MAT_DIRT or tr.MatType == MAT_GRASS or tr.MatType == MAT_SAND) and !GMS.IsInWater(tr.HitPos) then
			if ply:GetResource("Sprouts") >= 1 then
				local data = {}
				data.Pos = tr.HitPos
				local time = 3
					if ply.Upgrades["InstantPlant"] == 1 then
						time = .1
					end
					ply:DoProcess("PlantTree",time,data)
			else
				ply:SendMessage("You need a sprout.",3,Color(200,0,0,255))
			end
		else
			ply:SendMessage("You cannot plant on this terrain.",3,Color(200,0,0,255))
		end
	else
		ply:SendMessage("Aim at the ground to plant.",3,Color(200,0,0,255))
	end
end

concommand.Add("gms_planttree",GM.PlantTree)
/*---------------------------------------------------------

  Drink command

---------------------------------------------------------*/
function GM.DrinkFromBottle(ply,cmd,args)
	if ply:GetResource("Water_Bottles") < 1 then
		ply:SendMessage("You need a water bottle.",3,Color(200,0,0,255))
	return end

	ply:DoProcess("DrinkBottle",1.5)

end

concommand.Add("gms_DrinkBottle",GM.DrinkFromBottle)

/*---------------------------------------------------------

  Take Medicine command

---------------------------------------------------------*/
function GM.TakeAMedicine(ply,cmd,args)
	if ply:GetResource("Medicine") < 1 then
		ply:SendMessage("You need Medicine.",3,Color(200,0,0,255))
	return end

	ply:DoProcess("TakeMedicine",1.5)
end

concommand.Add("gms_TakeMedicine",GM.TakeAMedicine)

/*---------------------------------------------------------

  Drop weapon command

---------------------------------------------------------*/
function GM.DropWeapon(ply,cmd,args)
	if !ply:Alive() then return end
	if ply:GetActiveWeapon():GetClass() == "gms_hands" then
		ply:SendMessage("You cannot drop your hands!",3,Color(200,0,0,255))
	elseif ply:GetActiveWeapon():GetClass() == "gmod_camera" or ply:GetActiveWeapon():GetClass() == "weapon_physgun" or ply:GetActiveWeapon():GetClass() == "pill_pigeon" or ply:GetActiveWeapon():GetClass() == "weapon_physcannon" then
		ply:SendMessage("You cannot drop this!",3,Color(200,0,0,255))
	else
		ply:DropWeapon(ply:GetActiveWeapon())
	end
end

concommand.Add("gms_DropWeapon",GM.DropWeapon)

/*---------------------------------------------------------

  Drop resource command

---------------------------------------------------------*/
function GM.DropResource(ply,cmd,args)
	if args == nil or args[1] == nil then
		ply:SendMessage("You need to at least give a resource type!",3,Color(200,0,0,255))
	return end

	args[1] = string.Capitalize(args[1])

	if !ply.Resources[args[1]] or ply.Resources[args[1]] == 0 then
		ply:SendMessage("You don't have this kind of resource.",3,Color(200,0,0,255))
	return end

	if args[2] == nil or string.lower(args[2]) == "all" then
		args[2] = tostring(ply:GetResource(args[1]))
	end

	if tonumber(args[2]) <= 0 then
		ply:SendMessage("No zeros/negatives!",3,Color(200,0,0,255))
	return end

	local int = tonumber(args[2])
	local Type = args[1]

	local res = ply:GetResource(Type)

	if int > res then
		int = res
	end
	ply:DropResource(Type,int)
	ply:DecResource(Type,int)

	ply:SendMessage("Dropped "..Type.." ("..int.."x)",3,Color(10,200,10,255))
end

concommand.Add("gms_DropResources",GM.DropResource)

/*---------------------------------------------------------

  Admin Drop resource command

---------------------------------------------------------*/
function GM.ADropResource(ply,cmd,args)
	if ply.Trusted == 0 then
		if !ply:IsAdmin() then
			ply:SendMessage("You need admin rights for this!",3,Color(200,0,0,255))
			return
		end
	end

	if args == nil or args[1] == nil then
		ply:SendMessage("You need to at least give a resource type!",3,Color(200,0,0,255))
	return end

	args[1] = string.Capitalize(args[1])

	if args[2] == nil or string.lower(args[2]) == "all" then
		args[2] = tostring(ply:GetResource(args[1]))
	end

	if tonumber(args[2]) <= 0 then
		ply:SendMessage("No zeros/negatives!",3,Color(200,0,0,255))
	return end

	local int = tonumber(args[2])
	local Type = args[1] 

	ply:DropResource(Type,int)
	ply:SendMessage("Dropped "..Type.." ("..int.."x)",3,Color(10,200,10,255))
end

concommand.Add("gms_ADropResources",GM.ADropResource)

/*---------------------------------------------------------

  Take resource command

---------------------------------------------------------*/

function GM.TakeResource(ply,cmd,args)

	if ply.InProcess then return end

	if args == nil or args[1] == nil then
		ply:SendMessage("You need to at least give a resource type!",3,Color(200,0,0,255))
	return end

	if tonumber(args[2]) <= 0 then
		ply:SendMessage("No zeros/negatives!",3,Color(200,0,0,255))
	return end
	args[1] = string.Capitalize(args[1])

	local tr = ply:TraceFromEyes(150)
	local ent = tr.Entity
	local cls = tr.Entity:GetClass()
	if cls != "gms_resourcedrop" or (ply:GetPos()-ent:LocalToWorld(ent:OBBCenter())):Length() >= 65 or ent.Type != args[1] then return end
	if !ent:CPPICanUse(ply) then return end

	local int = tonumber(args[2])
	local room = ply.MaxResources - ply:GetAllResources()

	if int >= ent.Amount then
		int = ent.Amount
	end

	if room <= 0 then
		ply:SendMessage("You can't carry anymore!",3,Color(200,0,0,255))
	return end

	if room < int then
		int = room
	end

	ent.Amount = ent.Amount - int

	if ent.Amount <= 0 then
		ent:Fadeout()
	else
		ent:SetResourceDropInfo(ent.Type,ent.Amount)
	end

	ply:IncResource(ent.Type,int)
	ply:SendMessage("Picked up "..ent.Type.." ("..int.."x)",4,Color(10,200,10,255))
end

concommand.Add("gms_TakeResources",GM.TakeResource)

/*---------------------------------------------------------

  Buildings menu

---------------------------------------------------------*/
function GM.OpenBuildingsCombi(ply)
	ply:OpenCombiMenu("Buildings")
end

concommand.Add("gms_BuildingsCombi",GM.OpenBuildingsCombi)

function GM.OpenSpecialBuildingsCombi(ply)
	ply:OpenCombiMenu("SpecialBuildings")
end

concommand.Add("gms_SpecialBuildingsCombi",GM.OpenSpecialBuildingsCombi)

function GM.OpenTrophysCombi(ply)
	ply:OpenCombiMenu("Trophys")
end

concommand.Add("gms_TrophysCombi",GM.OpenTrophysCombi)
/*---------------------------------------------------------

  Generic combi menu

---------------------------------------------------------*/
function GM.OpenGenericCombi(ply)
	ply:OpenCombiMenu("Generic")
end

concommand.Add("gms_GenericCombi",GM.OpenGenericCombi)
/*---------------------------------------------------------

  Make combination

---------------------------------------------------------*/
function GM.MakeCombination(ply,cmd,args)
	if !args[1] or !args[2] then
		ply:SendMessage("Please specify a valid combination.",3,Color(255,255,255,255))
		ply:CloseCombiMenu()
	return end

	local group = args[1]
	local combi = args[2]

	if !GMS.Combinations[group] then return end
	if !GMS.Combinations[group][combi] then return end

	local tbl = GMS.Combinations[group][combi]

	
	--Check for nearby forge/fire etc:
	if group == "Cooking" then
		local nearby = false

		for k,v in pairs(ents.FindInSphere(ply:GetPos(),100)) do
			if (v:IsProp() and v:IsOnFire()) or (v:GetModel() == "models/props_c17/furniturestove001a.mdl" and v:CPPICanUse(ply)) then nearby = true end
		end

		if !nearby then
			ply:SendMessage("You need to be close to a fire!",3,Color(200,0,0,255))
			ply:CloseCombiMenu()
		return end

	elseif group == "StoneWeapons" then
		local nearby = false

		for k,v in pairs(ents.FindInSphere(ply:GetPos(),100)) do
			if v:GetClass() == "gms_stoneworkbench" and v:CPPICanUse(ply) then nearby = true end
		end

		if !nearby then
			ply:SendMessage("You need to be close to a workbench!",3,Color(200,0,0,255))
			ply:CloseCombiMenu()
		return end
		
	elseif group == "CopperWeapons" then
		local nearby = false

		for k,v in pairs(ents.FindInSphere(ply:GetPos(),100)) do
			if v:GetClass() == "gms_copperworkbench" and v:CPPICanUse(ply) then nearby = true end
		end

		if !nearby then
			ply:SendMessage("You need to be close to a workbench!",3,Color(200,0,0,255))
			ply:CloseCombiMenu()
		return end
		
	elseif group == "IronWeapons" then
		local nearby = false

		for k,v in pairs(ents.FindInSphere(ply:GetPos(),100)) do
			if v:GetClass() == "gms_ironworkbench" and v:CPPICanUse(ply) then nearby = true end
		end

		if !nearby then
			ply:SendMessage("You need to be close to a workbench!",3,Color(200,0,0,255))
			ply:CloseCombiMenu()
		return end
		
	elseif group == "AdvancedWeapons" then
		local nearby = false

		for k,v in pairs(ents.FindInSphere(ply:GetPos(),100)) do
			if v:GetClass() == "gms_advancedworkbench" and v:CPPICanUse(ply) then nearby = true end
		end

		if !nearby then
			ply:SendMessage("You need to be close to a workbench!",3,Color(200,0,0,255))
			ply:CloseCombiMenu()
		return end
		
	elseif group == "StoneFurnace" then
		local nearby = false

		for k,v in pairs(ents.FindInSphere(ply:GetPos(),100)) do
			if v:GetClass() == "gms_stonefurnace" and v:CPPICanUse(ply) then nearby = true end
		end

		if !nearby then
			ply:SendMessage("You need to be close to a furnace!",3,Color(200,0,0,255))
			ply:CloseCombiMenu()
		return end
		
	elseif group == "CopperFurnace" then
		local nearby = false

		for k,v in pairs(ents.FindInSphere(ply:GetPos(),100)) do
			if v:GetClass() == "gms_copperfurnace" and v:CPPICanUse(ply) then nearby = true end
		end

		if !nearby then
			ply:SendMessage("You need to be close to a furnace!",3,Color(200,0,0,255))
			ply:CloseCombiMenu()
		return end
		
	elseif group == "IronFurnace" then
		local nearby = false

		for k,v in pairs(ents.FindInSphere(ply:GetPos(),100)) do
			if v:GetClass() == "gms_ironfurnace" and v:CPPICanUse(ply) then nearby = true end
		end

		if !nearby then
			ply:SendMessage("You need to be close to a furnace!",3,Color(200,0,0,255))
			ply:CloseCombiMenu()
		return end
		
	elseif group == "SteelFurnace" then
		local nearby = false

		for k,v in pairs(ents.FindInSphere(ply:GetPos(),100)) do
			if v:GetClass() == "gms_steelfurnace" and v:CPPICanUse(ply) then nearby = true end
		end

		if !nearby then
			ply:SendMessage("You need to be close to a furnace!",3,Color(200,0,0,255))
			ply:CloseCombiMenu()
		return end
	end		 

	--Check for skills
	local numreq = 0

	if tbl.SkillReq then
		for k,v in pairs(tbl.SkillReq) do
			if ply:GetSkill(k) >= v then
				numreq = numreq + 1
			end
		end

		if numreq < table.Count(tbl.SkillReq) then
			ply:SendMessage("Not enough skill.",3,Color(200,0,0,255))
			ply:CloseCombiMenu()
		return end
	end



	--Check for resources
	local numreq = 0

	for k,v in pairs(tbl.Req) do
		if ply:GetResource(k) >= v then
			numreq = numreq + 1
		end
	end

	if numreq < table.Count(tbl.Req) and group != "Buildings" and group != "Trophys" and group != "SpecialBuildings" then
		ply:SendMessage("Not enough resources.",3,Color(200,0,0,255))
		ply:CloseCombiMenu()
	return end

	ply:CloseCombiMenu()
	
	--All well, make stuff:
	if group == "Cooking" then
		local data = {}
		data.Name = tbl.Name
		data.FoodValue = tbl.FoodValue
		data.Cost = table.Copy(tbl.Req)
		local time = 5

		if ply:GetActiveWeapon():GetClass() == "gms_fryingpan" then
			time = 2
		end
		
		if ply:GetActiveWeapon():GetClass() == "gms_steelfryingpan" then
			time = 1
		end

		ply:DoProcess("Cook",time,data)

	elseif group == "Generic" then
		local data = {}
		data.Name = tbl.Name
		data.Res = tbl.Results
		data.Cost = table.Copy(tbl.Req)
		local time = 5

		ply:DoProcess("MakeGeneric",time,data)

	elseif group == "Factory" or group == "Gunmaking" or group == "Utilities" then
		local data = {}
		data.Name = tbl.Name
		if tbl.AllSmelt == true then
			local sourcetable = ply:AllSmelt(tbl)
			data.Res  = sourcetable.Results
			data.Cost = table.Copy(sourcetable.Req)
		else		
			data.Res = tbl.Results
			data.Cost = table.Copy(tbl.Req)
		end
		local timecount = 1
		for k, v in pairs(data.Cost) do
			timecount  = timecount + v
		end 
		local time = timecount * 0.3

		if tbl.SwepClass != nil then
			data.Class = tbl.SwepClass
			ply:DoProcess("MakeWeapon",time,data)
		else		
			ply:DoProcess("Processing",time,data)
		end
		

	elseif group == "StoneWeapons" then
		local data = {}
		data.Name = tbl.Name
		data.Class = tbl.SwepClass
		data.Cost = table.Copy(tbl.Req)
		local time = 10

		ply:DoProcess("MakeWeapon",time,data)

	elseif group == "CopperWeapons" then
		local data = {}
		data.Name = tbl.Name
		data.Class = tbl.SwepClass
		data.Cost = table.Copy(tbl.Req)
		local time = 10

		ply:DoProcess("MakeWeapon",time,data)

	elseif group == "IronWeapons" then
		local data = {}
		data.Name = tbl.Name
		data.Class = tbl.SwepClass
		data.Cost = table.Copy(tbl.Req)
		local time = 10

		ply:DoProcess("MakeWeapon",time,data)	

	elseif group == "AdvancedWeapons" then
		local data = {}
		data.Name = tbl.Name
		data.Class = tbl.SwepClass
		data.Cost = table.Copy(tbl.Req)
		local time = 10

		ply:DoProcess("MakeWeapon",time,data)	

	elseif group == "Buildings" then
		local data = {}
		local trs = {}
		data.Name = tbl.Name
		data.Class = tbl.Results
		data.Cost = table.Copy(tbl.Req) 

		local time = 10
		if ply:GetSkill("Construction") < 10 then
			time = 16
		elseif	ply:GetSkill("Construction") < 20 then
			time = 8
		elseif	ply:GetSkill("Construction") < 50 then
			time = 4
		elseif ply:GetSkill("Construction") < 100 then
			time = 2
		end
		data.BuildSiteModel = tbl.BuildSiteModel
		trs = ply:TraceFromEyes(250)
		
		ply:DoProcess("MakeBuilding",time,data)
		
	elseif group == "Trophys" then
		local data = {}
		local trs = {}
		data.Name = tbl.Name
		data.Class = tbl.Results
		data.Cost = table.Copy(tbl.Req) 

		local time = 10
		if ply:GetSkill("Construction") < 10 then
			time = 16
		elseif	ply:GetSkill("Construction") < 20 then
			time = 8
		elseif	ply:GetSkill("Construction") < 50 then
			time = 4
		elseif ply:GetSkill("Construction") < 100 then
			time = 2
		end
		data.BuildSiteModel = tbl.BuildSiteModel
		trs = ply:TraceFromEyes(250)
		if !trs.HitWorld then
			ply:SendMessage("Aim at the ground to construct a structure.",3,Color(200,0,0,255))
		return end
		
		ply:DoProcess("MakeBuilding",time,data)
		
	elseif group == "SpecialBuildings" then
		local data = {}
		local trs = {}
		data.Name = tbl.Name
		data.Class = tbl.Results
		data.Cost = table.Copy(tbl.Req) 
		data.Trophy = tbl.Trophy
		time = 1
		data.BuildSiteModel = tbl.BuildSiteModel
		trs = ply:TraceFromEyes(250)
		if !trs.HitWorld then
			ply:SendMessage("Aim at the ground to construct a structure.",3,Color(200,0,0,255))
		return end
		
		ply:DoProcess("MakeSpecialBuilding",time,data)

	elseif group == "StoneFurnace" then
		local data = {}
		data.Name = tbl.Name
		if tbl.AllSmelt == true then
			local sourcetable = ply:AllSmelt(tbl)
			data.Res  = sourcetable.Results
			data.Cost = table.Copy(sourcetable.Req)
		else		
			data.Res = tbl.Results
			data.Cost = table.Copy(tbl.Req)
		end
		local timecount = 1
		local Amount = 0
		for k, v in pairs(data.Cost) do
			local TimeOff = ply:GetSkill("Smithing") or 0
			TimeOff = v - TimeOff
			TimeOff = math.floor(TimeOff)
			if TimeOff < 1 then
				TimeOff = 1
			end
			timecount  = timecount + TimeOff
			Amount = Amount + v
		end 
		local time = timecount * 0.5
		local Compare = ply:GetSkill("Smithing") or 0
		local Amount2 = 0
		if Compare > 19 && Compare < 40 then
			Amount2 = Amount / 2
		elseif	Compare > 39 then
			Amount2 = Amount / 4
		else
			Amount2 = Amount
		end
		Amount2 = math.floor(Amount2)
		if Amount2 < 1 then
			Amount2 = 1
		end
		data.Amount2 = Amount2



		ply:DoProcess("Smelt",time,data)

	elseif group == "CopperFurnace" then
		local data = {}
		data.Name = tbl.Name
		if tbl.AllSmelt == true then
			local sourcetable = ply:AllSmelt(tbl)
			data.Res  = sourcetable.Results
			data.Cost = table.Copy(sourcetable.Req)
		else		
			data.Res = tbl.Results
			data.Cost = table.Copy(tbl.Req)
		end
		local timecount = 1
		local Amount = 0
		for k, v in pairs(data.Cost) do
			local TimeOff = ply:GetSkill("Smithing") or 0
			TimeOff = v - TimeOff
			TimeOff = math.floor(TimeOff)
			if TimeOff < 1 then
				TimeOff = 1
			end
			timecount  = timecount + TimeOff
			Amount = Amount + v
		end 
		local time = timecount * 0.5
		local Compare = ply:GetSkill("Smithing") or 0
		local Amount2 = 0
		if Compare > 19 && Compare < 40 then
			Amount2 = Amount / 2
		elseif	Compare > 39 then
			Amount2 = Amount / 4
		else
			Amount2 = Amount
		end
		Amount2 = math.floor(Amount2)
		if Amount2 < 1 then
			Amount2 = 1
		end
		
		data.Amount2 = Amount2


		ply:DoProcess("Smelt",time,data)	

	elseif group == "IronFurnace" then
		local data = {}
		data.Name = tbl.Name
		if tbl.AllSmelt == true then
			local sourcetable = ply:AllSmelt(tbl)
			data.Res  = sourcetable.Results
			data.Cost = table.Copy(sourcetable.Req)
		else		
			data.Res = tbl.Results
			data.Cost = table.Copy(tbl.Req)
		end
		local timecount = 1
		local Amount = 0
		for k, v in pairs(data.Cost) do
			local TimeOff = ply:GetSkill("Smithing") or 0
			TimeOff = v - TimeOff
			TimeOff = math.floor(TimeOff)
			if TimeOff < 1 then
				TimeOff = 1
			end
			timecount  = timecount + TimeOff
			Amount = Amount + v
		end 
		local time = timecount * 0.5
		local Compare = ply:GetSkill("Smithing") or 0
		local Amount2 = 0
		if Compare > 19 && Compare < 40 then
			Amount2 = Amount / 2
		elseif	Compare > 39 then
			Amount2 = Amount / 4
		else
			Amount2 = Amount
		end
		Amount2 = math.floor(Amount2)
		if Amount2 < 1 then
			Amount2 = 1
		end
		
		data.Amount2 = Amount2


		ply:DoProcess("Smelt",time,data)		

	elseif group == "SteelFurnace" then
		local data = {}
		data.Name = tbl.Name
		if tbl.AllSmelt == true then
			local sourcetable = ply:AllSmelt(tbl)
			data.Res  = sourcetable.Results
			data.Cost = table.Copy(sourcetable.Req)
		else		
			data.Res = tbl.Results
			data.Cost = table.Copy(tbl.Req)
		end
		local timecount = 1
		local Amount = 0
		for k, v in pairs(data.Cost) do
			local TimeOff = ply:GetSkill("Smithing") or 0
			TimeOff = v - TimeOff
			TimeOff = math.floor(TimeOff)
			if TimeOff < 1 then
				TimeOff = 1
			end
			timecount  = timecount + TimeOff
			Amount = Amount + v
		end 
		local time = timecount * 0.5
		local Compare = ply:GetSkill("Smithing") or 0
		local Amount2 = 0
		if Compare > 19 && Compare < 40 then
			Amount2 = Amount / 2
		elseif	Compare > 39 then
			Amount2 = Amount / 4
		else
			Amount2 = Amount
		end
		Amount2 = math.floor(Amount2)
		if Amount2 < 1 then
			Amount2 = 1
		end
		
		data.Amount2 = Amount2


		ply:DoProcess("Smelt",time,data)	

	elseif group == "GrindingStone" then
		local data = {}
		data.Name = tbl.Name
		data.Res = tbl.Results
		data.Cost = table.Copy(tbl.Req)
		local timecount = 1
		local Amount = 0
		for k, v in pairs(data.Cost) do
			local TimeOff = ply:GetSkill("Smithing") or 0
			TimeOff = v - TimeOff
			TimeOff = math.floor(TimeOff)
			if TimeOff < 1 then
				TimeOff = 1
			end
			timecount  = timecount + TimeOff
			Amount = Amount + v
		end 
		local time = timecount * 0.5
		local Compare = ply:GetSkill("Smithing") or 0
		local Amount2 = 0
		if Compare > 19 && Compare < 40 then
			Amount2 = Amount / 2
		elseif	Compare > 39 then
			Amount2 = Amount / 4
		else
			Amount2 = Amount
		end
		Amount2 = math.floor(Amount2)
		if Amount2 < 1 then
			Amount2 = 1
		end
		
		data.Amount2 = Amount2


		ply:DoProcess("Crush",time,data)

	end
end

concommand.Add("gms_MakeCombination",GM.MakeCombination)
/*---------------------------------------------------------

  STOOLs and Physgun

---------------------------------------------------------*/
function GM:PhysgunPickup(ply, ent)
	if ply:IsAdmin() then return true end

	if ent.StrandedProtected || ent:IsPlayer() || table.HasValue(GMS.PickupProhibitedClasses,ent:GetClass()) then
		return false
	else
		return true
	end
end

function GM:GravGunPunt( ply, ent )
	return ply:IsAdmin()
end

function GM:CanTool(ply,tr,mode)
	if ply:IsAdmin() then return true end
	local ent = tr.Entity
	if IsValid(ent) && ent:IsVehicle() && ply.Trusted == 0 then
		ply:SendMessage("You are not allowed to toolgun vehicles.",3,Color(200,0,0,255))
		return false
	end
	if mode == "remover" then
		if !IsValid(ent) || (ent:IsFoodModel() or ent:IsTreeModel() or ent:IsRockModel() or table.HasValue(GMS.PickupProhibitedClasses,ent:GetClass())) then
			ply:SendMessage("This is prohibited!",3,Color(200,0,0,255))
			return false
		end	
	end
	if table.HasValue(GMS.ProhibitedStools,mode) then
		if ply.Trusted == 1 then
			if table.HasValue(GMS.TrustedAllowedTools,mode) then
				return true
			end
		end
		ply:SendMessage("This sTOOL is prohibited.",3,Color(200,0,0,255))
		return false
	end
	return true
end

/*---------------------------------------------------------

  Prop spawning

---------------------------------------------------------*/
function GM:PlayerSpawnedProp( ply, mdl, ent )
	if GetConVarNumber("gms_FreeBuild") == 1 then return end
	if GetConVarNumber("gms_FreeBuildSA") == 1 and ply:IsSuperAdmin() then return end
	if ply.InProcess then 
		ent:Remove()
	return end
	if ent:IsWeapon() then
		local wname = ent:GetClass()
		print(wname)
		if string.find(wname,"gms") then
			return true
		elseif ply:IsAdmin() then
			return true
		end
		return false	
	end
	
	ent.NormalProp = true
	
	if ply.CanSpawnProp == false and !ply:IsAdmin() and ply.Trusted == 0 then
		ent:Remove()
		ply:SendMessage("No spamming!",3,Color(200,0,0,255))
		return false
	end
	
	if (ent:IsRockModel() or ent:IsTreeModel() or ent:IsFoodModel()) and !ply:IsAdmin() then
		ent:Remove()
		ply:SendMessage("You cannot spawn this prop unless you're admin.",5,Color(255,255,255,255))
	return false
	end

	ply.CanSpawnProp = false
	timer.Simple(0,self.PlayerSpawnedPropDelay, self, ply, mdl, ent)
end

function GM:PlayerSpawnedPropDelay( ply, mdl, ent )
	ply.CanSpawnProp = true
	if ply.InProcess then return end

	--Admin only models
	if (ent:IsRockModel() or ent:IsTreeModel() or ent:IsFoodModel()) and !ply:IsAdmin() then
		ent:Remove()
		ply:SendMessage("You cannot spawn this prop unless you're admin.",5,Color(255,255,255,255))
	return end

	--Trace
	ent.EntOwner = ply
	local min,max = ent:WorldSpaceAABB()
	--local mass = ent:GetPhysicsObject():GetMass()

	-- Do volume in cubic "feet"
	local min, max = ent:OBBMins(), ent:OBBMaxs()
	local vol = math.abs(max.x-min.x) * math.abs(max.y-min.y) * math.abs(max.z-min.z)
	vol = vol/(16^3)

	local x = 0
	
	local trace = nil
	local tr = nil
	trace = {}
	trace.start = ent:GetPos() + Vector((math.random()*200)-100,(math.random()*200)-100,(math.random()*200)-100)
	trace.endpos = ent:GetPos()
	tr = util.TraceLine(trace)

	while (tr.Entity != ent and x < 5) do
		x = x + 1

		trace = {}
		trace.start = ent:GetPos() + Vector((math.random()*200)-100,(math.random()*200)-100,(math.random()*200)-100)
		trace.endpos = ent:GetPos()

		tr = util.TraceLine(trace)
	end

	--Faulty trace
	if tr.Entity != ent then
		ent:Remove()
		ply:SendMessage("You need more space to spawn.",3,Color(255,255,255,255))
		return 
	end


	local res = GMS.MaterialResources[tr.MatType]
	local cost = math.ceil(vol*GetConVarNumber("gms_CostsScale"))
	if ply.Upgrades["Half_Price_Props"] == 1 then
		cost = cost / 2
	end

	if cost > ply:GetResource(res) then
		if ply:GetBuildingSite() and ply:GetBuildingSite():IsValid() then ply:GetBuildingSite():Remove() end
		local site = ply:CreateBuildingSite(ent:GetPos(),ent:GetAngles(),ent:GetModel(),ent:GetClass())
		local tbl = site:GetTable()
		site.EntOwner = ply
		site.NormalProp = true
		local costtable = {}
		costtable[res] = cost
		tbl.Costs = table.Copy(costtable)
		local time = 10
		if ply:GetSkill("Construction") < 10 then
			time = 6
		elseif	ply:GetSkill("Construction") < 20 then
			time = 4
		elseif	ply:GetSkill("Construction") < 50 then
			time = 2
		elseif ply:GetSkill("Construction") < 100 then
			time = 1
		else
			time = 1
		end
		ply:DoProcess("Assembling",time)
		ply:SendMessage("Not enough resources, creating buildsite.",3,Color(255,255,255,255))
		local str = ":"
		for k,v in pairs(site.Costs) do
			str = str.." "..k.." ("..v.."x)"
		end
		site:SetNetworkedString('Resources', str)
		local Name = "Prop"
		site:SetNetworkedString('Name', Name)
		ent:Remove()
		return
	end

	--Resource cost
	if ply:GetResource(res) < cost then
		ent:Remove()
		ply:SendMessage("You need "..res.." ("..cost.."x) to spawn this prop.",3,Color(200,0,0,255))
	else
		ply:DecResource(res,cost)
		ply:SendMessage("Used "..res.." ("..cost.."x) to spawn this prop.",3,Color(255,255,255,255))
		local time = 10
		if ply:GetSkill("Construction") < 10 then
			time = 6
		elseif	ply:GetSkill("Construction") < 20 then
			time = 4
		elseif	ply:GetSkill("Construction") < 50 then
			time = 2
		elseif ply:GetSkill("Construction") < 100 then
			time = 1
		else
			time = 1
		end
		ply:DoProcess("Assembling",time)
		local phys = ent:GetPhysicsObject()
		if ValidEntity(phys) then
			hp = phys:GetMass()
			if hp < 100 then
				hp = 100
			end
		else
			hp = 100
		end
		ent.RPHealth = hp
		ent.RPMaxHealth = hp
		ent.Destroyable = 1
	end
end

function GM:PlayerSpawnedEffect(ply,mdl,ent)
	if GetConVarNumber("gms_FreeBuild") == 1 then return end
	ent:Remove()
end

function gms_NPCSpawn( pl, npc_type, npc_weapon ) 
   if ply:IsAdmin() then
		return true
	else
		return false
	end 
end
hook.Add( "PlayerSpawnNPC", "gms_playerSpawnNPC", gms_NPCSpawn );
 

function GM:PlayerSpawnedVehicle(ply,ent)
	
	if ply:IsAdmin() || ply.Upgrades["Mechanic"] == 1 then
		return true
	else
		ent:Remove()
	end
end

function GM:PlayerSpawnedSENT( ply, prop )
	if GetConVarNumber("gms_AllowSENTSpawn") == 1 then return end
	if ply:IsAdmin() || ply.Trusted == 1 then
		return true
	else
		prop:Remove()
	end
end

---------------------------------------------------------*/
--Override
function CCSpawnSWEP( player, command, arguments )
	if GetConVarNumber("gms_AllowSWEPSpawn") == 0 || player:IsAdmin() then
		player:SendMessage("SWEP spawning is disabled.",3,Color(200,0,0,255))
	return end

	if ( arguments[1] == nil ) then return end

	// Make sure this is a SWEP
	local swep = weapons.GetStored( arguments[1] )
	if (swep == nil) then return end
	
	// You're not allowed to spawn this!
	if ( !swep.Spawnable && !player:IsAdmin() ) then
		return
	end
	
	if ( !gamemode.Call( "PlayerSpawnSWEP", player, arguments[1], swep ) ) then return end
	
	local tr = player:GetEyeTraceNoCursor()

	if ( !tr.Hit ) then return end
	
	local entity = ents.Create( swep.Classname )
	
	if ( ValidEntity( entity ) ) then	
		entity:SetPos( tr.HitPos + tr.HitNormal * 32 )
		entity:Spawn()	
	end

 end 
   
 concommand.Add( "gm_spawnswep", CCSpawnSWEP )
 
 --Override
function CCGiveSWEP( player, command, arguments )
	if GetConVarNumber("gms_AllowSWEPSpawn") == 0 || player:IsAdmin() then
		player:SendMessage("SWEP spawning is disabled.",3,Color(200,0,0,255))
	return end

	if ( arguments[1] == nil ) then return end

	// Make sure this is a SWEP
	local swep = weapons.GetStored( arguments[1] )
	if (swep == nil) then return end
	
	// You're not allowed to spawn this!
	if ( !swep.Spawnable && !player:IsAdmin() ) then
		return
	end
	
	if ( !gamemode.Call( "PlayerGiveSWEP", player, arguments[1], swep ) ) then return end
	
	MsgAll( "Giving "..player:Nick().." a "..swep.Classname.."\n" )
	player:Give( swep.Classname )
	
	// And switch to it
	player:SelectWeapon( swep.Classname )

 end 
   
 concommand.Add( "gm_giveswep", CCSpawnSWEP )

/*---------------------------------------------------------

  Needs

---------------------------------------------------------*/
function PlayerMeta:UpdateNeeds()
	umsg.Start("gms_setneeds",self)
	umsg.Short(self.Sleepiness)
	umsg.Short(self.Hunger)
	umsg.Short(self.Thirst)
	umsg.Short(self.Warmth)
	umsg.Short(Time)
	umsg.Short(Light)
	umsg.End()
end

function GM.SubtractNeeds()
	for k,ply in pairs(player.GetAll()) do
		if ply:Alive() then
			--Sleeping
			if ply.Sleeping then
				if ply.Sleepiness < 1000 and ply.Sleepiness <= 950 then
					local trace = {}
					trace.start = ply:GetShootPos()
					trace.endpos = trace.start - (ply:GetUp() * 300)
					trace.filter = ply

					local tr = util.TraceLine(trace)
					if Entity(tr.Entity) and tr.Entity:IsSleepingFurniture() then
						ply.Sleepiness = ply.Sleepiness + 100
					else
						ply.Sleepiness = ply.Sleepiness + 50
					end
				elseif /*ply.Sleepiness < 1000 and*/ ply.Sleepiness > 950 then
					ply.Sleepiness = 1000
					GAMEMODE.PlayerWake(ply)
				end

				if ply.Thirst - 20 < 0 then
					ply.Thirst = 0
				else
					ply.Thirst = ply.Thirst - 20
				end

				if ply.Hunger - 20 < 0 then
					ply.Hunger = 0
				else
					ply.Hunger = ply.Hunger - 20
				end
				
				
				if ply.NeedShelter then ply:SetHealth(ply:Health() - 10) end
			end

			--Kay you're worn out
			if ply.AFK != true then
				//if ply.Warmth < Temp then
					//ply.Warmth = ply.Warmth + TempScale
				//elseif ply.Warmth > Temp then
					//ply.Warmth = ply.Warmth - TempScale
				//else
					//ply.Warmth = Temp
				//end
				
				local Scale = 1
				
				//if ply.Warmth > 50 then
					//Scale = 1 + (.1 * (ply.Warmth - 50))
				//elseif ply.Warmth < 50 then
					//Scale = 1 + (.1 * (50 - ply.Warmth))
				//end
				if ply.Upgrades["Mr_Survival"] == 1 then
					Scale = .25
				elseif ply.Upgrades["Wild_Man"] == 1 then
					Scale = .5
				else
					Scale = 1
				end
				if ply.Sleepiness > 0 then 
					ply.Sleepiness = ply.Sleepiness - (1 * Scale) 
				end
				if ply.Thirst > 0 then 
					ply.Thirst = ply.Thirst - (2 * Scale) 
				end
				if ply.Hunger > 0 then 
					ply.Hunger = ply.Hunger - (1 * Scale) 
				end
					
			end
             
			ply:UpdateNeeds()

			--Are you dying?
			if ply.Sleepiness <= 0 or ply.Thirst <= 0 or ply.Hunger <= 0 or ply.Warmth <= 0 then
				if ply:Health() > 4 then
					ply:SetHealth(ply:Health() - 2)
				else
					if ply.AWOLGiveAchievment then
						ply:AWOLGiveAchievment("STR_DIEFROMHUNGER")
					end
					ply:Kill()
					for k,v in pairs(player.GetAll()) do 
						v:SendMessage(ply:Nick().." died of famine.", 3, Color(170,0,0,255)) 
					end
				end
			end
		end
	end
         
	timer.Simple(1,GAMEMODE.SubtractNeeds)
end

timer.Simple(1,GM.SubtractNeeds)

/*---------------------------------------------------------
  Sleep
---------------------------------------------------------*/
function GM.PlayerSleep(ply,cmd,args)
	if ply.Sleeping or !ply:Alive() or ply.AFK == true then return end
	if ply.Sleepiness > 700 then
		ply:SendMessage("You're not tired enough.",3,Color(255,255,255,255))
	return end

	ply.Sleeping = true
	umsg.Start("gms_startsleep",ply)
	umsg.End()

	ply:Freeze(true)

	--Check for shelter
	local trace = {}
	trace.start = ply:GetShootPos()
	trace.endpos = trace.start + (ply:GetUp() * 300)
	trace.filter = ply

	local tr = util.TraceLine(trace)

	if !tr.HitWorld and !tr.HitNonWorld then
		ply.NeedShelter = true
	else
		ply.NeedShelter = false
	end
end

concommand.Add("gms_sleep",GM.PlayerSleep)

function GM.PlayerWake(ply,cmd,args)
	if !ply.Sleeping then return end
	ply.Sleeping = false
	umsg.Start("gms_stopsleep",ply)
	umsg.End()

	ply:Freeze(false)

	--Check for shelter
	local trace = {}
	trace.start = ply:GetShootPos()
	trace.endpos = trace.start + (ply:GetUp() * 300)
	trace.filter = ply

	local tr = util.TraceLine(trace)

	if ply.NeedShelter then
		ply:SendMessage("You should find some shelter!",5,Color(200,0,0,255))
	else
		ply:SendMessage("Ah, nothing like a good nights sleep!",5,Color(255,255,255,255))
	end
end

concommand.Add("gms_wakeup",GM.PlayerWake)

/*---------------------------------------------------------
 AFK
---------------------------------------------------------*/

function GM.AFK(ply,cmd,args)
	if ply:IsAdmin() then
		if ply.Sleeping or !ply:Alive() then return end
		if ply.InProcess then return end
		if ply.AFK == false or ply.AFK == nil then
			ply:SetNWString( "AFK", 1 )
			ply.AFK = true			
			umsg.Start("gms_startafk",ply)
			umsg.End()
		else
			ply:SetNWString( "AFK", 0 )
			ply.AFK = false			
			umsg.Start("gms_stopafk",ply)
			umsg.End()
		end

		ply:Freeze(ply.AFK)
	else
		ply:SendMessage("AFK Is disabled. Just drop your weapons.",3,Color(200,0,0,255))
	end

end

concommand.Add("gms_afk",GM.AFK)

/*---------------------------------------------------------
  Player Stuck
---------------------------------------------------------*/
function GM.PlayerStuck(ply,cmd,args)
	if ply.InProcess then return end

	if ply.Spam == true then
		ply:SendMessage("No spamming!",3,Color(200,0,0,255))
	return end

	if ply.Spam == false or ply.Spam == nil then
		ply:SendMessage("Sorry!",3,Color(200,0,0,255))
		ply:Kill()
	end
	
	ply.Spam = true
	
	timer.Simple(0.2, function() ply.Spam = false end, ply)
end

concommand.Add("gms_stuck",GM.PlayerStuck)

/*---------------------------------------------------------
  Loot-Able npcs
---------------------------------------------------------*/
GMS.LootableNPCs = 
{
	"npc_antlion",
    "npc_antlionguard",
	"npc_crow",
	"npc_seagull",
	"npc_pigeon"
}

function EntityMeta:IsLootableNPC()
	if table.HasValue(GMS.LootableNPCs,self:GetClass()) then
		return true
	end

	return false
end

function GM:OnNPCKilled( npc, killer, weapon )
	if npc:IsLootableNPC() then
		if killer:IsPlayer() then
			local loot = ents.Create("gms_loot")
			local tbl = loot:GetTable()
			local num = math.random(1,3)

			local res = {}
			if ply && CPPI then
				loot:CPPISetOwner(ply)
			end
			res["Meat"] = num
			tbl.Resources = res
			loot:SetPos(npc:GetPos() + Vector(0,0,64))
			loot:Spawn()
			timer.Simple(180, function(loot) if loot then loot:Remove() end end, loot)
			npc:Fadeout(5)
		else
			npc:Fadeout(5)			
		end
	end
end

/*---------------------------------------------------------
  Make Campfire command
---------------------------------------------------------*/
GM.CampFireProps = {}

function GM.CampFireTimer()
	if GetConVarNumber("gms_Campfire") == 1 then
		local GM = GAMEMODE

		for k,ent in pairs(GM.CampFireProps) do
			if !ent or ent == NULL then
				table.remove(GM.CampFireProps,k)
			else
				if CurTime() - ent.CampFireLifeTime >= 180 then
					ent:Fadeout()
					table.remove(GM.CampFireProps,k)
				elseif ent:WaterLevel() > 0 then
					ent:Fadeout()
					table.remove(GM.CampFireProps,k)
				else	
					ent:SetHealth(ent.CampFireMaxHP)
				end
			end
		end
		timer.Simple(1,GM.CampFireTimer)
	end
end

timer.Simple(1,GM.CampFireTimer)




/*---------------------------------------------------------
  Use Hook
---------------------------------------------------------*/
function GM:KeyPress(ply,key)
	if ply:IsPlayer() then
	local GM = GAMEMODE
	if key != IN_USE then return end
	if ply:KeyDown(1) then return end
	if ( ply:InVehicle() ) then 
        ply:ExitVehicle()
    end		
	local tr = ply:TraceFromEyes(150)
	if tr.HitNonWorld then

		if tr.Entity and !GMS.IsInWater(tr.HitPos) then
			local ent = tr.Entity
			local mdl = tr.Entity:GetModel()
			local cls = tr.Entity:GetClass()
			if cls == "spm_egg" || !ent:CPPICanUse(ply) then
				return
			end
			if (ent:IsFoodModel() or cls == "gms_food") and ((ply:GetPos()-ent:LocalToWorld(ent:OBBCenter())):Length() <= 150) then
				if cls == "gms_food" then
					ply:SendMessage("Restored "..tostring((ent.Value / 1000) * 100).."% food.",3,Color(10,200,10,255))
					ply:SetFood(ply.Hunger + ent.Value)
					ent:Fadeout(2)
					ply:Heal(ent.Value / 20)
					ply:SendMessage("Regained "..tostring(ent.Value / 20).." hp.",3,Color(255,0,0,255))
				else
					local data = {}
					data.Entity = ent
					ply:DoProcess("EatFruit",2,data)
				end
              
			elseif ent:IsTreeModel() then
				ply:DoProcess("SproutCollect",5)
               
			elseif cls == "gms_resourcedrop" and (ply:GetPos()-tr.HitPos):Length() <= 80  then
				ply:PickupResourceEntity(ent)
			elseif ent:IsOnFire() then
				if GetConVarNumber("gms_CampFire") == 1 then
					ply:OpenCombiMenu("Cooking")
				end
			end
		end
	elseif tr.HitWorld then
		for k,v in pairs(ents.FindInSphere(tr.HitPos,100)) do
			if v:IsGrainModel()  then
				local data = {}
				data.Entity = v
                  
				ply:DoProcess("HarvestGrain",3,data)
				return
			elseif v:IsBerryBushModel() then
				local data = {}
				data.Entity = v
                  
				ply:DoProcess("HarvestBush",3,data)
				return
			end
		end
        if tr then
			if (tr.MatType == MAT_DIRT or tr.MatType == MAT_GRASS or tr.MatType == MAT_SAND or tr.MatType == MAT_SNOW) and !GMS.IsInWater(tr.HitPos) then
				local time = 5
				if ply:GetActiveWeapon():GetClass() == "gms_shovel" then time = 2 end
				ply:DoProcess("Foraging",time)
			end
		end
	end
	local trace = {}
	trace.start = ply:GetShootPos()
	trace.endpos = trace.start + (ply:GetAimVector() * 150)
	trace.mask = MASK_WATER | MASK_SOLID
	trace.filter = ply

	local tr2 = util.TraceLine(trace)
	if (tr2.Hit and tr2.MatType == MAT_SLOSH and ply:WaterLevel() > 0) or ply:WaterLevel() == 3 then
		if ply.Thirst < 1000 and ply.Thirst > 950 then
			ply.Thirst = 1000
			ply:UpdateNeeds()
			if ply.Hasdrunk == false or ply.Hasdrunk == nil then
				ply:EmitSound(Sound("npc/barnacle/barnacle_gulp"..math.random(1,2)..".wav"))
				ply.Hasdrunk = true
				timer.Simple(0.2, function()	ply.Hasdrunk = false end, ply)
			end				
		elseif ply.Thirst < 950 then
			ply.Thirst = ply.Thirst + 50
			if ply.Hasdrunk == false or ply.Hasdrunk == nil then
				ply:EmitSound(Sound("npc/barnacle/barnacle_gulp"..math.random(1,2)..".wav"))
				ply.Hasdrunk = true
				timer.Simple(0.2, function()	ply.Hasdrunk = false end, ply)
			end				
			ply:UpdateNeeds()
		end
	elseif tr2.MatType == MAT_SLOSH and !tr.HitNonWorld then
		ply:DoProcess("BottleWater",3)
	end
	end
end

function PlayerMeta:PickupResourceEntity(ent)
	local int = ent.Amount
	local room = self.MaxResources - self:GetAllResources()

	if room <= 0 then
		self:SendMessage("You can't carry anymore!",3,Color(200,0,0,255))
	return end

	if room < int then
		int = room
	end

	ent.Amount = ent.Amount - int

	if ent.Amount <= 0 then
		ent:Fadeout()
	else
		ent:SetResourceDropInfo(ent.Type,ent.Amount)
	end

	self:IncResource(ent.Type,int)
	self:SendMessage("Picked up "..ent.Type.." ("..int.."x)",4,Color(10,200,10,255))
end

/*---------------------------------------------------------
  Saving/loading functions
---------------------------------------------------------*/
--Loading bar
function PlayerMeta:MakeLoadingBar(msg)
	umsg.Start("gms_MakeLoadingBar",self)
	umsg.String(msg)
	umsg.End()
end

function PlayerMeta:StopLoadingBar()
	umsg.Start("gms_StopLoadingBar",self)
	umsg.End()
end

--Saving bar
function PlayerMeta:MakeSavingBar(msg)
	umsg.Start("gms_MakeSavingBar",self)
	umsg.String(msg)
	umsg.End()
end

function PlayerMeta:StopSavingBar()
	umsg.Start("gms_StopSavingBar",self)
	umsg.End()
end

--Find pre-existing entities
function GM:FindMapSpecificEntities()
	self.MapSpecificEntities = ents.GetAll()
end
timer.Simple(3,GM.FindMapSpecificEntities,GM)

--Commands
function GM.SaveMapCommand(ply,cmd,args)
	if !ply:IsAdmin() then
		ply:SendMessage("You need admin rights for this!",3,Color(200,0,0,255))
	return end

	if !args[1] or string.Trim(args[1]) == "" then return end
	GAMEMODE:PreSaveMap(string.Trim(args[1]))
end

concommand.Add("gms_admin_savemap",GM.SaveMapCommand)

function GM.LoadMapCommand(ply,cmd,args)
	if !ply:IsAdmin() then
		ply:SendMessage("You need admin rights for this!",3,Color(200,0,0,255))
	return end

	if !args[1] or string.Trim(args[1]) == "" then return end
	GAMEMODE:PreLoadMap(string.Trim(args[1]))
end
concommand.Add("gms_admin_loadmap",GM.LoadMapCommand)

function GM.DeleteMapCommand(ply,cmd,args)
	if !ply:IsAdmin() then
		ply:SendMessage("You need admin rights for this!",3,Color(200,0,0,255))
	return end

	if !args[1] or string.Trim(args[1]) == "" then return end
	GAMEMODE:DeleteSavegame(string.Trim(args[1]))
end
concommand.Add("gms_admin_deletemap",GM.DeleteMapCommand)

--Delete map
function GM:DeleteSavegame(name)
	if !file.Exists("GMStranded/Gamesaves/"..name..".txt") then return end
         
	file.Delete("GMStranded/Gamesaves/"..name..".txt")
	if file.Exists("GMStranded/Gamesaves/"..name.."_info.txt") then file.Delete("GMStranded/Gamesaves/"..name.."_info.txt") end

	for k,ply in pairs(player.GetAll()) do
		if ply:IsAdmin() then
			umsg.Start("gms_RemoveLoadGameFromList",ply)
			umsg.String(name)
			umsg.End()
		end
	end
end

--Save map
function GM:PreSaveMap(name)
	if CurTime() < 3 then return end
	if CurTime() < self.NextSaved then return end

	for k,ply in pairs(player.GetAll()) do
		ply:MakeSavingBar("Saving game as \""..name.."\"")
	end

	self.NextSaved = CurTime() + 0.6
	timer.Simple(0.5,self.SaveMap,self,name)
end

function GM:SaveMap(name)

	local savegame = {}
	savegame["name"] = name
	savegame["entries"] = {}

	savegame_info = {}
	savegame_info["map"] = game.GetMap()
	savegame_info["date"] = os.date("%A %m/%d/%y")

	local num = 0

	for k,ent in pairs(ents.GetAll()) do
		if ent and ent != NULL and ent:IsValid() and !table.HasValue(self.MapSpecificEntities, ent) then
			if table.HasValue(GMS.SavedClasses,ent:GetClass()) then
				local entry = {}

				entry["class"] = ent:GetClass()
				entry["model"] = ent:GetModel()
				if ent:GetNetworkedString("Owner") == "World" then
				entry["owner"] = ent:GetNetworkedString("Owner")
				end
				if ent.Children != nil then
					entry["Children"] = ent.Children
				end
				if ent.PlantParent != NULL then
					entry["PlantParent"] = ent.PlantParent
				end
				if ent:GetNWEntity("plantowner") != NULL then
					entry["Plantowner"] = ent:GetNWEntity("plantowner")
				end
				
				local pos = ent:GetPos()
				local ang = ent:GetAngles()
				local colr,colg,colb,cola = ent:GetColor()

				entry["color"] = colr.." "..colg.." "..colb.." "..cola
				entry["pos"] =   pos.x.." "..pos.y.." "..pos.z
				entry["angles"] = ang.p.." "..ang.y.." "..ang.r
				entry["material"] = ent:GetMaterial() or "0"
				entry["keyvalues"] = ent:GetKeyValues()
				entry["table"] = ent:GetTable()

				local phys = ent:GetPhysicsObject()

				if phys and phys != NULL and phys:IsValid() then
					entry["freezed"] = phys:IsMoveable()
					entry["sleeping"] = phys:IsAsleep()
				end   

				if entry["class"] == "gms_resourcedrop" then
					entry["type"] = ent.Type
					entry["amount"] = ent.Amount
				end

				num = num + 1
				savegame["entries"][#savegame["entries"] + 1] = entry
			end
		end
	end

	file.Write("GMStranded/Gamesaves/"..name..".txt",util.TableToKeyValues(savegame))
	file.Write("GMStranded/Gamesaves/"..name.."_info.txt",util.TableToKeyValues(savegame_info))

	for k,ply in pairs(player.GetAll()) do
		ply:SendMessage("Saved game \""..name.."\".",3,Color(255,255,255,255))
		ply:StopSavingBar()

		if ply:IsAdmin() then
			umsg.Start("gms_AddLoadGameToList",ply)
			umsg.String(name)
			umsg.End()
		end
	end
end

--Load map
function GM:PreLoadMap(name)
	if CurTime() < 3 then return end
	if CurTime() < self.NextLoaded then return end
	if !file.Exists("GMStranded/Gamesaves/"..name..".txt") then return end

	for k,ply in pairs(player.GetAll()) do
		ply:MakeLoadingBar("Savegame \""..name.."\"")
	end

	self.NextLoaded = CurTime() + 0.6
	timer.Simple(0.5,self.LoadMap,self,name)
end

function GM:LoadMap(name)
	local savegame = util.KeyValuesToTable(file.Read("GMStranded/Gamesaves/"..name..".txt"))
	local num = table.Count(savegame["entries"])

	if num == 0 then
		Msg("This savegame is empty!\n")
	return end

	self:LoadMapEntity(savegame,num,1)
end

--Don't load it all at once
function GM:LoadMapEntity(savegame,max,k)
	local entry = savegame["entries"][tostring(k)]

	local ent = ents.Create(entry["class"])
	ent:SetModel(entry["model"])

	local pos = string.Explode(" ",entry["pos"])
	local ang = string.Explode(" ",entry["angles"])
	local col = string.Explode(" ",entry["color"])
	

	ent:SetColor(tonumber(col[1]),tonumber(col[2]),tonumber(col[3]),tonumber(col[4]))
	ent:SetPos(Vector(tonumber(pos[1]),tonumber(pos[2]),tonumber(pos[3])))
	ent:SetAngles(Angle(tonumber(ang[1]),tonumber(ang[2]),tonumber(ang[3])))
	if entry["owner"] == "World" then				
		ent:SetNetworkedString('Owner', entry["owner"])
	end
	if entry["Children"] != NULL then
		ent.Children = entry["Children"]
	end
	if entry["PlantParent"] != NULL then
		ent.PlantParent = entry["PlantParent"]
	end
	if entry["Plantowner"] != NULL then
		ent:SetNWEntity('plantowner', entry["Plantowner"]) 
	end
	if entry["material"] != "0" then ent:SetMaterial(entry["material"]) end

	for k,v in pairs(entry["keyvalues"]) do
		ent:SetKeyValue(k,v)
	end

	for k,v in pairs(entry["table"]) do
		ent[k] = v
	end
	ent:Spawn()

	if entry["class"] == "gms_resourcedrop" then
		ent.Type = entry["type"]
		ent.Amount = entry["amount"]
		ent:SetResourceDropInfo(ent.Type,ent.Amount)
	end

	local phys = ent:GetPhysicsObject()
	if phys and phys != NULL and phys:IsValid() then
		phys:EnableMotion(entry["freezed"])
		if entry["sleeping"] then phys:Sleep() else phys:Wake() end
	end

	if k >= max then
		for k,ply in pairs(player.GetAll()) do
			ply:SendMessage("Loaded game \""..savegame["name"].."\" ("..max.." entries)",3,Color(255,255,255,255))
			ply:StopLoadingBar()
		end
	else
		timer.Simple(0.05,self.LoadMapEntity,self,savegame,max,k + 1)
	end
end

/*---------------------------------------------------------
  Sprint Hook
---------------------------------------------------------*/
function GM.SprintKeyHook(ply,key)
	local GM = GAMEMODE
	if key != IN_SPEED then return end

	if ply.Upgrades["Sprint man"] == 1 then
		GM:SetPlayerSpeed(ply, 250,400)
	end
end
hook.Add("KeyPress","GMS_SprintKeyHook",GM.SprintKeyHook)

function GM.SprintKeyReleaseHook(ply,key)
	local GM = GAMEMODE
	if key != IN_SPEED then return end

	if ply.Upgrades["Sprint man"] == 1 then
		GM:SetPlayerSpeed(ply, 250,250)
	end
end
hook.Add("KeyReleased","GMS_SprintKeyReleaseHook",GM.SprintKeyReleaseHook)



OneSecTimer = 0
OneMinTimer = 0

Min = 0
Max = 180
Times = {}
Times[0] = Min
Times[1] = Min
Times[2] = Min
Times[3] = Min
Times[4] = (Max / 5)
Times[5] = ((Max / 5) * 2)
Times[6] = ((Max / 5) * 3)
Times[7] = ((Max / 5) * 4)
Times[8] = Max
Times[9] = Max
Times[10] = Max
Times[11] = Max
Times[12] = Max
Times[13] = Max
Times[14] = Max
Times[15] = Max
Times[16] = ((Max / 5) * 4)
Times[17] = ((Max / 5) * 3)
Times[18] = ((Max / 5) * 2)
Times[19] = (Max / 5)
Times[20] = Min
Times[21] = Min
Times[22] = Min
Times[23] = Min
Times[24] = Min
HasDay = 0
HasNight = 0

RandomLongTimer = 0
ServerStart = 0
function gms_Think()
	if ServerStart == 0 then
		ServerStart = 1
		RunConsoleCommand("sbox_maxnpcs","0")
	end
	if RandomLongTimer < CurTime() then
		RandomLongTimer = CurTime() + math.random(300,1200)
		NewQuest()
	end
	if OneSecTimer < CurTime() then
		OneSecTimer = CurTime() + 1
		
		Time = Time + (1/ 37.5)
		local RTime = 0
		if Time > 1 then
			RTime = math.floor(Time)
		else
			RTime = 0
		end
		if Time > 6 && Time < 18 then
			if HasDay == 0 then
				HasDay = 1
				HasNight = 0
				Temp = math.random(25 , 95)
				TempScale = math.random(.1 , 1.9)
			end
		else
			if HasNight == 0 then
				HasNight = 1
				HasDay = 0
				Temp = math.random(5 , 60)
				TempScale = math.random(.1 , 1.9)
			end
		end

		if Time > 24 then
			Time = 0
			RTime = 0
		end
		if RTime > 24 then
			RTime = 0
		end
		if Light then
			Light = Times[RTime]
		else
			Light = 1
			Light = Times[RTime]
		end

	end
end
hook.Add( "Think", "gms_Think", gms_Think )

/*---------------------------------------------------------
  Tribe: The Stranded
---------------------------------------------------------*/
function GM.Tribe1( ply )
	ply:SetTeam(1)
	ply:SendMessage("Successfully changed to Tribe: The Stranded!",5,Color(255,255,255,255))
end

concommand.Add("gms_tribe1", GM.Tribe1)
/*---------------------------------------------------------
  Tribe: Scavengers
---------------------------------------------------------*/
function GM.Tribe2( ply )
	ply:SetTeam(24)
	ply:SendMessage("Successfully changed to Tribe: Scavengers",5,Color(255,255,255,255))
end

concommand.Add("gms_tribe2", GM.Tribe2)
/*---------------------------------------------------------
  Tribe: The Dynamics
---------------------------------------------------------*/
function GM.Tribe3( ply )
	ply:SetTeam(23)
	ply:SendMessage("Successfully changed to Tribe: The Dynamics",5,Color(255,255,255,255))
end

concommand.Add("gms_tribe3", GM.Tribe3)
/*---------------------------------------------------------
  Tribe: The Gummies
---------------------------------------------------------*/
function GM.Tribe4( ply )
	ply:SetTeam(22)
	ply:SendMessage("Successfully changed to Tribe: The Gummies",5,Color(255,255,255,255))
end

concommand.Add("gms_tribe4", GM.Tribe4)
/*---------------------------------------------------------
  Tribe: Anonymous
---------------------------------------------------------*/
function GM.Tribe5( ply )
	ply:SetTeam(21)
	ply:SendMessage("Successfully changed to Tribe: Anonymous",5,Color(255,255,255,255))
end

concommand.Add("gms_tribe5", GM.Tribe5)
/*---------------------------------------------------------
  Tribe: Survivalists
---------------------------------------------------------*/
function GM.Tribe6( ply )
	ply:SetTeam(20)
	ply:SendMessage("Successfully changed to Tribe: Survivalists",5,Color(255,255,255,255))
end
concommand.Add("gms_tribe6", GM.Tribe6) 

local AlertSounds = {
"citizen_beaten1.wav",
"citizen_beaten4.wav",
"citizen_beaten5.wav",
"cough1.wav",
"cough2.wav",
"cough3.wav",
"cough4.wav"
}
/*---------------------------------------------------------
  Alert Message: Thirst
---------------------------------------------------------*/
local function AlertMessagesT( ply )
if GetConVarNumber("gms_Alerts") == 1 then
	for k, ply in pairs(player.GetAll()) do 
		if ply.Thirst < 125 and ply:Alive() then
			ply:EmitSound( Sound( AlertSounds[math.random(1,#AlertSounds)]) )
			end
		end
	end
end
timer.Create("AlertTimerT", 5, 0, AlertMessagesT)

/*---------------------------------------------------------
  Alert Message: Hunger
---------------------------------------------------------*/
local function AlertMessagesH()
if GetConVarNumber("gms_Alerts") == 1 then
	for k, ply in pairs(player.GetAll()) do 
		if ply.Hunger < 125 and ply:Alive() then
			ply:EmitSound( Sound( AlertSounds[math.random(1,#AlertSounds)]) )
			end
		end
	end
end
timer.Create("AlertTimerH", 5, 0, AlertMessagesH)

/*---------------------------------------------------------
  Alert Message: Sleepiness
---------------------------------------------------------*/
local function AlertMessagesS()
if GetConVarNumber("gms_Alerts") == 1 then
	for k, ply in pairs(player.GetAll()) do 
		if ply.Sleepiness < 125 and ply:Alive() then
			ply:EmitSound( Sound( AlertSounds[math.random(1,#AlertSounds)]) )
			end
		end
	end
end
timer.Create("AlertTimerS", 5, 0, AlertMessagesS)

/*---------------------------------------------------------
   Tribe system
---------------------------------------------------------*/
include( 'chatcommands.lua' )
function GM:PlayerSay(ply,text,public)
	if (string.find(text,"/createtribe") == 1) then
		local stuff = string.Explode("\"",text)
		if !stuff[2] or stuff[2] == "" then
			args = string.Explode(" ",text)
			if !args[5] then ply:ChatPrint("Syntax is: /createtribe \"tribename\" red green blue [password(optional)]") return "" end
		else
			args1 = string.Explode(" ",stuff[1])
			args2 = string.Explode(" ",stuff[3])
			if !args2[3] then ply:ChatPrint("Syntax is: /createtribe \"tribename\" red green blue [password(optional)]") return "" end
		end
		if stuff[2] and stuff[2] != "" then
			name = stuff[2]
			for i=2,4 do
				if !args2[i] or !tonumber(args2[i]) then ply:ChatPrint("Syntax is: /createtribe \"tribename\" red green blue [password(optional)]") return "" end
			end
		else
			name = args[2]
			for i=3,5 do
				if !args[i] or !tonumber(args[i]) then ply:ChatPrint("Syntax is: /createtribe \"tribename\" red green blue [password(optional)]") return "" end
			end
		end
		if stuff[2] and stuff[2] != "" then
			red = math.Clamp(tonumber(args2[2]),0,255)
			green = math.Clamp(tonumber(args2[3]),0,255)
			blue = math.Clamp(tonumber(args2[4]),0,255)
		else
			red = math.Clamp(tonumber(args[3]),0,255)
			green = math.Clamp(tonumber(args[4]),0,255)
			blue = math.Clamp(tonumber(args[5]),0,255)
		end
		local Password = false
		if stuff[2] and stuff[2] != "" then
			if args2[5] and args2[5] != "" then
				Password = args2[5]
			end
		else
			if args[6] and args[6] != "" then
				Password = args[6]
			end
		end
		
		GAMEMODE.NumTribes = GAMEMODE.NumTribes + 1
		GAMEMODE.Tribes[name] = {
		id = GAMEMODE.NumTribes,
		red = red,
		green = green,
		blue = blue,
		Password = Password
		}
		local rp = RecipientFilter()
		rp:AddAllPlayers()
		umsg.Start("newTribe",rp)
			umsg.String(name)
			umsg.Short(GAMEMODE.NumTribes)
			umsg.Short(red)
			umsg.Short(green)
			umsg.Short(blue)
		umsg.End()
		
		team.SetUp(GAMEMODE.NumTribes,tostring(name),Color(red,green,blue,255))
		ply:SetTeam(GAMEMODE.NumTribes)
		ply:SendMessage("Successfully Created A Tribe",5,Color(255,255,255,255))
		return ""
	elseif (string.find(text,"/join") == 1) then
		local join = string.Explode("\"",text)
		if join[2] and join[2] != "" then
			args = string.Explode(" ",join[3])
			jname = join[2]
			pw = args[2]
		else
			args = string.Explode(" ",text)
			jname = args[2]
			pw = args[3]
		end
		if !jname  then ply:ChatPrint("Syntax is: /jointribe \"tribename\" [password(if needed)]") return "" end
		for i,v in pairs(GAMEMODE.Tribes) do
			if string.lower(i) == string.lower(jname) then
				if v.Password and v.Password != pw then ply:PrintMessage(3,"Incorrect Tribal Password") return "" end
				ply:SetTeam(v.id)
				ply:SendMessage("Successfully Joined The Tribe",5,Color(255,255,255,255))
				return ""
			end
		end
		return ""
	elseif (string.find(text,"/leavetribe") == 1) then
				ply:SetTeam(1)
				ply:SendMessage("Successfully Left The Tribe",5,Color(255,255,255,255))
		return ""
	end
	
	local args = string.Explode(" ",text)
		if args == nil then args = {} end
	if public then
		return GMS.RunChatCmd( ply, unpack(args) ) or text
	else
		if GMS.RunChatCmd( ply, unpack(args) ) != "" then
			for k,v in pairs(player.GetAll()) do
				if v and v:IsValid() and v:IsPlayer() and v:Team() == ply:Team() then
					v:PrintMessage(3, "<TRIBE>" .. ply:Nick() .. ": " .. text)
				end
			end
		end
		return ""
	end
end

function GM.SendTribes(ply)
for i,v in pairs(GAMEMODE.Tribes) do
	umsg.Start("recvTribes",ply)
	umsg.Short(v.id)
	umsg.String(i)
	umsg.Short(v.red)
	umsg.Short(v.green)
	umsg.Short(v.blue)
	umsg.End()
	end
end
hook.Add("PlayerInitialSpawn","getTribes",GM.SendTribes)

function CreateTribe( ply, name, red, green, blue, password )
	
	local Password = false
	
	if password and password != "" then
		Password = password
	end
		
	GAMEMODE.NumTribes = GAMEMODE.NumTribes + 1
	GAMEMODE.Tribes[name] = {
	id = GAMEMODE.NumTribes,
	red = red,
	green = green,
	blue = blue,
	Password = Password
	}
	local rp = RecipientFilter()
	rp:AddAllPlayers()
	umsg.Start("newTribe",rp)
		umsg.String(name)
		umsg.Short(GAMEMODE.NumTribes)
		umsg.Short(red)
		umsg.Short(green)
		umsg.Short(blue)
	umsg.End()
	
	team.SetUp(GAMEMODE.NumTribes,tostring(name),Color(red,green,blue,255))
	ply:SetTeam(GAMEMODE.NumTribes)
	ply:SendMessage("Successfully Created A Tribe",5,Color(255,255,255,255))
end

function CreateTribeCmd( ply, cmd, args, argv )
	if !args[4] or args[4] == "" then
		ply:ChatPrint("Syntax is: gms_createtribe \"tribename\" red green blue [password(optional)]") return 
	end
	if args[5] and args[5] != "" then
		CreateTribe( ply, args[1], args[2], args[3], args[4], args[5] )
	else
		CreateTribe( ply, args[1], args[2], args[3], args[4], "" )
	end
end
concommand.Add( "gms_createtribe", CreateTribeCmd )

function joinTribe( ply, cmd, args )
	local pw = ""
	if !args[1] or args[1] == "" then
		ply:ChatPrint("Syntax is: gms_join \"tribename\" [password(if needed)]") return 
	end
	if args[2] and args[2] != "" then
		pw = args[2]
	end
	for i,v in pairs(GAMEMODE.Tribes) do
		if string.lower(i) == string.lower(args[1]) then
			if v.Password and v.Password != pw then ply:PrintMessage(3,"Incorrect Tribal Password") return end
			ply:SetTeam(v.id)
			ply:SendMessage("Successfully Joined The Tribe",5,Color(255,255,255,255))
		end
	end
end
concommand.Add( "gms_join", joinTribe )

function leaveTribe( ply, cmd, args )
	ply:SetTeam(1)
	ply:SendMessage("Successfully Left The Tribe",5,Color(255,255,255,255))
end
concommand.Add( "gms_leave", leaveTribe )

/*---------------------------------------------------------
   Resource Box Touch
---------------------------------------------------------*/

function OwnProp(ply,cmd,args)
	ply:ConCommand("ppro_ownprop")
end
concommand.Add("gms_own", OwnProp)

/*---------------------------------------------------------
   Resource Box Buildsite Touch
---------------------------------------------------------*/
function gms_addbuildsiteresource( ent, ent2 ) --where the fuck is this referenced?

	local ent_owner = ent:GetNetworkedString("Owner")
	local ent2_owner = ent2:GetNetworkedString("Owner")
	local ply = player.GetByID(ent:GetNetworkedString("Ownerid"))
	
	local ply = ent:CPPIGetOwner()
	local ply2 = ent2:CPPIGetOwner()

	if ply && ply2 and ent:IsPlayerHolding() then
			if ent.Amount > ent2.Costs[ent.Type] then	
				ent.Amount = ent.Amount - ent2.Costs[ent.Type]
				ent:SetResourceDropInfo(ent.Type,ent.Amount)
				ent2.Costs[ent.Type] = nil
			elseif ent.Amount <= ent2.Costs[ent.Type] then
				ent2.Costs[ent.Type] = ent2.Costs[ent.Type] - ent.Amount
				ent:Remove() 
			end
			for k,v in pairs(ent2.Costs) do
				if ent2.Costs[ent.Type] then
					if ent2.Costs[ent.Type] <= 0 then
						ent2.Costs[ent.Type] = nil
					end
				end				
			end 
			if table.Count(ent2.Costs) > 0 then
				local str = "You need: "
				for k,v in pairs(ent2.Costs) do
					str = str..k.." ("..v.."x)  "
				end

				str = str.." to finish."
				ply:SendMessage(str,5,Color(255,255,255,255))
			else
				ply:SendMessage("Finished!",3,Color(10,200,10,255))
				ent2:Finish()            
			end
			
			local str = ":"
			for k,v in pairs(ent2.Costs) do
				str = str.." "..k.." ("..v.."x)"
			end
			ent2:SetNetworkedString('Resources', str)
	end
end	


/*---------------------------------------------------------
   All Smelt Function
---------------------------------------------------------*/
function PlayerMeta:AllSmelt(ResourceTable)
local resourcedata = {}
resourcedata.Req = {}
resourcedata.Results = {}
local AmountReq = 0
	for k,v in pairs(ResourceTable.Req) do
		if self:GetResource(k) > 0 then
			if self:GetResource(k) <= ResourceTable.Max then
				resourcedata.Req[k] = self:GetResource(k)
				AmountReq = AmountReq + self:GetResource(k)				
			else
				resourcedata.Req[k] = ResourceTable.Max
				AmountReq = AmountReq + ResourceTable.Max
				self:SendMessage("You can only do " .. tostring(ResourceTable.Max) .. " " .. k .. " at a time.",3,Color(200,0,0,255))
			end
		else
			resourcedata.Req[k] = 1
		end
	end
	for k,v in pairs(ResourceTable.Results) do
		resourcedata.Results[k] = AmountReq
	end
	return resourcedata
end

/*---------------------------------------------------------
   Admin Message
---------------------------------------------------------*/
function adminMsg( loc, text )
	for k,v in pairs(player.GetAll()) do
		if v:IsAdmin() then
			v:PrintMessage(loc, text)
		end
	end	
end

//Biths stuff
function AGms_ResetDrink(ply)
	ply.HasDrunk = false
end

concommand.Add("aGMS_ResetDrink",AGms_ResetDrink)

SkillList = {"Cooking","Lumbering","Mining","Harvesting","Planting","Weapon_Crafting","Fishing","Smithing","Construction"}

function AddSkills(ply,cmd,args)
	if ply:IsAdmin() then
		local Skill = args[2]
		local Amount = args[3]
		local ply2 = string.lower(args[1])
		if table.HasValue(SkillList,Skill) then
			for k,v in pairs (player.GetAll()) do
				if string.find(string.lower(v:Nick()),ply2) then
					v:IncXP(Skill,Amount)
				end
			end
		end
	end
end

concommand.Add ("gms_AGiveSkills",AddSkills)

function PlayerEffectFunc(ply, height, Effect)
	pos = ply:GetShootPos()
	for k,v in pairs (player.GetAll()) do
		SendEffectsFunc (v,pos,Height,Effect)
	end
end

function EffectFunc(pos, height, Effect)
	for k,v in pairs (player.GetAll()) do
		SendEffectsFunc (v,pos,Height,Effect)
	end
end

local PlayerMeta = FindMetaTable("Player")

function SendEffectsFunc(ply,pos,Height,Effect)
	if ply:IsPlayer() then
		umsg.Start("EffectsFunc", ply)
					umsg.String(Effect)
					umsg.Vector(pos)
					umsg.Long(Height)
		umsg.End()
	end
end

function PlayerMeta:SetCacheResource(Resa,Amounta)

	local ply = self
	local trace = {}
		trace.start = ply:GetShootPos()
		trace.endpos = trace.start + (ply:GetAimVector() * 150)
		trace.filter = ply
		
		local tr = util.TraceLine(trace)
		if !tr.HitNonWorld then return end
		if !tr.Entity then return end
		
		if tr.Entity:GetClass() == "gms_storagecache" then
			
			local Res = Resa
			local Amount = Amounta
			Amount = math.floor(Amount)
			if Amount < 1 then
				Amount = 0
			end
			local nearby = false
			local ent = tr.Entity
			nearby = true
			
			//Need Nearby Thing				
				entity = ent
			
			
			if nearby == true && entity != ply then
					if entity.Resource[Res] then
							if ply:GetResource(Res) >= Amount then
								ply:DecResource(Res,Amount)
								entity.Resource[Res] = entity.Resource[Res] + Amount
								ply:SendMessage("Placed  "..Res.." in cache. ("..Amount..")", 3, Color(10,200,10,255))
							else
								Amount = ply:GetResource(Res)
								ply:DecResource(Res,Amount)
								entity.Resource[Res] = entity.Resource[Res] + Amount
								ply:SendMessage("Placed  "..Res.." in cache. ("..Amount..")", 3, Color(10,200,10,255))
							end
					else
						if ply:GetResource(Res) >= Amount then
							ply:DecResource(Res,Amount)
							entity.Resource[Res] = Amount
							ply:SendMessage("Placed  "..Res.." in cache. ("..Amount..")", 3, Color(10,200,10,255))
						else
							Amount = ply:GetResource(Res)
							ply:DecResource(Res,Amount)
							entity.Resource[Res] = Amount
							ply:SendMessage("Placed  "..Res.." in cache. ("..Amount..")", 3, Color(10,200,10,255))
						end
					end
			else
				ply:SendMessage("Must be closer to a cache.", 3, Color(10,200,10,255))	
			end
		else
			ply:SendMessage("Must be looking at a  cache.", 3, Color(10,200,10,255))	
		end
end


function Cache(ply,cmd,args)
	if args[1] && args[2] && args[3] then
		local Res = args[2]
		local Amount = args[3]
		
		if args[1] == "Get" then
			ply:GetCacheResource(Res,Amount)
		elseif args[1] == "Set" then
			ply:SetCacheResource(Res,Amount)
		end
	end
	
end

concommand.Add("gms_Cache",Cache)

function EatBerries (ply)
	if ply:GetResource("Berries") > 4 then
		ply:DoProcess("EatBerries",1)
	end
end

concommand.Add("gms_EatBerries",EatBerries)

function PlayerMeta:GetCacheResource(Resa,Amounta)
	local ply = self
	local trace = {}
		trace.start = ply:GetShootPos()
		trace.endpos = trace.start + (ply:GetAimVector() * 150)
		trace.filter = ply
		
		local tr = util.TraceLine(trace)
		if !tr.HitNonWorld then return end
		if !tr.Entity then return end
		
		if tr.Entity:GetClass() == "gms_storagecache" then
			local ent = tr.Entity
			if ent:CPPICanUse(ply) then
				local Res = Resa
				local Amount = Amounta
				Amount = math.floor(Amount)
				if Amount < 1 then
					Amount = 0
				end
				local nearby = false
				if !ent:CPPICanUse(ply) then 
					ply:SendMessage("You can't steal other peoples stuff.", 3, Color(10,200,10,255))
				return
				end
				nearby = true
				
				//Need Nearby Thing
					
					entity = ent
				
				if nearby == true && entity != ply then
						if entity.Resource[Res] then
							if entity.Resource[Res] >= Amount then
								ply:IncResource(Res,Amount)
								ply:SendMessage("Retrieved Resource "..Res.." ("..Amount..")", 3, Color(10,200,10,255))
								entity.Resource[Res] = entity.Resource[Res] - Amount
							else
								ply:IncResource(Res,entity.Resource[Res])
								ply:SendMessage("Retrieved Resource "..Res.." ("..entity.Resource[Res]..")", 3, Color(10,200,10,255))
								entity.Resource[Res] = entity.Resource[Res] - entity.Resource[Res]
							end
						else
							ply:SendMessage("Not enough resources in cache.", 3, Color(10,200,10,255))	
						end
				else
					ply:SendMessage("Must be closer to a cache.", 3, Color(10,200,10,255))	
				end
			end
		else
			ply:SendMessage("Must be looking at a  cache.", 3, Color(10,200,10,255))	
		end
end

function SendCacheInfo(ply)
	local trace = ply:GetEyeTrace()

		if trace.HitPos:Distance(ply:GetShootPos()) < 300 then

			if trace.Entity then
				if trace.Entity:GetClass() == "gms_storagecache" then

					local ent = trace.Entity
					
					umsg.Start("gms_ResetCacheData",ply)
							umsg.String("RESET")
					umsg.End()
					
					for k,v in pairs (ent.Resource) do
						umsg.Start("gms_ResourceCache",ply)
							umsg.String(k)
							umsg.Long(v)
						umsg.End()
					end					
				else
					ply:SendMessage("Must be looking at a  cache.", 3, Color(10,200,10,255))
				end
			else
				ply:SendMessage("Must be looking at a  cache.", 3, Color(10,200,10,255))
			end
		else
			ply:SendMessage("Must be looking at a  cache.", 3, Color(10,200,10,255))
		end
end
concommand.Add("gms_GetCacheInfo",SendCacheInfo)

--Teleportingsystem
function SendTeleInfo(ply,tele,telename,teleowner,ctele,ctelename)
	umsg.Start("gms_PrepareTele",ply)
		umsg.Short(table.Count(tele))
	umsg.End()
	for k,v in pairs(tele) do 
		umsg.Start("gms_SendTeleData",ply)
			umsg.Long(tele[k]:EntIndex())
			umsg.String(telename[k])
			umsg.String(teleowner[k])
		umsg.End()
	end
	umsg.Start("gms_OpenTele",ply)
		umsg.Long(ctele:EntIndex())
		umsg.String(ctelename)
	umsg.End()
end

function Hiddencommands(ply,cmd,args)
	if args[1] == "tele" && args[2] then
		local  id = args[2]
		TeleportPlayer(ply,id)
	end
end
concommand.Add("gms_hidden",Hiddencommands)

function TeleportPlayer(ply,teleid)
	if ply:Alive() then
		local ent = Entity(teleid)
		if ent then
			if ent:GetClass() == "gms_teleporter" then
				if ent:CPPICanUse(ply) || ent.Public == 1 then
					local pos = ent:GetPos()
					pos = pos + Vector(0,0,50)
					PlayerEffectFunc(ply,0,"GMS_TeleportEffect")
					ply:SetPos(pos)
					PlayerEffectFunc(ply,0,"GMS_TeleportEffect")
				else
					ply:SendMessage("Unable to teleport.",3,Color(200,0,0,255))
				end
			else
				print("UNABLE TO TELEPORT, NOT CORRECT ENTITY")
			end
		else
			print("UNABLE TO TELEPORT, NOT CORRECT ENTITY")
		end
	else
		ply:SendMessage("Unable to teleport.",3,Color(200,0,0,255))
	end
end

function NameTele(ply,cmd,args)
	local id = args[1]
	local name = args[2]
	if id && name then
		local ent = Entity(id)
		if ent then
			if ent:CPPICanUse(ply) then
				ent.TeleName = name
				ply:SendMessage("Teleporter renamed.",3,Color(200,0,0,255))
			else
				ply:SendMessage("Not your teleporter so stay away.",3,Color(200,0,0,255))
			end
		end
	end
end
concommand.Add("gms_nametele",NameTele)

function TogglePublic(ply,cmd,args)
	local id = args[1]
	if id  then
		local ent = Entity(id)
		if ent then
			if ent:CPPICanUse(ply) then
				if ent.Public == 1 then
					ent.Public = 0
					ply:SendMessage("Teleporter is no longer public.",3,Color(200,0,0,255))
				else
					ent.Public = 1
					ply:SendMessage("Teleporter is public.",3,Color(200,0,0,255))
				end
			else
				ply:SendMessage("Not your teleporter so stay away.",3,Color(200,0,0,255))
			end
		end
	end
end
concommand.Add("gms_tglpubtele",TogglePublic)

function PlyPrint(ply,msg)
	umsg.Start("PlayerConPrint",ply)
		umsg.String(msg)
	umsg.End()
end

function Stof(ply)
	for k,v in pairs(player.GetAll()) do
		PlyPrint(ply,"-----------------")
		PlyPrint(ply,"Name: "..v:Nick())
		PlyPrint(ply,"Id: "..v:UniqueID())
	end
end

concommand.Add("gms_getdata",Stof)

function OpenCloneMenu(ply,ent)
	SendUpgradeData(ply,ent)
	umsg.Start("gms_PrepareCloneMenu",ply)
		umsg.Short(ent.MaxCapacity)
		umsg.String(ent.Res)
		umsg.Short(ent.CurrentCapacity)
		umsg.Short(ent.TimeLapse)
		umsg.Short(ent.Rate)
		umsg.Short(ent.Fuel)
		umsg.Short(ent.FuelRate)
		umsg.Short(ent.MaxFuel)
		umsg.Short(ent:EntIndex())
	umsg.End()
end

function SendUpgradeData(ply,ent)
	if ValidEntity(ent) && ent:GetClass() == "gms_clonemachine" then
		umsg.Start("gms_Clone_SendUpgradeData",ply)
			umsg.Short(ent.Upgrades["MaxCapacity"])
			umsg.Short(ent.Upgrades["CurrentCapacity"])
			umsg.Short(ent.Upgrades["TimeLapse"])
			umsg.Short(ent.Upgrades["Rate"])
			umsg.Short(ent.Upgrades["FuelRate"])
			umsg.Short(ent.Upgrades["MaxFuel"])
		umsg.End()
	end
end
function Clone_UpdateEnt(ply,ent)
	if ValidEntity(ent) then
		local Clone = GMS_CloneUpgrades
			local skill = "MaxCapacity"
			local value =  Clone[skill][ent.Upgrades[skill]]["Value"]
			ent.MaxCapacity = value
			
			skill = "TimeLapse"
			value =  Clone[skill][ent.Upgrades[skill]]["Value"]
			ent.TimeLapse = value
			
			skill = "Rate"
			value =  Clone[skill][ent.Upgrades[skill]]["Value"]
			ent.Rate = value
			
			skill = "FuelRate"
			value =  Clone[skill][ent.Upgrades[skill]]["Value"]
			ent.FuelRate = value
			
			skill = "MaxFuel"
			value =  Clone[skill][ent.Upgrades[skill]]["Value"]
			ent.MaxFuel = value
			
		SendUpgradeData(ply,ent)
	end
end

function Clone_ChangeResource(ply,cmd,args)
	if args[1] && args[2] then
		local ent = args[1]
		local res = args[2]
		local Enabled = 0
		for k,v in pairs(GMS_Uncloneable) do 
			if (v == res) || (k == res) then
				Enabled = 1
			end
		end
		if Enabled == 0 then
			if ValidEntity(Entity(ent)) then
				if Entity(ent):CPPICanUse(ply) then
					if res == "NA" then
						ply:SendMessage("You have taken cloneing resource out. It will no longer clone.",5,Color(200,0,0,255))
						Entity(ent).Res = res
						Entity(ent).CurrentCapacity = 0
					else
						if ply.Resources[res] then
							if ply.Resources[res] >= 5  then
								ply:DecResource(res,5)
								ply:SendMessage("Resource change to "..res,3,Color(200,0,0,255))
								Entity(ent).Res = res
								Entity(ent).CurrentCapacity = 0
								Entity(ent).Timer = CurTime() + Entity(ent).TimeLapse
							else
								ply:SendMessage("You need atleast 5 "..res.. " to do this",3,Color(200,0,0,255))
							end
						else
							ply:SendMessage("You need atleast 5 "..res.. " to do this",3,Color(200,0,0,255))
						end
					end
				else
					ply:SendMessage("You can't touch this.",3,Color(200,0,0,255))
				end
			else
				ply:SendMessage("Not valid entity consider talking to admin.",3,Color(200,0,0,255))
			end
		else
			ply:SendMessage("The cloneing machine can't clone this resource.",3,Color(200,0,0,255))
		end
	else
		ply:SendMessage("Not valid entity consider talking to admin.",3,Color(200,0,0,255))
	end
end
concommand.Add("gms_Clone_ChangeResource",Clone_ChangeResource)

function Clone_Empty(ply,cmd,args)
	if args[1] then
		local ent = Entity(args[1])
		if ValidEntity(ent) then
			if ent:CPPICanUse(ply) then
				if ent.CurrentCapacity > 0 then
					DropRes(ent.Res,ent.CurrentCapacity,ent)
					ent.Timer = CurTime() + ent.TimeLapse
					ply:SendMessage("Tou have emptied "..ent.CurrentCapacity.." "..ent.Res..".",3,Color(200,0,0,255))
					ent.CurrentCapacity = 0
				else
					ply:SendMessage("There are no resources in the clone machine.",3,Color(200,0,0,255))
				end
			else
				ply:SendMessage("You can't touch this.",3,Color(200,0,0,255))
			end
		else
			ply:SendMessage("Not valid entity consider talking to admin.",3,Color(200,0,0,255))
		end
	end
end
concommand.Add("gms_Clone_Empty",Clone_Empty)

function Clone_Refuel(ply,cmd,args)
	if args[1] then
		local ent = Entity(args[1])
		if ValidEntity(ent) then
			if ent:CPPICanUse(ply) then
				local amount = (ent.MaxFuel - ent.Fuel)
				if ply.Resources["Coal"] >= amount then
					ply:DecResource("Coal",amount)
					ent.Fuel = ent.MaxFuel
					ply:SendMessage("You have refilled the tank.",3,Color(200,0,0,255))
				elseif ply.Resources["Coal"] > ply.Resources["Coal"] then
					ply:DecResource("Coal",ply.Resources["Coal"])
					ent.Fuel = ent.Fuel + ply.Resources["Coal"]
					ply:SendMessage("You have partially filled the tank.",3,Color(200,0,0,255))
				else
					ply:SendMessage("You don't have any coal to refill the tank.",3,Color(200,0,0,255))
				end
			else
				ply:SendMessage("You can't touch this.",3,Color(200,0,0,255))
			end
		else
			ply:SendMessage("Not valid entity consider talking to admin.",3,Color(200,0,0,255))
		end
	end
end
concommand.Add("gms_Clone_Refuel",Clone_Refuel)

function Clone_Upgrade(ply,cmd,args)
	if args[1] && args[2] then
		local ent = Entity(args[1])
		local skill = args[2]
		if ValidEntity(ent) then
			if ent:CPPICanUse(ply) then
				if GMS_CloneUpgrades[skill] then
					local c = GMS_CloneUpgrades[skill]
					local cost = c[ent.Upgrades[skill]]["Cost"]
					local res = c[ent.Upgrades[skill]]["Res"]
					local value =  c[ent.Upgrades[skill]]["Value"]
					if ent.Upgrades[skill] < 5 then
						if ply.Resources[res] then
							if ply.Resources[res] >= cost then
								ply:DecResource(res,cost)
								ent.Upgrades[skill] = ent.Upgrades[skill] + 1
								Clone_UpdateEnt(ply,ent)
								ply:SendMessage(skill .." has been upgraded.",3,Color(200,0,0,255))
								ply:SendMessage("Cloning timer restarted..",3,Color(200,0,0,255))
								ent.Timer = ent.TimeLapse
							else
								ply:SendMessage("You don't have the required resource.",3,Color(200,0,0,255))
							end
						else
							ply:SendMessage("You don't have the required resource.",3,Color(200,0,0,255))
						end
					else
						ply:SendMessage("It is already upgraded to the max.",3,Color(200,0,0,255))
					end
				else
					ply:SendMessage("Not valid skill consider talking to admin.",3,Color(200,0,0,255))
				end
			else
				ply:SendMessage("You can't touch this.",3,Color(200,0,0,255))
			end
		else
			ply:SendMessage("Not valid entity consider talking to admin.",3,Color(200,0,0,255))
		end
	end
end

concommand.Add("gms_Clone_Upgrade",Clone_Upgrade)

QuestStats = {}
QuestStats["Start"] = "NA"
QuestStats["Middle"] = "NA"
QuestStats["Finish"] = "NA"
QuestStats["Amount"] = 0
QuestStats["Resource"] = "NA"
QuestStats["Quest"] = "NA"
QuestStats["Skill"] = "NA"
function NewQuest()
	local start = table.Random(GMS_QuestStarts)
	local middle = table.Random(GMS_QuestMiddle)
	local finish = table.Random(GMS_QuestEnd)
	local amount = math.random(1,50)
	local res = table.Random(GMS_QuestRes)
	local skill = table.Random(GMS_QuestSkills)
	local quest = "Help me, my "..start.. " has "..middle.." and needs "..amount.." " .. res.. " to " ..finish .."."
	QuestStats = {}
	QuestStats["Start"] = start
	QuestStats["Middle"] = middle
	QuestStats["Finish"] = finish
	QuestStats["Amount"] = amount
	QuestStats["Resource"] = res
	QuestStats["Quest"] = quest
	QuestStats["Skill"] = skill
	
	
	for k,v in pairs(player.GetAll()) do 
		v:SendMessage("A new quest is a available. Use the 'Quick Menu (F3)' then 'Menus','Quest'; or type gms_openquest to see the quest.",10,Color(255,255,0,255))
		v.QuestComplete = 0
		v.QuestAccept = 0
	end
	SendAllQuestInfo()
end

function NewQuestCommand(ply)
	if ply:IsAdmin() then 
		NewQuest()
	end
end
concommand.Add("gms_aNewQuest",NewQuestCommand)

function AcceptQuest(ply)
	if ply.QuestAccept == 0 then
		ply.QuestAccept = 1
		ply:SendMessage("Wow, Thanks! i just hope my "..QuestStats["Start"].." will be able to "..QuestStats["Finish"]..".",10,Color(255,255,0,255))
		SendQuestInfo(ply)
	else
		ply:SendMessage("I have already asked you to do something for me.",10,Color(255,255,0,255))
	end
end

concommand.Add("gms_AcceptQuest",AcceptQuest)


function CompleteQuest(ply)
	if ply.QuestComplete == 0 then
		if ply.QuestAccept == 1 then
			if ply.Resources[QuestStats["Resource"]] then
				if ply.Resources[QuestStats["Resource"]] >= QuestStats["Amount"] then
					ply:DecResource(QuestStats["Resource"],QuestStats["Amount"])
					ply:IncXP(QuestStats["Skill"],100)
					ply:SendMessage("Wow thanks, now my "..QuestStats["Start"].." will be able to "..QuestStats["Finish"].." now." ,10,Color(255,255,0,255))
					ply.QuestComplete = 1
					ply.QuestAccept = 0
					SendQuestInfo(ply)
				else
					ply:SendMessage("Ummm maybe you didn't listen to me. I need "..QuestStats["Amount"].." " .. QuestStats["Resource"]..".",10,Color(255,255,0,255))
				end
			else
				ply:SendMessage("Ummm maybe you didn't listen to me. I need "..QuestStats["Amount"].." " .. QuestStats["Resource"]..".",10,Color(255,255,0,255))
			end
		else	
			ply:SendMessage("Wait a minute i havn't even asked you to do anything for me yet.",10,Color(255,255,0,255))
		end
	else
		ply:SendMessage("Wait a minute you have already completed this quest.",10,Color(255,255,0,255))
	end
end
concommand.Add("gms_CompleteQuest",CompleteQuest)

function SendQuestInfo(ply)
	umsg.Start("QuestInfo",ply)
		umsg.String(QuestStats["Quest"])
		umsg.String(QuestStats["Resource"])
		umsg.Short(QuestStats["Amount"])
		umsg.Short(ply.QuestComplete)
		umsg.Short(ply.QuestAccept)
	umsg.End()
end

function SendAllQuestInfo()
	for k,v in pairs(player.GetAll()) do 
		SendQuestInfo(v)
	end
end

function MakePlayerTrusted(ply,cmd,args)
	if ply:IsAdmin() then
		local name = args[1]
		for k,v in pairs (player.GetAll()) do
			if string.find(string.lower(v:Nick()),string.lower(name)) then
				if !(v.Trusted) then
					v.Trusted = 0
				end
				if v.Trusted == 0 then
					v.Trusted = 1
					ply:SendMessage("Trusted given to "..v:Nick(),10,Color(255,255,0,255))
					v:SendMessage("You have recieved trusted from "..ply:Nick().. " don't abuse it!",10,Color(255,255,0,255))
				else
					v.Trusted = 0
					ply:SendMessage("Trusted removed from "..v:Nick(),10,Color(255,255,0,255))
					v:SendMessage("You have recieved trusted from "..ply:Nick().. " don't abuse it!",10,Color(255,255,0,255))
				end
			else
				print("No player")
			end
		end
		SaveTrusted(ply)
	end
end
concommand.Add("trusted_amaketrusted",MakePlayerTrusted)

function gmskick(ply,cmd,args)
	if ply:IsAdmin() || ply.Trusted == 1 then
		local name = args[1]
		for k,v in pairs (player.GetAll()) do
			if string.find(string.lower(v:Nick()),string.lower(name)) then
				if !v.Trusted then
					v.Trusted = 0
				end
				if v.Trusted == 1 || ply:IsAdmin() then
					ply:SendMessage("Can't kick admin or trusted!",10,Color(255,255,0,255))
				else
					ply:SendMessage("Player Kicked",10,Color(255,255,0,255))
					v:Kick("LOLOL")
				end
			else
				print("No player")
			end
		end
	end
end
concommand.Add("trusted_kick",gmskick)

function SaveTrusted(ply)
	if ply.Trusted == nil then
		local num = tonumber((BithLoad("GMStranded/Saves/"..ply:UniqueID().."/Trusted.txt") or 0 ))
		ply.Trusted = num
	end
	if ply:IsAdmin() then
		ply.Trusted = 1
	end
	BithSave("GMStranded/Saves/"..ply:UniqueID().."/Trusted.txt",ply.Trusted)
end

concommand.Add("trusted_loadme",SaveTrusted)

function GM:PlayerNoClip( ply )
	if ply:IsAdmin() || ply.Trusted == 1 then
		return true
	else
		return false
	end
end


function gms_noclip(ply)
	if ply:IsAdmin() || ply.Trusted == 1 then
		if ply:GetMoveType()==MOVETYPE_FLY then
			ply:SetMoveType(MOVETYPE_WALK)
		else
			ply:SetMoveType(MOVETYPE_FLY)
		end
	end
end
concommand.Add("gms_noclip",gms_noclip)

function ToggleDestroyableProps(ply)
	if ply.Destruct then
		if ply.Destruct == 1 then
			ply.Destruct = 0
			ply:SendMessage("Prop damage is now off.",10,Color(255,255,0,255))
		else
			ply.Destruct = 1
			ply:SendMessage("Prop damage is now on.",10,Color(255,255,0,255))
		end
	else
		ply.Destruct = 0
		ply:SendMessage("Prop damage is now off.",10,Color(255,255,0,255))
	end
end
concommand.Add("gms_propdamage",ToggleDestroyableProps)
AIOn = 0
function ToggleAi(ply)
	if ply:IsAdmin() || ply.Trusted == 1 then
		if AIOn == 1 then
			AIOn = 0
			RunConsoleCommand("ai_ignoreplayers",1)
			ply:SendMessage("AI IS NOW OFF.",10,Color(255,255,0,255))
		else
			AIOn = 1
			RunConsoleCommand("ai_ignoreplayers",0)
			ply:SendMessage("AI IS NOW ON.",10,Color(255,255,0,255))
		end
	else
		ply:SendMessage("Hey you can't use this command.",10,Color(255,255,0,255))
	end
end

concommand.Add("gms_admin_toggleai",ToggleAi)

function GM:EntityTakeDamage( ent, infl, ent2, amo, dmg )
	if ent:IsPlayer() && !dmg:IsFallDamage() then
		if ent2:IsPlayer() then
			if ent2.PVP == 0 || ent.PVP == 0 then
				dmg:ScaleDamage( 0.5 )
			else
				dmg:ScaleDamage( 0.5 )
			end
		else
			dmg:ScaleDamage( 0.5 )
		end
	elseif !dmg:IsFallDamage() then
		dmg:ScaleDamage( 2)
	end
	if ent:IsNPC() then
		dmg:ScaleDamage( .25)
	end
	if ValidEntity(ent) and !ent:IsPlayer() and ent.Destroyable then
		local owner = ent:CPPIGetOwner()
		if ent2:IsPlayer() and ent.Destroyable == 1 and owner then
			if owner.Destruct then
			
			else
				owner.Destruct = 1
			end
			owner.Destruct = 1
			if owner.Destruct == 1 then
				if ent.RPHealth then
					ent.RPHealth = ent.RPHealth - amo
				else
					local hp = 0
					local phys = ent:GetPhysicsObject()
					if phys then
						hp = phys:GetMass()
						if hp < 50 then
							hp = 50
						end
					else
						hp = 100
					end
					ent.RPMaxHealth = hp
					ent.RPHealth = hp - amo
				end
				local per = ent.RPHealth / ent.RPMaxHealth
				ent:SetColor((per * 200) + 55, (per * 200) + 55, (per * 200) + 55,255)
				if ent.RPHealth <= 0 then
					ent:Remove()
					owner:SendMessage("Warning: A prop of yours has been destroyed.",10,Color(255,255,0,255))
				end
				return true
			end
		end
	end
end

function TogglePVP(ply)
	if ply.PVP then
	if ply.PVP == 1 then
		ply.PVP = 0
		ply:SendMessage("Warning: Player Vs Player Damage is disabled",10,Color(255,255,0,255))
	else
		ply.PVP = 1
		ply:SendMessage("Warning: Player Vs Player Damage is enabled!",10,Color(255,255,0,255))
	end
	else
		ply.PVP = 1
		ply:SendMessage("Warning: Player Vs Player Damage is enabled!",10,Color(255,255,0,255))
	end
end
concommand.Add("gms_PVP",TogglePVP)

function SendHudEffect(ply,time,int)
	umsg.Start("SendHudEffect",ply)
		umsg.Short(tonumber(time) or .1)
		umsg.Short(tonumber(int) or 10)
	umsg.End()
end


----------------------------------------------------
--SAVING AND LOADING
----------------------------------------------------
function GM.AutoSaveAllCharacters()
	local GM = GAMEMODE
	SetGlobalInt("plantlimit", GetConVarNumber("gms_PlantLimit"))
	if GetConVarNumber("gms_AutoSave") == 1 then
		for k,v in pairs(player.GetAll()) do
			v:SendMessage("Autosaving..",3,Color(255,255,255,255))
			GM.SaveCharacter(v)
		end
	end
         
	timer.Simple(math.Clamp(GetConVarNumber("gms_AutoSaveTime"),1,60) * 60,GM.AutoSaveAllCharacters)
end

timer.Simple(1,GM.AutoSaveAllCharacters)


function GM.SaveCharacter(ply)
	if OldLoad == 0 then
		if !file.IsDir("GMStranded") then file.CreateDir("GMStranded") end
		if !file.IsDir("GMStranded/Saves") then file.CreateDir("GMStranded/Saves") end

		local tbl = {}
		tbl["skills"] = {}
		tbl["experience"] = {}
		tbl["date"] = os.date("%A %m/%d/%y")
		tbl["name"] = ply:Nick()
		tbl.tribe = ply.Tribe

		for k,v in pairs(ply.Skills) do
			tbl["skills"][k] = v
		end
			 
		for k,v in pairs(ply.Experience) do
			tbl["experience"][k] = v
		end
		local name = ply.Account
		local pass = ply.Password
		file.Write("GMStranded/Saves/"..name.."/stats.txt",util.TableToKeyValues(tbl))
		file.Write("GMStranded/Saves/"..name.."/pass.txt",pass)
		ply:SendMessage("Saved character!",3,Color(255,255,255,255))
	else
		if !file.IsDir("GMStranded") then file.CreateDir("GMStranded") end
		if !file.IsDir("GMStranded/Saves") then file.CreateDir("GMStranded/Saves") end

		local tbl = {}
		tbl["skills"] = {}
		tbl["experience"] = {}
		tbl["date"] = os.date("%A %m/%d/%y")
		tbl["name"] = ply:Nick()
		tbl.tribe = ply.Tribe

		for k,v in pairs(ply.Skills) do
			tbl["skills"][k] = v
		end
			 
		for k,v in pairs(ply.Experience) do
			tbl["experience"][k] = v
		end

		file.Write("GMStranded/Saves/"..ply:UniqueID()..".txt",util.TableToKeyValues(tbl))
		ply:SendMessage("Saved character!",3,Color(255,255,255,255))
	end
end

concommand.Add("gms_savecharacter",GM.SaveCharacter)


function GM.SaveAllCharacters(ply)
	if !ply:IsAdmin() then 
		ply:SendMessage("You need admin rights for this!",3,Color(200,0,0,255))
	return end
         
	for k,v in pairs(player.GetAll()) do
		GAMEMODE.SaveCharacter(v)
	end
         
	ply:SendMessage("Saved characters on all current players.",3,Color(255,255,255,255))
end

concommand.Add("gms_admin_saveallcharacters",GM.SaveAllCharacters)

function GM:InitPostEntity()
	local path = "stranded_mapprops/" .. game.GetMap() .. ".txt"
	if file.Exists(path) then
		local txt = file.Read(path)
		for name,mod,x,y,z,p,y2,r in txt:gmatch("([^|\n]+)|([^|\n]+)|([^|\n]+)|([^|\n]+)|([^|\n]+)|([^|\n]+)|([^|\n]+)|([^|\n]+)\n") do
			local pos,ang = Vector(x,y,z),Angle(p,y2,r)
			local ent = ents.Create("prop_physics")
			ent:SetModel(mod)
			ent:SetPos(pos)
			ent:SetAngles(ang)
			ent:Spawn()
			local phys = ent:GetPhysicsObject()
			if IsValid(phys) then
				phys:EnableMotion(false)
			end
		end
	end
end

concommand.Add("gms_mapprops_add",function (ply)
	if !ply:IsAdmin() then return end
	local map = game.GetMap()
	local tr = ply:GetEyeTrace()
	local ent = tr.Entity
	if IsValid(ent) && ent:GetClass() == "prop_physics" then
		local name = ent:GetName()
		local mod,pos,ang = ent:GetModel(),ent:GetPos(),ent:GetAngles()
		if string.Trim(name) == "" then
			name = "gms_mp_" .. util.CRC(CurTime() .. mod .. map)
			ent:SetName(name)
		end
		local path = "stranded_mapprops/" .. map .. ".txt"
		local txt = ""
		if file.Exists(path) then
			txt = file.Read(path):gsub(name .. "|[^\n]+\n","")
		end
		txt = Format("%s%s|%s|%s|%s|%s|%s|%s|%s\n",txt,name,mod,pos.x,pos.y,pos.z,ang.p,ang.y,ang.r)
		file.Write(path,txt)
	end
end)
