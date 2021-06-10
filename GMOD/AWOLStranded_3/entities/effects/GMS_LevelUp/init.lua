
/*---------------------------------------------------------
   Initializes the effect. The data is a table of data 
   which was passed from the server.
---------------------------------------------------------*/

function EFFECT:Init(data)
local pos = data:GetOrigin()
	

local emitter = ParticleEmitter(pos)
for i=1, 64 do
	local particle = emitter:Add("particle/fire", pos)
	particle:SetVelocity(Vector(math.random(-250, 250),math.random(-250, 250),math.random(-250, 250)))
	particle:SetDieTime(math.Rand(1.5, 3))
	particle:SetStartAlpha(255)
	particle:SetEndAlpha(0)
	particle:SetStartSize(math.Rand(0, 30))
	particle:SetEndSize(0)
	particle:SetRoll(math.Rand(0, 360))
	particle:SetCollide(true)
	particle:SetColor(math.random(0, 255), math.random(0, 255), math.random(0, 255))
	particle:SetAirResistance(math.random(1, 20))
end
emitter:Finish()

end


/*---------------------------------------------------------
   THINK
---------------------------------------------------------*/
function EFFECT:Think( )
	return false
end

/*---------------------------------------------------------
   Draw the effect
---------------------------------------------------------*/
function EFFECT:Render()
end
