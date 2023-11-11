ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('lolex:postanskoS')
AddEventHandler('lolex:postanskoS', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer and xPlayer.job and xPlayer.job.name == Config.job then
        local kolicina = Config.jobNagrada
        xPlayer.addInventoryItem(Config.item, kolicina)
    else
        if Config.Notifikacija == 'esx' and Config.locale == 'rs' then
            TriggerClientEvent('esx:showNotification', source, '~y~Niste postar~s~!')
        elseif Config.Notifikacija == 'esx' and Config.locale == 'en' then
            TriggerClientEvent('esx:showNotification', source, '~y~You aren\'t the postman~s~!')
        elseif Config.Notifikacija == 'okok' and Config.locale == 'rs' then
            TriggerClientEvent('okokNotify:Alert', source, 'Postar', 'Vi niste postar', 5000, 'info', playSound)
        elseif Config.Notifikacija == 'okok' and Config.locale == 'en' then
            TriggerClientEvent('okokNotify:Alert', source, 'Postar', 'You aren\'t the postman', 5000, 'info', playSound)
        elseif Config.Notifikacija == 'mythic' and Config.locale == 'rs' then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Vi niste postar!', style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
        elseif Config.Notifikacija == 'mythic' and Config.locale == 'en' then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You aren\'t the postman', style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
        end
    end
end)

RegisterNetEvent('lolex:prodaja', function ()
    local papirV = 5
    local xPlayer = ESX.GetPlayerFromId(source)
    kolicinapapira = xPlayer.getInventoryItem(Config.item).count
    if kolicinapapira >= 1 then
        novac = kolicinapapira * papirV
        xPlayer.removeInventoryItem(Config.item, kolicinapapira)
        xPlayer.addMoney(novac)
    end
end)

ESX.RegisterServerCallback('getajitem', function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem(item).count >= 1 then
     cb(true)
    else
      cb(false)
    end
  end)