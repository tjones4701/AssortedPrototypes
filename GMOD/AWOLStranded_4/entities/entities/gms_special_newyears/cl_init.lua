include("shared.lua")

--Called when it's time to draw the entity.
--Return: Nothing
function ENT:Draw()
   self.Entity:DrawModel()
end

--Called when the SENT is spawned
--Return: Nothing
function ENT:Initialize()
	self.Entity.Move = CurTime() + 1
end

--Return true if this entity is translucent.
--Return: Boolean
function ENT:IsTranslucent()
end

--Called when a save-game is loaded.
--Return: Nothing
function ENT:OnRestore()
end

--Called when the SENT thinks.
--Return: Nothing
function ENT:Think()
	if self.Entity.Move < CurTime() then
		self.Entity.Move = CurTime() + 2
		EffectsFunc(self.Entity:GetPos(), 0, "special_newyears_pop")
	end
end