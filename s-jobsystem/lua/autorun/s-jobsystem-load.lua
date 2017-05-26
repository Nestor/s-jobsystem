/*-----------------------------------------------------------------
	Auteur		= SlownLS
	Addon 		= S-JobSystem
	Version 	= 1.0
	Site 		= http://slownls.fr
	Steam 	 	= https://steamcommunity.com/id/slownls/
-----------------------------------------------------------------*/

if( SERVER ) then		
	// Config
	include( "s-jobsystem/s-jobsystem-config.lua" )
	AddCSLuaFile( "s-jobsystem/s-jobsystem-config.lua" )
	// Server
	include( "s-jobsystem/server/sv_s-jobsystem.lua" )
	include( "s-jobsystem/server/sv_s-jobsystems-functions.lua" )
	// Client
	AddCSLuaFile( "s-jobsystem/client/cl_s-jobsystem.lua" )
end

if( CLIENT ) then
	// Config
	include( "s-jobsystem/s-jobsystem-config.lua" )
	// Client
	include( "s-jobsystem/client/cl_s-jobsystem.lua" )
end