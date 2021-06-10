------------------------------------
--	Spacetech's Pet Mod
--	File: cl_init.lua
--	By Spacetech
------------------------------------

include('shared.lua')

function ENT:Draw()
	self.Entity:DrawModel()
	if(LocalPlayer():GetEyeTrace().Entity == self.Entity and EyePos():Distance(self.Entity:GetPos()) < 512 and self.Entity:GetNetworkedEntity("Tooltip") != nil) then
		AddWorldTip(self.Entity:EntIndex(), self.Entity:GetNetworkedString("Tooltip"), 0.5, self.Entity:GetPos(), self.Entity)
	end
end
