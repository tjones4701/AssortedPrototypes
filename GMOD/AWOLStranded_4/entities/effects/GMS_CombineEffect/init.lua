
/*---------------------------------------------------------
   Initializes the effect. The data is a table of data 
   which was passed from the server.
---------------------------------------------------------*/

function EFFECT:Init(data)
local pos = data:GetOrigin()
WorldSound( "physics/glass/glass_bottle_break1.wav", pos, 160, 130 )
	

local emitter = ParticleEmitter(pos)
local num = 1
local time = math.random(0,100)
for i=1, 128 do
	local particle = emitter:Add("particle/fire", pos)
	time = time + 1
	particle:SetVelocity(math.random(-25,25),math.random(-25,25),time)
	particle:SetDieTime(math.Rand(1, 5))
	particle:SetStartAlpha(255)
	particle:SetEndAlpha(0)
	particle:SetStartSize(math.Rand(1, 5))
	particle:SetEndSize(0)
	particle:SetRoll(math.Rand(0, 360))
	particle:SetCollide(true)
	math.random(0,255)
	local x = math.random(0,255)
	if num == 1 then
		num = 2
		particle:SetColor(x, x, x,255)
	else
		num = 1
		particle:SetColor(x/10, x/10, x/4,255)
	end
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
