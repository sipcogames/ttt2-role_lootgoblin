if SERVER then
	AddCSLuaFile()

	resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_lootgoblin.vmt")
end

roles.InitCustomTeam(ROLE.name, {
	icon = "vgui/ttt/dynamic/roles/icon_lootgoblin",
	color = Color(102, 0, 255, 255)
})

function ROLE:PreInitialize()
	self.color = Color(102, 0, 255, 255)

	self.abbr = "lootgoblin"
	self.visibleForTeam = {TEAM_TRAITOR}
	self.surviveBonus = 2
	self.scoreKillsMultiplier = 0
	self.scoreTeamKillsMultiplier = 0
	self.preventWin = true

	self.defaultTeam = TEAM_LOOTGOBLIN
	self.defaultEquipment = INNO_EQUIPMENT

	self.conVarData = {
		pct = 0.17,
		maximum = 1,
		minPlayers = 6,
		random = 25,
		togglable = true
	}
end

function ROLE:Initialize()
  if SERVER and JESTER then self.networkRoles = {JESTER} end
end

if SERVER then

	function ROLE:GiveRoleLoadout(ply, isRoleChange)

		--save old values
		SetGlobalInt("GoblinStep",ply:GetStepSize())
		SetGlobalInt("GoblinScale",ply:GetModelScale())
		SetGlobalInt("GoblinView",ply:GetViewOffset())
		SetGlobalInt("GoblinCrouch",ply:GetViewOffsetDucked())
		SetGlobalInt("GoblinWalk",ply:GetWalkSpeed())
		SetGlobalInt("GoblinRun",ply:GetRunSpeed())

    ply:SetMaxHealth(GetConVar("ttt2_lootgoblin_health"):GetInt())
    ply:SetHealth(GetConVar("ttt2_lootgoblin_health"):GetInt())
    ply:SetStepSize(ply:GetStepSize()*0.5)
    ply:SetModelScale(ply:GetModelScale()*0.5, 1)
    ply:SetViewOffset(ply:GetViewOffset()*0.5)
    ply:SetViewOffsetDucked(ply:GetViewOffsetDucked()*0.5)
    ply:SetWalkSpeed(300)
    ply:SetRunSpeed(600)
    ply:EmitSound("ttt2/goblinspawn.mp3",0)
	end

  function ROLE:RemoveRoleLoadout(ply, isRoleChange)
    ply:SetMaxHealth(100)
  	ply:SetStepSize(GetGlobalInt("GoblinStep"))
  	ply:SetModelScale(GetGlobalInt("GoblinScale"),1)
  	ply:SetViewOffset(GetGlobalInt("GoblinView"))
  	ply:SetViewOffsetDucked(GetGlobalInt("GoblinCrouch"))
  	ply:SetWalkSpeed(GetGlobalInt("GoblinWalk"))
  	ply:SetRunSpeed(GetGlobalInt("GoblinRun"))
	end

	-- inform other players about the loot goblin in this round
	hook.Add("TTTBeginRound", "LootGoblinTraitorMsg", function()
		if not GetConVar("ttt_" .. LOOTGOBLIN.name .. "_enabled"):GetBool() then return end

		if GetConVar("ttt_" .. LOOTGOBLIN.name .. "_enabled"):GetInt() > #(player.GetAll()) then return end

		-- GET A LIST OF ALL LOOT GOBLINS
		local is_gob = false
		local players = player.GetAll()
		for i = 1, #players do
			local ply = players[i]

			if ply:GetSubRole() == ROLE_LOOTGOBLIN then
				is_gob = true
			end
		end

		if (is_gob == false) then return end --IF is no Loot Gob, then skip

		-- NOTIFY ALL PLAYERS IF THERE IS A LOOT GOBLIN THIS ROUND
		if GetConVar("ttt2_lootgoblin_announce"):GetBool() then
			if (is_gob) then
				LANG.MsgAll("ttt2_role_lootgoblin_info_kill", nil, MSG_MSTACK_WARN)
				for x = 1, #players do
					local ply2 = players[x]
					if (ply2 ~= ROLE_LOOTGOBLIN) then
						ply2:PrintMessage(HUD_PRINTCENTER, "There's a Loot Goblin!")
					end
				end
			else
				LANG.MsgAll("ttt2_role_lootgoblin_info_no", nil, MSG_MSTACK_PLAIN)
			end
		end
	end)

end

if CLIENT then
  function ROLE:AddToSettingsMenu(parent)
    local form = vgui.CreateTTT2Form(parent, "header_roles_additional")

    form:MakeSlider({
      serverConvar = "ttt2_lootgoblin_health",
      label = "ttt2_lootgoblin_health",
      min = 1,
      max = 100,
      decimal = 0
    })

    form:MakeCheckBox({
      serverConvar = "ttt2_lootgoblin_announce",
      label = "ttt2_lootgoblin_announce"
    })

    form:MakeSlider({
      serverConvar = "ttt2_lootgoblin_lootnum",
      label = "ttt2_lootgoblin_lootnum",
      min = 1,
      max = 10,
      decimal = 0
    })

    form:MakeSlider({
      serverConvar = "ttt2_lootgoblin_damagescale",
      label = "ttt2_lootgoblin_damagescale",
      min = 0,
      max = 1,
      decimal = 2
    })

  end
end