
function EFFECT:Init(data)
	self.amount = 8
	self.time = CurTime()+1
end

function EFFECT:Emit()
	local emitter = ParticleEmitter(LocalPlayer():GetPos())
	for i=0, self.amount do
		local a = math.random(9999)
		local b = math.random(1,180)
		local dist = math.random(256,2048)
		local X = math.sin(b)*math.sin(a)*dist
		local Y = math.sin(b)*math.cos(a)*dist
		local offset = Vector(X,Y,0)
		local spawnpos = LocalPlayer():GetPos()+Vector(0,0,1024)+offset
		local particle = emitter:Add("particle/rain", spawnpos)
		if (particle) then
			particle:SetVelocity(Vector(math.random(-75,75),math.random(-75,75),0))
			particle:SetLifeTime(0)
			particle:SetDieTime(10)
			particle:SetStartAlpha(150)
			particle:SetEndAlpha(150)
			particle:SetStartLength(20)
			particle:SetEndLength(20)
			particle:SetStartSize(2)
			particle:SetEndSize(2)
			particle:SetAirResistance(0)
			particle:SetGravity(Vector(0,0,math.random(-600,-200)))
			particle:SetCollide(true)
			particle:SetBounce(0)
			particle:SetColor(128,128,128,150)
		end
	end
	emitter:Finish()
end

function EFFECT:Think()
	if not (self.time < CurTime()) then
		self:Emit()
	else
		return false
	end
end

function EFFECT:Render()
end