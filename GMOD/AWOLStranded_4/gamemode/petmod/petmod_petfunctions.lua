

function PetMod_AdoptAfterEgg(ply, Pet, PetType, Pos)
	if ply.PetMod.Egg.Active == 1 then
		local Ent = ents.Create(Pet)
		Ent:SetPos(Pos)
		Ent:AddEntityRelationship(ply, 3, 99)
		Ent:Spawn()
		Ent:Activate()
		Ent:SetName("SPM-Pet")
		Ent:SetMaxHealth(PetMod_Config.SpawnHealth)
		Ent:SetHealth(PetMod_Config.SpawnHealth)	
		Ent:CPPISetOwner(ply)
		ply.PetMod.Egg.Active = 0	
		if ply.PetMod then
		else
			ply.PetMod = {}
			ply.PetMod.Pet = {}
		end
		if ply.PetMod.Pet then
		else
			ply.PetMod.Pet = {}
		end
		local e = ply.PetMod.Pet
		ply.PetMod.Pet.Hunger = 100
		e.Active = 1
		e.Age =  1
		e.Mood = 100
		e.Respect = 100
		e.Index = Ent:EntIndex()
		e.Action = "Wander"
		e.Name = PetMod_Config.PetNames[math.random(#PetMod_Config.PetNames)]
		e.Gender = ""
		e.Type = PetType
		if(math.random(1, 2) == 1) then
			e.Gender = "Male"
		else
			e.Gender = "Female"
		end
		
		
		ply:SetNetworkedBool("HasPet", true)
		ply:SetNetworkedEntity("Pet", PetMod_GetPlayersPet(ply))
		
		PetMod_GetPlayersPet(ply):SetNetworkedBool("IsPet", true)
		PetMod_GetPlayersPet(ply):SetNetworkedString("Name", e.Name)
		PetMod_GetPlayersPet(ply):SetNetworkedEntity("Player", ply)
		PetMod_GetPlayersPet(ply):SetNetworkedString("Age", e.Age)
		PetMod_GetPlayersPet(ply):SetNetworkedString("Gender", e.Gender)
		
		PetMod_EntityRelationshipNPC(ply)	
		PetMod_PlayerRelationship(PetMod_GetPlayersPet(ply))
		ply:SendMessage( ply:Nick().." adopted a "..string.lower(e.Gender).." "..e.Type,3,Color(200,0,0,255))
	end
end

function PetMod_Adopt(ply,cmd, args)
	if ply.Upgrades["Mans_Best_Friend"] == 1 then
		if args[1] then
		if PetMod_GetPlayersPet(ply) then
			ply:SendMessage( "You already have a pet..",3,Color(200,0,0,255))
		elseif PetMod_GetPlayersEgg(ply) then
			PetMod_GetPlayersEgg(ply):Remove()
			ply:SendMessage( "Your old egg has been removed.",3,Color(200,0,0,255))
		else
			local name = args[1]
			local Pet = "npc_"..string.lower(args[1])
			

			if !ply:IsAdmin() and table.HasValue(PetMod_Config.AdminAdoptablePets, Pet) then
				ply:SendMessage( "You can't adopt this kind of pet.",3,Color(200,0,0,255))
				return
			
			elseif !table.HasValue(PetMod_Config.AdoptablePets, Pet)  then
				ply:SendMessage( "You can't adopt that kind of pet.",3,Color(200,0,0,255))
				return
			end
			
			local tr = PetMod_TraceLine(ply)
			if(tr.NonHitWorld) then
				ply:SendMessage( "Look at the ground when adopting a pet.",3,Color(200,0,0,255))
				return
			end
			local Egg = ents.Create("spm_egg")
			Egg:SetPos(tr.HitPos + Vector(0, 0, 8.5))
			Egg:Spawn()
			Egg:Activate()
			Egg.Owner = ply
			Egg.PetType = Pet
			Egg:SetNetworkedString("Pet", Pet)
			Egg:SetNetworkedString("PetType", Pet)
			Egg:SetNetworkedEntity("Player", ply)
			Egg:SetNetworkedString("Tooltip", ply:Nick().."'s "..Pet.." Egg")
			ply.PetMod.Egg.Index = Egg:EntIndex()
			ply.PetMod.Egg.Active = 1
			ply:SendMessage( "You have recieved a "..Pet.." egg. Please protect it and wait for it to hatch",3,Color(200,0,0,255))
			Egg:CPPISetOwner(ply)
		end
		else
			ply:SendMessage( "You need a pet type. See the menu for details.",3,Color(200,0,0,255))
		end
	else
		ply:SendMessage( "You need the 'Mans_Best_Friend' trophy to make this.",3,Color(200,0,0,255))
	end
end

concommand.Add("gms_pet_Adopt",PetMod_Adopt)







function PetMod_Attack(ply,cmd, args)
	if args[1] then
		if PetMod_CheckPlayers(args[1],ply) then
			local target = PetMod_CheckPlayers(args[1],ply)
			if target == ply then
				if PetMod_GetPlayersPet(ply) then
					local ent = PetMod_GetPlayersPet(ply)
					if ent.Attack then
					else
						ent.Attack = {}
					end
					if(table.HasValue(ent.Attack, target)) then
						PetMod_GetPlayersPet(ply):AddEntityRelationship(target, 3, 99)
						ply:SendMessage( "Your pet will no longer attack "..string.lower(target:Nick()),3,Color(200,0,0,255))
						for k2,v2 in pairs(ent.Attack) do
							if(target == v2) then
								v2 = nil
							end
						end
					else
						table.insert(ent.Attack, target)
						PetMod_GetPlayersPet(ply):AddEntityRelationship(target, 1, 99)
						PetMod_GetPlayersPet(ply):SetLastPosition(target:GetPos())
						PetMod_GetPlayersPet(ply):SetSchedule(71)
						ply:SendMessage( "Your pet will now attack "..string.lower(target:Nick()),3,Color(200,0,0,255))
					end	
					ply.PetMod.Pet.Action = "Follow"
				else
					ply:SendMessage( "You don't even have a pet.",3,Color(200,0,0,255))
				end	
			else
				ply:SendMessage( "Your pet loves you to much to do that.",3,Color(200,0,0,255))
			end
		else
			ply:SendMessage( "Invalid victim.",3,Color(200,0,0,255))
		end
	else
		ply:SendMessage( "You need to have a name for the player to attack.",3,Color(200,0,0,255))
	end
end

--concommand.Add("gms_pet_attack",PetMod_Attack)


function PetMod_Feed(ply)
	if PetMod_GetPlayersPet(ply) then
		local ent = PetMod_GetPlayersPet(ply)
		if (ent:GetPos() - ply:GetPos()):Length() > 200 then
			ply:SendMessage( "You must be close to your pet to feed it.",3,Color(200,0,0,255))
			return
		else
			local canfood = 0
			local res = "NA"
			for k,v in pairs(ply.Resources) do 
				if table.HasValue(PetMod_Config.Food,k) && v > 4.9 then 
					canfood = 1
					res = k
				end
			end
			
			if canfood == 1 then
				ply:DecResource(res,5)
				ply.PetMod.Pet.Hunger = ply.PetMod.Pet.Hunger + 100
			if ply.PetMod.Pet.Hunger > 100 then
				ply.PetMod.Pet.Hunger = 100
			end
			PetMod_Heal(ply,50)
			ply:SendMessage( "You have fed your pet.",3,Color(200,0,0,255))
			else
				ply:SendMessage( "You need 5 Berries,5 Meat,5 Grain, 5 Herbs or 5 Leaves.",3,Color(200,0,0,255))
			end
		end
	end
end

concommand.Add("gms_pet_feed",PetMod_Feed)




function PetMod_Follow(ply)
	if PetMod_GetPlayersPet(ply) then
		ply:SendMessage( "You pet has started following you.",3,Color(200,0,0,255))
		ply.PetMod.Pet.Action = "Follow"
	end
end

concommand.Add("gms_pet_follow",PetMod_Follow)

function PetMod_Roam(ply)
	if PetMod_GetPlayersPet(ply) then
		ply:SendMessage( "Your pet will now do what it wants.",3,Color(200,0,0,255))
		ply.PetMod.Pet.Action = "Wander"
	end
end
concommand.Add("gms_pet_wander",PetMod_Roam)

function KillPet(ply)
	if PetMod_GetPlayersPet(ply) then
		PetMod_KillPet(ply)
		ply:SendMessage( "You have killed your pet. You heartless asshole.",3,Color(200,0,0,255))
	end
end

concommand.Add("gms_pet_kill_yousure",KillPet)



function PetMod_Heal(ply,amount)
	if PetMod_GetPlayersPet(ply) then
		local pet = PetMod_GetPlayersPet(ply)
		local PetHealth = pet:Health()
		local PetMaxHealth = pet:GetMaxHealth()
		
		if(PetHealth == PetMaxHealth) then
			ply:SendMessage( "You don't need to heal your pet.",3,Color(200,0,0,255))
		else
			if PetHealth + amount >= PetMaxHealth then
				pet:SetHealth(PetMaxHealth)
			else
				pet:SetHealth(PetHealth + amount)
			end
			ply:SendMessage( "Your pet healed.",3,Color(200,0,0,255))
		end
	end
end



function PetMod_Move(ply)
	if PetMod_GetPlayersPet(ply) then
		local pet = PetMod_GetPlayersPet(ply)
		ply.PetMod.Pet.Action = "Wander"
			
		local tr = PetMod_TraceLine(ply)
		pet:SetLastPosition(tr.HitPos)
		pet:SetSchedule(71)
		ply:SendMessage( "Your pet is now moving.",3,Color(200,0,0,255))
	end
end

concommand.Add("gms_pet_Move",PetMod_Move)

function PetMod_Name(ply,cmd,args)	
	local name = args[1]
	if PetMod_GetPlayersPet(ply) && name then
		ply.PetMod.Pet.Name = name
		PetMod_GetPlayersPet(ply):SetNetworkedString("Name", name)
		ply:SendMessage( "Your new pets name is "..args[1]..".",3,Color(200,0,0,255))
	end
end

concommand.Add("gms_pet_name",PetMod_Name)

function PetMod_Stay(ply)	
	if PetMod_GetPlayersPet(ply) then
		ply:SendMessage( "Your pet is now staying.",3,Color(200,0,0,255))
		ply.PetMod.Pet.Action = "Stay"
	end
end

concommand.Add("gms_pet_stay",PetMod_Stay)