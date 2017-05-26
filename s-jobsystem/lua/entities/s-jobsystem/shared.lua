/*-----------------------------------------------------------------
	Auteur		= SlownLS
	Addon 		= S-JobSystem
	Version 	= 1.0
	Site 		= http://slownls.fr
	Steam 	 	= https://steamcommunity.com/id/slownls/
-----------------------------------------------------------------*/

ENT.Base = "base_ai"
ENT.Type = "ai"
ENT.PrintName       = "Job System"
ENT.Category        = "♦ SlownLS | Job System ♦" 
ENT.Spawnable       = false

function ENT:GetNPCJobID()
	return self:GetNWFloat( "S-JobSystem:NPCID")
end

function ENT:GetNPCJobName()
	return self:GetNWString( "S-JobSystem:NPCName")
end

function ENT:GetNPCJobModel()
	return self:GetNWString( "S-JobSystem:NPCModel")
end

function ENT:GetNPCJobSave()
	return self:GetNWBool( "S-JobSystem:NPCSave")
end