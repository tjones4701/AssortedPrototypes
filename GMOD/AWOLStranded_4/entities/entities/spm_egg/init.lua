------------------------------------
--	Spacetech's Pet Mod
--	File: init.lua
--	By Spacetech
------------------------------------

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')


function ENT:Initialize()
	self.Entity:SetModel("models/props_junk/watermelon01.mdl")
	
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)

	self.Entity:SetMaterial("models/shiny")
	self.Entity:SetAngles(Angle(0.000, -45.000, 90.000))
	self.Entity:SetColor(math.random(0,255), math.random(0,255), math.random(0,255), 255)
	
	local Phys = self.Entity:GetPhysicsObject()
	if(Phys:IsValid()) then
		Phys:Wake()
		--Phys:EnableMotion(false)
	end
	self.Entity.HatchTimer = CurTime() + math.random(10,20)
	self.Entity.Hatching = false
	self.Entity.Health = 100
end



function ENT:OnTakeDamage(Damageinfo)
	self.Entity.Health = self.Entity.Health - Damageinfo:GetDamage()
	if(self.Entity.Health <= 0) then
		self.Entity:Remove()
	end
end

function ENT:Think()
	if self.Entity.HatchTimer then
		if self.Entity.HatchTimer < CurTime() then
			self.Hatching = true
			if self.PetType && self.Entity.Owner then
				PetMod_AdoptAfterEgg(self.Entity.Owner, self.PetType, self.PetType, self.Entity:GetPos())
			end
			self.Entity:Remove()
		end
	else
		self.Entity.HatchTimer = CurTime() + math.random(10,20)
	end
end

function ENT:OnRemove()
	local FakeEgg = ents.Create("prop_physics")
	FakeEgg:SetModel(self.Entity:GetModel())
	FakeEgg:SetMaterial(self.Entity:GetMaterial())
	FakeEgg:SetAngles(self.Entity:GetAngles())
	FakeEgg:SetColor(self.Entity:GetColor())
	FakeEgg:SetPos(self.Entity:GetPos())
	FakeEgg:Spawn()
	FakeEgg:Activate()	
	FakeEgg:Fire("break", .01)
	if self.Hatching == false then
		local ply = self.Entity.Owner
		if ply then
			ply.PetMod.Egg.Active = 0
			ply:SendMessage("Your egg has broken.  :-(",3,Color(200,0,0,255))
		end
	end
end
