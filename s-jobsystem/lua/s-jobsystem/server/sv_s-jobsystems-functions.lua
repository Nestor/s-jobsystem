/*-----------------------------------------------------------------
	Auteur		= SlownLS
	Addon 		= S-JobSystem
	Version 	= 1.0
	Site 		= http://slownls.fr
	Steam 	 	= https://steamcommunity.com/id/slownls/
-----------------------------------------------------------------*/

function SJobSystem:CreateData()
	if !file.IsDir("S-jobsystem", "DATA") then
		file.CreateDir("S-jobsystem", "DATA") 
		file.CreateDir("S-jobsystem/npcs/"..string.lower(game.GetMap()), "DATA") 
	end 
end

function SJobSystem:InitializeNPC()
	for k, v in pairs(file.Find("s-jobsystem/npcs/"..string.lower(game.GetMap()).."/*.txt", "DATA")) do
		local NPCFilePos = file.Read("s-jobsystem/npcs/"..string.lower(game.GetMap()).."/"..v, "DATA")
			 
		local NPCInfos =  util.JSONToTable(NPCFilePos)

		local NPCPos = string.Explode(" ", NPCInfos.Pos)

		local JobNPC = ents.Create("s-jobsystem")
		JobNPC:SetModel(NPCInfos.Model)
		JobNPC:SetPos(Vector( NPCPos[1],NPCPos[2],NPCPos[3]))
		JobNPC:SetNPCJobID(NPCInfos.ID)
		JobNPC:SetNPCJobName(NPCInfos.Name)
		JobNPC:SetNPCJobModel(NPCInfos.Model)
		JobNPC:SetNPCJobSave(true)
		JobNPC:Spawn()
	end
end

function SJobSystem:RespawnNPC()
	for k, v in pairs(file.Find("s-jobsystem/npcs/"..string.lower(game.GetMap()).."/*.txt", "DATA")) do
		local NPCFilePos = file.Read("s-jobsystem/npcs/"..string.lower(game.GetMap()).."/"..v, "DATA")
			 
		local NPCInfos =  util.JSONToTable(NPCFilePos)

		local NPCPos = string.Explode(" ", NPCInfos.Pos)

		local JobNPC = ents.Create("s-jobsystem")
		JobNPC:SetModel(NPCInfos.Model)
		JobNPC:SetPos(Vector( NPCPos[1],NPCPos[2],NPCPos[3]))
		JobNPC:SetNPCJobID(NPCInfos.ID)
		JobNPC:SetNPCJobName(NPCInfos.Name)
		JobNPC:SetNPCJobModel(NPCInfos.Model)
		JobNPC:SetNPCJobSave(true)
		JobNPC:Spawn()
	end
end

function SJobSystem:DeleteNPC(ply,ID,Entity)
	if ply:IsSuperAdmin() then
		if Entity:GetClass() == "s-jobsystem" then
			if file.Exists( "s-jobsystem/npcs/"..string.lower(game.GetMap()).."/"..ID..".txt" , "DATA" ) then
				file.Delete( "s-jobsystem/npcs/"..string.lower(game.GetMap()).."/"..ID..".txt" )
			end

			Entity:Remove()
		end
	else
		ply:ChatPrint("Vous n'êtes pas superadmin.")
	end
end