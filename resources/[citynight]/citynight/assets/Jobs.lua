Jobs = {

    -- garage type 2 = tout ceux qui ont le job voient les véhicule que n'importe quel joueur du job met
    -- 1 = self service
    -- 0 = classique
    chomeur = {
        label = "👤 Citoyen",
        grade = {
            {
                label = "",
                salary = 10
            },
        }
    },
    families = {
        label = "🔰 Families",
        grade = {
            {
                label = "",
                salary = 0
            },
        },
        garage = {
            Name = "Garage families",
            Pos =  {x = -228.63,  y = -1697.07,  z =32.88}, 
            Properties = {
                type = 2, 
                Limit = 25,
                vehicles = {},
                spawnpos = {x = -228.63,  y = -1697.07,  z =32.88,h=283.16}, 

            },
            Blipdata = {
                Pos = {x = -228.63,  y = -1697.07,  z =32.88}, 
                Blipcolor  =7,
                Blipname = "Garage families"
            }
        },
        Storage = {
            {
                Pos = {x=-136.89,y=-1608.59,z=34.03},
                Limit = 500,
                Name = "coffre_families"
            },
        },

    },

    biker = {
        label = "🔰 Bikers",
        grade = {
            {
                label = "",
                salary = 0
            },
        },
        garage = {
            Name = "Garage Bikers",
            Pos =  {x = -228.63,  y = -1697.07,  z =32.88}, 
            Properties = {
                type = 2, 
                Limit = 25,
                vehicles = {},
                spawnpos = {x = -228.63,  y = -1697.07,  z =32.88,h=283.16}, 

            },
            Blipdata = {
                Pos = {x = -228.63,  y = -1697.07,  z =32.88}, 
                Blipcolor  =7,
                Blipname = "Garage Bikers"
            }
        },
        Storage = {
            {
                Pos = {x=-136.89,y=-1608.59,z=34.03},
                Limit = 500,
                Name = "coffre_Bikers"
            },
        },

    },
        vagos = {
        label = "🔰 Vagos",
        grade = {
            {
                label = "",
                salary = 0
            },
        },
        garage = {
            Name = "Garage vagos",
            Pos =  {x = 333.93,  y = -2038.31,  z =20.1}, 
            Properties = {
                type = 2, 
                Limit = 25,
                vehicles = {},
                spawnpos = {x = 333.93,  y = -2038.31,  z =20.1,h=58.37}, 

            },
            Blipdata = {
                Pos = {x = 333.93,  y = -2038.31,  z =20.1}, 
                Blipcolor  =7,
                Blipname = "Garage vagos"
            }
        },
        Storage = {
            {
                Pos = {x=330.24,y=-2013.95,z=21.39},
                Limit = 500,
                Name = "coffre_vagos"
            },
        },

    },
    ballas = {
        label = "🔰 Ballas",
        grade = {
            {
                label = "",
                salary = 0
            },
        },
        
        garage = {
            Name = "Garage ballas",
            Pos =  {x = 112.62,  y = -1946.82,  z =19.69}, 
            Properties = {
                type = 2, 
                Limit = 25,
                vehicles = {},
                spawnpos = {x = 112.62,  y = -1946.82,  z =19.6,h=50.64}, 

            },
            Blipdata = {
                Pos = {x = 112.62,  y = -1946.82,  z =19.6}, 
                Blipcolor  =7,
                Blipname = "Garage ballas"
            }
        },
        Storage = {
            {
                Pos = {x=106.39,y=-1981.23,z=19.96},
                Limit = 500,
                Name = "coffre_ballas"
            },
        },
    },
    delperrosquar = {
        label = "🔰 Del Perro Squar",
        grade = {
            {
                label = "",
                salary = 0
            },
        },
        garage = {
            Name = "Garage Del Perro Squar",
            Pos =  {x = -1552.91,  y = -403.31,  z =41.99}, 
            Properties = {
                type = 2, 
                Limit = 25,
                vehicles = {},
                spawnpos = {x = -1552.91,  y = -403.31,  z =41.99,h=229.08}, 

            },
            Blipdata = {
                Pos = {x = -1552.91,  y = -403.31,  z =41.99}, 
                Blipcolor  =7,
                Blipname = "Garage Del Perro Squar"
            }
        },
        Storage = {
            {
                Pos = {x=-1567.57,y=-403.88,z=41.39},
                Limit = 500,
                Name = "coffre_delsperoo"
            },
        },
    },
    oneil = {
        label = "Ferme O'neil",
        label2 = "Ferme o'neil",
        FreeAccess = false,
        grade = {
            {
                label = "Fermier",
                salary = 25,
                name = "worker"
            },
            {
                label = "Gérant",
                salary = 35,
                name = "gerant"
            },
            {
                label = "Patron",
                salary = 50,
                name = "boss"
            }
        },
        garage = {
            Name = "Garage ferme",
            Pos =  {x = 2015.23,  y = 4979.07,  z =41.88},
            Properties = {
                type = 1, 
                Limit = 25,
                vehicles = {},
                spawnpos =  {x = 2015.23,  y = 4979.07,  z =41.88}, 

            },
                vehicles = {
                    {name="benson",label="Voiture de service",job=true,tuning = {
                        modXenon = true
                    }},

                },
            Blipdata = {
                Pos = {x = 2015.23,  y = 4979.07,  z =41.88}, 
                Blipcolor  =7,
                Blipname = "Garage ferme"
            }
        },
        requiredService = false,
        work = {

            recolte = {
                type = "recolte",
                workSize = 10.0,
                Pos = {x=2201.97,y=5179.28,z=58.35},
                giveitem = "blez",
                blipcolor =7,
                blipname = "Récolte du blé",
                add = "~p~+ 1 Blé",
                anim = {
      
                    lib = "anim@mp_snowball",
                    anim = "pickup_snowball"
            
                },
            },
            traitement = {
                type = "traitement",
                workSize = 10.45,
                blipcolor =7,
                blipname = "Traitement du blé",
                Pos =  {x=2309.5,y=4885.85,z=41.81},
                required = "blez",
                giveitem = "farine",
                add = "~p~+ 1  Farine"
            },
            traitement2 = {
                type = "traitement",
                workSize = 10.45,
                blipcolor =7,
                blipname = "Traitement de la farine",
                Pos =  {x=2680.62,y=3508.35,z=53.3},
                required = "farine",
                giveitem = "pain",
                add = "~p~+ 1  Pain"
            },
            vente = {
                type = "vente",
                blipcolor =7,
                workSize = 10.45,
                blipname = "Vente",
                Pos = {x=83.14,y=-1551.22,z=29.6},
                required = "pain",
                price = math.random( 10,11 ),
                add = "~p~- 1 Pain"
            },
        }
    },
    vigneron = {
        label = "🍇 Vigneron",
        label2 = "Vigneron",
        FreeAccess = true,
        grade = {
            {
                label = "CDD",
                salary = 15,
                name = "cdd"
            },
            {
                label = "CDI",
                salary = 25,
                name = "cdi"
            },
            {
                label = "Patron",
                salary = 40,
                name = "boss"
            }
        },
        Menu = {
            menu = {
                title = "Vigneron",
                subtitle = "Actions disponibles",
                name = "vigneron_menuperso"
            },
            buttons = {
                {label="Facturation",onSelected=function() CreateFacture("vigneron") end,ActiveFct=function() HoverPlayer() end},
            },
        },
        garage = {
            Name = "Garage vigneron",
            Pos =  {x = -1887.76,  y = 2045.01,  z =139.86}, 
            Properties = {
                type = 1,
                Limit = 15,
                vehicles = {
                    {name="bison",label="Voiture de service",job=true,tuning = {
                        modXenon = true
                    }},

                },
                spawnpos = {x = -1895.71,  y = 2034.61,  z =141.86,h=339.66}, 

            },
            Blipdata = {
                Pos = {x = -1887.76,  y = 2045.01,  z =139.86}, 
                Blipcolor  =7,
                Blipname = "Garage"
            }
        },
        requiredService = false,
    
        work = {

            recolte = {
                type = "recolte",
                workSize = 10.0,
                Pos = {x=-1812.54,y=2206.83,z=92.37},
                giveitem = "raisin",
                blipcolor =7,
                blipname = "Récolte",
                add = "~p~+ 1 Raisin",
                anim = {
      
                    lib = "anim@mp_snowball",
                    anim = "pickup_snowball"
            
                },
            },
            traitement2 = {
                type = "traitement",
                workSize = 10.45,
                blipcolor =7,
                blipname = "Traitement raisin",
                Pos = {x=-52.83,y=1903.4,z=195.36},
                required = "raisin",
                giveitem = "jus_raisin",
                add = "~p~+ 1  Jus de raisin"
            },
            
            traitement = {
                type = "traitement",
                workSize = 10.45,
                blipcolor =7,
                blipname = "Traitement jus de raisin",
                Pos = {x=-1929.02,y=1779.09,z=173.07},
                required = "jus_raisin",
                giveitem = "bouteille_vin",
                add = "~p~+ 1  Bouteille de vin"
            },
            vente = {
                type = "vente",
                blipcolor =7,
                workSize = 10.45,
                blipname = "Vente",
                Pos = {x=51.59,y=6486.16,z=31.36},
                required = "bouteille_vin",
                price = math.random( 10,11 ),
                add = "~p~- 1 Bouteille de vin"
            },
        }
    },
    raffinerie = {
        label = "Rafinerie",
        label2 = "Rafinerie",
        FreeAccess = false,
        grade = {
            {
                label = "Raffineur",
                salary = 15,
                name = "cdd"
            },
            {
                label = "Responsable de prod",
                salary = 25,
                name = "cdi"
            },
            {
                label = "Patron",
                salary = 40,
                name = "boss"
            }
        },
        Menu = {
            menu = {
                title = "Raffinerie",
                subtitle = "Actions disponibles",
                name = "Raffinerie_menuperso"
            },

            buttons = {
                {label="Facture",onSelected=function() CreateFacture("raffinerie") end,ActiveFct=function() HoverPlayer() end},
            },
        },
        requiredService = false,
    
        work = {

            recolte = {
                type = "recolte",
                workSize = 10.0,
                Pos = {x=1343.01,y=-2113.07,z=54.85},
                giveitem = "petrol",
                blipcolor =7,
                blipname = "Récolte",
                add = "~p~+ 1 Pétrole",
                anim = {
      
                    lib = "anim@mp_snowball",
                    anim = "pickup_snowball"
            
                },
            },
            traitement2 = {
                type = "traitement",
                workSize = 10.45,
                blipcolor =7,
                blipname = "Traitement pétrole",
                Pos = {x=270.72,y=-3056.22,z=5.83},
                required = "petrol",
                giveitem = "petrol_melanged",
                add = "~p~+ 1  Mélange pétrole"
            },
            
            traitement = {
                type = "traitement",
                workSize = 10.45,
                blipcolor =7,
                blipname = "Traitement mélange pétrole",
                Pos = {x=2760.85,y=1486.87,z=30.79},
                required = "petrol_melanged",
                giveitem = "petrol_rafined",
                add = "~p~+ 1  Pétrole raffiné"
            },
            vente = {
                type = "vente",
                blipcolor =7,
                workSize = 10.45,
                blipname = "Vente",
                Pos = {x=51.59,y=6486.16,z=31.36},
                required = "petrol_rafined",
                price = math.random( 10,11 ),
                add = "~p~- 1 Pétrole raffiné"
            },
        }
    },

    police = {  
        label = "👮🏼 LSPD",
        label2 = "LSPD",
        grade = {
            {
                label = "Cadet",
                salary = 15,
                name = "cadet"
            },
            {
                label = "Officier I",
                salary = 20,
                name = "officier"
            },
            
            {
                label = "Officier II",
                salary = 25,
                name = "officier"
            },
            {
                label = "Officier III",
                salary = 30,
                name = "officier"
            },
            {
                label = "Sergent",
                salary = 35,
                name = "sergent"
            },
            {
                label = "Sergent-Chef",
                salary = 40,
                name = "sergent-Chef"
            },
            {
                label = "Lieutenant",
                salary = 45,
                name = "drh"
            },
            {
                label = "Capitaine",
                salary = 50,
                name = "BD"
            },
            {
                label = "Commandant",
                salary = 60,
                name = "boss"
            }
        },
        garage = {
            Name = "Garage police",
            Pos =  {x = 438.53,  y = -1021.1,  z = 27.63, h=87.59},
            Properties = {
                type = 1,
                Limit = 50,
                vehicles = {
                    {name="03expeditionr",label="03expeditionr",job=true,tuning = {
                       modXenon = true
                    }}, 
                    {name="11caprice",label="11caprice",job=true,tuning = {
                       modXenon = true
                    }},
                    {name="14charger",label="14charger",job=true,tuning = {
                       modXenon = true 
                    }},
                    {name="16explorer",label="16explorer",job=true,tuning = {
                       modXenon = true  
                    }},
                    {name="16taurus",label="16taurus",job=true,tuning = {
                       modXenon = true      
                    }},
                    {name="18charger",label="18charger",job=true,tuning = {
                       modXenon = true    
                    }},
                    {name="18tahoe",label="18tahoe",job=true,tuning = {
                       modXenon = true     
                    }},
                    {name="19durango",label="19durango",job=true,tuning = {
                       modXenon = true    
                    }},
                    {name="newvic",label="newvic",job=true,tuning = {
                       modXenon = true 
                    }},     

                },
                spawnpos = {x = 438.53,  y = -1021.1,  z = 27.63, h=87.59},

         },
          Blipdata = {
            Pos = {x = 438.53,  y = -1021.1,  z = 27.63, h=87.59},
            Blipcolor  =7,
            Blipname = "Garage"
          }
       },
        Menu = {
            menu = {
                title = "Police",
                subtitle = "Actions disponibles",
                name = "police_menuperso"
            },
            submenus = {
                ["Actions citoyen"] = {
                    submenu ="police_menuperso",
                    title = "Actions citoyen",
                    menus = {
                        buttons = {
                            {label="Menotter",onSelected=function() Police.HandcuffPly() end,ActiveFct= function() HoverPlayer() end},
                            {label="Démenotter",onSelected=function() Police.CutMenottes() end,ActiveFct= function() HoverPlayer() end},
                            {label="Retrait points permis",onSelected=function() Police.RetraitPermis() end},
                        },
                        submenus = {}
                    }

                },
                ["Actions véhicule"] = {
                    submenu ="police_menuperso",
                    title = "Actions véhicule",
                    menus = {
                        buttons = {
                            {label="Inspecter la plaque",onSelected=function() Police.PlateCheck() end,ActiveFct= function() Mecano.ShowMarker() end},
                            {label="Crocheter",onSelected=function() Police.Crocheter() end,ActiveFct= function() Mecano.ShowMarker() end},
                            {label="Immobiliser",onSelected=function() Police.Immobiliser() end,ActiveFct= function() Mecano.ShowMarker() end},
                            
                        },
                        submenus = {}
                    }

                },
            },
            buttons = {
                {label="Amendes",onSelected=function() CreateFacture("police") end,ActiveFct=function() HoverPlayer() end},
                {label="Appelez des renforts",onSelected=function()             local plyCoords = GetEntityCoords(GetPlayerPed(-1))
            local x,y,z = table.unpack(plyCoords)
            TriggerServerEvent("call:makeCall","police",{x=x,y=y,z=z},"J'ai besoin de renfort!") end,ActiveFct=function() end}
           --     {label="Supprimer herse",onSelected=function() DeleteHerse() end},
            },
        },
        Storage = {
            {
                Pos = {x=452.4,y=-979.52,z=29.69},
                Limit = 9999999,
                Name = "coffre"
            },
        },
        work = {
            vestiaire = {
                type = "Vestiaire",
                workSize = 1.45,
                Pos = {x=450.05,y=-993.16,z=30.69},
                
                Tenues = {
                    ['Tenue de service'] = {
                        male = {
                            ['tshirt_1'] = 39, ['tshirt_2'] = 0,
                            ['torso_1'] = 190, ['torso_2'] = 0,
                            ['decals_1'] = 0, ['decals_2'] = 0,
                            ['arms'] = 0,
                            ['pants_1'] = 35, ['pants_2'] = 0,
                            ['shoes_1'] = 25, ['shoes_2'] = 0,
                            ['helmet_1'] = 0, ['helmet_2'] = 0,
                            ['chain_1'] = 8, ['chain_2'] = 0,
                            ['ears_1'] = -1, ['ears_2'] = 0
                        },
                        female = {
                            ['tshirt_1'] = 27, ['tshirt_2'] = 0,
                            ['torso_1'] = 146, ['torso_2'] = 0,
                            ['decals_1'] = 0, ['decals_2'] = 0,
                            ['arms'] = 31,
                            ['pants_1'] = 34, ['pants_2'] = 0,
                            ['shoes_1'] = 25, ['shoes_2'] = 0,
                            ['helmet_1'] = -1, ['helmet_2'] = 0,
                            ['chain_1'] = 0, ['chain_2'] = 0,
                            ['ears_1'] = 0, ['ears_2'] = 0
                        },
                    },
                    ["Tenue manches longues"] = {
                        male = {
                            ['tshirt_1'] = 39, ['tshirt_2'] = 0,
                            ['torso_1'] = 193, ['torso_2'] = 0,
                            ['decals_1'] = 0, ['decals_2'] = 0,
                            ['arms'] = 1,
                            ['pants_1'] = 35, ['pants_2'] = 0,
                            ['shoes_1'] = 25, ['shoes_2'] = 0,
                            ['helmet_1'] = 0, ['helmet_2'] = 0,
                            ['chain_1'] = 8, ['chain_2'] = 0,
                            ['ears_1'] = -1, ['ears_2'] = 0
                        },
                        female = {
                            ['tshirt_1'] = 0, ['tshirt_2'] = 0,
                            ['torso_1'] = 0, ['torso_2'] = 0,
                            ['decals_1'] = 0, ['decals_2'] = 0,
                            ['arms'] = 0,
                            ['pants_1'] = 0, ['pants_2'] = 0,
                            ['shoes_1'] = 0, ['shoes_2'] = 0,
                            ['helmet_1'] = 0, ['helmet_2'] = 0,
                            ['chain_1'] = 0, ['chain_2'] = 0,
                            ['ears_1'] = 0, ['ears_2'] = 0
                        },
                    },
                    ['Tenue cérémonie'] = {
                        male = {
                            ['tshirt_1'] = 39, ['tshirt_2'] = 0,
                            ['torso_1'] = 200, ['torso_2'] = 0,
                            ['decals_1'] = 0, ['decals_2'] = 0,
                            ['arms'] = 75,
                            ['pants_1'] = 35, ['pants_2'] = 0,
                            ['shoes_1'] = 25, ['shoes_2'] = 0,
                            ['helmet_1'] = 1, ['helmet_2'] = 0,
                            ['chain_1'] = 8, ['chain_2'] = 0,
                            ['ears_1'] = -1, ['ears_2'] = 0
                        },
                        female = {
                            ['tshirt_1'] = 14, ['tshirt_2'] = 1,
                            ['torso_1'] = 225, ['torso_2'] = 0,
                            ['decals_1'] = 0, ['decals_2'] = 0,
                            ['arms'] = 88,
                            ['pants_1'] = 34, ['pants_2'] = 1,
                            ['shoes_1'] = 25, ['shoes_2'] = 0,
                            ['helmet_1'] = 45, ['helmet_2'] = 0,
                            ['chain_1'] = 0, ['chain_2'] = 0,
                            ['ears_1'] = 0, ['ears_2'] = 0
                        },
                    },
                    ['Tenue K9'] = {
                        male = {
                            ['tshirt_1'] = 37, ['tshirt_2'] = 0,
                            ['torso_1'] = 101, ['torso_2'] = 0,
                            ['decals_1'] = 0, ['decals_2'] = 0,
                            ['arms'] = 17,
                            ['pants_1'] = 49, ['pants_2'] = 1,
                            ['shoes_1'] = 38, ['shoes_2'] = 0,
                            ['helmet_1'] = 0, ['helmet_2'] = 0,
                            ['chain_1'] = 1, ['chain_2'] = 0,
                            ['ears_1'] = 0, ['ears_2'] = 0
                        },
                        female = {
                            ['tshirt_1'] = 27, ['tshirt_2'] = 0,
                            ['torso_1'] = 93, ['torso_2'] = 0,
                            ['decals_1'] = 0, ['decals_2'] = 0,
                            ['arms'] = 31,
                            ['pants_1'] = 54, ['pants_2'] = 1,
                            ['shoes_1'] = 25, ['shoes_2'] = 0,
                            ['helmet_1'] = -1, ['helmet_2'] = 0,
                            ['chain_1'] = 0, ['chain_2'] = 0,
                            ['ears_1'] = 0, ['ears_2'] = 0
                        },
                    },
                    ['Tenue enquêteur'] = {
                        male = {
                            ['tshirt_1'] = 0, ['tshirt_2'] = 2,
                            ['torso_1'] = 35, ['torso_2'] = 1,
                            ['decals_1'] = 0, ['decals_2'] = 0,
                            ['arms'] = 17,
                            ['pants_1'] = 49, ['pants_2'] = 1,
                            ['shoes_1'] = 25, ['shoes_2'] = 0,
                            ['helmet_1'] = 0, ['helmet_2'] = 0,
                            ['chain_1'] = 0, ['chain_2'] = 0,
                            ['ears_1'] = 0, ['ears_2'] = 0
                        },
                        female = {
                            ['tshirt_1'] = 51, ['tshirt_2'] = 1,
                            ['torso_1'] = 168, ['torso_2'] = 1,
                            ['decals_1'] = 0, ['decals_2'] = 0,
                            ['arms'] = 23,
                            ['pants_1'] = 51, ['pants_2'] = 1,
                            ['shoes_1'] = 25, ['shoes_2'] = 0,
                            ['helmet_1'] = 0, ['helmet_2'] = 0,
                            ['chain_1'] = 0, ['chain_2'] = 0,
                            ['ears_1'] = 0, ['ears_2'] = 0
                        },
                    },
                    ["Tenue d'intervention"] = {
                        male = {
                            ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                            ['torso_1'] = 49, ['torso_2'] = 0,
                            ['decals_1'] = 0, ['decals_2'] = 0,
                            ['arms'] = 17,
                            ['pants_1'] = 31, ['pants_2'] = 0,
                            ['shoes_1'] = 25, ['shoes_2'] = 0,
                            ['helmet_1'] = 75, ['helmet_2'] = 0,
                            ['chain_1'] = 0, ['chain_2'] = 0,
                            ['ears_1'] = 0, ['ears_2'] = 0
                        },
                        female = {
                            ['tshirt_1'] = 14, ['tshirt_2'] = 1,
                            ['torso_1'] = 42, ['torso_2'] = 0,
                            ['decals_1'] = 0, ['decals_2'] = 0,
                            ['arms'] = 18,
                            ['pants_1'] = 30, ['pants_2'] = 1,
                            ['shoes_1'] = 25, ['shoes_2'] = 0,
                            ['helmet_1'] = 0, ['helmet_2'] = 0,
                            ['chain_1'] = 0, ['chain_2'] = 0,
                            ['ears_1'] = 0, ['ears_2'] = 0
                        },
                    },
            
                }
            },
        },
    },

    banker = {
        label = "💰  Banquier",
        grade = {
            {
                label = "Employé",
                salary = 30,
                name = "employe",
                show = true
            },
            {
                label = "Trésorier",
                salary = 35,
                name = "tresorier",
                show = true
            },
            {
                label = "DRH",
                salary = 40,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 60,
                name = "pdg",
                show = true                
            }
        },
        Menu = {
            menu = {
                title = "Banquier",
                subtitle = "Actions disponibles",
                name = "Banquier_menuperso"
            },

            buttons = {
                {label="Facture",onSelected=function() CreateFacture("banker") end,ActiveFct=function() HoverPlayer() end},
            },
        },
        Extrapos = {
            Banker = { -- fourrière
                Pos = {
                    {x=249.93,y=230.25,z=106.29}
                },
                Enter = function()
                    EnterBankZone()  
                end,
                Exit = function()
                    ExitBankZone()  
                end,
                zonesize = 1.5,
                Blips = {
                    sprite = 500,
                    color = 69,
                    name = "Gestion comptes",
                },
                Marker = {
                    type = 1,
                    scale = {x=1.5,y=1.5,z=0.2},
                    color = {r=255,g=255,b=255,a=120},
                    Up = false,
                    Cam = false,
                    Rotate = false,
                    visible = true
                }
            },
        },
    },
    gouv = {
        label = "Gouvernement",
        label2 = "Gouvernement",
        grade = {
            {
                label = "Assistant",
                salary = 40,
                name = "Assistant",
                show = true
            },
            {
                label = "Secrétaire",
                salary = 60,
                name = "secretaire",
                show = true
            },
            {
                label = "Président",
                salary = 80,
                name = "boss",
                show = true
            },
        },
        CustomMenu = true,
        Storage = {
            {
                Pos = {x=-43.38,y=-1748.37,z=29.42},
                Limit = 500,
                Name = "coffre"
            },
        },

        garage = {
            Name = "Garage gouvernement",
            Pos =  {}, 
            Properties = {
                type = 1,-- = garage self service 
                Limit = 50,
                vehicles = {
                    {name="bison",label="Voiture de service",job=true,tuning = {
                        modXenon = true
                    }},     
                },
                spawnpos = {}, 

            },
            Blipdata = {
                Pos = {}, 
                Blipcolor  =7,
                Blipname = "Garage"
            }
        },
    },



    darnell = {     
        label = "💼 Ponsonby's",
        grade = {
            {
                label = "Employé",
                salary = 30,
                name = "employe",
                show = true                
            },
            {
                label = "Trésorier",
                salary = 40,
                name = "tresorier",
                show = true                
            },
            {
                label = "DRH",
                salary = 50,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 70,
                name = "pdg",
                show = true            
            }
        },
        extraPos = { 
            Manequin = {
                Pos = {
                    {x=-168.4,y=-298.3,z=39.79},
                },
            }
        }
    },

    lsms = {    
        label = "💉 LSMS",
        grade = {
            {
                label = "Infirmier",
                salary = 30,
                name = "infirmier",
                show = true            
            },
            {
                label = "Médecin",
                salary = 40,
                name = "medecin",
                show = true
            },
            {
                label = "Médecin-chef",
                salary = 50,
                name = "medecinchef",
                show = true
            }, 

            {
                label = "Directeur adjoint",
                salary = 60,
                name = "drh",
                show = true                
            },
            {
                label = "Directeur",
                salary = 70,
                name = "boss",
                show = true               
            },
        },
        garage = {
            Name = "Garage ambulance",
            Pos =  {x=363.37,y=-589.8,z=27.79}, 
            Properties = {
                type = 1,-- = garage self service 
                Limit = 50,
                vehicles = {
                    {name="ambulance",label="Voiture de service",job=true,tuning = {
                        modXenon = true
                    }},     
                },
                spawnpos =  {x=363.37,y=-589.8,z=27.79}, 

            },
            Blipdata = {
                Pos =  {x=363.37,y=-589.8,z=27.79}, 
                Blipcolor  =7,
                Blipname = "Garage LSMS"
            }
        },
        Storage = {
            {
                Pos = {x=335.77,y=-584.8,z=27.79},
                Limit = 500,
                Name = "coffre_lsms"
            },
        },
        Menu = {
            menu = {
                title = "Ambulance",
                subtitle = "Actions disponibles",
                name = "ambulance_menuperso"
            },
            buttons = {
                {label="Facturation",onSelected=function() CreateFacture("lsms") end,ActiveFct=function() HoverPlayer() end},
                {label="Réanimation",onSelected=function() Ambulance.Revive() end,ActiveFct=function() HoverPlayer() end},
                {label="Soin",onSelected=function() Ambulance.Heal() end,ActiveFct=function() HoverPlayer() end},

            },
        },

        work = {
            vestiaire = {
                type = "Vestiaire",
                workSize = 1.45,
                Pos = {x=335.81,y=-579.67,z=28.79},
                Tenues = {
                    ['Tenue de services'] = {
                        male = {
                            ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                            ['torso_1'] = 250, ['torso_2'] = 0,
                            ['decals_1'] = 58, ['decals_2'] = 0,
                            ['arms'] = 85,
                            ['pants_1'] = 96, ['pants_2'] = 0,
                            ['shoes_1'] = 69, ['shoes_2'] = 0,
                            ['helmet_1'] = 0, ['helmet_2'] = 0,
                            ['chain_1'] = 126, ['chain_2'] = 0,
                            ['ears_1'] = 0, ['ears_2'] = 0
                        },
                        female = {
                            ['tshirt_1'] = 58, ['tshirt_2'] = 0,
                            ['torso_1'] = 258, ['torso_2'] = 0,
                            ['decals_1'] = 66, ['decals_2'] = 0,
                            ['arms'] = 109,
                            ['pants_1'] = 99, ['pants_2'] = 0,
                            ['shoes_1'] = 72, ['shoes_2'] = 0,
                            ['helmet_1'] = 0, ['helmet_2'] = 0,
                            ['chain_1'] = 96, ['chain_2'] = 0,
                            ['ears_1'] = 0, ['ears_2'] = 0,
                        }
                    }
                }
            },
        },
    },

    mecano = {     
        label = "🔧 Mécano",
        grade = {
            {
                label = "Employé",
                salary = 20,
                name = "employe",
                show = true               
            },
            {
                label = "Trésorier",
                salary = 25,
                name = "tresorier",
                show = true              
            },
            {
                label = "DRH",
                salary = 35,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 50,
                name = "boss",
                show = true           
            }
        },
        Menu = {
            menu = {
                title = "Mécano",
                subtitle = "Actions disponibles",
                name = "mecano_menuperso"
            },
            submenus = {
                ["Actions véhicule"] = {
                    submenu ="mecano_menuperso",
                    title = "Actions véhicule",
                    menus = {
                        buttons = {
                            {label="Inspecter l'état du véhicule",onSelected=function() Mecano.CheckVehicle() end,ActiveFct= function() Mecano.ShowMarker() end},
                            {label="Ouvrir le capot",onSelected=function() Mecano.OpenTrunk() end,ActiveFct= function() Mecano.ShowMarker() end},
                            {label="Réparer le véhicule",onSelected=function() Mecano.Repair() end,ActiveFct= function() Mecano.ShowMarker() end},
                            {label="Nettoyer le véhicule",onSelected=function() Mecano.CleanVehicule() end,ActiveFct= function() Mecano.ShowMarker() end},
                            {label="Fourière",onSelected=function() Mecano.Fouriere() end,ActiveFct= function() Mecano.ShowMarker() end},

                        },
                        submenus = {}
                    }

                },

            },
            buttons = {
                {label="Facturation",onSelected=function() CreateFacture("mecano") end,ActiveFct=function() HoverPlayer() end},
            },
        },
        Extrapos = {
            Tow = { -- fourrière
                Pos = {
                    {x=-41.63,y=-1683.18,z=29.43}
                },
                Enter = EnterZoneTow,
                Exit = ExitZoneTow,
                zonesize = 1.5,
                Blips = {
                    sprite = 473,
                    color = 81,
                    name = "Fourrière",
                },
                Marker = {
                    type = 1,
                    scale = {x=1.5,y=1.5,z=0.2},
                    color = {r=255,g=255,b=255,a=120},
                    Up = false,
                    Cam = false,
                    Rotate = false,
                    visible = true
                }
            },
            LsCustom = {
                Pos = {
                    {x=-211.63,y=-1323.18,z=30.89}
                },
                Enter = function()
                    EnterZoneLSC()
                end,
                Exit = function()
                    ExitZoneLSC()
                end,
                zonesize = 5.5,
                Blips = {
                    sprite = 72,
                    color = 81,
                    name = "LSCustoms",
                },
                Marker = {
                    type = 25,
                    scale = {x=5.5,y=5.5,z=0.2},
                    color = {r=255,g=255,b=255,a=120},
                    Up = false,
                    Cam = false,
                    Rotate = false,
                    visible = true
                }
            }
        },
        stockages = {
            coffremechanics1 = { -- fourrière
                Pos = {
                    {x=-46.52,y=-1682.81,z=29.43}
                },
                zonesize = 1.5,
                maxWeight = 15,
                Marker = {
                    type = 1,
                    scale = {x=1.5,y=1.5,z=0.2},
                    color = {r=255,g=255,b=255,a=120},
                    Up = false,
                    Cam = false,
                    Rotate = false,
                    visible = true
                }
            }
        },
        Storage = {
            {
                Pos = {x=-227.91,y=-1327.8,z=29.89},
                Limit = 500,
                Name = "coffre_mécano"
            }
        },
        work = {
            vestiaire = {
                type = "Vestiaire",
                workSize = 1.45,
                Pos = {x=958.76,y=-3005.28,z=-39.64},
                Tenues = {
                    ['Tenue de services'] = {
                        male = {
                            ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                            ['torso_1'] = 65, ['torso_2'] = 0,
                            ['decals_1'] = 0, ['decals_2'] = 0,
                            ['arms'] = 17,
                            ['pants_1'] = 38, ['pants_2'] = 0,
                            ['shoes_1'] = 25, ['shoes_2'] = 0,
                            ['helmet_1'] = 0, ['helmet_2'] = 0,
                            ['chain_1'] = 0, ['chain_2'] = 0,
                            ['ears_1'] = 0, ['ears_2'] = 0
                        },
                        female = {
                            ['tshirt_1'] = 14, ['tshirt_2'] = 0,
                            ['torso_1'] = 59, ['torso_2'] = 0,
                            ['decals_1'] = 0, ['decals_2'] = 0,
                            ['arms'] = 18,
                            ['pants_1'] = 38, ['pants_2'] = 0,
                            ['shoes_1'] = 25, ['shoes_2'] = 0,
                            ['helmet_1'] = 0, ['helmet_2'] = 0,
                            ['chain_1'] = 0, ['chain_2'] = 0,
                            ['ears_1'] = 0, ['ears_2'] = 0
                        }
                    }
                }
            },
        },
    },
    ltd = {     
        label = "🍕 Épicier",
        grade = {
            {
                label = "Employé",
                salary = 25,
                name = "employe",
                show = true                
            },
            {
                label = "Trésorier",
                salary = 35,
                name = "tresorier",
                show = true                
            },
            {
                label = "DRH",
                salary = 40,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 50,
                name = "boss",
                show = true            
            }
        },
        garage = {
            Name = "Garage épicier",
            Pos =  {x = -40.92,  y = -1747.97,  z =29.33}, 
            Properties = {
                type = 1,-- = garage self service 
                Limit = 50,
                vehicles = {
                    {name="bison",label="Voiture de service",job=true,tuning = {
                        modXenon = true
                    }},     
                },
                spawnpos = {x = -38.99,  y = -1745.07,  z =29.33,h=224.97}, 

            },
            Blipdata = {
                Pos = {x = -40.92,  y = -1747.97,  z =29.33}, 
                Blipcolor  =7,
                Blipname = "Garage"
            }
        },
        Menu = {
            menu = {
                title = "LTD",
                subtitle = "Actions disponibles",
                name = "LTD_menuperso"
            },

            buttons = {
                {label="Facture",onSelected=function() CreateFacture("ltd") end,ActiveFct=function() HoverPlayer() end},
            },
        },
        Storage = {
            {
                Pos = {x=-43.38,y=-1748.37,z=29.42},
                Limit = 500,
                Name = "coffre"
            },
        },
        work = {

            traitement = {
                type = "traitement",
                workSize = 10.45,
                blipcolor =51,
                blipname = "Déballage batteries",
                Pos = {x=2919.98,y=4298.13,z=50.91},
                required = "batterypack",
                giveitem = "battery",
                add = "~b~+ 1  Batterie"
            },
            traitement2 = {
                type = "traitement",
                workSize = 10.45,
                blipcolor =51,
                blipname = "Déballage téléphones",
                Pos = {x=2919.98,y=4298.13,z=50.91},
                required = "telpack",
                giveitem = "tel",
                add = "~o~+ 1  Téléphone"
            },
        }
    },

    import = {     
        label = "🚛 Import Export",
        grade = {
            {
                label = "Employé",
                salary = 25,
                name = "employe",
                show = true                
            },
            {
                label = "Trésorier",
                salary = 30,
                name = "tresorier",
                show = true                
            },
            {
                label = "DRH",
                salary = 35,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 50,
                name = "pdg",
                show = true            
            }
        },
    },

    concess = {     
        label = "🚗 Concessionnaire",
        grade = {
            {
                label = "Employé",
                salary = 35,
                name = "employe",
                show = true                
            }
        },
        Menu = {
            menu = {
                title = "Concessionnaire",
                subtitle = "Actions disponibles",
                name = "Concessionnaire_menuperso"
            },

            buttons = {
                {label="Facture",onSelected=function() CreateFacture("concess") end,ActiveFct=function() HoverPlayer() end},
            },
        },
    },

    immo = {     
        label = "🏡 Agent Immobilier",
        grade = {
            {
                label = "Employé",
                salary = 35,
                name = "employe",
                show = true                
            }
        },
    },

    unicorn = {     
        label = "🍹 Unicorn",
        grade = {
            {
                label = "Employé",
                salary = 35,
                name = "employe",
                show = false              
            }
        },
    },

    fib = {     
        label = "🕵️ Agent Fédéral",
        grade = {
            {
                label = "Employé",
                salary = 45,
                name = "employe",
                show = false                
            }
        },
    },

    Taxi = {     
        label = "Taxi",
        label2 = "Taxi",
        grade = {
            {
                label = "Chaffeur",
                salary = 30,
                name = "employe",
                show = true              
            },
            {
                label = "Manager",
                salary = 40,
                name = "employe2",
                show = true              
            },
            {
                label = "Patron",
                salary = 50,
                name = "boss",
                show = true                
            },
        },
        Menu = {
            menu = {
                title = "Taxi",
                subtitle = "Actions disponibles",
                name = "taxi_menuperso"
            },

            buttons = {
                {label="Facture",onSelected=function() CreateFacture("taxi") end,ActiveFct=function() HoverPlayer() end},
            },
        },
    },

    bcso = {     
        label = "🚔 BCSO",
        grade = {
            {
                label = "Aspirant",
                salary = 35,
                name = "aspi",
            },
            {
                label = "Deputy",
                salary = 45,
                name = "deputy",
            },
            {
                label = "Deputy-Chef",
                salary = 50,
                name = "deputychef",
            },
            {
                label = "Chef De Division",
                salary = 55,
                name = "chefdivi",
            },
            {
                label = "Sherif Adjoint",
                salary = 60,
                name = "drh",
            },
            {
                label = "Sherif",
                salary = 70,
                name = "pdg",
            }
        },
    },
}
