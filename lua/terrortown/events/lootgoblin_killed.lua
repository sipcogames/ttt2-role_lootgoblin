if CLIENT then
	EVENT.icon = Material("vgui/ttt/vskin/events/lootgoblin_killed")
	EVENT.title = "title_event_lootgoblin_killed"

	function EVENT:GetText()
		return {
			{
				string = "desc_event_lootgoblin_killed",
				params = {
					killer = self.event.killer.nick,
					irole = roles.GetByIndex(self.event.killer.role).name,
					iteam = self.event.killer.team,
				},
				translateParams = true
			}
		}
	end
end

if SERVER then
	function EVENT:Trigger(killer)
		self:AddAffectedPlayers(
			{killer:SteamID64()},
			{killer:Nick()}
		)

		return self:Add({
			killer = {
				nick = killer:Nick(),
				sid64 = killer:SteamID64(),
				role = killer:GetSubRole(),
				team = killer:GetTeam(),
			}
		})
	end

	function EVENT:CalculateScore()
		local event = self.event

		self:SetPlayerScore(event.killer.sid64, {
			score = 2
		})
	end
end

function EVENT:Serialize()
	return self.event.killer.nick .. " killed the Loot Goblin!"
end
