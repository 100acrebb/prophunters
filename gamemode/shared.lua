--GM.Name 	= "Prophunters"
GM.Name 	= "Prop Hunt"
GM.Author 	= "MechanicalMind"
// Credits to waddlesworth for the logo and icon
GM.Email 	= ""
GM.Website 	= "http://codingconcoctions.com/"
--GM.Version 	= "1.2.1"

TEAM_SPECTATOR = 1
TEAM_HUNTER = 2
TEAM_PROP = 3

team.SetUp(TEAM_SPECTATOR, "Spectators", Color(120, 120, 120))
team.SetUp(TEAM_HUNTER, "Hunters", Color(255, 150, 50))
team.SetUp(TEAM_PROP, "Props", Color(50, 150, 255))

function GM:ShouldCollide(ent1, ent2)
	if !IsValid(ent1) then return true end
	if !IsValid(ent2) then return true end

	return true
end

function GM:PlayerSetNewHull(ply, s, hullz, duckz)
	self:PlayerSetHull(ply, s, s, hullz, duckz)
end

function GM:PlayerSetHull(ply, hullx, hully, hullz, duckz)
	hullx = hullx or 16
	hully = hully or 16
	hullz = hullz or 72
	duckz = duckz or hullz / 2
	ply:SetHull(Vector(-hullx, -hully, 0), Vector(hullx, hully, hullz))
	ply:SetHullDuck(Vector(-hullx, -hully, 0), Vector(hullx, hully, duckz))

	if SERVER then
		net.Start("hull_set")
		net.WriteEntity(ply)
		net.WriteFloat(hullx)
		net.WriteFloat(hully)
		net.WriteFloat(hullz)
		net.WriteFloat(duckz)
		net.Broadcast()
		// TODO send on player spawn
	end
end