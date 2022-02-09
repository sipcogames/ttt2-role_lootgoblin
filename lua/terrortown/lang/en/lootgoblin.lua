L = LANG.GetLanguageTableReference("en")

-- GENERAL ROLE LANGUAGE STRINGS
L[LOOTGOBLIN.name] = "Loot Goblin"
L[LOOTGOBLIN.defaultTeam] = "Team Loot Goblin"
L["hilite_win_" .. LOOTGOBLIN.defaultTeam] = "THE LOOT GOBLIN WON?!"
L["win_" .. LOOTGOBLIN.defaultTeam] = "The Loot Goblin has won!"
L["info_popup_" .. LOOTGOBLIN.name] = [[You are the Loot Goblin! Your full of loot, try to survive until the round ends!]]
L["body_found_" .. LOOTGOBLIN.abbr] = "They were a Loot Goblin! Nice Kill!"
L["search_role_" .. LOOTGOBLIN.abbr] = "This person was a Loot Goblin! Nice Shot!"
L["ev_win_" .. LOOTGOBLIN.defaultTeam] = "The Loot Goblin won the round!"
L["target_" .. LOOTGOBLIN.name] = "Loot Goblin"
L["ttt2_desc_" .. LOOTGOBLIN.name] = [[The Loot Goblin is visible for everyone. They are at half health and half the size.
The Loot Goblin cannot deal damage or kill himself. But if he gets killed, he drops loot. So he'll try to survive!]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_role_lootgoblin_killed_by_player"] = "{nick} killed the Loot Goblin!"
L["ttt2_role_lootgoblin_info_kill"] = "Kill the Loot Goblin for its Loot!"
L["ttt2_role_lootgoblin_info_no"] = "There is no Loot Goblin in this round!"
L["ttt2_role_lootgoblin_info_single"] = "'{playername}' is the Loot Goblin!"

-- WINSTATE LANGS
L["ttt2_role_lootgoblin_winstate_1"] = "Loot Goblin winstate 1: You will win if you survive."

-- EVENT LANGS
L["title_event_lootgoblin_killed"] = "Loot Goblin Killed!"
L["desc_event_lootgoblin_killed"] = "{killer} ({irole} / {iteam}) killed the Loot Goblin!"

-- CONVAR LANGS
L["ttt2_lootgoblin_health"] = "Loot Goblin Max HP"
L["ttt2_lootgoblin_announce"] = "Announce if a lootgoblin is in the round"
L["ttt2_lootgoblin_lootnum"] = "Loot Dropped on Kill"
L["ttt2_lootgoblin_damagescale"] = "Damage Scale for Loot Goblin"