-- Angry Chicken
-- By Teta_Bonita

AddCSLuaFile( 'cl_init.lua' )
AddCSLuaFile( 'shared.lua' )
include( 'shared.lua' )

local sndBreak = Sound( "Watermelon.BulletImpact" )


function ENT:Initialize()	

	self:SetModel( "models/weapons/w_chickeneggnade_thrown.mdl" )
	
	-- Initiate  physics
	local mins = Vector( -4, -4, -7 )
	local maxs = Vector( 4, 4, 7 )
	
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetCollisionBounds( mins, maxs )
	
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then 
		phys:Wake()
	end
	
	self.Spawning = false
	
end


function ENT:SpawnChicken( pos, norm )

	if not self:IsValid() then return end -- Just in case

	if self.Spawning then return end
	self.Spawning = true

	pos = pos + 4 * norm
	
	-- Play an effect
	self:BreakEffects( pos, norm )

	-- Spawn the chicken
	local chicken = ents.Create( "sent_chicken" )
	chicken:CPPISetWorld()
	chicken:SetPos( pos )
	chicken:Spawn()
	chicken:Activate()
	
	-- Set its owner
	-- Kill yourself
	self:Remove()

end


function ENT:BreakEffects( pos, norm )

	norm = norm or Vector( 0, 0, 1 )

	local fx = EffectData()
	fx:SetOrigin( pos )
	fx:SetNormal( norm )
	util.Effect( "egg_break", fx )
	
	self:EmitSound( sndBreak )

end


function ENT:PhysicsCollide( data )

	timer.Simple( 0.05, self.SpawnChicken, self, data.HitPos, -1 * data.HitNormal )

end


function ENT:OnTakeDamage( dmginfo )

	self:TakePhysicsDamage( dmginfo )

	-- Break the egg but don't spawn the chicken if we have sustained too much damage
	if dmginfo:GetDamage() > 15 and not self.Spawning then
	
		self.Spawning = true -- but not really
		self:BreakEffects( self:GetPos() )
		
		self:Remove()
		
		return
	
	end
	
	self:SpawnChicken( self:GetPos(), Vector( 0, 0, 1 ) )

end

