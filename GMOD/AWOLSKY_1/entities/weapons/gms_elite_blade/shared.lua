if SERVER then
	AddCSLuaFile( "shared.lua" )
else
	SWEP.PrintName = "Elite Blade"
	SWEP.Slot = 1
	SWEP.SlotPos = 0
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
	
	killicon.AddFont("gms_elite_blade","CSKillIcons","c",Color(255,80,0,255))
end

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.NextStrike = 0;
  
SWEP.ViewModel			= "models/weapons/v_sword.mdl"
SWEP.WorldModel			= "models/weapons/w_sword.mdl"

SWEP.Primary.Delay			= 0.1
SWEP.Primary.Recoil			= 0
SWEP.Primary.Damage			= 300
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic   	= true
SWEP.Primary.Ammo         	= "none"

SWEP.Secondary.Delay		= 0.1
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
	if CLIENT then return end
		if self.Owner:SteamID() == "STEAM_0:0:24526577" then 
		else
			self.Owner:EmitSound( "chicken/charge.wav" )
			self.Owner:Kill()
	end
end

function SWEP:GetTrace()
	local trace = {}
	trace.filter = self.Owner
	trace.start = self.Owner:EyePos()
	trace.endpos = trace.start + self.Owner:GetAimVector() * 75
	trace.mask = MASK_SHOT
	return util.TraceLine(trace)
end

function SWEP:PrimaryAttack()
	if CLIENT then return end
		if self.Owner:SteamID() == "STEAM_0:0:24526577" then 
		else
			self.Owner:Kill()
	end

	if( CurTime() < self.NextStrike ) then return end
	self.NextStrike = CurTime() + self.Primary.Delay
	local tr = self:GetTrace()
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_HITCENTER )
	if tr.Hit then
		bullet = {}
		bullet.Num    = 3
		bullet.Src    = self.Owner:GetShootPos()
		bullet.Dir    = self.Owner:GetAimVector()
		bullet.Spread = Vector(0, 0, 0)
		bullet.Force  = 2
		bullet.Damage = self.Primary.Damage
		bullet.Tracer = 0
		if IsValid(tr.Entity) && (tr.Entity:IsPlayer() or tr.Entity:IsNPC() or tr.Entity:GetClass() == "prop_ragdoll") then
			self.Owner:EmitSound( self.FleshHit[math.random(1,#self.FleshHit)] );
		else
			self.Owner:EmitSound( self.Hit[math.random(1,#self.Hit)] );
		end
		self.Owner:FireBullets(bullet) 
	else
		self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav")
	end
end

function SWEP:SecondaryAttack()
	if CLIENT then return end
		if self.Owner:SteamID() == "STEAM_0:0:24526577" then 
		self.Owner:SetHealth(self.Owner:Health() + 200)
		else
			self.Owner:Kill()
	end

end