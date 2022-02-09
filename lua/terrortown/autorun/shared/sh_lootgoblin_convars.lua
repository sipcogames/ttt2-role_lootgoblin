CreateConVar("ttt2_lootgoblin_health", 50, {FCVAR_NOTIFY, FCVAR_ARCHIVE})
CreateConVar("ttt2_lootgoblin_announce", 1, {FCVAR_NOTIFY, FCVAR_ARCHIVE})
CreateConVar("ttt2_lootgoblin_lootnum", 3, {FCVAR_NOTIFY, FCVAR_ARCHIVE})
CreateConVar("ttt2_lootgoblin_damagescale", 0.0, {FCVAR_NOTIFY, FCVAR_ARCHIVE})

hook.Add("TTTUlxDynamicRCVars", "ttt2_ulx_dynamic_lootgoblin_convars", function(tbl)
  tbl[ROLE_LOOTGOBLIN] = tbl[ROLE_LOOTGOBLIN] or {}

  table.insert(tbl[ROLE_LOOTGOBLIN], {
      cvar = "ttt2_lootgoblin_health",
      slider = true,
      min = 1,
      max = 100,
      desc = "ttt2_lootgoblin_health (def. 50)"
  })

  table.insert(tbl[ROLE_LOOTGOBLIN], {
    cvar = "ttt2_lootgoblin_announce",
    checkbox = true,
    desc = "ttt2_lootgoblin_announce (Def. 1)"
  })

  table.insert(tbl[ROLE_LOOTGOBLIN], {
      cvar = "ttt2_lootgoblin_lootnum",
      slider = true,
      min = 1,
      max = 10,
      desc = "ttt2_lootgoblin_lootnum (def. 3)"
  })

  table.insert(tbl[ROLE_LOOTGOBLIN], {
      cvar = "ttt2_lootgoblin_damagescale",
      slider = true,
      min = 0.0,
      max = 1.0,
      desc = "ttt2_lootgoblin_damagescale (def. 0.0)"
  })
end)