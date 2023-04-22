ESX = exports["es_extended"]:getSharedObject()

------------------
-- INIZIO PESCA --
------------------

RegisterNetEvent('krs:pescatore') 
AddEventHandler('krs:pescatore', function()
    
local Ped = PlayerPedId()
local inWater = IsEntityInWater(Ped)
if not inWater then
    return end
    TriggerServerEvent('togliesca')
    local success = lib.skillCheck({'easy', 'easy', {areaSize = 60, speedMultiplier = 1}})
    if success then
        lib.progressCircle({
            FreezeEntityPosition(Ped, true),
            duration = 15000,
            position = 'bottom',
            label = KRS.Traduzione["InizioPesca"],
            useWhileDead = false,
            canCancel = false,
            disable = {
                car = true,
            },
            anim = {
                dict = 'amb@world_human_stand_fishing@idle_a',
                clip = 'idle_c'
            },
            prop = {
                model = `prop_fishing_rod_01`,
                pos = vec3(0.03, 0.03, 0.03),
                rot = vec3(0.03, 0.03, 0.03)
            },
        })
        TriggerServerEvent('krs:pescatore')
    else
        lib.notify({
            title = 'Krs Fishing',
            description = KRS.Traduzione["Fallito"],
            type = 'error'
        })
    end
    FreezeEntityPosition(Ped, false)
end)


-------------
-- VENDITA --
-------------


Citizen.CreateThread(function() -- PROCESSO --
    if not HasModelLoaded('s_m_y_chef_01') then
       RequestModel('s_m_y_chef_01')
       while not HasModelLoaded('s_m_y_chef_01') do
          Citizen.Wait(5)
       end
    end

npc = CreatePed(4, 's_m_y_chef_01', -1816.2390, -1192.6757, 13.3048,  326.5992, false, true)
FreezeEntityPosition(npc, true)
SetEntityInvincible(npc, true)
SetBlockingOfNonTemporaryEvents(npc, true)
local VenditaNpc = false
local options = {
    
    {
        name = 'ox:cuoco',
        event = 'krs:vendita',
        icon = 'fa-solid fa-fish',
        label = 'Vendi il pesce',
        canInteract = function(entity)
            return not IsEntityDead(entity)
        end
    }
}

local optionNames = { 'ox:cuoco'}
exports.ox_target:addLocalEntity(npc,options)


end)

RegisterNetEvent('krs:vendita')
AddEventHandler('krs:vendita', function(value)
    VenditaNpc = value
end)



RegisterNetEvent('krs:vendita') 
AddEventHandler('krs:vendita', function()
    local Ped = PlayerPedId()
    local input = lib.inputDialog('Parla con Tony', {
        {type = 'select', label = 'Vendita', options = {
            {label = "Orata", value = "orata"},
            {label = "Acciuga", value = "acciuga"},
            {label = "Sgombro", value = "sgombro"},
        }},
    })
    
    if input and #input > 0 then
        TriggerServerEvent('krs:vendita',  input[1])
    end
    
end)

-- KRS BLIP --
Citizen.CreateThread(function()
	for i=1, #KRS.Blip, 1 do
		local blip = AddBlipForCoord(KRS.Blip[i].x, KRS.Blip[i].y, KRS.Blip[i].z)
		SetBlipSprite (blip, KRS.Blip[i].id)
		SetBlipDisplay(blip, 2)
		SetBlipColour (blip, KRS.Blip[i].color)
		SetBlipAsShortRange(blip, true)
		SetBlipScale(blip, KRS.Blip[i].grandezza)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(KRS.Blip[i].name)
		EndTextCommandSetBlipName(blip)
	end
end)