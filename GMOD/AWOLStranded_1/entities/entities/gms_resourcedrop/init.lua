AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:EndTouch(entEntity)
end

function ENT:Initialize()
 	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
 	self.Entity:SetColor(255,255,255,255)
	self.Entity.Type = "Resource"
 	self.Entity.Amount = 0
end

function ENT:AcceptInput(input, ply)
end

function ENT:KeyValue(k,v)
end

function ENT:OnRestore()
end

function ENT:OnTakeDamage(dmiDamage)
end

function ENT:PhysicsSimulate(pobPhysics,numDeltaTime)
end

function ENT:StartTouch(ent)
	local class = ent:GetClass()
	if class == "gms_resourcedrop" and ent.Type == self.Type && !ent.CombiRemoved && !self.CombiRemoved then
		local ply,uid = self:CPPIGetOwner()
		local ply2,uid2 = ent:CPPIGetOwner()
		if plt && ent:CPPICanUse(ply) then
			ent.Amount = self.Amount + ent.Amount
			ent:SetResourceDropInfo(ent.Type,ent.Amount) 
			self.CombiRemoved = true
			self:Remove()
		elseif ply2 && self:CPPICanUse(ply2) then
			self.Amount = self.Amount + ent.Amount
			self:SetResourceDropInfo(self.Type,self.Amount) 
			ent.CombiRemoved = true
			ent:Remove()
		end
	end

	if class == "gms_storagecache" then
		local ply,uid = self:CPPIGetOwner()
		if ply && ent:CPPICanUse(ply) then
			local res = self.Type 
			local amount =	self.Amount
			if ent.Resource[res] then
				ent.Resource[res] = ent.Resource[res] + amount
			else
				ent.Resource[res] = amount
			end
			self:Remove()
		end
	end
end

function ENT:Think()

end

function ENT:Touch(entEntity)
end

function ENT:UpdateTransmitState(entEntity)
end