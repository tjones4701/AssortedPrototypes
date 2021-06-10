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
	self.Entity:SetModel("models/props/cs_militia/microwave01.mdl")
 	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
 	self.Entity:SetColor(255,255,255,255)
	self.Entity.MaxCapacity = 10
	self.Entity.Res = "NA"
	self.Entity.CurrentCapacity = 0
	self.Entity.TimeLapse = 60
	self.Entity.Rate = 5
	self.Entity.Timer2 = 0 
	self.Entity.Timer = CurTime() + self.Entity.TimeLapse
	self.Entity.Fuel = 50
	self.Entity.FuelRate = 25
	self.Entity.MaxFuel = 50
	self.Entity.OpenTime = 0
	self.Entity.Upgrades = {}
	self.Entity.Upgrades["MaxCapacity"] = 1
	self.Entity.Upgrades["CurrentCapacity"] = 1
	self.Entity.Upgrades["TimeLapse"] = 1
	self.Entity.Upgrades["Rate"] = 1
	self.Entity.Upgrades["FuelRate"] = 1
	self.Entity.Upgrades["MaxFuel"] = 1
end

function DropRes(resource,int,entity)
		local ent = ents.Create("gms_resourcedrop")
		ent:SetPos(entity:GetPos() + Vector(0,0,50))
		ent:SetAngles(entity:GetAngles())
		
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
		local ply,uid = self.Entity:CPPIGetOwner()
		if uid then
			ent:CPPISetOwnerUID(uid)
		end
end


function ENT:Use(ply)
	if self.Entity.OpenTime < CurTime() then
		OpenCloneMenu(ply,self.Entity)
		self.Entity.OpenTime = CurTime() + 1
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
	if self.Entity.Timer < CurTime() then
		local ent = self.Entity
		ent.Timer = CurTime() + self.Entity.TimeLapse
		if ent.Res != "NA" then
			if (ent.CurrentCapacity < ent.MaxCapacity) && (ent.Fuel > 0) then
				ent.CurrentCapacity = ent.CurrentCapacity + ent.Rate
				ent.Fuel = ent.Fuel - ent.FuelRate
				EffectFunc(self.Entity:GetPos(), 0, "GMS_Smoke_1_grey")
			end
			if !(ent.Fuel > 0) then
				ent.Fuel = 0
			end
			if !(ent.CurrentCapacity < ent.MaxCapacity)then
				ent.CurrentCapacity = ent.MaxCapacity
			end
		else
			ent.CurrentCapacity = 0
		end
	end
	if self.Entity.Timer2 < CurTime() then
		local ent = self.Entity
		local colour1 = 0
		local colour2 = 0
		self.Entity.Timer2 = CurTime() + 1
		if !(ent.Fuel > 0) then
			ent.Fuel = 0
			colour1 = 255
		end
		if !(ent.CurrentCapacity < ent.MaxCapacity)then
			ent.CurrentCapacity = ent.MaxCapacity
			colour2 = 255
		end
		self.Entity:SetColor(255 - colour1,255 - colour2,255,255)
	end
end

--Called when an entity touches this SENT.
--Return: Nothing
function ENT:Touch(entity)

end


--Called when: ?
--Return: TRANSMIT_ALWAYS, TRANSMIT_NEVER or TRANSMIT_PVS
function ENT:UpdateTransmitState(entEntity)
end