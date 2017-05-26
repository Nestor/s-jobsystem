/*-----------------------------------------------------------------
	Auteur		= SlownLS
	Addon 		= S-JobSystem
	Version 	= 1.0
	Site 		= http://slownls.fr
	Steam 	 	= https://steamcommunity.com/id/slownls/
-----------------------------------------------------------------*/

AddCSLuaFile()


surface.CreateFont("SlownLSFont20", {
  font = "Open Sans", 
  size = 20, 
  weight = 2000
})

net.Receive("S-JobSystem:Message",function()
	local Message = net.ReadString()
	chat.AddText(Color(230, 92, 78), "[S-JobSystem] ", color_white, Message)
end)

net.Receive("S-JobSystem:OpenMenuConfig",function()
	local SJobSystemEntity = net.ReadEntity()

	local Base = vgui.Create( "DFrame" )
	Base:SetSize( 435, 215 )
	Base:Center()
	Base:SetTitle( "" )
	Base:SetVisible( true )
	Base:SetDraggable( true )
	Base:ShowCloseButton( true )
	Base:MakePopup()
	Base.Paint = function(self,w,h)
        draw.RoundedBox(1, 0, 0, w, h,  Color(245, 248, 250))

        draw.RoundedBox(1, 0, 0, w, 25, Color(255, 255, 255))
        draw.RoundedBox(1, 0, 25, w,1, Color(0, 0, 0, 80))
	end

	local NPCID = vgui.Create( "DTextEntry", Base ) 
	NPCID:SetPos( 5, 30 )
	NPCID:SetSize( Base:GetWide()-10, 25 )
	if SJobSystemEntity:GetNPCJobSave() == true then
		NPCID:SetText( SJobSystemEntity:GetNPCJobID() )	
	else
		NPCID:SetText( "Enter unique ID (Number)..." )	
	end
	NPCID:SetNumeric(true)	
	NPCID.OnGetFocus = function(self)
		if self:GetText() == "Enter unique ID (Number)..." then
			self:SetText("")
		end
	end
	NPCID.OnLoseFocus = function(self)
		if self:GetText() == "Enter unique ID (Number)..." then
			self:SetText("")
		end
	end	

	local NPCName = vgui.Create( "DTextEntry", Base ) 
	NPCName:SetPos( 5, 65 )
	NPCName:SetSize( Base:GetWide()-10, 25 )
	if SJobSystemEntity:GetNPCJobSave() == true then
		NPCName:SetText( SJobSystemEntity:GetNPCJobName() )	
	else
		NPCName:SetText( "Jobs" )	
	end

	local NPCModel = vgui.Create( "DTextEntry", Base ) 
	NPCModel:SetPos( 5, 100 )
	NPCModel:SetSize(Base:GetWide()-10, 25 )
	if SJobSystemEntity:GetNPCJobSave() == true then
		NPCModel:SetText( SJobSystemEntity:GetNPCJobModel() )	
	else
		NPCModel:SetText( "models/gman_high.mdl" )	
	end

    local NPCSave = vgui.Create( "DButton", Base )
    NPCSave:SetPos( 5,135)
    NPCSave:SetSize( Base:GetWide()-10, 35 )
    NPCSave:SetText( "Save" )
    NPCSave:SetFont( "SlownLSFont20" )
    NPCSave:SetTextColor(Color(255, 255, 255, 200))
    NPCSave.OnCursorEntered = function(self) surface.PlaySound("UI/buttonrollover.wav")  self.hover = true self:SetTextColor(Color(230, 92, 78)) end
    NPCSave.OnCursorExited = function(self) self.hover = false  self:SetTextColor(color_white) end
    NPCSave.Paint = function(self,w,h) 
        if self.hover then
            draw.RoundedBox(1, 0, 0, w, h, Color(36, 39, 44, 255))
        else
            draw.RoundedBox(2, 0, 0, w, h,  Color(54, 57, 62, 255))
        end
    end
    NPCSave.DoClick = function()
    	if NPCID:GetValue() == "Enter unique ID (Number)..." or NPCID:GetValue() == "" then
    		return chat.AddText(Color(230, 92, 78), "[S-JobSystem] ", color_white, "Vous devez rentrer un mettre un ID Unique.")
    	else
    		net.Start('S-JobSystem:SaveNPC')
	    	net.WriteFloat(NPCID:GetValue())
	    	net.WriteString(NPCName:GetValue())
	    	net.WriteString(NPCModel:GetValue())
	    	net.WriteEntity(SJobSystemEntity)
	    	net.SendToServer()
	    end

    	Base:Close()
    end

    local NPCDelete = vgui.Create( "DButton", Base )
    NPCDelete:SetPos( 5, 175)
    NPCDelete:SetSize( Base:GetWide()-10, 35 )
    NPCDelete:SetText( "Delete" )
    NPCDelete:SetFont( "SlownLSFont20" )
    NPCDelete:SetTextColor(Color(255, 255, 255, 200))
    NPCDelete.OnCursorEntered = function(self) surface.PlaySound("UI/buttonrollover.wav")  self.hover = true self:SetTextColor(Color(230, 92, 78)) end
    NPCDelete.OnCursorExited = function(self) self.hover = false  self:SetTextColor(color_white) end
    NPCDelete.Paint = function(self,w,h) 
        if self.hover then
            draw.RoundedBox(1, 0, 0, w, h, Color(36, 39, 44, 255))
        else
            draw.RoundedBox(2, 0, 0, w, h,  Color(54, 57, 62, 255))
        end
    end
    NPCDelete.DoClick = function()
		net.Start('S-JobSystem:DelNPC')    	
    	net.WriteEntity(SJobSystemEntity)
    	net.SendToServer()

    	Base:Close()
    end
end)

net.Receive("S-JobSystem:OpenMenu",function()
	local NPCID = net.ReadFloat()

	local Base = vgui.Create( "DFrame" )
	Base:SetSize( 435, 400 )
	Base:Center()
	Base:SetTitle( "" )
	Base:SetVisible( true )
	Base:SetDraggable( true )
	Base:ShowCloseButton( true )
	Base:MakePopup()
	Base.Paint = function(self,w,h)
        draw.RoundedBox(1, 0, 0, w, h,  Color(245, 248, 250))

        draw.RoundedBox(1, 0, 0, w, 25, Color(255, 255, 255))
        draw.RoundedBox(1, 0, 25, w,1, Color(0, 0, 0, 80))
	end

    local Liste = vgui.Create("DScrollPanel", Base)
    Liste:SetSize(Base:GetWide()-10, Base:GetTall()-35)
    Liste:SetPos(5, 30)
    local scrollbar = Liste:GetVBar()
    function scrollbar:Paint(w, h)
        draw.RoundedBox(3, 5, 0, 10, h, Color(46, 49, 54, 255))
    end
    function scrollbar.btnUp:Paint(w, h)
        draw.RoundedBox(3, 5, 0, 10, h, Color(36, 39, 44, 255))
    end
    function scrollbar.btnDown:Paint(w, h)
        draw.RoundedBox(3, 5, 0, 10, h, Color(36, 39, 44, 255))
    end
    function scrollbar.btnGrip:Paint(w, h)
        draw.RoundedBox(3, 5, 0, 10, h, Color(54, 57, 62, 255))
    end

	for k, v in pairs(RPExtraTeams) do
    	if v.JobID == NPCID then
	        local Fond = vgui.Create("DPanel", Liste)
	        Fond:SetSize(0, 65)
	        Fond:DockMargin(0, 0, 0, 5)
	        Fond:Dock(TOP)
	        Fond:SetText("")
			Fond.Paint = function(self, w,h)
				draw.RoundedBox(0,0,0,w,h,Color(54, 57, 62, 255))

				local TeamName = string.len(string.upper(v.name))
				local TeamDesc = string.len(v.description)

				if TeamName <= 20 then 
					draw.SimpleText( string.upper(v.name),"SlownLSFont20",80, 8, col, TEXT_ALIGN_LEFT)
				else
					draw.SimpleText( string.sub( string.upper(v.name), 1, 18 ).."...", "SlownLSFont20",80, 8, col, TEXT_ALIGN_LEFT)
				end			
				draw.SimpleText( "Salaire: "..DarkRP.formatMoney(v.salary).."$","SlownLSFont20",80, 35, col, TEXT_ALIGN_LEFT)

				draw.RoundedBox(0,0,h-1,w,1,Color(0,0,0,80))
			end

	        local model
	       
	        if type( v.model ) == "table" then
	            model = table.Random( v.model )
	        else
	            model = v.model
	        end
	       
	        local Model = vgui.Create( "SpawnIcon", Fond )
	        Model:SetSize( 65, 65 )
	        Model:SetPos( 0, 0 )
	        Model:SetModel( model )

			local ChoiceJobs = vgui.Create("DButton", Fond)
			ChoiceJobs:SetText("Choisir")
			ChoiceJobs:SetTextColor(color_black)
			ChoiceJobs:SetPos(Liste:GetWide()-100-30,17)
			ChoiceJobs:SetSize(100,30)
			ChoiceJobs:SetTooltip(v.description)
			ChoiceJobs.Paint = function(self,w,h)
				draw.RoundedBox(0,0,0,w,h,Color(255, 255, 255))
			end
			ChoiceJobs.DoClick = function()
                for _, team in pairs( team.GetAllTeams() ) do
                    if team.Name == v.name then
                        DarkRP.setPreferredJobModel(_, model)
                    end
                end

				if v.vote then
					RunConsoleCommand("say","/vote"..v.command)
				else
					RunConsoleCommand("say", "/"..v.command)
				end
				Base:Remove()
			end
		end
    end
end)
