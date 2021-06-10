-- Angry Chicken
-- By Teta_Bonita

AddCSLuaFile( 'cl_init.lua' )
AddCSLuaFile( 'shared.lua' )
include( 'shared.lua' )


---------------------------------
-- Adjustable Variables  --
---------------------------------

local MAX_HEALTH = 25

local JUMP_VERT_SPEED = 180
local JUMP_HORIZ_SPEED = 300
local WADDLE_SPEED = 100

local ATTACK_DIST = 0 -- The chicken must be at least this close to a target before attacking it
local ANGER_STARTATTACK = 1000 -- Start attacking after anger level is greater than this
local ANGER_MAX = 100000 -- Anger level at which the chicken should explode
local ANGER_RATE = 0 -- Added to the anger level every 0.2 seconds


----------------
-- Sounds  --
----------------

local sndTabAttack = 
{
	Sound( "chicken/attack1.wav" ),
	Sound( "chicken/attack2.wav" )
}

local sndTabIdle = 
{
	Sound( "chicken/idle1.wav" ),
	Sound( "chicken/idle2.wav" ),
	Sound( "chicken/idle3.wav" )
}

local sndTabPain = 
{
	Sound( "chicken/pain1.wav" ),
	Sound( "chicken/pain2.wav" ),
	Sound( "chicken/pain3.wav" )
}

local sndAngry = Sound( "chicken/alert.wav" )
local sndDeath = Sound( "chicken/death.wav" )
local sndCharge = Sound( "chicken/charge.wav" )



--------------------------------
-- Initialize (no shit?)  --
--------------------------------

function ENT:Initialize()	

	-- Bok bok!
	self:SetModel( "models/lduke/chicken/chicken3.mdl" )
	
	-- Initiate  physics
	local mins = Vector( -7, -6, 0 )
	local maxs = Vector( 7, 6, 25 )
	
	self:PhysicsInitBox( mins, maxs )
	self:SetCollisionBounds( mins, maxs )
	
	self:SetSolid( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	
	self.Phys = self:GetPhysicsObject()
	if self.Phys:IsValid() then 
		self.Phys:SetMass( 8 ) -- Chickens are light
		self.Phys:Wake()
	end
	
	-- How much health do we have right now?
	self.CurHealth = MAX_HEALTH

	
	-- Are we about to die?
	self.Dieing = self.Dieing or false
	
	-- Cheap way to identify chickens
	self.IsChicken = true

	
	-- Waddling stuff
	self.Waddling = self.Waddling or false -- Are we waddling?
	self.InitialWaddlePhase = math.Rand( 0, 2 * math.pi )
	self.LastAngleChange = self.LastAngleChange or 0
	self.NextEmitIdle = self.NextEmitIdle or CurTime()
	
	-- When can we jump again?
	self.NextJump = self.NextJump or CurTime()
	
	-- In what manner are we moving right now?
	self.CurrentMoveFunction = self.CurrentMoveFunction or self.Waddle 
	
	-- We need to do this or else PhysicsSimulate won't be called
	self:StartMotionController()
	
	-- Wake-up sound
	self:EmitSound( sndTabAttack[ math.random( 1, #sndTabAttack ) ], 100, 100 )
	self.Entity:CPPISetWorld()

end


function ENT:SpawnFunction( ply, tr )

	if not tr.Hit then return end
	
	local ent = ents.Create( self.Classname )
	ent:SetPos( tr.HitPos + tr.HitNormal * 8 )
	ent:Spawn()
	ent:Activate()
	
	return ent

end


------------------------------
-- Decision Functions --
------------------------------

-- Decide what we should be doing right now
function ENT:Think()

	self:NextThink( CurTime() + 0.2 )

	-- Do waddling stuff
	if self.Waddling then				
		-- Hop if we're stuck upside-down
		if self:GetAngles():Up():Dot( Vector( 0, 0, -1) ) >= 0 and self:OnSomething() then	
			self.Phys:AddVelocity( Vector( 0, 0, 200 ) )
			self.Phys:AddAngleVelocity( VectorRand() * 350 )	
		end
	
		-- Play idle sounds
		if CurTime() > self.NextEmitIdle then		
			self.NextEmitIdle = CurTime() + 3		
			-- 33 percent chance of emitting a sound every 3 seconds
			if math.random() < 0.33 then
				self:EmitSound( sndTabIdle[ math.random( 1, #sndTabIdle ) ] )
			end
		end		
		return true		
	end
	self:StartWaddling()
	return true



end


-- Decide what our new health should be and if we should die
function ENT:OnTakeDamage( dmginfo )
	self:TakePhysicsDamage( dmginfo )
	if self.Dieing then return end	
	self.CurHealth = self.CurHealth - dmginfo:GetDamage()
	if self.CurHealth <= 0 then
		self.Dieing = true
		if dmginfo:GetAttacker():IsWorld() then
			self:DoDeath()
		else
			timer.Simple( math.Rand( 0.05, 0.1 ), self.DoDeath, self )
		end		
		return		
	end	
	-- Emit pain sounds
	self:EmitSound( sndTabPain[ math.random( 1, #sndTabPain ) ] )	
	-- Emit feathers
	local dmgpos = dmginfo:GetDamagePosition()
	if dmgpos == Vector( 0, 0, 0 ) then 
		dmgpos = self:GetPos()
		dmgpos.z = dmgpos.z + 10
	end	
	local fx = EffectData()
	fx:SetOrigin( dmgpos )
	util.Effect( "chicken_pain", fx )
end












-- Returns true if the chicken is on top of something
function ENT:OnSomething()

	local start = self:GetPos() + Vector( 0, 0, 20 )
	local endpos = Vector( start.x, start.y, start.z - 30 )

	local tr = util.TraceLine( 
	{
		start = start,
		endpos = endpos,
		filter = self,
		mask = MASK_SOLID | MASK_WATER
	})
	
	return tr.Hit

end


function ENT:StartWaddling()
	self.Waddling = true
	self.CurrentMoveFunction = self.Waddle
end


function ENT:StopWaddling()
	self.Waddling = false
end




-- Do explosion damage, emit sounds, play death effects, and remove the chicken
function ENT:DoDeath()
	if not self:IsValid() then return end -- Just in case	
	local mypos = self:GetPos()
	-- Spawn blood and feathers
	local fx = EffectData()
	fx:SetOrigin( mypos )
	util.Effect( "chicken_death", fx )	
	local pos = self:GetPos() + Vector(0,0,1)	
	local chicken = ents.Create("gms_loot")
	local tbl = chicken:GetTable()
	local num = math.random(1,3)
	local res = {}
	local ply,uid = self.Entity:CPPIGetOwner()
	if uid then
		chicken:CPPISetOwnerUID(uid)
	end
	res["Meat"] = num
	res["Feathers"] = num
	tbl.Resources = res
	chicken:SetPos(self:GetPos()+ Vector(0,0,64))
	chicken:Spawn()
	-- Emit death sounds
	self:EmitSound( sndDeath )	
	-- Die
	self:Remove()
end


--------------------------------
-- Movement Functions --
--------------------------------

-- This just returns a call to our current move function
function ENT:PhysicsSimulate( phys, dt )
	phys:Wake()
	return self:CurrentMoveFunction( phys, dt )
end




-- The main waddling move function
function ENT:Waddle( phys, dt )

	if not self:OnSomething() then return SIM_NOTHING end

	local TargetAng = self:GetAngles()
	local DeltaAng = math.Rand( -50, 50 ) * dt + self.LastAngleChange
	self.LastAngleChange = DeltaAng
	
	TargetAng.p = 0
	TargetAng.y = TargetAng.y + 30 * math.sin( 0.6 * CurTime() ) + DeltaAng -- turn randomly
	TargetAng.r = 60 * math.sin( 10 * CurTime() + self.InitialWaddlePhase ) -- waddle side-to side

	-- Increment the angle
	phys:ComputeShadowControl(
	{
		secondstoarrive		= 1,
		angle				= TargetAng,
		maxangular			= 400,
		maxangulardamp		= 60,
		dampfactor			= 0.8,
		deltatime			= dt
	})	
	local linear = self:GetAngles():Forward() * WADDLE_SPEED - phys:GetVelocity()
	linear.z = linear.z + 250 -- Compensate for gravity/friction	
	return Vector( 0, 0, 0 ), linear, SIM_GLOBAL_ACCELERATION
end

