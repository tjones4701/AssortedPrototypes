
/*---------------------------------------------------------
   Initializes the effect. The data is a table of data 
   which was passed from the server.
---------------------------------------------------------*/

function EFFECT:Init(data)
local pos = data:GetOrigin()
WorldSound( "ambient/water/water_spray3.wav", pos, 160, 130 )
	

local emitter = ParticleEmitter(pos)
for i=1, 128 do
	local particle = emitter:Add("particle/fire", pos)
	particle:SetVelocity(Vector(math.random(-100, 100),math.random(-100, 100),math.random(-10, 150)))
	particle:SetDieTime(math.Rand(1, 5))
	particle:SetStartAlpha(255)
	particle:SetEndAlpha(0)
	particle:SetStartSize(math.Rand(0, 10))
	particle:SetEndSize(0)
	particle:SetRoll(math.Rand(0, 360))
	particle:SetCollide(true)
	particle:SetColor(math.random(0,255), math.random(0,255), math.random(0,255),255)
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
