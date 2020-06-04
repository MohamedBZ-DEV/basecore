PublicFarm = {
    Weed = {
        recolte = {
            type = "recolte",
            workSize = 10.0,
            Pos = {x=-2089.92,y=2494.25,z=3.09},
            giveitem = "weed_tete",
            blip = "none",
            add = "~p~+ 1 Tete de Cannabis",
            anim = {
  
                lib = "anim@mp_snowball",
                anim = "pickup_snowball"
        
            },
        },
        sechage = {
            type = "sechage",
            workSize = 4.45,
            blip = "none",
            Pos =  {x=-54.92,y=2874.65,z=55.73},
            required = "weed_tete",
            giveitem = "weed_secher",
            add = "~p~+ 1  Secher De Cannabis"
        },
        traitement = {
            type = "traitement",
            workSize = 4.45,
            blip = "none",
            Pos =  {x=-41.16,y=2873.85,z=59.59},
            required = "weed_secher",
            giveitem = "weed_pooch",
            add = "~p~+ 1  Pochon De Cannabis"
        },
    },
    Coke = {
        recolte = {
            type = "recolte",
            workSize = 5.0,
            Pos = {x=725.3,y=2296.44,z=50.46},
            giveitem = "coke",
            blip = "none",
            add = "~p~+ 1 Cocaine",
            anim = {
  
                lib = "anim@mp_snowball",
                anim = "pickup_snowball"
        
            },
        },
        traitement = {
            type = "traitement",
            workSize = 10.45,
            blip = "none",
            Pos =  {x=922.96,y=-1731.05,z=32.16},
            required = "coke",
            giveitem = "coke1",
            add = "~p~+ 1  Pochon de cocaine"
        },
    },
}