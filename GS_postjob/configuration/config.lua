Config = {}

Config.locale = 'rs' -- RS Za Srpski EN Za Engleski // RS For Serbian EN For English
Config.target = true -- ZA SAD SAMO NA TARGET // FOR NOW ONLY ON TARGET -- Ako zelite da radi na target onda ostavite na true a ako zelite na 3d text onda stavite false  // If u want to it works on target don't change it if u want on 3d text then put it on false
Config.item = 'papers' -- Zamenite papers sa vasim itemom koji hocete da dobijate // Change papers into your item name which u wanna to players to get
Config.job = 'postar' -- Zamenite postar sa vasim job imenom // Change postar into your job name
Config.jobNagrada = math.random(2,10) -- Zamenite 2-10 sa vasim brojem papira kolko hocete da postari dobijaju papira // Change 2-10 with your numbers that your post worker will get
Config.Notifikacija = 'esx' -- Za esx notifikacije 'esx' za okok notifikacije 'okok' za mythic notifikacije 'mythic' // For esx notifications 'esx' for okok notifications 'okok' for mythic notifications 'mythic'
Config.rsNotifikacijaZaStrpljenje = 'Ispraznili ste ovaj paketomat, idite na drugi!' -- Promenite kako ocete da kaze mu da mora da ide na drugi
Config.enNotifikacijaZaStrpljenje = 'You emptied this postbox, go find a new one!' -- Change text how u wanna to they see when they need to go on other postbox
Config.ProgressBar = true -- Stavi te na false ako ne zelite a true ako zelite imati progressbar // Set it on false if u don't wanna have progressbar if u want to have set it on true

Config.Blipovi = {
    {
        Ime = "Posta", -- Ime blipa // Name of blip
        Velicina = 1, -- Velicina blipa // Size of blip
        Boja = nil, -- Boja blipa // Color of blip
        Ikonica = 16, -- Blip sprite // Blip sprite
        Kordinate = vector3(68.7760, 123.6485, 79.1696), -- Kordinate blipa // Coords of blip
        Pokazuj = 6, -- Display
        PotrebanPosao = false -- Da li treba osoba da ima posao da vidi // Does it require job to see the blip
    }
}

Config.Vozila = {
    {
    kordinatezaspawnauta = vector4(70.7198, 120.6300, 79.1592, 154.8105), -- Coords to spawn vehicle
    modelauta = 'boxville2', -- Vehicle Model
    coords = vector4(74.9591, 117.1463, 79.1617, 71.9176), -- Coords of ped
    model = 'a_m_m_bevhills_01' -- Ped
    }
}

Config.Prodaja = { -- Selling
    {
    coords = vector4(75.8135, 119.9183, 79.1893, 74.9136), -- Coords of ped
    model = 'a_f_m_soucent_02' -- Ped
    }
}