/*-----------------------------------------------------------------
	Auteur		= SlownLS
	Addon 		= S-JobSystem
	Version 	= 1.0
	Site 		= http://slownls.fr
	Steam 	 	= https://steamcommunity.com/id/slownls/
-----------------------------------------------------------------*/

AddCSLuaFile()

SWEP.PrintName = "Job System Config"
SWEP.Author = "SlownLS"
SWEP.Category = "♦ SlownLS | Job System ♦"
SWEP.Instructions = "Left click to spawn NPC\nRight click to config NPC"

SWEP.Spawnable			= true
SWEP.AdminOnly			= true
SWEP.UseHands			= true

SWEP.ViewModel			= "models/weapons/c_pistol.mdl"
SWEP.WorldModel			= "models/weapons/w_pistol.mdl"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Slot				= 3
SWEP.SlotPos			= 1
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= true
SWEP.UseHands			= true

function SWEP:Initialize()
    self:SetHoldType("normal")
end

/*-------------------------
		Deploy
-------------------------*/

function SWEP:Deploy()
	if CLIENT or not IsValid(self:GetOwner()) then return true end

	if SERVER then
		net.Start("S-JobSystem:Message")
		net.WriteString("Left click to spawn NPC")
		net.Send(self.Owner)

		net.Start("S-JobSystem:Message")
		net.WriteString("Right click to config NPC")
		net.Send(self.Owner)
	end

    return true
end

function SWEP:Holster()
	return true
end

/*-------------------------
		PrimaryAttack
-------------------------*/

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime()+.2)
	if SERVER then
		if self.Owner:IsSuperAdmin() then
			local tr = self.Owner:GetEyeTrace()

			local JobNPC = ents.Create("s-jobsystem")
			JobNPC:SetModel('models/gman_high.mdl')
			JobNPC:SetPos(tr.HitPos)
			JobNPC:Spawn()
						
			undo.Create( "s-jobsystem" )
			undo.AddEntity( JobNPC )
			undo.SetPlayer( self:GetOwner() )
			undo.Finish()
		else
			self.Owner:ChatPrint("Vous n'êtes pas superadmin.")
		end
	end
end

/*-------------------------
		SecondaryAttack
-------------------------*/

function SWEP:SecondaryAttack()
	self:SetNextPrimaryFire(CurTime()+.2)
	if SERVER then
		local tr = self.Owner:GetEyeTrace()
		local ent = tr.Entity

		if ent:GetClass() == "s-jobsystem" then
			if self.Owner:GetPos():Distance( ent:GetPos() ) <= 100 then
				net.Start("S-JobSystem:OpenMenuConfig")
				net.WriteEntity(ent)
				net.Send(self.Owner)
			end
		end
	end
end
