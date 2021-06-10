if SERVER then
	AddCSLuaFile( "shared.lua" )
else
	SWEP.PrintName = "Sword"
	SWEP.Slot = 2
	SWEP.SlotPos = 0
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
	
	killicon.AddFont("gms_sword","CSKillIcons","c",Color(255,80,0,255))
end

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.NextStrike = 0;
  
SWEP.ViewModel			= "models/weapons/v_sword.mdl"
SWEP.WorldModel			= "models/weapons/w_sword.mdl"

SWEP.Primary.Delay			= 0.5
SWEP.Primary.Recoil			= 0
SWEP.Primary.Damage			= 36
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic   	= true
SWEP.Primary.Ammo         	= "none"

SWEP.Secondary.Delay		= 0.9
SWEP.Secondary.Recoil		= 0
SWEP.Secondary.Damage		= 0
SWEP.Secondary.NumShots		= 1
SWEP.Secondary.Cone			= 0
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic   	= false
SWEP.Secondary.Ammo         = "none"

SWEP.Hit = {"weapons/knife/knife_hitwall1.wav"}
SWEP.FleshHit = {"weapons/knife/knife_hit1.wav","weapons/knife/knife_hit2.wav","weapons/knife/knife_hit3.wav","weapons/knife/knife_hit4.wav"}

function SWEP:Initialize()
	if SERVER then
		self:SetWeaponHoldType( "melee" );
	end

end

function SWEP:Precache()
end

function SWEP:Deploy()
	self.Owner:EmitSound( "weapons/knife/knife_deploy1.wav" )
	return true
end

function SWEP:PrimaryAttack()
	if( CurTime() < self.NextStrike ) then return end
	self.NextStrike = CurTime() + self.Primary.Delay
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	--local trace = self.Owner:GetEyeTrace()
	local tr = self.Owner:GetEyeTrace()
	if tr.HitPos:Distance(self.Owner:GetShootPos()) <= 115 then
		self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			bullet = {}
			bullet.Num    = 1
			bullet.Src    = self.Owner:GetShootPos()
			bullet.Dir    = self.Owner:GetAimVector()
			bullet.Spread = Vector(0, 0, 0)
			bullet.Tracer = 0
			bullet.Force  = 1
			bullet.Damage = 36
				if IsValid(tr.Entity) && (tr.Entity:IsPlayer() or tr.Entity:IsNPC() or tr.Entity:GetClass() == "prop_ragdoll" or tr.Entity:GetClass() == "sent_chicken") then
					self.Owner:EmitSound( self.FleshHit[math.random(1,#self.FleshHit)] );
				else
					self.Owner:EmitSound( self.Hit[math.random(1,#self.Hit)] );
				end
			self.Owner:FireBullets(bullet) 
	else
		self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER)
		self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav")
	end
end

function SWEP:SecondaryAttack()

end