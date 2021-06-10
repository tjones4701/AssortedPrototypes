
/*---------------------------------------------------------
   Initializes the effect. The data is a table of data 
   which was passed from the server.
---------------------------------------------------------*/

function EFFECT:Init(data)
local pos = data:GetOrigin()
	

local emitter = ParticleEmitter(pos)
for i=1, 64 do
	local particle = emitter:Add("particle/fire", pos)
	particle:SetVelocity(Vector(math.random(-100, 100),math.random(-100, 100),math.random(-10, 150)))
	particle:SetDieTime(math.Rand(1, 5))
	particle:SetStartAlpha(255)
	particle:SetEndAlpha(0)
	particle:SetStartSize(math.Rand(0, 50))
	particle:SetEndSize(0)
	particle:SetRoll(math.Rand(0, 360))
	particle:SetCollide(true)
	local colour = math.random(0, 180)
	particle:SetColor(colour, colour, colour)
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
