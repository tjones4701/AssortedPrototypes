AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

--Called when an entity is no longer touching this SENT.
--Return: Nothing
function ENT:EndTouch(entEntity)
end

--Called when the SENT is spawned
--Return: Nothing

function ENT:Initialize()
	self.Entity:SetModel("models/props_c17/furnituresink001a.mdl")
 	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetColor(255,255,255,255)
	self.Entity.Water = 0
end

function ENT:Use(ply)
	
		if ply.NextDrink == nil then
			ply.NextDrink = CurTime()
		end
	if ply.NextDrink < CurTime() then	
		ply.NextDrink = CurTime() + 1
		if self.Entity.Water > 0 then
			self.Entity.Water = self.Entity.Water - 1
			if ply.Thirst > 750 && ply.Thirst < 975 then
				ply.Thirst = 1000
				ply:UpdateNeeds()
				ply:EmitSound(Sound("npc/barnacle/barnacle_gulp"..math.random(1,2)..".wav"))	
			elseif ply.Thirst < 750 then
				ply.Thirst = ply.Thirst + 250
				ply:EmitSound(Sound("npc/barnacle/barnacle_gulp"..math.random(1,2)..".wav"))			
				ply:UpdateNeeds()
			else
				ply:SendMessage( "You don't need to drink.",3,Color(0,180,255,255))
			end
		else
			local value = 5
			local res = "Water_Bottles"
			local needed = math.floor((100 - self.Entity.Water) / value)
			if needed > 0 then
				if ply.Resources[res] == nil then
					ply.Resources[res] = 0
				end
				local amount = ply.Resources[res]
				if amount < 1 then
					res = "Acidic_Water"
					value = 10
					if ply.Resources[res] == nil then
						ply.Resources[res] = 0
					end
				end
				needed = math.floor((100 - self.Entity.Water) / value)
				amount = ply.Resources[res]
				if amount > needed then 
					amount = needed
				end
				if amount >= 1 then
					self.Entity.Water = self.Entity.Water + (amount * value)
					if self.Entity.Water > 100 then
						self.Entity.Water = 100
					end
					ply:SendMessage( "You have used "..amount.." "..res.." to put water in the fountain.",3,Color(0,180,255,255))
					ply:DecResource(res,amount)
				else
					ply:SendMessage( "You need Water Bottles or Acidic Water to refill it.",3,Color(0,180,255,255))
				end
			else
				ply:SendMessage( "It doesn't need refilling.",3,Color(0,180,255,255))
			end
		end
		self.Entity:SetNetworkedInt("WaterAmount",self.Entity.Water)
	end
end

function ENT:AcceptInput(input, ply)
end

--Called when the entity key values are setup (either through calls to ent:SetKeyValue, or when the map is loaded).
--Return: Nothing
function ENT:KeyValue(k,v)
end

--Called when a save-game is loaded.
--Return: Nothing
function ENT:OnRestore()
end

--Called when something hurts the entity.
--Return: Nothing
function ENT:OnTakeDamage(dmiDamage)
end

--Controls/simulates the physics on the entity.
--Return: (SimulateConst) sim, (Vector) linear_force and (Vector) angular_force
function ENT:PhysicsSimulate(pobPhysics,numDeltaTime)
end

--Called when an entity starts touching this SENT.
--Return: Nothing
function ENT:StartTouch(entEntity)
end

--Called when the SENT thinks.
--Return: Nothing
function ENT:Think()
end

--Called when an entity touches this SENT.
--Return: Nothing
function ENT:Touch(entEntity)
end

--Called when: ?
--Return: TRANSMIT_ALWAYS, TRANSMIT_NEVER or TRANSMIT_PVS
function ENT:UpdateTransmitState(entEntity)
end