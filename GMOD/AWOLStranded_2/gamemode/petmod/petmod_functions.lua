function PetMod_IsPetOwner(ply,ent)
	if ent:IsNPC() && ply:IsPlayer() then
		local e = ply.PetMod.Pet
		if ent:CPPIGetOwner() == ply && e.Active == 1 && e.Index == ent:EntIndex() then
			return true
		else
			return false
		end
	end
end

function PetMod_PlayerRelationshipNPC(ply)
    for k,v in pairs(ents.FindByClass("npc_*")) do
	    if(v:GetName() == "SPM-Pet") then
			v:AddEntityRelationship(ply, 4, 99)
		end
    end
end

function PetMod_GetPlayersPet(ply)
	if ply:IsPlayer() then
		if ply.PetMod then
			if ply.PetMod.Pet then
				if ply.PetMod.Pet.Active == 1 then
					local ent = Entity(ply.PetMod.Pet.Index)
					if ValidEntity(ent) then
						return ent
					end
				end
			end
		end
	end
	return nil
end

function PetMod_GetPlayersEgg(ply)
	if ply:IsPlayer() then
		if ply.PetMod then
			if ply.PetMod.Egg then
				if ply.PetMod.Egg.Active == 1 then
					local ent = Entity(ply.PetMod.Egg.Index)
					if ValidEntity(ent) then
						return ent
					end
				end
			end
		end
	end
	return nil
end

function PetMod_HasPet(ply)
	if ply.PetMod.Pet.Active == 1 then
		return true
	end
	return false
end

function PetMod_HasEgg(ply)
	if ply.PetMod.Egg.Active == 1 then
		return true
	end
	return false
end

function PetMod_KillEgg(ply)
	if	PetMod_HasEgg(ply) then
		local ent = PetMod_GetPlayersPet(ply)
		ent:Remove()
		ply.PetMod.Egg.Active = 1
	end
end

function PetMod_EntityRelationshipNPC(ply)
	if PetMod_GetPlayersPet(ply) then
		local ent = PetMod_GetPlayersPet(ply)
		for k,v in pairs(ents.FindByClass("npc_*")) do
			if(v:GetName() == "SPM-Pet") then
				ent:AddEntityRelationship(v, 3, 99)
				v:AddEntityRelationship(ent, 3, 99)
			else
				ent:AddEntityRelationship(v, 1, 99)
				v:AddEntityRelationship(ent, 1, 99)
			end
		end
	end
end

function PetMod_PlayerRelationship(ent)
	if ValidEntity(ent) then
		for k,v in pairs(player.GetAll()) do
			ent:AddEntityRelationship(v, 3, 99)
		end
	end
end

function PetMod_KillPet(ply)
	if PetMod_GetPlayersPet(ply) then
		local ent = PetMod_GetPlayersPet(ply)
		local Pos = ent:GetPos()
		local Model = ent:GetModel()
		local Color = ent:GetColor()
		local ColorR, ColorG, ColorB, ColorA = ent:GetColor()
		ColorA = 255
		
		ent:Remove()
		
		ply.PetMod.Pet.Active = 0
	
		ply:SetNetworkedBool("HasPet", false)
	end
end

function PetMod_TraceLine(ply)
	local Trace = util.GetPlayerTrace(ply)	
	return util.TraceLine(Trace)
end



function PetMod_UpperFirst(String)
	return string.upper(string.sub(String, 0, 1))..string.lower(string.sub(String, 2))
end

function PetMod_CheckPlayers(name,ply)
	local amount = 0
	local re = nil
	for k,v in pairs(player.GetAll()) do 
		if string.find(string.lower(v:Nick()),string.lower(name)) then
			amount = amount + 1
			re = v
		end
	end
	if amount == 1 && !(re == nil) then
		return re
	end
	return nil
end
