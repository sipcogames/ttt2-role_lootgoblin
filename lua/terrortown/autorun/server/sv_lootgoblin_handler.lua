-- Jester Style Functions
local function LootGoblinDealNoDamage(ply, attacker)
	if not IsValid(ply) or not IsValid(attacker) or not attacker:IsPlayer() or attacker:GetSubRole() ~= ROLE_LOOTGOBLIN then return end

	return true -- true to block damage event
end

local function SpawnLootGoblinConfetti(ply)
	if not IsValid(ply) or ply:GetSubRole() ~= ROLE_LOOTGOBLIN then return end

	if not IsValid(attacker) or attacker == ply then return end

	ply:EmitSound("ttt2/goblinpop.mp3")

	net.Start("GobConfetti")
	net.WriteEntity(ply)
	net.Broadcast()
end

--reset Loot Goblin Traits
local function ResetGoblin(ply)
	ply:SetMaxHealth(100)
  ply:SetStepSize(GetGlobalInt("GoblinStep"))
  ply:SetModelScale(GetGlobalInt("GoblinScale"),1)
  ply:SetViewOffset(GetGlobalInt("GoblinView"))
  ply:SetViewOffsetDucked(GetGlobalInt("GoblinCrouch"))
  ply:SetWalkSpeed(GetGlobalInt("GoblinWalk"))
  ply:SetRunSpeed(GetGlobalInt("GoblinRun"))
end

local function SpawnWeapon(wp,ply)
  local wepdrop = ents.Create(wp)
  
  timer.Simple(0, function()
    if not IsValid(wepdrop) then return end

    wepdrop:SetPos(ply:GetPos())
    wepdrop:Spawn()
  end)
end

-- Calc Traitor Weapons for Loot and Drop them
local function SpawnLootDrops(ply)
	--if not IsValid(ply) or ply:GetSubRole() ~= ROLE_LOOTGOBLIN then return end

	local t_weapons = {}
	local value = 0

	for _, v in pairs( weapons.GetList() ) do
  
		if table.HasValue(v.CanBuy, ROLE_TRAITOR) then
			
			table.insert( t_weapons, v.ClassName )
			value = value + 1
		
		end
	end

	--PrintTable(t_weapons)

	for i=0, GetConVar("ttt2_lootgoblin_lootnum"):GetInt() do
		
		randwep = math.random(1,value)

		SpawnWeapon(t_weapons[randwep],ply)

		i = i + 1

	end
end

-- Announce who kills the Loot Goblin
local function AnnounceLootGoblinKiller(ply, killer)
	LANG.MsgAll("ttt2_role_lootgoblin_killed_by_player", {nick = killer:Nick()}, MSG_MSTACK_PLAIN)
	events.Trigger(EVENT_LOOTGOBLIN_KILLED,killer)
	LOOTGOBLIN.shouldWin = false
end

-- Jester deals no damage to other players
hook.Add("PlayerTakeDamage", "LootGoblinNoDamage", function(ply, inflictor, killer, amount, dmginfo)
	if LootGoblinDealNoDamage(ply, killer) then
		if (GetConVar("ttt2_lootgoblin_damagescale"):GetFloat() > 0.0) then

			dmginfo:ScaleDamage(GetConVar("ttt2_lootgoblin_damagescale"):GetFloat())
			--dmginfo:ScaleDamage(0.25)
			return
		else
			
			dmginfo:ScaleDamage(0)
			dmginfo:SetDamage(0)
			return
		end
	end
end)

hook.Add("TTT2PostPlayerDeath", "LootGoblinPostDeath", function(ply, inflictor, killer)
	if not IsValid(ply)
		or ply:GetSubRole() ~= ROLE_LOOTGOBLIN
		or not IsValid(killer)
		or not killer:IsPlayer()
		or killer == ply
		or GetRoundState() ~= ROUND_ACTIVE
		or hook.Run("TTT2PreventLootGoblinWinstate", killer)
	then return end

	ResetGoblin(ply)
	AnnounceLootGoblinKiller(ply,killer)
	SpawnLootGoblinConfetti(ply)
	SpawnLootDrops(ply)
	

end)

--[[
hook.Add("TTTEndRound", "LootGoblinEndRound", function()
	for _, v in ipairs(player.GetAll()) do
		if (v:GetSubRole() == ROLE_LOOTGOBLIN and v:Alive()) then --lootgoblin survived and should win
			LOOTGOBLIN.shouldWin = true
		end
	end
end)
]]

-- LOOT GOBLIN WIN IF SURVIVE ROUND
hook.Add("TTT2ModifyWinningAlives", "CheckLootGoblinTeamSwitch", function(alives)
    local winningTeam = ""

    if alives == nil then return end

    -- Check alive teams
    for i in pairs(alives) do
      local t = alives[i]
      if winningTeam ~= "" and winningTeam ~= t then return end
      winningTeam = t
    end

    --if winningTeam == "" then return end
 
    -- Find and change Loot Goblin team to winning team
    for _, ply in ipairs(player.GetAll()) do
      if (not IsValid(ply) or not ply:Alive()) then continue end
			if (SpecDM and (ply.IsGhost and ply:IsGhost() or (vics.IsGhost and vics:IsGhost()))) then continue end

      if (ply:GetSubRole() == ROLE_LOOTGOBLIN) then
      	if (winningTeam == "") then --only goblin wins
      		roles.LOOTGOBLIN.shouldWin = true
      	else --join winners
        	ply:UpdateTeam(winningTeam, false)
        	ResetGoblin(ply)
        end
      end
    end
end)
