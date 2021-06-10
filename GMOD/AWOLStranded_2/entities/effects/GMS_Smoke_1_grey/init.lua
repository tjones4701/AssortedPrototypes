
/*---------------------------------------------------------
   Initializes the effect. The data is a table of data 
   which was passed from the server.
---------------------------------------------------------*/

function EFFECT:Init(data)
local pos = data:GetOrigin()
	

local emitter = ParticleEmitter(pos)
for i=1, 64 do
	local particle = emitter:Add("particle/fire", pos)
	particle:SetVelocity(Vector(math.random(-150, 150),math.random(-150, 150),math.random(-50, 150)))
	particle:SetDieTime(math.Rand(1.5, 3))
	particle:SetStartAlpha(255)
	particle:SetEndAlpha(0)
	particle:SetStartSize(math.Rand(0, 15))
	particle:SetEndSize(0)
	particle:SetRoll(math.Rand(0, 360))
	particle:SetCollide(false)
	local colour = math.random(0,255)
	particle:SetColor(colour, colour, colour,255)
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
