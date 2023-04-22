KRS = {}

-- ITEMS RANDOM --
KRS.PescaItems = { -- KRS Items --
    [1] = {id = "item", name = 'acciuga', label = 'Acciuga', quantity = math.random(1, 2), chance = 1},
    [2] = {id = "item", name = 'sgombro', label = 'Sgombro', quantity = math.random(1, 2), chance = 1},
    [3] = {id = "item", name = 'orata', label = 'Orata', quantity = math.random(1, 2), chance = 1},
}

KRS.Traduzione = { 

    InizioPesca = "Lanciando la lenza",
    Prendi = "Inizia a pescare",
    Fallito = "Non riesco a pescare",
    Parlaconilcuoco = "Parlando con il cuoco per la vendita",
    Vendita = "Vendi il pesce",
    VenditaFallita = "Non sono riuscito a vendere",
   
}

KRS.Blip = {
    
    {name="Vendita del Pesce",  color = 26, id = 108, x = -1815.6431, y = -1191.9677, z = 14.3048, grandezza = 0.80}, 
}

-- VENDITA --
KRS.Vendita = {
    ["random"] = math.random(100,150), -- RANDOM SOLDI VENDITA --
    ["price"] = 500 -- SOLDI NORMALI VENDITA --
}

