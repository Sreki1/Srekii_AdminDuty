-- Srekii <3

ESX = nil
local currentAdminPlayers = {}
local visibleAdmins = {}
AdminList = {}


Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
    end
  end)

RegisterNetEvent('red_adminmode:clupdatelist')
AddEventHandler('red_adminmode:clupdatelist', function(list) 
    AdminList = list
end)

RegisterNetEvent('red_adminmode:setGodmode')
AddEventHandler('red_adminmode:setGodmode', function(state)
    SetEntityInvincible(GetPlayerPed(-1), state)
end)

RegisterNetEvent('red_adminmode:setOutfit')
AddEventHandler('red_adminmode:setOutfit', function()
    TriggerEvent('skinchanger:change', "tshirt_1", 15)
    TriggerEvent('skinchanger:change', "tshirt_2", 0)
    TriggerEvent('skinchanger:change', "torso_1", 287)
    TriggerEvent('skinchanger:change', "torso_2", 2)
    TriggerEvent('skinchanger:change', "arms", 3)
    TriggerEvent('skinchanger:change', "pants_1", 114)
    TriggerEvent('skinchanger:change', "pants_2", 2)
    TriggerEvent('skinchanger:change', "shoes_1", 78)
    TriggerEvent('skinchanger:change', "shoes_2", 2)
    TriggerEvent('skinchanger:change', "helmet_1", -1)
    TriggerEvent('skinchanger:change', "helmet_2", 0)
    TriggerEvent('skinchanger:change', "mask_1", 135)
    TriggerEvent('skinchanger:change', "mask_2", 2)
    TriggerEvent('skinchanger:change', "chain_1", 0)
    TriggerEvent('skinchanger:change', "chain_2", 0)
    TriggerEvent('skinchanger:change', "ears_1", 0)
    TriggerEvent('skinchanger:change', "ears_2", 0)
    TriggerEvent('skinchanger:change', "bags_1", 0)
    TriggerEvent('skinchanger:change', "bags_2", 0)
    TriggerEvent('skinchanger:change', "hair_1", 0)
    TriggerEvent('skinchanger:change', "hair_2", 0)
    TriggerEvent('skinchanger:change', "bproof_1", 0)
    TriggerEvent('skinchanger:change', "bproof_2", 0)
    TriggerEvent('skinchanger:change', "sex", 0)
end)

RegisterNetEvent('red_adminmode:zivil')
AddEventHandler('red_adminmode:zivil', function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
end)





Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('admin_tag:set_admins')
AddEventHandler('admin_tag:set_admins', function(admins)
    currentAdminPlayers = admins
    for id, admin in pairs(visibleAdmins) do
        if admins[id] == nil then
            visibleAdmins[id] = nil
        end
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    ESX.TriggerServerCallback('admin_tag:getAdminsPlayers', function(admins)
        currentAdminPlayers = admins
    end)
end)

function draw3DText(pos, text, options)
    options = options or {}
    local color = options.color or { r = 255, g = 255, b = 255, a = 255 }
    local scaleOption = options.size or 0.8

    local camCoords = GetGameplayCamCoords()
    local dist = #(vector3(camCoords.x, camCoords.y, camCoords.z) - vector3(pos.x, pos.y, pos.z))
    local scale = (scaleOption / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scaleMultiplier = scale * fov
    SetDrawOrigin(pos.x, pos.y, pos.z, 0);
    SetTextProportional(0)
    SetTextScale(0.0 * scaleMultiplier, 0.55 * scaleMultiplier)
    SetTextColour(color.r, color.g, color.b, color.a)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.NearCheckWait)
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        for k, v in pairs(currentAdminPlayers) do
            local playerServerID = GetPlayerFromServerId(v.source)
            if playerServerID ~= -1 then
                local adminPed = GetPlayerPed(playerServerID)
                local adminCoords = GetEntityCoords(adminPed)

                local distance = #(adminCoords - pedCoords)
                if distance < (Config.SeeDistance) then
                    visibleAdmins[v.source] = v
                else
                    visibleAdmins[v.source] = nil
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k, v in pairs(visibleAdmins) do
            local playerServerID = GetPlayerFromServerId(v.source)
            if playerServerID ~= -1 then
                local adminPed = GetPlayerPed(playerServerID)
                local adminCoords = GetEntityCoords(adminPed)
                local x, y, z = table.unpack(adminCoords)
                z = z + Config.ZOffset
				local PlayerServerID = v.source

                local label
                if Config.TagByPermission then
                    label = Config.PermissionLabels[v.permission]
                else
                    label = Config.GroupLabels[v.group] .. GetPlayerName(GetPlayerFromServerId(v.source))
                end

                if label then
                    if v.source == GetPlayerServerId(PlayerId()) then
                        if Config.SeeOwnLabel == true then
                            draw3DText(vector3(x, y, z), label, {
                                size = Config.TextSize
                            })
                        end
                    else
                        draw3DText(vector3(x, y, z), label, {
                            size = Config.TextSize
                        })
                    end
                end
            end
        end
    end
end)
