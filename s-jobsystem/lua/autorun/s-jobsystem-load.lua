/*-----------------------------------------------------------------
	Auteur		= SlownLS
	Addon 		= S-JobSystem
	Version 	= 1.0
	Site 		= http://slownls.fr
	Steam 	 	= https://steamcommunity.com/id/slownls/
-----------------------------------------------------------------*/

SJobSystem = {}

if( SERVER ) then		
	// Server
	include( "s-jobsystem/server/sv_s-jobsystem.lua" )
	include( "s-jobsystem/server/sv_s-jobsystems-functions.lua" )
	// Client
	AddCSLuaFile( "s-jobsystem/client/cl_s-jobsystem.lua" )
end

if( CLIENT ) then
	// Client
	include( "s-jobsystem/client/cl_s-jobsystem.lua" )
end
