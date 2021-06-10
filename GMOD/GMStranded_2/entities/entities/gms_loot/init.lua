AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self.Entity:SetModel("models/weapons/w_bugbait.mdl")
    self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
 	self.Entity:SetColor(255,0,0,255)
	self.Entity.Time = 0
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end

function ENT:Use(ply)
	if !(SPropProtection.PlayerIsPropOwner(ply, self.Entity) or SPropProtection.IsBuddy(ply, self.Entity)) and !(tonumber(SPropProtection["Config"]["use"]) != 1) then return end
    local data = {}
    data.Entity = self.Entity
    data.Resources = self.Resources
    ply:DoProcess("Loot",5,data)
end

function ENT:Think()
	if self.Entity.Time < CurTime() then
		self.Entity.Time = CurTime() + .5
		EffectFunc(self:GetPos(), 2, "GMS_LootEffect")
	end
end