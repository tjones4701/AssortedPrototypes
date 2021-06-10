if SERVER then
	AddCSLuaFile( "shared.lua" )
else
	SWEP.PrintName = "Healer"
	SWEP.Slot = 1
	SWEP.SlotPos = 0
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
	
	killicon.AddFont("gms_healer","CSKillIcons","c",Color(255,80,0,255))
end

SWEP.Author			= "MrElite"
SWEP.Instructions	= "Left Click to heal. Any errors contact MrElite."
SWEP.Contact		= "MrElite"
SWEP.Purpose		= "Heal yourself if injured"

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.NextStrike = 0;
  
SWEP.ViewModel			= "models/weapons/v_grenade.mdl"
SWEP.WorldModel			= "models/weapons/w_grenade.mdl"

SWEP.Primary.Delay			= 60
SWEP.Primary.Recoil			= 0
SWEP.Primary.Damage			= 0
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic   	= false
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

function SWEP:Initialize()
	if SERVER then
		self:SetWeaponHoldType( "melee" );
	end

end

function SWEP:Precache()
end


function SWEP:Deploy()
		if CurTime() >= self.NextStrike then
			self.Owner:SendMessage("Ready to heal.\n")
		elseif CurTime() < self.NextStrike then
			self.Owner:SendMessage("Recharging.\n")
		end		
end

function SWEP:PrimaryAttack()
	if( CurTime() > self.NextStrike ) && self.Owner:Health() < 500 then 
		self.Owner:SetHealth(self.Owner:Health() + 50) 
		self.NextStrike = CurTime() + self.Primary.Delay
	elseif self.Owner:Health()>= 500 then
		self.Owner:SendMessage("Maximum Health Reached.")
	end
end

function SWEP:SecondaryAttack()

end