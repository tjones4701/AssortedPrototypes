--Locals
local PlayerMeta = FindMetaTable("Player")
local EntityMeta = FindMetaTable("Entity")
/*---------------------------------------------------------
  Process system
---------------------------------------------------------*/
GMS.Processes = {}

--Registry
function GMS.RegisterProcess(name,tbl)
         GMS.Processes[name] = tbl
end

--Handle think hooks
GM.ProcessThinkHookTable = {}
function GM.ProcessThink()
         local GM = GAMEMODE
         for k,v in pairs(GM.ProcessThinkHookTable) do
             local think;
             if v.Think then think = v:Think() end
             
             local basethink = v:BaseThink()
             
             if think or basethink then
                if v.Owner and v.Owner != NULL and v.Owner:IsValid() then 
                   v.Owner:Freeze(false)
                   v.Owner:StopProcessBar()
                   v.Owner.InProcess = false
                   v.Owner:SendMessage("Cancelled.",3,Color(200,0,0,255))
                end

                v.IsStopped = true
                timer.Destroy("GMS_ProcessTimer_"..v.TimerID)
                GM.RemoveProcessThink(v)
             end
         end
end

hook.Add("Think","gms_ProcessThinkHooks",GM.ProcessThink)

function GM.AddProcessThink(tbl)
         table.insert(GAMEMODE.ProcessThinkHookTable,tbl)
end

function GM.RemoveProcessThink(tbl)
	for k,v in pairs(GAMEMODE.ProcessThinkHookTable) do
        if v == tbl then
            table.remove(GAMEMODE.ProcessThinkHookTable,k)
        end
    end
end

--Actual processing
function PlayerMeta:DoProcess(name,time,data)
		local ply = self
         if self.InProcess then
            self:SendMessage("You can't do this much at once.",3,Color(200,0,0,255))
         return end
		 
         --Moved these up so that the process bar will end accurately:Waddles
		 local oldtime = time
		 if self.Upgrades["Strength_Enhancement"] == 1 then
			time = oldtime / 2
		 end
		 
		 if self.Upgrades["MuscleMan"] == 1 then
			time = oldtime / 4
		 end
		 
		 if self.Upgrades["Super_Soldier"] == 1 then
			time = oldtime / 5
		 end
		 
        --Need seperate instance
         self.ProcessTable = table.Merge(table.Copy(GMS.Processes[name]),table.Copy(GMS.Processes.BaseProcess))
         self.ProcessTable.Owner = self
         self.ProcessTable.Time = time
         self.ProcessTable.TimerID = self:UniqueID()
         if data then self.ProcessTable.Data = data end

         self.InProcess = true

         if self.ProcessTable.OnStart then self.ProcessTable:OnStart() end
		--Start think
         GAMEMODE.AddProcessThink(self.ProcessTable)

         timer.Create("GMS_ProcessTimer_"..self:UniqueID(),time, 1, GAMEMODE.StopProcess, self)
end

function PlayerMeta:MakeProcessBar(name,time)
         umsg.Start("gms_MakeProcessBar",self)
			 umsg.String(name) 
			 umsg.Float(time)
         umsg.End()
end

function PlayerMeta:StopProcessBar()
         umsg.Start("gms_StopProcessBar",self)
         umsg.End()
end

function GM.StopProcess(pl)
	if pl == nil or pl.ProcessTable == nil then return end

	--Run stop
	local bool = pl.ProcessTable:BaseStop()
	if pl.ProcessTable.OnStop then pl.ProcessTable:OnStop() end
	--Stop think
	--Removed the original function check, hopefully fixing the lag bug.:Waddles
	GAMEMODE.RemoveProcessThink(pl.ProcessTable)
         
	pl.InProcess = false
	pl.ProcessTable = nil
end
/*---------------------------------------------------------
  Base process
---------------------------------------------------------*/
local PROCESS = {}

function PROCESS:BaseThink()
	if self.Owner && self then
		if ValidEntity(self.Owner) then
			if self.Owner:IsPlayer() then
				if !self.Owner:IsValid() or !self.Owner:IsConnected() then return true end
				if !self.Owner:Alive() then
					return true
				end
			end
		end
	end
end

function PROCESS:BaseStop()
         if !self.Owner:Alive() or !self.Owner or self.Owner == NULL then return false end
         if !self.Owner:IsValid() then return false end         
         self.Owner:StopProcessBar()
         return true
end

GMS.Processes.BaseProcess = PROCESS
/*---------------------------------------------------------
  Fruit eating process
---------------------------------------------------------*/
local PROCESS = {}

PROCESS.SideGain = {}
PROCESS.SideGain["melon"] = "Melon_Seeds"
PROCESS.SideGain["orange"] = "Orange_Seeds"
PROCESS.SideGain["banana"] = "Banana_Seeds"

function PROCESS:OnStart()
		local ply = self.Owner
         self.Owner:MakeProcessBar("Eating Fruit",self.Time)
         self.Owner:Freeze(true)
		 
		 self.Owner:EmitSound(Sound("vo/SandwichEat09.wav"))
		 
		 local owner = nil
		 local ent = self.Data.Entity
         local plant = ent.PlantParent
		 
		if plant then
			owner = plant:GetNWEntity("plantowner")
		end
		
         if self.Data.Entity:GetModel() == "models/props_junk/watermelon01.mdl" then
            self.SideGain = "Melon_Seeds"
         elseif self.Data.Entity:GetModel() == "models/props/cs_italy/orange.mdl" then
            self.SideGain = "Orange_Seeds"
         elseif self.Data.Entity:GetModel() == "models/props/cs_italy/bananna_bunch.mdl" then
            self.SideGain = "Banana_Seeds"
         end

         if plant then
			if plant.Children then
				plant.Children = plant.Children - 1
				if plant.Children <= 0 then
				   plant:Fadeout()
				   if owner and owner != NULL then
						owner:SetNWInt("plants", owner:GetNWInt("plants")-1)
				   end
				end
			end
         end

         self.Data.Entity:Fadeout(2)
end

function PROCESS:OnStop()
        if self.SideGain then
		local numto = (self.Owner:GetSkill("Harvesting") / 10) or 1
		local numto = math.floor(numto)
		if numto < 1 then
			numto = 1
		end
	    local numstart = 1
	    if self.Owner:GetActiveWeapon():GetClass() == "gms_woodenspoon" then 
			numto = math.floor (numto * 2)
			numstart = math.floor(numto / 4)
			if numstart < 1 then
				numstart = 1
			end
	    end
	    local num = math.random(numstart,numto)		
			if num ~= 0 then
				self.Owner:IncResource(self.SideGain,num)
				self.Owner:SendMessage(string.gsub(self.SideGain,"_"," ").." ("..num.."x)", 3, Color(10,200,10,255))
				self.Owner:EmitSound(Sound("items/ammo_pickup.wav"))
			end
		end
		
        self.Owner:SetFood(self.Owner.Hunger + 250)
        self.Owner:SendMessage("You feel a little less hungry now.",3,Color(255,255,255,255))
        self.Owner:Freeze(false)
end

GMS.RegisterProcess("EatFruit",PROCESS)

/*---------------------------------------------------------
  Foraging process
---------------------------------------------------------*/
local PROCESS = {}
PROCESS.Results = {}
PROCESS.Results[1] = "Melon Seeds"
PROCESS.Results[2] = "Banana Seeds"
PROCESS.Results[3] = "Orange Seeds"
PROCESS.Results[4] = "Grain Seeds"
PROCESS.Results[5] = "Herbs"
PROCESS.Results[6] = "Berries"
PROCESS.Results[7] = "Tree_Seedlings"

function PROCESS:OnStart()
         self.Owner:MakeProcessBar("Foraging",self.Time)
         self.Owner:Freeze(true)
end

function PROCESS:OnStop()
         local num = math.random(1,100)

         if num > 50 - self.Owner:GetSkill("Harvesting") then
            local res = self.Results[math.random(1,#self.Results)]

            local amount = math.random(1,3)
            self.Owner:IncResource(string.gsub(res," ","_"),amount)
            self.Owner:IncXP("Harvesting",math.Clamp(math.Round(50 / self.Owner:GetSkill("Harvesting")),1 , 1000))
            self.Owner:SendMessage(res.." ("..amount.."x)", 3, Color(10,200,10,255))
            self.Owner:EmitSound(Sound("items/ammo_pickup.wav"))
         else
           self.Owner:SendMessage("Found nothing of interest", 3, Color(255,255,255,255))
         end

         self.Owner:Freeze(false)
end

GMS.RegisterProcess("Foraging",PROCESS)

/*---------------------------------------------------------
  Looting process
---------------------------------------------------------*/
local PROCESS = {}

function PROCESS:OnStart()
         self.Data.Entity:Fadeout(2)

         self.Owner:MakeProcessBar("Looting",self.Time)
         self.Owner:Freeze(true)
end

function PROCESS:OnStop()
         for k,v in pairs(self.Data.Resources) do
             self.Owner:SendMessage(k.." ("..v.."x)", 3, Color(10,200,10,255))
             self.Owner:IncResource(k,v)
         end
         
         self.Owner:EmitSound(Sound("items/ammo_pickup.wav"))
         self.Owner:Freeze(false)
end

GMS.RegisterProcess("Loot",PROCESS)

/*---------------------------------------------------------
  Digging
---------------------------------------------------------*/
local PROCESS = {}
--Yes, horribly random, I know
PROCESS.Rarities = {}
PROCESS.Rarities[1] = "Unobtainium"
PROCESS.Rarities[2] = "Sand"
PROCESS.Rarities[3] = "Rope"
PROCESS.Rarities[4] = "Bass"
PROCESS.Rarities[5] = "Sand"
PROCESS.Rarities[6] = "Stone"

function PROCESS:OnStart()
         self.Owner:MakeProcessBar("Digging",self.Time)
         self.Owner:Freeze(true)
         self.StartTime = CurTime()
         
         self:PlaySound()
end

function PROCESS:PlaySound()
         if CurTime() - self.StartTime > self.Time then return end
         if self.Owner:Alive() then
			 self.Owner:GetActiveWeapon():SendWeaponAnim(ACT_VM_HITCENTER)
			 self.Owner:EmitSound(Sound("player/footsteps/gravel"..math.random(1,4)..".wav"))
			 
			 timer.Simple(1.4,self.PlaySound,self)
		 end
end

function PROCESS:OnStop()
         local num = math.random(1,100)
         
         if num < 10 then
            local res = self.Rarities[math.random(1,#self.Rarities)]
		if self.Data and self.Data.Sand and math.random() > 0.50 then res = "Sand" end
            self.Owner:IncResource(res,1)
            self.Owner:SendMessage(res.." (1x)",3,Color(10,200,10,255))
            self.Owner:SendMessage("You found something weird!",3,Color(255,255,255,255))
            self.Owner:EmitSound(Sound("items/ammo_pickup.wav"))
         elseif num > 10 and num < 40 then
            self.Owner:SendMessage("Found nothing of interest",3,Color(255,255,255,255))
         else
            local tr = self.Owner:TraceFromEyes(200)
            
            local ent = ents.Create("prop_physics")
            ent:SetPos(tr.HitPos + Vector(0,0,10))
            ent:SetModel(GMS.SmallRockModel)
            ent:Spawn()
			ent:CPPISetOwner(self.Owner)
            
            ent:Fadein(2)
            ent.Uses = 10
         end

         self.Owner:Freeze(false)
end

GMS.RegisterProcess("Dig",PROCESS)

/*---------------------------------------------------------
  Filter ground process
---------------------------------------------------------*/
local PROCESS = {}
PROCESS.Results = {}
PROCESS.Results[1] = "Sand"
PROCESS.Results[2] = "Sand"
PROCESS.Results[3] = "Sand"
PROCESS.Results[4] = "Glass" -- 25% Chance, Easy hack :\

function PROCESS:OnStart()
         self.Owner:MakeProcessBar("Filtering Ground",self.Time)
         self.Owner:Freeze(true)
end

function PROCESS:OnStop()
         local num = math.random(1,100)

         if num > 50 - self.Owner:GetSkill("Harvesting") then
            local res = self.Results[math.random(1,#self.Results)]

            local amount = math.random(1,3)
            self.Owner:IncResource(string.gsub(res," ","_"),amount)
            self.Owner:IncXP("Harvesting",math.Clamp(math.Round(50 / self.Owner:GetSkill("Harvesting")),1 , 1000))
            self.Owner:SendMessage(res.." ("..amount.."x)", 3, Color(10,200,10,255))
            self.Owner:EmitSound(Sound("items/ammo_pickup.wav"))
         else
           self.Owner:SendMessage("Found nothing of interest", 3, Color(10,200,10,255))
         end

         self.Owner:Freeze(false)
end

GMS.RegisterProcess("FilterGround",PROCESS)

/*---------------------------------------------------------
  Grain harvesting
---------------------------------------------------------*/
local PROCESS = {}

function PROCESS:OnStart()
         self.Owner:MakeProcessBar("Harvesting Grain",self.Time)
         self.Owner:Freeze(true)
         
         local ent = self.Data.Entity

         if ent and ent != NULL then
            if !ent.Uses then ent.Uses = math.random(1,3) end
         end
end

function PROCESS:OnStop()
         local num = math.random(1,100)
         local add = 0
         if self.Owner:GetActiveWeapon():GetClass() == "gms_sickle" then add = add + 30 end

         if num > 50 - self.Owner:GetSkill("Harvesting") - add then
            local amount = math.random(1,2)
            self.Owner:IncResource("Grain_Seeds",amount)
            self.Owner:IncXP("Harvesting",math.Clamp(math.Round(50 / self.Owner:GetSkill("Harvesting")),1 , 1000))
            self.Owner:SendMessage("Grain Seeds ("..amount.."x)", 3, Color(10,200,10,255))
            self.Owner:EmitSound(Sound("items/ammo_pickup.wav"))
            local ent = self.Data.Entity
			local owner = ent:GetNWEntity("plantowner")
        
            if ent and ent != NULL then
               if ent.Uses then
                  ent.Uses = ent.Uses - 1
                  if ent.Uses <= 0 then
				  	if owner and owner != NULL then
						owner:SetNWInt("plants", owner:GetNWInt("plants")-1)
					end
                     ent:Fadeout()
                  end
               end
            end

         else
           self.Owner:SendMessage("Failed.", 3, Color(200,0,0,255))
         end

         self.Owner:Freeze(false)
end

GMS.RegisterProcess("HarvestGrain",PROCESS)
/*---------------------------------------------------------
 Berry harvesting
---------------------------------------------------------*/
local PROCESS = {}

function PROCESS:OnStart()
         self.Owner:MakeProcessBar("Harvesting Bush",self.Time)
         self.Owner:Freeze(true)
         
         local ent = self.Data.Entity
         
         if ent and ent != NULL then
            if !ent.Uses then ent.Uses = math.random(1,3) end
         end
end

function PROCESS:OnStop()
         local num = math.random(1,100)

         local add = 0
         if self.Owner:GetActiveWeapon():GetClass() == "gms_sickle" then add = add + 25 end

         if num > 50 - self.Owner:GetSkill("Harvesting") - add then
            local amount = math.random(1,2)
            self.Owner:IncResource("Berries",amount)
            self.Owner:IncXP("Harvesting",math.Clamp(math.Round(50 / self.Owner:GetSkill("Harvesting")),1 , 1000))
            self.Owner:SendMessage("Berries ("..amount.."x)", 3, Color(10,200,10,255))
            self.Owner:EmitSound(Sound("items/ammo_pickup.wav"))
            local ent = self.Data.Entity     
			local owner = ent:GetNWEntity("plantowner")    

            if ent and ent != NULL then
               if ent.Uses then
                  ent.Uses = ent.Uses - 1
                  if ent.Uses <= 0 then
					if owner and owner != NULL then
						owner:SetNWInt("plants", owner:GetNWInt("plants")-1)
					end
                     ent:Fadeout()
                  end
               end
            end

         else
           self.Owner:SendMessage("Failed.", 3, Color(200,0,0,255))
         end

         self.Owner:Freeze(false)
end

GMS.RegisterProcess("HarvestBush",PROCESS)
/*---------------------------------------------------------
  Make Campfire process
---------------------------------------------------------*/
local PROCESS = {}

function PROCESS:OnStart()
	if GetConVarNumber("gms_Campfire") == 1 then
         self.Owner:MakeProcessBar("Making Campfire",self.Time)
         self.Owner:Freeze(true)
	end
end

function PROCESS:OnStop()
	if GetConVarNumber("gms_Campfire") == 1 then
         local num = math.random(1,3)

         if num == 1 then
            self.Owner:SendMessage("Failed.", 3, Color(200,0,0,255))
         else
            self.Data.Entity:MakeCampfire()
            self.Owner:SendMessage("Made campfire.",5,Color(10,200,100,255))
            self.Owner:DecResource("Wood",5)
         end

         self.Owner:Freeze(false)
	end
end

GMS.RegisterProcess("Campfire",PROCESS)

/*---------------------------------------------------------
  Wood cutting
---------------------------------------------------------*/
local PROCESS = {}

function PROCESS:OnStart()
         self.Owner:MakeProcessBar("Chopping Wood",self.Time)
         self.Owner:Freeze(true)
         
         self.StartTime = CurTime()
         
         self.Owner:GetActiveWeapon():SendWeaponAnim(ACT_VM_HITCENTER)
		 self.Owner:EmitSound(Sound("physics/wood/wood_solid_impact_bullet"..tostring(math.random(1,5))..".wav"))
		 if ValidEntity(self.Data.Entity) then
			if !self.Data.Entity.Uses then self.Data.Entity.Uses = 100 end
		 end
			
end


function PROCESS:OnStop()
         local num = math.random(1,100)
					 if num < self.Data.Chance + self.Owner:GetSkill("Lumbering") then
				local num2 = math.random(self.Data.MinAmount,self.Data.MaxAmount)
				self.Owner:IncResource("Wood",num2)
				self.Owner:IncXP("Lumbering",math.Clamp(math.Round(50 / self.Owner:GetSkill("Lumbering")),1 , 1000))
				self.Owner:SendMessage("Wood ("..num2.."x)", 3, Color(10,200,10,255))
				self.Owner:EmitSound(Sound("items/ammo_pickup.wav"))
				if ValidEntity(self.Data.Entity) then
					if self.Data.Entity then self.Data.Entity.Uses = self.Data.Entity.Uses - num2 end
				end
			 else
				self.Owner:SendMessage("Failed.",3,Color(200,0,0,255))
			 end
			 
			 self.Owner:Freeze(false)
			if ValidEntity(self.Data.Entity) then 
			 if self.Data.Entity != NULL then
				if self.Data.Entity.Uses <= 0 then
				   self.Data.Entity:Fadeout()
				end
			 end
		end
end

GMS.RegisterProcess("WoodCutting",PROCESS)

/*---------------------------------------------------------
  Mining
---------------------------------------------------------*/
local PROCESS = {}

function PROCESS:OnStart()
         self.Owner:MakeProcessBar("Mining",self.Time)
         self.Owner:Freeze(true)
         self.StartTime = CurTime()
         if !self.Data.Entity.Uses then self.Data.Entity.Uses = 250 end
		 self.Owner:GetActiveWeapon():SendWeaponAnim(ACT_VM_HITCENTER)
		 self.Owner:EmitSound(Sound("physics/glass/glass_bottle_impact_hard"..tostring(math.random(1,3))..".wav"))
end


function PROCESS:OnStop()
	if self.Owner:Alive() then
         local num = math.random(1,100)
		 local num2 = 1

         if num < self.Data.Chance + self.Owner:GetSkill("Mining") then
			if self.Owner:GetActiveWeapon():GetClass() == "gms_stonepickaxe" then 
            num2 = math.random(1,3)
			end
			if self.Owner:GetActiveWeapon():GetClass() == "gms_platinumpickaxe" then 
            num2 = math.random(1,5)
			end
			if self.Owner:GetActiveWeapon():GetClass() == "gms_unobtainiumpickaxe" then 
				num2 = math.random(1,6)
			end
			if self.Owner:GetActiveWeapon():GetClass() == "gms_unobtainiumpickaxe" && self.Owner:GetSkill("Mining") > 50 then 
				num2 = math.random(1,7)
			end
			if self.Owner:GetActiveWeapon():GetClass() == "gms_adamantiumpickaxe" then 
				num2 = math.random(1,8)
			end
			if self.Owner:GetActiveWeapon():GetClass() == "gms_adamantiumpickaxe" && self.Owner:GetSkill("Mining") > 150 then 
				num2 = math.random(1,9)
			end
			if self.Owner:GetActiveWeapon():GetClass() == "gms_crystalpickaxe" then 
				num2 = math.random(3,9)
			end
			if self.Owner:GetActiveWeapon():GetClass() == "gms_crystalpickaxe" && self.Owner:GetSkill("Mining") > 300 then 
				num2 = math.random(3,10)
			end
			if self.Owner:GetActiveWeapon():GetClass() == "gms_diamondpickaxe" then 
				num2 = math.random(4,25)
			end
			if self.Owner:GetActiveWeapon():GetClass() == "gms_diamondpickaxe" && self.Owner:GetSkill("Mining") > 500 then 
				num2 = math.random(4,26)
			end
			if self.Owner:GetActiveWeapon():GetClass() == "gms_goldpickaxe" then 
				num2 = math.random(1,7)
			end
			if self.Owner:GetActiveWeapon():GetClass() == "gms_goldpickaxe" && self.Owner:GetSkill("Mining") > 1500 then 
				num2 = math.random(8,25)
			end
			if self.Owner:GetActiveWeapon():GetClass() == "gms_cheatpickaxe" then 
				num2 = math.random(4,26)
			end
			
            local num3 = math.random(self.Data.MinAmount,self.Data.MaxAmount)
			local Compound11Amount = math.floor((num3/2))
			if Compound11Amount < 1 then
				Compound11Amount = 1
			end

			if num2 == 1 then
               self.Owner:IncResource("Stone",num3)
               self.Owner:SendMessage("Stone ("..num3.."x)", 3, Color(10,200,10,255))
			elseif num2 == 2 then
               self.Owner:IncResource("Stone",num3)
               self.Owner:SendMessage("Stone ("..num3.."x)", 3, Color(10,200,10,255))
            elseif num2 == 3 then
               self.Owner:IncResource("Platinum_Ore",num3)
               self.Owner:SendMessage("Platinum Ore ("..num3.."x)", 3, Color(10,200,10,255))
			elseif num2 == 4 then
               self.Owner:IncResource("Unobtainium_Ore",num3)
               self.Owner:SendMessage("Unobtainium Ore ("..num3.."x)", 3, Color(10,200,10,255))
			elseif num2 == 5 then
               self.Owner:IncResource("Unobtainium_Ore",num3)
               self.Owner:SendMessage("Unobtainium Ore ("..num3.."x)", 3, Color(10,200,10,255))
			elseif num2 == 6 then
               self.Owner:IncResource("Unobtainium_Ore",num3)
               self.Owner:SendMessage("Unobtainium Ore ("..num3.."x)", 3, Color(10,200,10,255))
			elseif num2 == 7 then
               self.Owner:IncResource("Compound11",num3)
               self.Owner:SendMessage("Compound11 ("..num3.."x)", 3, Color(10,200,10,255))
			elseif num2 == 8 then
               self.Owner:IncResource("Crystal",num3)
               self.Owner:SendMessage("Crystal ("..num3.."x)", 3, Color(10,200,10,255))
			elseif num2 == 9 then
               self.Owner:IncResource("Compound11",num3)
               self.Owner:SendMessage("Compound11 ("..num3.."x)", 3, Color(10,200,10,255))
			elseif num2 == 10 then
               self.Owner:IncResource("Crystal",num3)
               self.Owner:SendMessage("Crystal ("..num3.."x)", 3, Color(10,200,10,255))
			elseif num2 == 11 then
               self.Owner:IncResource("Platinum_Ore",num3)
               self.Owner:SendMessage("Platinum Ore ("..num3.."x)", 3, Color(10,200,10,255))
			elseif num2 == 12 then
               self.Owner:IncResource("Unobtainium_Ore",num3)
               self.Owner:SendMessage("Unobtainium Ore("..num3.."x)", 3, Color(10,200,10,255))
			elseif num2 == 13 then
               self.Owner:IncResource("Unobtainium_Ore",num3)
               self.Owner:SendMessage("Unobtainium Ore ("..num3.."x)", 3, Color(10,200,10,255))
			elseif num2 == 14 then
               self.Owner:IncResource("Unobtainium_Ore",num3)
               self.Owner:SendMessage("Unobtainium Ore("..num3.."x)", 3, Color(10,200,10,255))
			elseif num2 == 15 then
               self.Owner:IncResource("Platinum_Ore",num3)
               self.Owner:SendMessage("Platinum Ore("..num3.."x)", 3, Color(10,200,10,255))
			elseif num2 == 16 then
               self.Owner:IncResource("Platinum_Ore",num3)
               self.Owner:SendMessage("Platinum Ore ("..num3.."x)", 3, Color(10,200,10,255))
			elseif num2 == 17 then
               self.Owner:IncResource("Platinum_Ore",num3)
               self.Owner:SendMessage("Platinum Ore ("..num3.."x)", 3, Color(10,200,10,255))
			elseif num2 == 18 then
               self.Owner:IncResource("Crystal",num3)
               self.Owner:SendMessage("Crystal ("..num3.."x)", 3, Color(10,200,10,255))
			elseif num2 == 19 then
               self.Owner:IncResource("Crystal",num3)
               self.Owner:SendMessage("Crystal ("..num3.."x)", 3, Color(10,200,10,255))
			elseif num2 == 20 then
               self.Owner:IncResource("Crystal",num3)
               self.Owner:SendMessage("Crystal ("..num3.."x)", 3, Color(10,200,10,255))
			elseif num2 == 21 then
               self.Owner:IncResource("Crystal",num3)
               self.Owner:SendMessage("Crystal ("..num3.."x)", 3, Color(10,200,10,255))
			elseif num2 == 22 then
               self.Owner:IncResource("Unobtainium_Ore",num3)
               self.Owner:SendMessage("Unobtainium Ore ("..num3.."x)", 3, Color(10,200,10,255))
			elseif num2 == 23 then
               self.Owner:IncResource("Platinum_Ore",num3)
               self.Owner:SendMessage("Platinum Ore("..num3.."x)", 3, Color(10,200,10,255))
			elseif num2 == 24 then
               self.Owner:IncResource("Unobtainium_Ore",num3)
               self.Owner:SendMessage("Unobtainium Ore("..num3.."x)", 3, Color(10,200,10,255))
			elseif num2 == 25 then
               self.Owner:IncResource("Crystal",num3)
               self.Owner:SendMessage("Crystal ("..num3.."x)", 3, Color(10,200,10,255))
			elseif num2 == 26 then
               self.Owner:IncResource("Gold_Nugget",num3)
               self.Owner:SendMessage("Gold Nugget("..num3.."x)", 3, Color(10,200,10,255))
            end

            self.Owner:IncXP("Mining", math.Clamp(math.Round(50 / self.Owner:GetSkill("Mining")),1 , 1000))
            self.Owner:EmitSound(Sound("items/ammo_pickup.wav"))
         else
			self.Owner:SendMessage("Failed.",3,Color(200,0,0,255))
         end
         
         self.Owner:Freeze(false)
         

	else
		self.Owner:SendMessage("You are dead.",3,Color(200,0,0,255))
	end
end

GMS.RegisterProcess("Mining",PROCESS)
/*---------------------------------------------------------
  Tree_Seedlings collect
---------------------------------------------------------*/
local PROCESS = {}

function PROCESS:OnStart()
            self.Owner:MakeProcessBar("Loosening Tree_Seedlings",self.Time)
            self.Owner:Freeze(true)
end

function PROCESS:OnStop()
         local num = math.random(1,100)

         local add = 0
         if self.Owner:GetActiveWeapon():GetClass() == "gms_sickle" then add = add + 30 end

         if num > 50 - self.Owner:GetSkill("Harvesting") - add then
            self.Owner:IncResource("Tree_Seedlings",1)
            self.Owner:IncXP("Harvesting",math.Clamp(math.Round(50 / self.Owner:GetSkill("Harvesting")),1 , 1000))
            self.Owner:SendMessage("Tree Seedlings (1x)", 3, Color(10,200,10,255))
            self.Owner:EmitSound(Sound("items/ammo_pickup.wav"))
			local Roots = math.random(0,5)
				self.Owner:IncResource("Roots",Roots)
				if Roots > 0 then
					self.Owner:SendMessage("Roots ("..Roots.."x)", 3, Color(10,200,10,255))
				else
					self.Owner:SendMessage("Failed", 3, Color(10,200,10,255))
				end
         else
            local Roots = math.random(0,5)
				self.Owner:IncResource("Roots",Roots)
				if Roots > 0 then
					self.Owner:SendMessage("Roots ("..Roots.."x)", 3, Color(10,200,10,255))
				else
					self.Owner:SendMessage("Failed", 3, Color(10,200,10,255))
				end
         end

         self.Owner:Freeze(false)
end

GMS.RegisterProcess("Tree_SeedlingsCollect",PROCESS)

/*---------------------------------------------------------
  Plant Melon
---------------------------------------------------------*/
local PROCESS = {}

function PROCESS:OnStart()
         self.Owner:MakeProcessBar("Planting Watermelon",self.Time)
         self.Owner:Freeze(true)
end

function PROCESS:OnStop()

         self.Owner:DecResource("Melon_Seeds",1)
         self.Owner:IncXP("Planting",math.Clamp(math.Round(50 / self.Owner:GetSkill("Planting")),1 , 1000))
         self.Owner:SendMessage("Successfully planted.", 3, Color(10,200,10,255))
         
         local ent = ents.Create("gms_seed")
		 ent:CPPISetOwner(self.Owner)
         ent:SetPos(self.Data.Pos)
         local tbl = ent:GetTable()
		 local isupgraded = 0
		 if self.Owner.Upgrades["Advanced_Fertilizer"] == 1 then
			isupgraded = 1
		 end
         tbl:Setup("melon",160 - math.Clamp(self.Owner:GetSkill("Planting"),0,60) + math.random(-20,20),self.Owner,isupgraded)
         ent:Spawn()

         self.Owner:Freeze(false)
end

GMS.RegisterProcess("PlantMelon",PROCESS)

/*---------------------------------------------------------
  Plant Banana
---------------------------------------------------------*/
local PROCESS = {}

function PROCESS:OnStart()
         self.Owner:MakeProcessBar("Planting Banana",self.Time)
         self.Owner:Freeze(true)
end

function PROCESS:OnStop()

         self.Owner:DecResource("Banana_Seeds",1)
         self.Owner:IncXP("Planting",math.Clamp(math.Round(50 / self.Owner:GetSkill("Planting")),1 , 1000))
         self.Owner:SendMessage("Successfully planted.", 3, Color(10,200,10,255))
         
         local ent = ents.Create("gms_seed")
		 ent:CPPISetOwner(self.Owner)
         ent:SetPos(self.Data.Pos)
         local tbl = ent:GetTable()
		 local isupgraded = 0
		 if self.Owner.Upgrades["Advanced_Fertilizer"] == 1 then
			isupgraded = 1
		 end
         tbl:Setup("banana",160 - math.Clamp(self.Owner:GetSkill("Planting"),0,60) + math.random(-20,20),self.Owner,isupgraded)
         ent:Spawn()

         self.Owner:Freeze(false)
end

GMS.RegisterProcess("PlantBanana",PROCESS)

/*---------------------------------------------------------
  Plant Orange
---------------------------------------------------------*/
local PROCESS = {}

function PROCESS:OnStart()
         self.Owner:MakeProcessBar("Planting Orange",self.Time)
         self.Owner:Freeze(true)
end

function PROCESS:OnStop()

         self.Owner:DecResource("Orange_Seeds",1)
         self.Owner:IncXP("Planting",math.Clamp(math.Round(50 / self.Owner:GetSkill("Planting")),1 , 1000))
         self.Owner:SendMessage("Successfully planted.", 3, Color(10,200,10,255))
         
         local ent = ents.Create("gms_seed")
		 ent:CPPISetOwner(self.Owner)
         ent:SetPos(self.Data.Pos)
         local tbl = ent:GetTable()
		 local isupgraded = 0
		 if self.Owner.Upgrades["Advanced_Fertilizer"] == 1 then
			isupgraded = 1
		 end
         tbl:Setup("orange",160 - math.Clamp(self.Owner:GetSkill("Planting"),0,60) + math.random(-20,20),self.Owner,isupgraded)
         ent:Spawn()


         self.Owner:Freeze(false)
end

GMS.RegisterProcess("PlantOrange",PROCESS)

/*---------------------------------------------------------
  Plant Grain
---------------------------------------------------------*/
local PROCESS = {}

function PROCESS:OnStart()
         self.Owner:MakeProcessBar("Planting Grain",self.Time)
         self.Owner:Freeze(true)
end

function PROCESS:OnStop()

         self.Owner:DecResource("Grain_Seeds",1)
         self.Owner:IncXP("Planting",math.Clamp(math.Round(50 / self.Owner:GetSkill("Planting")),1 , 1000))
         self.Owner:SendMessage("Successfully planted.", 3, Color(10,200,10,255))
         
         local ent = ents.Create("gms_seed")
		 ent:CPPISetOwner(self.Owner)
         ent:SetPos(self.Data.Pos)
         local tbl = ent:GetTable()
		 local isupgraded = 0
		 if self.Owner.Upgrades["Advanced_Fertilizer"] == 1 then
			isupgraded = 1
		 end
         tbl:Setup("grain",160 - math.Clamp(self.Owner:GetSkill("Planting"),0,60) + math.random(-20,20),self.Owner,isupgraded)
         ent:Spawn()

         self.Owner:Freeze(false)
end

GMS.RegisterProcess("PlantGrain",PROCESS)

/*---------------------------------------------------------
  Plant Bush
---------------------------------------------------------*/
local PROCESS = {}

function PROCESS:OnStart()
         self.Owner:MakeProcessBar("Planting Berry Bush",self.Time)
         self.Owner:Freeze(true)
end

function PROCESS:OnStop()

         self.Owner:DecResource("Berries",1)
         self.Owner:IncXP("Planting",math.Clamp(math.Round(50 / self.Owner:GetSkill("Planting")),1 , 1000))
         self.Owner:SendMessage("Successfully planted.", 3, Color(10,200,10,255))
         
         local ent = ents.Create("gms_seed")
		 ent:CPPISetOwner(self.Owner)
         ent:SetPos(self.Data.Pos)
         local tbl = ent:GetTable()
		 local isupgraded = 0
		 if self.Owner.Upgrades["Advanced_Fertilizer"] == 1 then
			isupgraded = 1
		 end
         tbl:Setup("berry",160 - math.Clamp(self.Owner:GetSkill("Planting"),0,60) + math.random(-20,20),self.Owner,isupgraded)
         ent:Spawn()

         self.Owner:Freeze(false)
end

GMS.RegisterProcess("PlantBush",PROCESS)

/*---------------------------------------------------------
  Plant Tree
---------------------------------------------------------*/
local PROCESS = {}

function PROCESS:OnStart()
         self.Owner:MakeProcessBar("Planting Tree",self.Time)
         self.Owner:Freeze(true)
end

function PROCESS:OnStop()

         self.Owner:DecResource("Tree_Seedlings",1)
         self.Owner:IncXP("Planting",math.Clamp(math.Round(50 / self.Owner:GetSkill("Planting")),1 , 1000))
         self.Owner:SendMessage("Successfully planted.", 3, Color(10,200,10,255))
         
         local ent = ents.Create("gms_seed")
         ent:SetPos(self.Data.Pos)
         local tbl = ent:GetTable()
		 local isupgraded = 0
		 if self.Owner.Upgrades["Advanced_Fertilizer"] == 1 then
			isupgraded = 1
		 end
         tbl:Setup("tree",240 - math.Clamp(self.Owner:GetSkill("Planting"),0,60) + math.random(-20,20),self.Owner,isupgraded)
         ent:Spawn()

         self.Owner:Freeze(false)
end

GMS.RegisterProcess("PlantTree",PROCESS)

/*---------------------------------------------------------
  Assembling
---------------------------------------------------------*/
local PROCESS = {}

function PROCESS:OnStart()
         self.Owner:MakeProcessBar("Assembling",self.Time)
         self.Owner:Freeze(true)
end

function PROCESS:OnStop()
		if self.Owner:GetSkill("Construction") < 1 then
			self.Owner:IncXP("Construction",50,1 , 1000)
		elseif self.Owner:GetSkill("Construction") < 50 then
			self.Owner:IncXP("Construction",25,1 , 1000)
		elseif self.Owner:GetSkill("Construction") < 100 then
			self.Owner:IncXP("Construction",10,1 , 1000)
		else
			self.Owner:IncXP("Construction",1,1 , 1000)
		end
         self.Owner:SendMessage("Assembly successful.", 3, Color(10,200,10,255))
         self.Owner:Freeze(false)
end

GMS.RegisterProcess("Assembling",PROCESS)

/*---------------------------------------------------------
  Fishing
---------------------------------------------------------*/
local PROCESS = {}

function PROCESS:OnStart()
         self.Owner:MakeProcessBar("Fishing",self.Time)
         self.Owner:Freeze(true)
end

function PROCESS:OnStop()
	local num = math.random(1,100)
	if num < self.Data.Chance + self.Owner:GetSkill("Fishing") then
		local max = 4
		if self.Owner:GetSkill("Fishing") > 10 then
			max = 5
		end
		if self.Owner:GetSkill("Fishing") > 20 then
			max = 6
		end
		if self.Owner:GetSkill("Fishing") > 40 then
			max = 7
		end
		if self.Owner:GetSkill("Fishing") > 70 then
			max = 8
		end
		if self.Owner:GetSkill("Fishing") > 100 then
			max = 9
		end
		
		local fish = math.random(1,max)
		if fish < 4 then
			self.Owner:IncResource("Bass",1)
			self.Owner:SendMessage("Bass (1x)", 3, Color(10,200,10,255))
		elseif fish < 6 then
			self.Owner:IncResource("Salmon",1)
			self.Owner:SendMessage("Salmon (1x)", 3, Color(10,200,10,255))
		elseif fish < 8 then
			self.Owner:IncResource("Trout",1)
			self.Owner:SendMessage("Trout (1x)", 3, Color(10,200,10,255))
		else
			self.Owner:IncResource("Shark",1)
			self.Owner:SendMessage("Shark (1x)", 3, Color(10,200,10,255))
		end
	else
		self.Owner:SendMessage("Failed.",3,Color(200,0,0,255))
	end
	self.Owner:IncXP("Fishing",math.Clamp(math.Round(50 / self.Owner:GetSkill("Fishing")),1 , 1000))        
	self.Owner:EmitSound(Sound("ambient/water/water_splash"..math.random(1,3)..".wav"))
	self.Owner:Freeze(false)
end

GMS.RegisterProcess("Fishing",PROCESS)

/*---------------------------------------------------------
  Advanced Fishing
---------------------------------------------------------*/
local PROCESS = {}

function PROCESS:OnStart()
         self.Owner:MakeProcessBar("Fishing",3)
         self.Owner:Freeze(true)
end

function PROCESS:OnStop()
         local num = math.random(1,100)

         if num < self.Data.Chance + self.Owner:GetSkill("Fishing") then
		if num < (self.Data.Chance + self.Owner:GetSkill("Fishing")) / 2 then
			self.Owner:IncResource("Bass",1)
			self.Owner:SendMessage("Bass (1x)", 3, Color(10,200,10,255))
		end
		if num >= (self.Data.Chance + self.Owner:GetSkill("Fishing")) / 2 && num < (self.Data.Chance + self.Owner:GetSkill("Fishing")) / 1.5 then
			self.Owner:IncResource("Trout",1)
			self.Owner:SendMessage("Trout (1x)", 3, Color(10,200,10,255))
		end
		if num >= (self.Data.Chance + self.Owner:GetSkill("Fishing")) / 1.5 && num < (self.Data.Chance + self.Owner:GetSkill("Fishing")) / 1.2 then
			self.Owner:IncResource("Salmon",1)
			self.Owner:SendMessage("Salmon (1x)", 3, Color(10,200,10,255))
		end
		if num >= (self.Data.Chance + self.Owner:GetSkill("Fishing")) / 1.2 && num < self.Data.Chance + self.Owner:GetSkill("Fishing") then
			self.Owner:IncResource("Shark",1)
			self.Owner:SendMessage("Shark (1x)", 3, Color(10,200,10,255))
		end

            self.Owner:IncXP("Fishing",math.Clamp(math.Round(50 / self.Owner:GetSkill("Fishing")),1 , 1000))        
            self.Owner:EmitSound(Sound("ambient/water/water_splash"..math.random(1,3)..".wav"))
         else
            self.Owner:SendMessage("Failed.",3,Color(200,0,0,255))
         end
         
         self.Owner:Freeze(false)
end

GMS.RegisterProcess("AdvancedFishing",PROCESS)

/*---------------------------------------------------------
  Bottle Water
---------------------------------------------------------*/
local PROCESS = {}

function PROCESS:OnStart()
         self.Owner:MakeProcessBar("Bottling Water",self.Time)
         self.Owner:Freeze(true)
end

function PROCESS:OnStop()
		local level = self.Owner:GetSkill("Harvesting")
		local Bottles = level / 10
		Bottles = math.floor(Bottles)
		if Bottles < 1 then
			Bottles = 1
		end
         self.Owner:IncResource("Water_Bottles",Bottles)
		 self.Owner:IncXP("Harvesting",math.Clamp(math.Round(50 / self.Owner:GetSkill("Harvesting")),1 , 1000))
         self.Owner:SendMessage("Water Bottle ("..Bottles..")", 3, Color(10,200,10,255))
		 self.Owner:EmitSound(Sound("ambient/water/water_spray"..math.random(1,3)..".wav"))

         self.Owner:Freeze(false)
end

GMS.RegisterProcess("BottleWater",PROCESS)

/*---------------------------------------------------------
  Drink bottle
---------------------------------------------------------*/
local PROCESS = {}

function PROCESS:OnStart()
         self.Owner:MakeProcessBar("Drinking Bottle",self.Time)
         self.Owner:Freeze(true)
         self.StartTime = CurTime()
         
         self:PlaySound()
end

function PROCESS:PlaySound()
         if CurTime() - self.StartTime > self.Time then return end
         
		 if self.Owner:Alive() then
			 self.Owner:GetActiveWeapon():SendWeaponAnim(ACT_VM_HITCENTER)
			 self.Owner:EmitSound(Sound("npc/barnacle/barnacle_gulp"..math.random(1,2)..".wav"))
			 
			 timer.Simple(0.75,self.PlaySound,self)
		 end
end

function PROCESS:OnStop()
         self.Owner:DecResource("Water_Bottles",1)
         self.Owner:SendMessage("You're a little less thirsty now.", 3, Color(10,200,10,255))
	 if self.Owner.Thirst <= 750 then
         	self.Owner:SetThirst(self.Owner.Thirst + 250)
         elseif self.Owner.Thirst >= 750 then
		self.Owner:SetThirst(1000)
         end
         self.Owner:Freeze(false)
end

GMS.RegisterProcess("DrinkBottle",PROCESS)

/*---------------------------------------------------------
Eat Berries
---------------------------------------------------------*/
local PROCESS = {}

function PROCESS:OnStart()
         self.Owner:MakeProcessBar("Eating Berries",self.Time)
         self.Owner:Freeze(true)
         self.StartTime = CurTime()
         
         self:PlaySound()
end

function PROCESS:PlaySound()
         if CurTime() - self.StartTime > self.Time then return end
         
		 if self.Owner:Alive() then
			 self.Owner:GetActiveWeapon():SendWeaponAnim(ACT_VM_HITCENTER)
			 self.Owner:EmitSound(Sound("npc/barnacle/barnacle_gulp"..math.random(1,2)..".wav"))
			 
			 timer.Simple(0.75,self.PlaySound,self)
		 end
end

function PROCESS:OnStop()
         self.Owner:DecResource("Berries",5)
         self.Owner:SendMessage("You're less hurgy now.", 3, Color(10,200,10,255))
	 if self.Owner.Hunger <= 500 then
         	self.Owner:SetFood(self.Owner.Food + 500)
     elseif self.Owner.Hunger >= 500 then
		self.Owner:SetFood(1000)
     end
         self.Owner:Freeze(false)
end

GMS.RegisterProcess("EatBerries",PROCESS)

/*---------------------------------------------------------
  Cooking
---------------------------------------------------------*/
local PROCESS = {}

function PROCESS:OnStart()
         self.Owner:MakeProcessBar("Cooking "..self.Data.Name,self.Time)
         self.Owner:Freeze(true)
         self.Sound = CreateSound(self.Owner,Sound("npc/headcrab/headcrab_burning_loop2.wav"))
         self.Sound:Play()
end

function PROCESS:OnStop()
         local num = math.random(1,100)
         
         if num + self.Owner:GetSkill("Cooking") >= 50 then
            self.Owner:SendMessage("Successfully cooked.", 3, Color(10,200,10,255))
            self.Owner:IncXP("Cooking",math.Clamp(math.Round(50 / self.Owner:GetSkill("Cooking")),1 , 1000))

            local food = ents.Create("gms_food")
            food:SetPos(self.Owner:TraceFromEyes(70).HitPos + Vector(0,0,5))
			food:CPPISetOwner(self.Owner)
            food.Value = self.Data.FoodValue
            food:Spawn()

            food:SetFoodInfo(self.Data.Name)
            
            for k,v in pairs(self.Data.Cost) do
                self.Owner:DecResource(k,v)
            end
         else
            self.Owner:SendMessage("Failed.", 3, Color(200,0,0,255))
            
            local num = math.random(1,2)
            
            if num == 1 then
               for k,v in pairs(self.Data.Cost) do
                   self.Owner:DecResource(k,v)
               end
               
               self.Owner:SendMessage("The ingredients were wasted!",3,Color(200,0,0,255))
            end
         end

         self.Sound:Stop()
         self.Owner:Freeze(false)
end

GMS.RegisterProcess("Cook",PROCESS)
/*---------------------------------------------------------
  Make Weapon
---------------------------------------------------------*/
local PROCESS = {}

function PROCESS:OnStart()
         self.Owner:MakeProcessBar("Crafting "..self.Data.Name,self.Time)
         self.Owner:Freeze(true)
end

function PROCESS:OnStop()
	self.Owner:SendMessage("Made a "..self.Data.Name..".", 3, Color(10,200,10,255))
	self.Owner:IncXP("Weapon_Crafting",math.Clamp(math.Round(250 / self.Owner:GetSkill("Weapon_Crafting")),1 , 1000))
	if self.Owner.AWOLGiveAchievment then
		if self.Data.Name == "Gold Pickaxe" then
			self.Owner:AWOLGiveAchievment("CNS_MAKEGOLD")
		end
	end
	self.Owner:Give(self.Data.Class)

	EffectFunc(self.Owner:GetShootPos(), 0, "GMS_MAkeWeaponEffect")
	for k,v in pairs(self.Data.Cost) do
		self.Owner:DecResource(k,v)
	end


	self.Owner:Freeze(false)
end

GMS.RegisterProcess("MakeWeapon",PROCESS)
/*---------------------------------------------------------
  MakeGeneric
---------------------------------------------------------*/
local PROCESS = {}

function PROCESS:OnStart()
         self.Owner:MakeProcessBar("Making "..self.Data.Name,self.Time)
         self.Owner:Freeze(true)
end

function PROCESS:OnStop()
         for k,v in pairs(self.Data.Cost) do
             self.Owner:DecResource(k,v)
         end

         for k,v in pairs(self.Data.Res) do
             self.Owner:SendMessage("Made "..string.gsub(k,"_"," ").." ("..v.."x)", 3, Color(10,200,10,255))
             self.Owner:IncResource(k,v)
         end

         self.Owner:Freeze(false)
end

GMS.RegisterProcess("MakeGeneric",PROCESS)
/*---------------------------------------------------------
  Make Building
---------------------------------------------------------*/
local PROCESS = {}

function PROCESS:OnStart()
         self.Owner:MakeProcessBar("Setting up "..self.Data.Name.." site",self.Time)
         self.Owner:Freeze(true)
end

function PROCESS:OnStop()
         self.Owner:SendMessage("Made a "..self.Data.Name.." site.", 3, Color(10,200,10,255))
		if self.Owner:GetSkill("Construction") < 1 then
			self.Owner:IncXP("Construction",100,1 , 1000)
		elseif self.Owner:GetSkill("Construction") < 50 then
			self.Owner:IncXP("Construction",50,1 , 1000)
		elseif self.Owner:GetSkill("Construction") < 100 then
			self.Owner:IncXP("Construction",25,1 , 1000)
		else
			self.Owner:IncXP("Construction",5,1 , 1000)
		end
         
        if(self.Owner:GetBuildingSite() and self.Owner:GetBuildingSite():IsValid()) then
			self.Owner:GetBuildingSite():Remove()
		end
		
		 local pos = self.Owner:TraceFromEyes(250).HitPos
         local site = self.Owner:CreateStructureBuildingSite(pos, self.Owner:GetAngles(),self.Data.BuildSiteModel,self.Data.Class,self.Data.Cost,self.Data.Name)
		
         self.Owner:Freeze(false)
end

GMS.RegisterProcess("MakeBuilding",PROCESS)

/*---------------------------------------------------------
  Make Special Building
---------------------------------------------------------*/
local PROCESS = {}

function PROCESS:OnStart()
	self.Owner:MakeProcessBar("Setting up "..self.Data.Name.." site",self.Time)
	self.Owner:Freeze(true)
end

function PROCESS:OnStop()
		if self.Owner.Upgrades[self.Data.Trophy] then
			if self.Owner.Upgrades[self.Data.Trophy] == 1 then
				self.Owner:SendMessage("Made a "..self.Data.Name.." site.", 3, Color(10,200,10,255))
				 
				if(self.Owner:GetBuildingSite() and self.Owner:GetBuildingSite():IsValid()) then
					self.Owner:GetBuildingSite():Remove()
				end
				
				if self.Owner.AWOLGiveAchievment then
					if self.Data.Name == "StargateSG1" then
						self.Owner:AWOLGiveAchievment("CNS_STARGATE")
					end
				end
				
				local pos = self.Owner:TraceFromEyes(250).HitPos
				local site = self.Owner:CreateStructureBuildingSite(pos, self.Owner:GetAngles(),self.Data.BuildSiteModel,self.Data.Class,self.Data.Cost,self.Data.Name)
			else
				self.Owner:SendMessage("You need to have the "..self.Data.Trophy.." upgrade to build this", 3, Color(10,200,10,255))
			end
		else
			self.Owner:SendMessage("You need to have the "..self.Data.Trophy.." upgrade to build this", 3, Color(10,200,10,255))
		end
         self.Owner:Freeze(false)
end

GMS.RegisterProcess("MakeSpecialBuilding",PROCESS)
/*---------------------------------------------------------
  Smelt
---------------------------------------------------------*/
local PROCESS = {}

function PROCESS:OnStart()
		self.Owner:MakeProcessBar("Smelting "..self.Data.Name,self.Time)
		self.Owner:Freeze(true)
end

function PROCESS:OnStop()
	 for k,v in pairs(self.Data.Cost) do
		 self.Owner:DecResource(k,v)
	 end

	 for k,v in pairs(self.Data.Res) do
		 self.Owner:SendMessage("Made "..string.gsub(k,"_"," ").." ("..v.."x)", 3, Color(10,200,10,255))
		 self.Owner:IncResource(k,v)
	 end
	 self.Owner:IncXP("Smithing",math.Clamp(math.Round((50 / self.Owner:GetSkill("Smithing")) *self.Data.Amount2),1 , 1000))

	 self.Owner:Freeze(false)
end

GMS.RegisterProcess("Smelt",PROCESS)

/*---------------------------------------------------------
  Crush
---------------------------------------------------------*/
local PROCESS = {}

function PROCESS:OnStart()
         self.Owner:MakeProcessBar("Crushing "..self.Data.Name,self.Time)
         self.Owner:Freeze(true)
end

function PROCESS:OnStop()
         for k,v in pairs(self.Data.Cost) do
             self.Owner:DecResource(k,v)
         end

         for k,v in pairs(self.Data.Res) do
             self.Owner:SendMessage("Made "..string.gsub(k,"_"," ").." ("..v.."x)", 3, Color(10,200,10,255))
             self.Owner:IncResource(k,v)
         end

         self.Owner:Freeze(false)
end

GMS.RegisterProcess("Crush",PROCESS)

/*---------------------------------------------------------
  Processing
---------------------------------------------------------*/
local PROCESS = {}

function PROCESS:OnStart()
         self.Owner:MakeProcessBar("Processing "..self.Data.Name,self.Time)
         self.Owner:Freeze(true)
end

function PROCESS:OnStop()
         for k,v in pairs(self.Data.Cost) do
             self.Owner:DecResource(k,v)
         end

         for k,v in pairs(self.Data.Res) do
             self.Owner:SendMessage("Made "..string.gsub(k,"_"," ").." ("..v.."x)", 3, Color(10,200,10,255))
             self.Owner:IncResource(k,v)
         end

         self.Owner:Freeze(false)
end

GMS.RegisterProcess("Processing",PROCESS)
/*--------------------------------------------------------
Trading
---------------------------------------------------------*/
local PROCESS = {}

function PROCESS:OnStart()
		self.Owner:MakeProcessBar("Trading"..self.Data.Name,self.Time)
		self.Owner:Freeze(true)
end

function PROCESS:OnStop()
	 for k,v in pairs(self.Data.Cost) do
		 self.Owner:DecResource(k,v)
	 end

	 for k,v in pairs(self.Data.Res) do
		 self.Owner:SendMessage("Traded for "..string.gsub(k,"_"," ").." ("..v.."x)", 3, Color(10,200,10,255))
		 self.Owner:IncResource(k,v)
	 end
	 self.Owner:IncXP("Weapon_Crafting",math.Clamp(math.Round((250 / self.Owner:GetSkill("Weapon_Crafting")) *self.Data.Amount2),1 , 1000))

	 self.Owner:Freeze(false)
end

GMS.RegisterProcess("Trade",PROCESS)

/*---------------------------------------------------------