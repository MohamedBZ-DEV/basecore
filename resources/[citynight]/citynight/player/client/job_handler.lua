
Job = setmetatable({
    isWorking = false
}, Job)
JobBLIP = {}
CurrentZone = nil
inService = false
function Job:Set(_job,grade)
    local m = _job
    _job = Jobs[_job]
    self.name = _job
    self.Job = _job
    self.Job.gradenum = grade
    self.Job.name = m
    self.grade = grade
    self.garage = _job.garage
    for i = 1 , #JobBLIP,1 do
        RemoveBlip(JobBLIP[i])
    end
    TriggerEvent("myJobIs",self.Job.name)
    JobBLIP = {}
    if _job ~= nil then
        self.Job.gradelabel = _job.grade[tonumber(grade)].label
        if _job.grade[tonumber(grade)].show == false then
            TriggerEvent("es:activateJob",_job.label )
        else
            TriggerEvent("es:activateJob",_job.label .. " " .. _job.grade[tonumber(grade)].label)
            
        end
        InitJob(Jobs,"Jobs")
    else
        TriggerEvent("es:activateJob",nil)
    end
end
AddEventHandler("getJob1",function(cb)
    if Job ~= nil and Job.Job ~= nil then
        cb(Job.Job.nale)
    else
        cb(nil)
    end
end)
function InitJob(Jobs,Type)
    Citizen.CreateThread(function()
        for k ,v in pairs(Jobs) do
        
                if isAnyJob(k,Type) then
                    
                    if v.garage ~= nil then
                        local Pos = v.garage.Pos
                        Pos.z = Pos.z + 1.0

                        local garage = Garage.New(v.garage.Name,Pos,v.garage.Properties,v.garage.Blipdata)
                        garage:Setup()
                    end

                    

                    if v.Storage then
                        for c,t in pairs(v.Storage) do
                            local Storage = Storage.New(t.Name.."_storage", t.Limit)
                            Storage:LinkToPos(t.Pos)
                        end
                    end
                    if v.Menu then
                        LoadJobMenu(v.Menu)
                    end
                    if v.CustomMenu then
                        LoadCustomMenu(k)
                    end
                    if v.Extrapos~= nil then
                        for k,v in pairs(v.Extrapos) do
                            for i=1,#v.Pos,1 do
                                Zone:Add(v.Pos[i],v.Enter,v.Exit,k,v.zonesize)

                                local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
                                SetBlipSprite (blip, v.Blips.sprite)
                                SetBlipDisplay(blip, 4)
                                SetBlipScale  (blip, 0.8)
                                SetBlipColour (blip,  v.Blips.color)
                                SetBlipAsShortRange(blip, true)
                                BeginTextCommandSetBlipName("STRING")
                                AddTextComponentString(v.Blips.name)
                                EndTextCommandSetBlipName(blip)
                                v.Pos[i].z = v.Pos[i].z -1.0
                                Marker:Add(v.Pos[i],v.Marker)
                            end
                        end
                    end
                    if v.work ~= nil then
                    for k,v in pairs(v.work) do
                        local Positionn = v.Pos 
                        Positionn.y = Positionn.y - 1
                                    Marker:Add(v.Pos,{
                type = 23,
                scale = {x=1.5,y=1.5,z=0.2},
                color = {r=255,g=255,b=255,a=120},
                Up = false,
                Cam = false,
                Rotate = false,
                visible = true
            })
                        local blip = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)
                        SetBlipSprite (blip, 1)
                        SetBlipDisplay(blip, 4)
                        SetBlipScale  (blip, 0.8)
                        SetBlipColour (blip,  v.blipcolor)
                        SetBlipAsShortRange(blip, true)
                        BeginTextCommandSetBlipName("STRING")
                        AddTextComponentString(v.blipname)
                        EndTextCommandSetBlipName(blip)
                        table.insert( JobBLIP,blip )
                        Zone:Add(v.Pos,function()
                            print(k)
                            Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour interagir")
                            KeySettings:Add("keyboard","E",JobStartAct,k)
                            KeySettings:Add("controller",46,JobStartAct,k)
                            CurrentZone = Type
                        end,function()
                            Hint:RemoveAll()
                            KeySettings:Clear("keyboard","E",k)
                            KeySettings:Clear("controller",46,k)
                            RageUI.Visible(RMenu:Get('jobs',k),false)
                            CurrentZone = nil
                        end,k,v.workSize or 1.5)
                        RMenu.Add('jobs',k, RageUI.CreateMenu(nil, "Tenues disponibles",10,100))
                    end
                end
            end
        end
    end)
end
function Job:Get()
    return self.Job
end
function Job:GetSalary()
    return self.Job.grade[self.grade].salary
end
function Job:GetGrg()
    return self.garage
end
function Job:IsBoss()
    if self.Job.grade[self.grade].name == "boss" then
        return true
    end
end

Orga = setmetatable({
    isWorking = false
}, Orga)
OrgaBlip = {}
function Orga:Set(_job,grade)
    local m = _job
    _job = Jobs[_job]
    if _job ~= nil then
        self.Job = _job
        self.Job.name = m
        self.grade = grade
        for i = 1 , #OrgaBlip,1 do
            RemoveBlip(OrgaBlip[i])
        end
        OrgaBlip = {}
        if _job ~= nil then
            if _job.grade[tonumber(grade)].show == false then
                TriggerEvent("es:activateJob2",_job.label )
            else
                TriggerEvent("es:activateJob2",_job.label .. " " .. _job.grade[tonumber(grade)].label)
            end
            InitJob(Jobs,"Orga")
            
        else
            TriggerEvent("es:activateJob2",nil)
        end
    end
end

function Orga:Get()
    return self.Job
end

function JobStartAct(d)
    -- TODO
    Job.CurrentAction = d
    print(d)
    if d == "vestiaire" then
        Job:OpenClotheRoom(CurrentZone)
    else
        Job:StartRecolte(CurrentZone)
    end

end



function isAnyJob(job,type)
    if type == "Jobs" or type == nil then
        if job == Job.Job.name then
            return true
        else

        end
    else

        if Orga.Job ~= nil and job == Orga.Job.name then
            return true
        else
            return false
        end
    end
end

-- TODO achever systeme de job

RegisterNetEvent('Jobs:SetRank')
AddEventHandler('Jobs:SetRank', function(e)
    Job:Set(Job:Get().name,e)
end)

RegisterNetEvent('Jobs:SetJob2')
AddEventHandler('Jobs:SetJob2', function(job,grade)
    Job:Set(job,grade)
end)

RegisterNetEvent('Jobs:SetOrga2')
AddEventHandler('Jobs:SetOrga2', function(job,grade)
    Orga:Set(job,grade)
end)


function UpdateService()
    TriggerServerEvent("core:SetService",Job:Get().name,inService)
end

function UpdateService()
    TriggerServerEvent("core:SetService",Job:Get().name,inService)
end