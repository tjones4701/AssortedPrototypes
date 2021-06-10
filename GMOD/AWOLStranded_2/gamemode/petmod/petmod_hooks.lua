------------------------------------
--	Spacetech's Pet Mod
--	File: Hooks.lua
--	By Spacetech
------------------------------------

function PetMod_PlayerInitialSpawn(ply)
	ply.PetMod = {}
	local c = ply.PetMod
	c.Egg = {}
	local e = ply.PetMod.Egg
	e.Active = 0
	e.PetType = "NA"
	e.Index = 0
	c.Pet = {}
	local e = ply.PetMod.Pet
	e.Hunger =0
	e.Active = 0
	e.Age = 0
	e.HP = 0
	e.Mood = 0
	e.Respect = 0
	e.Index = 0
	e.Action = "Wander"
	e.Name = PetMod_Config.PetNames[math.random(#PetMod_Config.PetNames)]
	e.Gender = ""
	e.Type = PetType
	for k,v in pairs(ents.FindByClass("npc_*")) do
		if(v:GetName() == "SPM-Pet") then
			v:AddEntityRelationship(ply, 3, 99)
		end
	end
end
hook.Add("PlayerInitialSpawn", "PetMod_PlayerInitialSpawn", PetMod_PlayerInitialSpawn)

function PetMod_PlayerDisconnected(ply)
	if(PetMod_HasPet(ply)) then
		PetMod_KillPet(ply)
	elseif(PetMod_HasEgg(ply)) then
		PetMod_KillEgg(ply)
	end
end
hook.Add("PlayerDisconnected", "PetMod_PlayerDisconnected", PetMod_PlayerDisconnected)


function PetMod_PlayerSpawnedNPC(ply, ent)
	PetMod_EntityRelationshipNPC(ent)
end
hook.Add("PlayerSpawnedNPC", "PetMod_PlayerSpawnedNPC", PetMod_PlayerSpawnedNPC)

function PetMod_CanTool(ply, tr)
	if(tr.HitWorld) then return end
	ent = tr.Entity
	if(ent:GetClass() == "spm_egg") then
		ply:SendMessage("You can't do that to the pet.",3,Color(200,0,0,255))
		return false
	elseif(ent:GetName() == "SPM-Pet") then
		return false
	end		
end
hook.Add("CanTool", "PetMod_CanTool", PetMod_CanTool)

function PetMod_PhysgunHooks(ply, ent)
	if ply:IsAdmin() then
		return true
	end
	if(!ent:IsValid()) then return end
	
	if(ent:GetClass() == "spm_egg") then
		if ent:CPPIGetOwner() == ply then
			return true
		end
		return false
	elseif(ent:GetName() == "SPM-Pet") then
		if ent:CPPIGetOwner() == ply then
			return true
		end
		return false
	end
end
hook.Add("PhysgunPickup", "PetMod_PhysgunPickup", PetMod_PhysgunHooks)
hook.Add("GravGunPunt", "PetMod_GravGunPunt", PetMod_PhysgunHooks)
hook.Add("GravGunPickupAllowed", "PetMod_GravGunPickupAllowed", PetMod_PhysgunHooks)

function PetMod_OnNPCKilled(victim, killer, weapon)
	local ent = victim
	if ent:IsNPC() then
		for k,v in pairs(player.GetAll()) do
			if ent:CPPIGetOwner() == v && v.PetMod.Pet.Index == ent:EntIndex() then
				PetMod_KillPet(v)
				v:SendMessage("YOUR PET HAS DIED!.",3,Color(200,0,0,255))	
				return
			end
		end
	end
end
hook.Add("OnNPCKilled", "PetMod_OnNPCKilled", PetMod_OnNPCKilled)

