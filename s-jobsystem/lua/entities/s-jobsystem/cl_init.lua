/*-----------------------------------------------------------------
	Auteur		= SlownLS
	Addon 		= S-JobSystem
	Version 	= 1.0
	Site 		= http://slownls.fr
	Steam 	 	= https://steamcommunity.com/id/slownls/
-----------------------------------------------------------------*/

include("shared.lua")

function ENT:Draw()
	self:DrawModel()
	
   	local pos = self:GetPos()
	local ang = self:GetAngles()

    ang:RotateAroundAxis(ang:Up(), 90)
    ang:RotateAroundAxis(ang:Forward(), 90) 

	if LocalPlayer():GetPos():Distance(self:GetPos()) < 350 then
    	cam.Start3D2D(pos+ang:Up()*0+ang:Right()*-50, ang, 0.17)
				draw.DrawText(self:GetNPCJobName(), "SlownLSFont30", 0,-180, color_white, TEXT_ALIGN_CENTER)
		cam.End3D2D()
   end
end