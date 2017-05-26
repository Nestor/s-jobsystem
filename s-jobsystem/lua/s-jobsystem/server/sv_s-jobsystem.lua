/*-----------------------------------------------------------------
	Auteur		= SlownLS
	Addon 		= S-JobSystem
	Version 	= 1.0
	Site 		= http://slownls.fr
	Steam 	 	= https://steamcommunity.com/id/slownls/
-----------------------------------------------------------------*/

util.AddNetworkString("S-JobSystem:Message")
util.AddNetworkString("S-JobSystem:OpenMenuConfig")
util.AddNetworkString("S-JobSystem:OpenMenu")
util.AddNetworkString("S-JobSystem:SaveNPC")
util.AddNetworkString("S-JobSystem:DelNPC")

timer.Simple(1,function()
	// Create Folder Data
	SJobSystem:CreateData()
	// Spawn NPC's
	SJobSystem:InitializeNPC()
end)

hook.Add("PostCleanupMap","S-JobSystem:Respawn",function()	
	// Respawn All NPC's
	SJobSystem:RespawnNPC()
end)

net.Receive("S-JobSystem:SaveNPC",function(lenght,ply)
	local NPC = {}
	local NPCID = string.lower(net.ReadFloat())
	local NPCName = net.ReadString()
	local NPCModel = net.ReadString()
	local NPCEntity = net.ReadEntity()

	if ply:IsSuperAdmin() then
		if NPCEntity:GetClass() == "s-jobsystem" then
			if file.Exists( "s-jobsystem/npcs/"..string.lower(game.GetMap()).."/"..NPCID..".txt" , "DATA" ) then
				file.Delete( "s-jobsystem/npcs/"..string.lower(game.GetMap()).."/"..NPCID..".txt" )
			end

			local NPCEntityPos = string.Explode(" ", tostring(NPCEntity:GetPos()))

			NPC = {
				ID = NPCID,
				Pos = NPCEntityPos[1].." "..NPCEntityPos[2].." "..NPCEntityPos[3],
				Name = NPCName,
				Model = NPCModel
			}

			file.Write("s-jobsystem/npcs/"..string.lower(game.GetMap()).."/"..NPCID..".txt", util.TableToJSON( NPC ))

			NPCEntity:SetNPCJobID(NPCID)
			NPCEntity:SetNPCJobName(NPCName)
			NPCEntity:SetNPCJobModel(NPCModel)
			NPCEntity:SetNPCJobSave(true)
			NPCEntity:SetModel(NPCModel)
		end
	else
		ply:ChatPrint("Vous n'êtes pas superadmin.")
	end
end)

net.Receive("S-JobSystem:DelNPC",function(lenght,ply)
	local NPCEntity = net.ReadEntity()
	local NPCID = NPCEntity:GetNPCJobID()

	SJobSystem:DeleteNPC(ply,NPCID,NPCEntity)
end)