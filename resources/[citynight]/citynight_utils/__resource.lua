resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
client_script '3dme_cl.lua'
client_script 'pause.lua'
client_script 'cl_fuel.lua'
client_script 'cl_utils.lua'
client_script 'cl_status.lua'


server_script "sv_fuel.lua"
server_script '@mysql-async/lib/MySQL.lua'
server_script '3dme_sv.lua'