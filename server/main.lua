-- NotW4018 <3

ESX = nil
AdminPlayers = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('aduznost', function(source,args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if AdminPlayers[source] == nil then
        if Config.TagByPermission then
            AdminPlayers[source] = {source = source, permission = xPlayer.getPermissions()}
        else
            AdminPlayers[source] = {source = source, group = xPlayer.getGroup()}
        end

        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'USLI STE U ADMIN MODE', style = { ['background-color'] = '#00c410', ['color'] = '#000000' } })
		TriggerClientEvent('red_adminmode:setGodmode', source, true)
        TriggerClientEvent('red_adminmode:setOutfit', source)
    else
        AdminPlayers[source] = nil
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'IZASLI STE IZ ADMIN MODA', style = { ['background-color'] = '#00c410', ['color'] = '#000000' } })
		TriggerClientEvent('red_adminmode:setGodmode', source, false)
		TriggerClientEvent('red_adminmode:zivil', source)
    end
    TriggerClientEvent('admin_tag:set_admins',-1,AdminPlayers)
end)

ESX.RegisterServerCallback('admin_tag:getAdminsPlayers',function(source,cb)
    cb(AdminPlayers)
end)

AddEventHandler('esx:playerDropped', function(source)
    if AdminPlayers[source] ~= nil then
        AdminPlayers[source] = nil
    end
    TriggerClientEvent('admin_tag:set_admins',-1,AdminPlayers)
end)

RegisterCommand("admini", function(source)
  local xPlayers = ESX.GetPlayers()
  for i=1, #xPlayers, 1 do
     local xPlayer = ESX.GetPlayerFromId(xPlayers[i]) 
     if xPlayer.pduty(i) == true then
      local xIgrac = ESX.GetPlayerFromId(source)
      TriggerClientEvent('chat:addMessage', source , {
        args = {'Online admini |', " IME : ^3 " .. GetPlayerName(xPlayers[i]) .. "^0 GRUPA ^3" .. xPlayer.getGroup() .. "^0 ID ^3" .. xPlayers[i]}
      })
      end
    end
end)
