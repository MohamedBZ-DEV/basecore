local Blips = {
    {Pos = {x=428.4,y=-983.3,z=30.71},sprite=60,size=1.1,color=29,name="Commissariat"},
    {Pos = {x=119.47,y=-1308.58,z=29.71},sprite=121,size=0.7,color=61,name="Unicorn"},
    {name="Aéroport", color=3, sprite=90, Pos = {x=-1336.25, y=-3043.99, z=13.9444}},
    {name="Aéroport", color=3, sprite=90, Pos = {x=2044.42, y=4768.07, z=41.0603}},
    
--   {name="Banque", color=2, sprite=434, Pos = {x=-2964.76, y=482.658, z=15.7068}},
--	{name="Banque", color=2, sprite=434, Pos = {x=260.232, y=205.886, z=106.284}},
--	{name="Banque", color=2, sprite=434, Pos = {x=150.061, y=-1039.99, z=29.3778}},
--	{name="Banque", color=2, sprite=434, Pos = {x=-1213.57, y=-328.829, z=37.7908}},
--    {name="Banque", color=2, sprite=434, Pos = {x=-109.453, y=6464.05, z=31.6267}},

    {name="Location", color=9, sprite=225, Pos = {x=-1017.87, y=-2697.18, z=13.98}},
    
    {name="Distributeur de Billets", color=2, sprite=434,size = 0.80, Pos = { x=89.9733, y=2.18227, z=68.2283}},
	{name="Distributeur de Billets", color=2, sprite=434,size = 0.80, Pos = { x=-526.065, y=-1221.99, z=18.4549}},
	{name="Distributeur de Billets", color=2, sprite=434,size = 0.80, Pos = {x=711.389, y=-820.833, z=23.6155}},
	{name="Distributeur de Billets", color=2, sprite=434,size = 0.80, Pos = { x=-2073.44, y=-317.245, z=13.316}},
	{name="Distributeur de Billets", color=2, sprite=434,size = 0.80, Pos = { x=-821.17, y=-1083.29, z=11.1324}},
	{name="Distributeur de Billets", color=2, sprite=434,size = 0.80, Pos = { x=1686.4, y=4816.36, z=42.0092}},

    {name="Hôpital", color = 5, sprite=61, Pos = {x=344.04, y=-586.18, z=97.98}},
    {name="Mécano", color = 3, sprite=402, Pos = {x=-341.05, y=-136.79, z=39.01}},
    {name="Journaliste", color = 2, sprite=446, Pos = {x=-207.84, y=-1319.68, z=30.28}},
    {name="Taxi", color = 5, sprite=198, Pos = {x=909.18, y=-179.6, z=74.17}},

    {name="Night-Club(SOON)", color = 26, sprite=475, Pos = {x=-429.99, y=261.72, z=83}},
    
}

Citizen.CreateThread(function()
    for i = 1 , #Blips , 1 do
        local v = Blips[i]
        local blip = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)
        SetBlipSprite (blip, v.sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, v.size or 0.8)
        SetBlipColour (blip,  v.color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.name)
        EndTextCommandSetBlipName(blip)
    end


end)
