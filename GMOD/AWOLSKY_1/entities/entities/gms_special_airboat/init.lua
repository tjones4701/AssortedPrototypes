ENT.Type 		= "point"
ENT.Base		= "base_point"

ENT.PrintName	= ""
ENT.Author		= "Mechanical Mind"
ENT.Contact		= ""

ENT.Spawnable			= false
ENT.AdminSpawnable		= false


function ENT:Initialize()
	local car = ents.Create("prop_vehicle_airboat")
	car:SetModel("models/airboat.mdl")
	car:SetKeyValue("vehiclescript","scripts/vehicles/airboat.txt")
	car:SetPos(self:GetPos())
	car:SetAngles(self:GetAngles())
	car:Spawn()
	car:Activate()
	car.ClassOverride = "prop_vehicle_airboat"
	if self.CPPIGetOwner && car.CPPISetOwner then
		local ply,uid,name = self:CPPIGetOwner()
		if uid then
			car:CPPISetOwnerUID(uid)
		end
	end
	self:Remove()
end

function ENT:OnRemove()
end

function ENT:KeyValue(k,v)
end
