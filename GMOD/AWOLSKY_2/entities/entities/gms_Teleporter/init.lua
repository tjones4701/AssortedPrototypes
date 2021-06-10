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
 	 self.Entity:SetColor(255,255,255,255)
	 self.Entity:SetModel("models/props_lab/teleplatform.mdl")
	 self.Entity:SetMaterial("models/props_combine/metal_combinebridge001")

 	 self.Entity:PhysicsInit( SOLID_VPHYSICS )
	 self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	 self.Entity:SetSolid( SOLID_VPHYSICS )
	 self.Entity.TeleName = "NO_NAME"
	 self.Entity.Time = 0
	 self.Entity.Public = 0
end

function ENT:Use(ply)
	if self.Entity.Time < CurTime() then
		if self.Entity:CPPICanUse(ply) || self.Entity.Public == 1 then
			local tele = {}
			local telename = {}
			local teleowner = {}
			local amount = 0
			for k,v in pairs (ents.FindByClass("gms_teleporter")) do
				if v:CPPICanUse(ply) || v.Public == 1 then
					if v.TeleName && (v != self.Entity) then
						 local ply,uid = v:CPPIGetOwner()
						amount = amount + 1
						tele[amount] = v
						telename[amount] = v.TeleName
						if ply then
							teleowner[amount] = ply:Nick()
						end
					end
				end
			end
			SendTeleInfo(ply,tele,telename,teleowner,self.Entity,self.Entity.TeleName)
			self.Entity.Time = CurTime() + 5
		end		
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