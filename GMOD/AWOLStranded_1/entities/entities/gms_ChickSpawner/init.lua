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
 	 self.Entity:SetColor(255,0,0,255)
	 self.Entity:SetModel("models/props_lab/jar01a.mdl")

 	 self.Entity:PhysicsInit( SOLID_VPHYSICS )
	 self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	 self.Entity:SetSolid( SOLID_VPHYSICS )
	 self.Entity.Timer = 0
	 self.Entity.ChickenSpawn = 1


end

function ENT:Use(ply)
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
	if self.Entity.Timer < CurTime() then
		self.Entity.Timer = CurTime() + 60
		local Amount = 0
		for k,v in pairs (ents.FindByClass("sent_Chicken")) do
			Amount = Amount + 1
		end
		if Amount < 10 then
			-- Spawn the chicken
			local pos = self.Entity:GetPos() + Vector(0,0,60)
			local chicken = ents.Create( "sent_chicken" )
			chicken:SetPos( pos )
			chicken:Spawn()
			chicken:Activate()
			local ply,uid = self.Entity:CPPIGetOwner()
			if uid then
				chicken:CPPISetOwnerUID(uid)
			end
		end
	end
end

--Called when an entity touches this SENT.
--Return: Nothing
function ENT:Touch(entEntity)
end

--Called when: ?
--Return: TRANSMIT_ALWAYS, TRANSMIT_NEVER or TRANSMIT_PVS
function ENT:UpdateTransmitState(entEntity)
end