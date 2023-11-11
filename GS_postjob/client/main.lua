ESX = exports['es_extended']:getSharedObject()

Citizen.CreateThread(function ()
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end
end)

local function getLine()
    local info = debug.getinfo(2, "Sl")
    return info.currentline
end

print('Ovaj print se nalazi na liniji: ' .. getLine())
--[[
function notifikacija(poruka)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(poruka)
    DrawNotification(0,1)
end
--]]

function Draw3DText(x, y, z, text)
    local onScreen, _x, _y = GetScreenCoordFromWorldCoord(x, y, z)

    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()

        BeginTextCommandDisplayText("STRING")
        AddTextComponentSubstringPlayerName(text)
        EndTextCommandDisplayText(_x, _y)
    end
end

-- export Draw3DText(100.0, -1000.0, 30.0, "A!")

Citizen.CreateThread(function ()
    for i, v in pairs(Config.Blipovi) do
        local blip = AddBlipForCoord(v.Kordinate.x, v.Kordinate.y, v.Kordinate.z)

        SetBlipSprite(blip, v.Ikonica)

        if v.Boja ~= nil then
            SetBlipColour(blip, v.Boja)
        end

        SetBlipDisplay(blip, v.Pokazuj)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.Ime)  -- Stavi ime blipu
        EndTextCommandSetBlipName(blip)

        Citizen.CreateThread(function ()
            while true do
                Citizen.Wait(0)

                local display = v.Pokazuj

                if v.PotrebanPosao then
                    if ESX.PlayerData.job and ESX.PlayerData.job.name then
                        if ESX.PlayerData.job.name ~= Config.job then
                            display = 0
                        end
                    end
                end

                SetBlipDisplay(blip, display)
            end
        end)
    end
end)

local sacekaj = false -- cooldown
local currentProp = nil

RegisterNetEvent('lolex:postansko')
AddEventHandler('lolex:postansko', function(propName)
    if not sacekaj then
        if currentProp and currentProp == propName then
            if Config.locale == 'rs' then
                ESX.ShowNotification("Vec ste pokupili papire s ovog standa. Pronadjite drugi!")
            elseif Config.locale == 'en' then
                ESX.ShowNotification("You already took papers from this stand, go find another one!")
            end
        else
            sacekaj = true
            currentProp = propName
            
            TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true) -- animacija // animation = /e parkingmeter
            if Config.ProgressBar == true then
                if Config.locale == 'rs' then
                    exports.rprogress:Start('Uzimate papire...', 5000) -- 5 sekundi uzimanja papira // 5 seconds to take papers
                elseif Config.locale == 'en' then
                    exports.rprogress:Start('Taking papers...', 5000) -- 5 sekundi uzimanja papira // 5 seconds to take papers
                end
            elseif Config.ProgressBar == false then
                Citizen.Wait(5000) -- 5 sekundi / 5 seconds
            end
            TriggerServerEvent('lolex:postanskoS', propName)
            ClearPedTasks(PlayerPedId()) -- prekini animaciju // stop animation
            Citizen.Wait(10000) -- 10 sekundi // 10 seconds
            sacekaj = false
        end
    else
        if Config.Notifikacija == 'esx' and Config.locale == 'rs' then
            ESX.ShowNotification(Config.rsNotifikacijaZaStrpljenje)
        elseif Config.Notifikacija == 'esx' and Config.locale == 'en' then
            ESX.ShowNotification(Config.enNotifikacijaZaStrpljenje)
        elseif Config.Notifikacija == 'okok' and Config.locale == 'rs' then
            exports['okokNotify']:Alert('Posta', Config.rsNotifikacijaZaStrpljenje, 5000, 'info', playSound)
        elseif Config.Notifikacija == 'okok' and Config.locale == 'en' then
            exports['okokNotify']:Alert('Post', Config.enNotifikacijaZaStrpljenje, 5000, 'info', playSound)
        elseif Config.Notifikacija == 'mythic' and Config.locale == 'rs' then
            exports['mythic_notify']:DoHudText('inform', Config.rsNotifikacijaZaStrpljenje)
        elseif Config.Notifikacija == 'mythic' and Config.locale == 'en' then
            exports['mythic_notify']:DoHudText('inform', Config.enNotifikacijaZaStrpljenje)
        end
    end
end)

if Config.target == true then
    if Config.locale == 'rs' then
        exports.qtarget:AddTargetModel('prop_postbox_01a', {
            options = {
                {
                    event = 'lolex:postansko',
                    icon = 'fa fa-suitcase',
                    label = 'Otvori postansko sanduce',
                    prop = 'prop_postbox_01a',
                }
            },
            distance = 2.0
        })
        exports.qtarget:AddTargetModel('prop_news_disp_03a', {
            options = {
                {
                    event = 'lolex:postansko',
                    icon = 'fa fa-suitcase',
                    label = 'Otvori postansko sanduce',
                    prop = 'prop_news__disp_03a',
                }
            },
            distance = 2.0
        })  
        exports.qtarget:AddTargetModel('prop_news_disp_02a', {
            options = {
                {
                    event = 'lolex:postansko',
                    icon = 'fa fa-suitcase',
                    label = 'Otvori postansko sanduce',
                     prop = 'prop_news__disp_02a',
                }
            },
            distance = 2.0
        })
    elseif Config.locale == 'en' then
        exports.qtarget:AddTargetModel('prop_postbox_01a', {
            options = {
                {
                    event = 'lolex:postansko',
                    icon = 'fa fa-suitcase',
                    label = 'Open post box',
                    prop = 'prop_postbox_01a',
                }
            },
            distance = 2.0
        }) 
        exports.qtarget:AddTargetModel('prop_news_disp_03a', {
            options = {
                {
                    event = 'lolex:postansko',
                    icon = 'fa fa-suitcase',
                    label = 'Open post box',
                    prop = 'prop_news__disp_03a',
                }
            },
            distance = 2.0
            })
            
        exports.qtarget:AddTargetModel('prop_news_disp_02a', {
            options = {
                {
                    event = 'lolex:postansko',
                    icon = 'fa fa-suitcase',
                    label = 'Open post box',
                    prop = 'prop_news__disp_02a',
                }
            },
            distance = 2.0
        })
    end
end

Citizen.CreateThread(function()
    
    for _,v in pairs(Config.Vozila) do
      RequestModel(GetHashKey(v.model))
      while not HasModelLoaded(GetHashKey(v.model)) do
        Wait(1)
      end
      PostaviPeda = CreatePed(4, v.model, vector3(v.coords.x, v.coords.y, v.coords.z - 1) , v.coords.w, false, true)
      FreezeEntityPosition(PostaviPeda, true) 
      SetEntityInvincible(PostaviPeda, true)
      SetBlockingOfNonTemporaryEvents(PostaviPeda, true)
        if Config.locale == 'rs' then
        exports.qtarget:AddBoxZone('vozila', vector3(v.coords.x, v.coords.y, v.coords.z - 1), v.coords.w, 1.0, {
            name= 'vozila',
            heading= v.coords.w,
            debugPoly= false,
            minZ= v.coords.z -1,
            maxZ= v.coords.z +2,
            }, {
              options = {
                {
                  event = 'lolex:izvadi',
                  icon = "fas fa-sign-in-alt",
                  label = "Uzmi vozilo", 
                  job = Config.job  
                },
                {
                  event = 'lolex:parkiraj',
                  icon = "fas fa-sign-in-alt",
                  label = "Parkiraj vozilo",   
                  job = Config.job
                },
              },
              distance = 3.5
          })
        elseif Config.locale == 'en' then
            exports.qtarget:AddBoxZone('vozila', vector3(v.coords.x, v.coords.y, v.coords.z - 1), v.coords.w, 1.0, {
                name= 'vozila',
                heading= v.coords.w,
                debugPoly= false,
                minZ= v.coords.z -1,
                maxZ= v.coords.z +2,
                }, {
                  options = {
                    {
                      event = 'lolex:izvadi',
                      icon = "fas fa-sign-in-alt",
                      label = "Take vehicle", 
                      job = Config.job  
                    },
                    {
                      event = 'lolex:parkiraj',
                      icon = "fas fa-sign-in-alt",
                      label = "Park vehicle",   
                      job = Config.job
                    },
                  },
                  distance = 3.5
              })
        end
    end
end)

Citizen.CreateThread(function()
    
    for _,v in pairs(Config.Prodaja) do
      RequestModel(GetHashKey(v.model))
      while not HasModelLoaded(GetHashKey(v.model)) do
        Wait(1)
      end
      PostaviPeda = CreatePed(4, v.model, vector3(v.coords.x, v.coords.y, v.coords.z - 1) , v.coords.w, false, true)
      FreezeEntityPosition(PostaviPeda, true) 
      SetEntityInvincible(PostaviPeda, true)
      SetBlockingOfNonTemporaryEvents(PostaviPeda, true)
      if Config.locale == 'rs' then
        exports.qtarget:AddBoxZone('prodaja', vector3(v.coords.x, v.coords.y, v.coords.z - 1), v.coords.w, 1.0, {
            name= 'prodaja',
            heading= v.coords.w,
            debugPoly= false,
            minZ= v.coords.z -1,
            maxZ= v.coords.z +2,
            }, {
              options = {
                {
                  action = function()
                      if Config.locale == 'rs' then
                      exports.rprogress:Start('Prodajete papire...', 5000) -- 5 sekundi prodaja papira // 5 seconds to sell papers
                      TriggerServerEvent('lolex:prodaja')
                      else
                        if Config.Notifikacija == 'esx' and Config.locale == 'rs' then
                            ESX.showNotification('esx:showNotification', source, '~y~Nemate papira~s~!')
                        elseif Config.Notifikacija == 'esx' and Config.locale == 'en' then
                            ESX.showNotification('esx:showNotification', source, '~y~You don\'t have papers~s~!')
                        elseif Config.Notifikacija == 'okok' and Config.locale == 'rs' then
                            TriggerClientEvent('okokNotify:Alert', source, 'Posta', 'Nemate papira', 5000, 'info', playSound)
                            exports['okokNotify']:Alert('Posta', 'Nemate papira', 5000, 'info', playSound)
                        elseif Config.Notifikacija == 'okok' and Config.locale == 'en' then
                            exports['okokNotify']:Alert('Post', 'You don\'t have papers', 5000, 'info', playSound)
                        elseif Config.Notifikacija == 'mythic' and Config.locale == 'rs' then
                            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Nemate papira!', style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
                        elseif Config.Notifikacija == 'mythic' and Config.locale == 'en' then
                            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You don\'t have papers', style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
                        end
                      end
                  end,
                  icon = "fas fa-sign-in-alt",
                  label = "Prodaj papir",   
                  job = Config.job
                },
              },
              distance = 3.5
          })
        elseif Config.locale == 'en' then
            exports.qtarget:AddBoxZone('prodaja', vector3(v.coords.x, v.coords.y, v.coords.z - 1), v.coords.w, 1.0, {
                name= 'prodaja',
                heading= v.coords.w,
                debugPoly= false,
                minZ= v.coords.z -1,
                maxZ= v.coords.z +2,
                }, {
                  options = {
                    {
                      action = function()
                          if Config.locale == 'en' then
                            ESX.TriggerServerCallback('getajitem', function(ima) 
                                if ima then 
                                    exports.rprogress:Start('Selling papers...', 5000) -- 5 sekundi prodaja papira // 5 seconds to sell papers
                                    TriggerServerEvent('lolex:prodaja')
                                else
                                    if Config.Notifikacija == 'esx' and Config.locale == 'en' then
                                        ESX.showNotification('esx:showNotification', source, '~y~You don\'t have papers~s~!')
                                    elseif Config.Notifikacija == 'okok' and Config.locale == 'en' then
                                        exports['okokNotify']:Alert('Post', 'You don\'t have papers', 5000, 'info', playSound)
                                    elseif Config.Notifikacija == 'mythic' and Config.locale == 'en' then
                                        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You don\'t have papers', style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
                                    end
                                end
                              end, Config.item)
                          end
                      end,
                      icon = "fas fa-sign-in-alt",
                      label = "Sell papers",   
                      job = Config.job
                    },
                  },
                  distance = 3.5
              })
        end
    end
end)

RegisterNetEvent('lolex:izvadi', function()
    for k,v in pairs(Config.Vozila) do 
        ESX.Game.SpawnVehicle(v.modelauta, vector3(v.kordinatezaspawnauta.x, v.kordinatezaspawnauta.y, v.kordinatezaspawnauta.z), v.kordinatezaspawnauta.w, function(vozilo)
            TaskWarpPedIntoVehicle(PlayerPedId(), vozilo, -1)
        end)
    end
end)

RegisterNetEvent('lolex:parkiraj', function ()
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        ESX.Game.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId(), true))
    else
        ESX.ShowNotification("Niste u vozilu")
    end
end)