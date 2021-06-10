
PetModTimers = {}
PetModTimers.FS = 0
PetModTimers.HA = 0

function PetModTimer()
	if PetModTimers.HA < CurTime() then
		PetModTimers.HA = CurTime() + 2.5
		for k,v in pairs(player.GetAll()) do 
			if PetMod_GetPlayersPet(v) then
				v.PetMod.Pet.Age = v.PetMod.Pet.Age + .25
				v.PetMod.Pet.Hunger = v.PetMod.Pet.Hunger - .05
				if v.PetMod.Pet.Hunger < 1 then
					v:SendMessage( "Your pet has died of hunger.",3,Color(200,0,0,255))
					PetMod_KillPet(v)
				elseif v.PetMod.Pet.Hunger < 10 then
					v:SendMessage( "Your pet is very hungry, feed it now!",3,Color(200,0,0,255))
				elseif v.PetMod.Pet.Hunger < 30 then
					v:SendMessage( "Your pet is hungry, you need to feed it.",3,Color(200,0,0,255))
				end
				PetMod_GetPlayersPet(v):SetNetworkedString("Age", v.PetMod.Pet.Age)
			end
		end
	end
	if PetModTimers.FS < CurTime() then
		PetModTimers.FS = CurTime() + 1
		for k,v in pairs(player.GetAll()) do 
			if PetMod_GetPlayersPet(v) then
				if v.PetMod.Pet.Action == "Follow" then
					PetMod_GetPlayersPet(v):SetLastPosition(v:GetPos())
					PetMod_GetPlayersPet(v):SetSchedule(71)
				elseif v.PetMod.Pet.Action == "Stay" then
					local StayPos = PetMod_GetPlayersPet(v):GetPos()
					PetMod_GetPlayersPet(v):SetLastPosition(StayPos)
					PetMod_GetPlayersPet(v):SetSchedule(71)	
				end
			end
		end
	end
end

hook.Add("Think","petmod_think",PetModTimer)
