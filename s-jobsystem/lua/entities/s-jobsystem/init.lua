/*-----------------------------------------------------------------
	Auteur		= SlownLS
	Addon 		= S-JobSystem
	Version 	= 1.0
	Site 		= http://slownls.fr
	Steam 	 	= https://steamcommunity.com/id/slownls/
-----------------------------------------------------------------*/

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("")
	self:SetSolid( SOLID_BBOX )
	self:SetUseType( SIMPLE_USE )
end

function ENT:AcceptInput(Name,Activator,Caller) 
    if Name == "Use" && IsValid(Caller) && Caller:IsPlayer() then
    	net.Start("S-JobSystem:OpenMenu")
    	net.WriteFloat(self:GetNPCJobID())
    	net.Send(Caller)
    end
end

function ENT:SetNPCJobID( id )
	self:SetNWFloat( "S-JobSystem:NPCID", id )
end

function ENT:SetNPCJobName( name )
	self:SetNWString( "S-JobSystem:NPCName", name )
end

function ENT:SetNPCJobModel( model )
	self:SetNWString( "S-JobSystem:NPCModel", model )
end

function ENT:SetNPCJobSave( bool )
	self:SetNWBool( "S-JobSystem:NPCSave", bool )
end