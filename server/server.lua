ESX = exports["es_extended"]:getSharedObject()


RegisterNetEvent('krs:pescatore') -- INIZIO DELLA PESCA --
AddEventHandler('krs:pescatore', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local index = math.random(1, #KRS.PescaItems)
    local oggetto = KRS.PescaItems[index]
    Citizen.Wait(3500)
        if math.random(1, 2) >= oggetto.chance then
            if oggetto.id == "item" then
                xPlayer.addInventoryItem(oggetto.name, oggetto.quantity)
                TriggerClientEvent('ox_lib:notify', xPlayer.source, {type = 'success', description = 'Hai trovato '..oggetto.quantity..' '..oggetto.label})       
        end
    end
end)

ESX.RegisterUsableItem("cannadapesca", function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local hasEsca = xPlayer.getInventoryItem("esca").count 

	if hasEsca > 0 then 
		TriggerClientEvent("krs:pescatore", source) 
	
	else
        TriggerClientEvent('ox_lib:notify', xPlayer.source, {type = 'error', description = 'Non possiedi l\'esca'})
	end
end)

RegisterNetEvent('togliesca', function()
    local xPlayer = ESX.GetPlayerFromId(source)
xPlayer.removeInventoryItem('esca', 1)

end)


RegisterNetEvent("krs:vendita") -- VENDITA --
AddEventHandler("krs:vendita", function(item)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem = xPlayer.getInventoryItem(item)
    if xItem.count >=1 then
    xPlayer.removeInventoryItem(item, 1)
    Citizen.Wait(1000)
    xPlayer.addMoney(KRS.Vendita["random"])
    TriggerClientEvent('ox_lib:notify', xPlayer.source, {type = 'success', description = 'Hai venduto il pesce al cuoco.'})
    else
        TriggerClientEvent('ox_lib:notify', xPlayer.source, {type = 'error', description = 'Non possiedi il pesce da vendere al cuoco.'})
    end
end)