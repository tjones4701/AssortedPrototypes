if( SERVER ) then
	AddCSLuaFile( "shared.lua" )
	SWEP.Weight	= 5
	SWEP.AutoSwitchTo = false
	SWEP.AutoSwitchFrom = false
end

if( CLIENT ) then
	SWEP.PrintName	= "Adamantium Bow"
	SWEP.Slot	= 2
	SWEP.SlotPos	= 5
	SWEP.DrawAmmo	= false
	SWEP.DrawCrosshair = false
	SWEP.ViewModelFOV = 62
	SWEP.ViewModelFlip = false
end

SWEP.Base		= "weapon_base"

SWEP.Author		= "Bithmar"
SWEP.Instructions	= "Pull and release"
SWEP.Contact		= "Pull and release"
SWEP.Purpose		= "Pull and release"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none" 
SWEP.Primary.ShootStage = 0


util.PrecacheSound("weapons/knife/knife_deploy1.wav")
util.PrecacheSound("weapons/knife/knife_hitwall1.wav")
util.PrecacheSound("weapons/knife/knife_hit1.wav")
util.PrecacheSound("weapons/knife/knife_hit2.wav")
util.PrecacheSound("weapons/knife/knife_hit3.wav")
util.PrecacheSound("weapons/knife/knife_hit4.wav")
util.PrecacheSound("weapons/iceaxe/iceaxe_swing1.wav")
  
SWEP.ViewModel      = "models/weapons/v_bow.mdl"
SWEP.WorldModel   = "models/weapons/w_bow.mdl"

function SWEP:Initialize()
	if( SERVER ) then
		self:SetWeaponHoldType( "pistol" )
	end
	self.Hit = { 
		Sound( "weapons/knife/knife_hitwall1.wav" )
	}
	self.FleshHit = {
  		Sound( "weapons/knife/knife_hit1.wav" ),
		Sound( "weapons/knife/knife_hit2.wav" ),
		Sound( "weapons/knife/knife_hit3.wav" ),
  		Sound( "weapons/knife/knife_hit4.wav" )
	}
	self.Weapon.ShootStage = 0

end

function SWEP:Deploy()
	self.Weapon.ShootStage = 0
	self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
	self.Owner:EmitSound( "weapons/knife/knife_deploy1.wav" )
	return true
end

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire(CurTime()+.1)
	if self.Weapon.ShootStage == 0 then
			if self.Owner:GetResource("Arrows") > 0 then
				self.Weapon:SendWeaponAnim( ACT_VM_RELOAD)
				self.Weapon:SetNextPrimaryFire(CurTime()+3)
				self.Weapon.ShootStage = 1
			else
				self.Owner:SendMessage("You need more arrows!",3,Color(200,0,0,255))
			end
	else
		self.Owner:EmitSound( "weapons/iceaxe/iceaxe_swing1.wav" )
		self.Weapon.ShootStage = 0
		self.Weapon:SetNextPrimaryFire(CurTime()+3)
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK)
		if CLIENT then return end
		local trace = self.Owner:GetEyeTrace()
		if trace.HitPos:Distance(self.Owner:GetShootPos()) >= 10 then
			if trace.Entity:IsPlayer() or trace.Entity:IsNPC() or trace.Entity:GetClass()=="prop_ragdoll" or trace.Entity:GetClass() == "sent_chicken"  then
				self.Owner:EmitSound( self.FleshHit[math.random(1,#self.FleshHit)] )
			end


			if trace.Entity:IsValid() and trace.Entity.TakeDamage then
				if (trace.Entity:IsPlayer() or trace.Entity:IsNPC() or trace.Entity:GetClass() == "sent_chicken" )  then
					if self.Owner:GetResource("Arrows") > 0 then
						trace.Entity:TakeDamage(50, self.Owner, self)
						self.Owner:DecResource("Arrows",1)
					else
						self.Owner:SendMessage("You need more arrows!",3,Color(200,0,0,255))
					end
				else
					if self.Owner:GetResource("Arrows") > 0 then
						trace.Entity:TakeDamage(50, self.Owner, self)
						self.Owner:DecResource("Arrows",1)
					else
						self.Owner:SendMessage("You need more arrows!",3,Color(200,0,0,255))
					end
				end
			end

	end
	
	end

end

function SWEP:SecondaryAttack()
end

