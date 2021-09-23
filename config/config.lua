Config = {}

-- NotW4018 <3

-- STA TI NE TREBA OD GRUPA PROMENI
Config.SeeOwnLabel = true
Config.SeeDistance = 100
Config.TextSize = 0.8
Config.ZOffset = 1.2
Config.NearCheckWait = 500
Config.TagByPermission = false --Using xPlayer.getPermissions() which is deprecated method for old ESX
Config.GroupLabels = {
    helper = "~g~[PROBNI ADMIN]\n~w~ ",
    mod = "~g~[MODERATOR]\n~w~ ",
	owner = "~g~[VLASNIK]\n~w~ ",
    admin = "~g~[ADMIN]\n~w~ ",
    headadmin = "~g~[HEAD ADMIN]\n~w~ ",
	developer = "~g~[SKRIPTER]\n~w~ ",
    superadmin = "~g~[VLASNIK]\n~w~ ",
}

Config.PermissionLabels = {
    [1] = "PROBNI ADMIN",
    [2] = "~g~MODERATOR",
    [3] = "~g~ADMIN",
    [4] = "~g~SUPER ADMIN",
    [5] = "~g~VLASNIK",
}
