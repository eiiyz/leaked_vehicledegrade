--[[
_________ _______________  ___ ________                       
\_   ___ \\_   _____/\   \/  / \______ \   _______  __________
/    \  \/ |    __)   \     /   |    |  \_/ __ \  \/ /\___   /
\     \____|     \    /     \   |    `   \  ___/\   /  /    / 
 \______  /\___  /   /___/\  \ /_______  /\___  >\_/  /_____ \
        \/     \/          \_/         \/     \/            \/
    Discord: Aizen#9186
    CFX Devz: https://discord.gg/dMMmr82S23
    KK: https://discord.gg/MT2996y
    Antichix: https://discord.gg/NmFcvCs
]]

ESX=nil;Citizen.CreateThread(function()while ESX==nil do TriggerEvent('esx:getSharedObject',function(a)ESX=a end)Citizen.Wait(0)end;while ESX.GetPlayerData().job==nil do Citizen.Wait(10)end;ESX.PlayerData=ESX.GetPlayerData()end)RegisterNetEvent('esx:setJob')AddEventHandler('esx:setJob',function(b)ESX.PlayerData.job=b end)VehicleStatus={}DecorRegister("PlayerVehicle",2)RegisterNetEvent('cfx_vehicletuning:client:setOwnedVehicle')AddEventHandler('cfx_vehicletuning:client:setOwnedVehicle',function(c)DecorSetBool(c,"PlayerVehicle",true)end)function checkOwnedVehicle(c)return DecorExistOn(c,"PlayerVehicle")end;local d=0;local e=0;local f=false;Citizen.CreateThread(function()while true do Citizen.Wait(1000)if IsPedInAnyVehicle(GetPlayerPed(-1),false)then local c=GetVehiclePedIsIn(GetPlayerPed(-1),false)if checkOwnedVehicle(c)then if not IsThisModelABicycle(GetEntityModel(c))and GetPedInVehicleSeat(c,-1)==GetPlayerPed(-1)then local g=GetVehicleEngineHealth(c)local h=GetVehicleBodyHealth(c)local i=GetVehicleNumberPlateText(c)if VehicleStatus[i]==nil then TriggerServerEvent("cfx_vehicletuning:server:setupVehicleStatus",i,g,h)else TriggerServerEvent("cfx_vehicletuning:server:updatePart",i,"engine",g)TriggerServerEvent("cfx_vehicletuning:server:updatePart",i,"body",h)if GetVehicleEngineHealth(currentVehicle)<=200.0 then f=true;print("^2ALREADY BROKEN^0")end;d=d+1;e=e+1;if d>=math.random(10,15)then ApplyEffects(c)d=0 end;if e>=65 then RandomEffects(c)e=0 end;if GetVehicleEngineHealth(c)<=200.0 and not f then f=true;BrokenEffects(c)print("^2JUST GOT BROKEN^0")end end else d=0;e=0;Citizen.Wait(1000)end end else d=0;e=0;Citizen.Wait(2000)end end end)RegisterNetEvent('cfx_vehicletuning:client:setVehicleStatus')AddEventHandler('cfx_vehicletuning:client:setVehicleStatus',function(i,j)VehicleStatus[i]=j end)RegisterNetEvent('cfx_vehicletuning:client:getVehicleStatus')AddEventHandler('cfx_vehicletuning:client:getVehicleStatus',function(i,j)if not IsPedInAnyVehicle(GetPlayerPed(-1),false)then local c=GetVehiclePedIsIn(GetPlayerPed(-1),true)if c~=nil and c~=0 then local k=GetEntityCoords(c)local l=GetEntityCoords(GetPlayerPed(-1))if GetDistanceBetweenCoords(l.x,l.y,l.z,k.x,k.y,k.z,true)<5.0 then if not IsThisModelABicycle(GetEntityModel(c))then local i=GetVehicleNumberPlateText(c)if VehicleStatus[i]~=nil then local m=PlayerPedId()RequestAnimDict("mp_car_bomb")TaskPlayAnim(m,"mp_car_bomb","car_bomb_mechanic",8.0,-8,-1,49,0,0,0,0)Wait(100)TaskPlayAnim(m,"mp_car_bomb","car_bomb_mechanic",8.0,-8,-1,49,0,0,0,0)Wait(3000)ClearPedTasks(m)SendStatusMessage(VehicleStatus[i])else exports['mythic_notify']:DoLongHudText('error','Status unknown..')end else exports['mythic_notify']:DoLongHudText('error','Not a valid vehicle..')end else exports['mythic_notify']:DoLongHudText('error','You are not close enough to the vehicle.')end else exports['mythic_notify']:DoLongHudText('error','You must be in the vehicle first.')end else exports['mythic_notify']:DoLongHudText('error','You must be outside the vehicle.')end end)RegisterNetEvent('cfx_vehicletuning:client:setPartLevel')AddEventHandler('cfx_vehicletuning:client:setPartLevel',function(n,o)if IsPedInAnyVehicle(GetPlayerPed(-1),false)then local c=GetVehiclePedIsIn(GetPlayerPed(-1),false)if not IsThisModelABicycle(GetEntityModel(c))and GetPedInVehicleSeat(c,-1)==GetPlayerPed(-1)then local i=GetVehicleNumberPlateText(c)if n=="engine"then SetVehicleEngineHealth(c,o)TriggerServerEvent("cfx_vehicletuning:server:updatePart",i,"engine",GetVehicleEngineHealth(c))elseif n=="body"then SetVehicleBodyHealth(c,o)TriggerServerEvent("cfx_vehicletuning:server:updatePart",i,"body",GetVehicleBodyHealth(c))else TriggerServerEvent("cfx_vehicletuning:server:updatePart",i,n,o)end else exports['mythic_notify']:DoLongHudText('error','You are not a driver or on a bicycle.')end else exports['mythic_notify']:DoLongHudText('error','You are not in a vehicle.')end end)function ApplyEffects(p)local i=GetVehicleNumberPlateText(p)print('^5VEHICEL STATUS EFFECTS KICKED IN^0')if checkOwnedVehicle(p)then if GetVehicleClass(p)~=13 and GetVehicleClass(p)~=21 and GetVehicleClass(p)~=16 and GetVehicleClass(p)~=15 and GetVehicleClass(p)~=14 then if VehicleStatus[i]~=nil then local q=math.random(1,100)print('APPLY EFFECTS STATUS\nRad :'..VehicleStatus[i]["radiator"]..'\nAxle :'..VehicleStatus[i]["axle"]..'\nBrakes :'..VehicleStatus[i]["brakes"]..'\nClutch :'..VehicleStatus[i]["clutch"]..'\nFuel :'..VehicleStatus[i]["fuel"])if VehicleStatus[i]["radiator"]<=35 then local g=GetVehicleEngineHealth(p)if VehicleStatus[i]["radiator"]>=20 and VehicleStatus[i]["radiator"]<=35 then if g>=900 and g<=1000 then SetVehicleEngineHealth(p,g-math.random(5,10))end;print('Radiator Damage effect applied | EngineHealth:'..g)elseif VehicleStatus[i]["radiator"]>=10 and VehicleStatus[i]["radiator"]<=19 then if g>=800 and g<=1000 then SetVehicleEngineHealth(p,g-math.random(15,20))end;print('Radiator Damage effect applied | EngineHealth:'..g)elseif VehicleStatus[i]["radiator"]>=0 and VehicleStatus[i]["radiator"]<=9 then if g>=365 and g<=1000 then SetVehicleEngineHealth(p,g-math.random(20,30))end;print('Radiator Damage effect applied | EngineHealth:'..g)end;if q>=98 then SetVehicleEngineHealth(p,g-math.random(40,50))print('Radiator Damage effect applied | EngineHealth:'..g)end else print('^5Radiator Damage effect not applied^0 | ^2RAD STATUS < 35^0')end;if VehicleStatus[i]["axle"]<=45 then local q=math.random(1,100)if VehicleStatus[i]["axle"]>=25 and VehicleStatus[i]["axle"]<=45 and q>90 then for r=0,360 do SetVehicleSteeringScale(p,r)Citizen.Wait(5)end;print('Axle Damage effect applied')elseif VehicleStatus[i]["axle"]>=11 and VehicleStatus[i]["axle"]<=24 and q>70 then for r=0,360 do SetVehicleSteeringScale(p,r)Citizen.Wait(10)end;print('Axle Damage effect applied')elseif VehicleStatus[i]["axle"]>=0 and VehicleStatus[i]["axle"]<=10 and q>50 then for r=0,360 do SetVehicleSteeringScale(p,r)Citizen.Wait(15)end;print('Axle Damage effect applied')end;if q>=98 then for r=0,360 do Citizen.Wait(25)SetVehicleSteeringScale(p,r)end;print('Axle Damage effect applied')end else print('^5Axle Damage effect not applied^0 | ^2AX STATUS < 45^0')end;if VehicleStatus[i]["brakes"]<=45 then local q=math.random(1,100)if VehicleStatus[i]["brakes"]>=25 and VehicleStatus[i]["brakes"]<=45 and q>90 then SetVehicleHandbrake(p,true)Citizen.Wait(1000)SetVehicleHandbrake(p,false)print('Brakes Damage effect applied')elseif VehicleStatus[i]["brakes"]>=11 and VehicleStatus[i]["brakes"]<=24 and q>70 then SetVehicleHandbrake(p,true)Citizen.Wait(3000)SetVehicleHandbrake(p,false)print('Brakes Damage effect applied')elseif VehicleStatus[i]["brakes"]>=0 and VehicleStatus[i]["brakes"]<=10 and q>50 then SetVehicleHandbrake(p,true)Citizen.Wait(5000)SetVehicleHandbrake(p,false)print('Brakes Damage effect applied')end else print('^5Brakes Damage effect not applied^0 | ^2BR STATUS < 45^0')end;if VehicleStatus[i]["clutch"]<=45 then local q=math.random(1,100)if VehicleStatus[i]["clutch"]>=25 and VehicleStatus[i]["clutch"]<=45 and q>90 then SetVehicleHandbrake(p,true)for r=1,360 do SetVehicleSteeringScale(p,r)Citizen.Wait(5)end;Citizen.Wait(2000)SetVehicleHandbrake(p,false)print('Clutch Damage effect applied')elseif VehicleStatus[i]["clutch"]>=11 and VehicleStatus[i]["clutch"]<=24 and q>70 then SetVehicleHandbrake(p,true)for r=1,360 do SetVehicleSteeringScale(p,r)Citizen.Wait(5)end;Citizen.Wait(5000)SetVehicleHandbrake(p,false)print('Clutch Damage effect applied')elseif VehicleStatus[i]["clutch"]>=0 and VehicleStatus[i]["clutch"]<=10 and q>50 then SetVehicleHandbrake(p,true)for r=1,360 do SetVehicleSteeringScale(p,r)Citizen.Wait(5)end;Citizen.Wait(7000)SetVehicleHandbrake(p,false)print('Clutch Damage effect applied')end else print('^5Clutch Damage effect not applied^0 | ^2CL STATUS < 45^0')end;if VehicleStatus[i]["fuel"]<=80 and(q>=81 and q<=100)then local s=exports['LegacyFuel']:GetFuel(p)if VehicleStatus[i]["fuel"]<=80 and VehicleStatus[i]["fuel"]>=60 then exports['LegacyFuel']:SetFuel(p,s-2.0)print('Fuel Damage effect applied')elseif VehicleStatus[i]["fuel"]<=59 and VehicleStatus[i]["fuel"]>=40 then exports['LegacyFuel']:SetFuel(p,s-4.0)print('Fuel Damage effect applied')elseif VehicleStatus[i]["fuel"]<=39 and VehicleStatus[i]["fuel"]>=20 then exports['LegacyFuel']:SetFuel(p,s-6.0)print('Fuel Damage effect applied')elseif VehicleStatus[i]["fuel"]<=19 and VehicleStatus[i]["fuel"]>=6 then exports['LegacyFuel']:SetFuel(p,s-8.0)print('Fuel Damage effect applied')else exports['LegacyFuel']:SetFuel(p,s-10.0)print('Fuel Damage effect applied')end else print('^5Fuel Damage effect not applied^0 | ^2FL STATUS < 80^0 | ^2 CHANCE :'..q..' ^0')end;TriggerServerEvent("cfx_vehicletuning:server:saveStatus",i)end end else print('^1EFFECTS NOT APPLIED VEHICLE NOT OWNED^0')end end;function RandomEffects(p)local i=GetVehicleNumberPlateText(p)print('^5VEHICEL STATUS RANDOM EFFECTS KICKED IN^0')if checkOwnedVehicle(p)then if GetVehicleClass(p)~=13 and GetVehicleClass(p)~=21 and GetVehicleClass(p)~=16 and GetVehicleClass(p)~=15 and GetVehicleClass(p)~=14 then if VehicleStatus[i]~=nil then local t=VehicleStatus[i]["radiator"]local u=VehicleStatus[i]["axle"]local v=VehicleStatus[i]["brakes"]local w=VehicleStatus[i]["clutch"]local x=VehicleStatus[i]["fuel"]for r=1,5 do local q=math.random(1,100)if q>=0 and q<=10 then x=x-math.random(0,1)TriggerServerEvent('cfx_vehicletuning:server:SetPartLevel',i,"fuel",x)print('Random Effect Applied | NEW VALUE FL:'..x)elseif q>=11 and q<=20 then t=t-math.random(0,1)TriggerServerEvent('cfx_vehicletuning:server:SetPartLevel',i,"radiator",t)print('Random Effect Applied | NEW VALUE RD:'..t)elseif q>=21 and q<=30 then w=w-math.random(0,1)TriggerServerEvent('cfx_vehicletuning:server:SetPartLevel',i,"clutch",w)print('Random Effect Applied | NEW VALUE CL:'..w)elseif q>=41 and q<=50 then v=v-math.random(0,1)TriggerServerEvent('cfx_vehicletuning:server:SetPartLevel',i,"brakes",v)print('Random Effect Applied | NEW VALUE BR:'..v)elseif q>=51 and q<=60 then u=u-math.random(0,1)TriggerServerEvent('cfx_vehicletuning:server:SetPartLevel',i,"axle",u)print('Random Effect Applied | NEW VALUE AX:'..u)end end;if x<0 then x=0;TriggerServerEvent('cfx_vehicletuning:server:SetPartLevel',i,"fuel",x)end;if t<0 then t=0;TriggerServerEvent('cfx_vehicletuning:server:SetPartLevel',i,"radiator",t)end;if w<0 then w=0;TriggerServerEvent('cfx_vehicletuning:server:SetPartLevel',i,"clutch",w)end;if v<0 then v=0;TriggerServerEvent('cfx_vehicletuning:server:SetPartLevel',i,"brakes",v)end;if u<0 then u=0;TriggerServerEvent('cfx_vehicletuning:server:SetPartLevel',i,"axle",u)end;print('^5RANDOM EFFECTS APPLIED VEHICLE OWNED^0')TriggerServerEvent("cfx_vehicletuning:server:saveStatus",i)end end else print('^1RANDOM EFFECTS NOT APPLIED VEHICLE NOT OWNED^0')end end;function BrokenEffects(p)local i=GetVehicleNumberPlateText(p)print('^5VEHICEL STATUS BROKEN EFFECTS KICKED IN^0')if checkOwnedVehicle(p)then if GetVehicleClass(p)~=13 and GetVehicleClass(p)~=21 and GetVehicleClass(p)~=16 and GetVehicleClass(p)~=15 and GetVehicleClass(p)~=14 then if VehicleStatus[i]~=nil then local t=VehicleStatus[i]["radiator"]-math.random(5,10)TriggerServerEvent('cfx_vehicletuning:server:SetPartLevel',i,"radiator",t)print('Broken Effect Applied | NEW VALUE RD:'..t)local u=VehicleStatus[i]["axle"]-math.random(5,10)TriggerServerEvent('cfx_vehicletuning:server:SetPartLevel',i,"axle",u)print('Broken Effect Applied | NEW VALUE AX:'..u)local v=VehicleStatus[i]["brakes"]-math.random(5,10)TriggerServerEvent('cfx_vehicletuning:server:SetPartLevel',i,"brakes",v)print('Broken Effect Applied | NEW VALUE BR:'..v)local w=VehicleStatus[i]["clutch"]-math.random(5,10)TriggerServerEvent('cfx_vehicletuning:server:SetPartLevel',i,"clutch",w)print('Broken Effect Applied | NEW VALUE CL:'..w)local x=VehicleStatus[i]["fuel"]-math.random(5,10)TriggerServerEvent('cfx_vehicletuning:server:SetPartLevel',i,"fuel",x)print('Broken Effect Applied | NEW VALUE FL:'..x)if x<0 then x=0;TriggerServerEvent('cfx_vehicletuning:server:SetPartLevel',i,"fuel",x)end;if t<0 then t=0;TriggerServerEvent('cfx_vehicletuning:server:SetPartLevel',i,"radiator",t)end;if w<0 then w=0;TriggerServerEvent('cfx_vehicletuning:server:SetPartLevel',i,"clutch",w)end;if v<0 then v=0;TriggerServerEvent('cfx_vehicletuning:server:SetPartLevel',i,"brakes",v)end;if u<0 then u=0;TriggerServerEvent('cfx_vehicletuning:server:SetPartLevel',i,"axle",u)end;print('^5BROKEN EFFECTS APPLIED VEHICLE OWNED^0')TriggerServerEvent("cfx_vehicletuning:server:saveStatus",i)end end else print('^1BROKEN EFFECTS NOT APPLIED VEHICLE NOT OWNED^0')end end;RegisterCommand('repair',function(y,z)local n=string.lower(z[1])local A=tonumber(z[2])local c=ESX.Game.GetVehicleInDirection()if ESX.PlayerData.job.name=='mechanic'then if n~=nil and A>0 then if n~="packaged_main_kit"and n~="fuel_tank"and n~="radiator"and n~="clutch"and n~="brakes"and n~="axle"and n~="scrap_fuel_tank"and n~="scrap_radiator"and n~="scrap_clutch"and n~="scrap_brakes"and n~="scrap_axle"then exports['mythic_notify']:DoCustomHudText('error','Invalid vehicle part.',5000)return end;local B=checkHasItem(n,A)if not B then exports['mythic_notify']:DoCustomHudText('error','You do not have enough materials.',5000)return end;if DoesEntityExist(c)then TriggerEvent("mythic_progbar:client:progress",{name="unique_action_name",duration=20000,label="Repairing vehicle",useWhileDead=false,canCancel=true,controlDisables={disableMovement=true,disableCarMovement=true,disableMouse=false,disableCombat=true},animation={animDict="mp_car_bomb",anim="car_bomb_mechanic",flags=49}},function(j)if not j then local i=GetVehicleNumberPlateText(c)local o;local t=VehicleStatus[i]["radiator"]local u=VehicleStatus[i]["axle"]local v=VehicleStatus[i]["brakes"]local w=VehicleStatus[i]["clutch"]local x=VehicleStatus[i]["fuel"]if n=="scrap_fuel_tank"then n="fuel"o=x+A*5;item='scrap_fuel_tank'elseif n=="scrap_radiator"then n="radiator"o=t+A*5;item='scrap_radiator'elseif n=="scrap_clutch"then n="clutch"o=w+A*5;item='scrap_clutch'elseif n=="scrap_brakes"then n="brakes"o=v+A*5;item='scrap_brakes'elseif n=="scrap_axle"then n="axle"o=u+A*5;item='scrap_axle'elseif n=='fuel_tank'then n="fuel"o=x+A*10;item='fuel_tank'elseif n=="radiator"then n="radiator"o=t+A*10;item='radiator'elseif n=="clutch"then n="clutch"o=w+A*10;item='clutch'elseif n=="brakes"then n="brakes"o=v+A*10;item='brakes'elseif n=="axle"then n="axle"o=u+A*10;item='axle'end;if o>=100 then o=100 end;print('ATTEMPT REPAIR | PART: '..n..' | LEVEL: '..o)exports['mythic_notify']:DoLongHudText('inform','Maintenance repaired! | Part: '..n..' | Level: '..o..'')TriggerServerEvent('cfx_vehicletuning:server:SetPartLevel',i,n,o)TriggerServerEvent("cfx_vehicletuning:server:saveStatus",i)TriggerServerEvent('cfx_vehicletuning:server:removeItem',item,A)end end)else c=GetVehiclePedIsIn(PlayerPedId(),true)local C=GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),GetEntityCoords(c),1)if C<2.0 then TriggerEvent("mythic_progbar:client:progress",{name="unique_action_name",duration=20000,label="Repairing vehicle",useWhileDead=false,canCancel=true,controlDisables={disableMovement=true,disableCarMovement=true,disableMouse=false,disableCombat=true},animation={animDict="mp_car_bomb",anim="car_bomb_mechanic",flags=49}},function(j)if not j then local i=GetVehicleNumberPlateText(c)local o;local t=VehicleStatus[i]["radiator"]local u=VehicleStatus[i]["axle"]local v=VehicleStatus[i]["brakes"]local w=VehicleStatus[i]["clutch"]local x=VehicleStatus[i]["fuel"]if n=="scrap_fuel_tank"then n="fuel"o=x+A*5;item='scrap_fuel_tank'elseif n=="scrap_radiator"then n="radiator"o=t+A*5;item='scrap_radiator'elseif n=="scrap_clutch"then n="clutch"o=w+A*5;item='scrap_clutch'elseif n=="scrap_brakes"then n="brakes"o=v+A*5;item='scrap_brakes'elseif n=="scrap_axle"then n="axle"o=u+A*5;item='scrap_axle'elseif n=='fuel_tank'then n="fuel"o=x+A*10;item='fuel_tank'elseif n=="radiator"then n="radiator"o=t+A*10;item='radiator'elseif n=="clutch"then n="clutch"o=w+A*10;item='clutch'elseif n=="brakes"then n="brakes"o=v+A*10;item='brakes'elseif n=="axle"then n="axle"o=u+A*10;item='axle'end;if o>=100 then o=100 end;print('ATTEMPT REPAIR | PART: '..n..' | LEVEL: '..o)exports['mythic_notify']:DoLongHudText('inform','Maintenance repaired! | Part: '..n..' | Level: '..o..'')TriggerServerEvent('cfx_vehicletuning:server:SetPartLevel',i,n,o)TriggerServerEvent("cfx_vehicletuning:server:saveStatus",i)TriggerServerEvent('cfx_vehicletuning:server:removeItem',item,A)end end)else exports['mythic_notify']:DoCustomHudText('error','There is no vehicle nearby.',5000)end end end else exports['mythic_notify']:DoCustomHudText('error','You\'re not a mechanic.',5000)end end)RegisterCommand('fixall',function(y,z)local c=ESX.Game.GetVehicleInDirection()if ESX.PlayerData.job.name=='mechanic'then local B=checkHasItem('packaged_main_kit',1)if not B then exports['mythic_notify']:DoCustomHudText('error','You do not have enough materials.',5000)return end;if DoesEntityExist(c)then playAnim('mp_car_bomb','car_bomb_mechanic',-1)local D=exports['np-taskbarskill']:taskBar(30000,math.random(10,20))if D<=0 then exports['mythic_notify']:DoLongHudText('error','You messed up the wirings.')ClearPedTasks(PlayerPedId())return end;local D=exports['np-taskbarskill']:taskBar(20000,math.random(8,10))if D<=0 then exports['mythic_notify']:DoLongHudText('error','You messed up the wirings.')ClearPedTasks(PlayerPedId())return end;local D=exports['np-taskbarskill']:taskBar(1500,math.random(3,5))if D<=0 then exports['mythic_notify']:DoLongHudText('error','You messed up the wirings.')ClearPedTasks(PlayerPedId())return end;local D=exports['np-taskbarskill']:taskBar(30000,math.random(10,20))if D<=0 then exports['mythic_notify']:DoLongHudText('error','You messed up the wirings.')ClearPedTasks(PlayerPedId())return end;local D=exports['np-taskbarskill']:taskBar(20000,math.random(8,10))if D<=0 then exports['mythic_notify']:DoLongHudText('error','You messed up the wirings.')ClearPedTasks(PlayerPedId())return end;local D=exports['np-taskbarskill']:taskBar(1500,math.random(3,5))if D<=0 then exports['mythic_notify']:DoLongHudText('error','You messed up the wirings.')ClearPedTasks(PlayerPedId())return end;ClearPedTasks(PlayerPedId())local i=GetVehicleNumberPlateText(c)SetVehicleFixed(c)SetVehicleDeformationFixed(c)SetVehicleUndriveable(c,false)TriggerServerEvent("cfx_vehicletuning:server:fixEverything",i)TriggerServerEvent('cfx_vehicletuning:server:removeItem','packaged_main_kit',1)TriggerServerEvent("cfx_vehicletuning:server:saveStatus",i)exports['mythic_notify']:DoLongHudText('inform','Maintenance fully repaired!')else c=GetVehiclePedIsIn(PlayerPedId(),true)local C=GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),GetEntityCoords(c),1)if C<2.0 then playAnim('mp_car_bomb','car_bomb_mechanic',-1)local D=exports['np-taskbarskill']:taskBar(30000,math.random(10,20))if D<=0 then exports['mythic_notify']:DoLongHudText('error','You messed up the wirings.')ClearPedTasks(PlayerPedId())return end;local D=exports['np-taskbarskill']:taskBar(20000,math.random(8,10))if D<=0 then exports['mythic_notify']:DoLongHudText('error','You messed up the wirings.')ClearPedTasks(PlayerPedId())return end;local D=exports['np-taskbarskill']:taskBar(1500,math.random(3,5))if D<=0 then exports['mythic_notify']:DoLongHudText('error','You messed up the wirings.')ClearPedTasks(PlayerPedId())return end;local D=exports['np-taskbarskill']:taskBar(30000,math.random(10,20))if D<=0 then exports['mythic_notify']:DoLongHudText('error','You messed up the wirings.')ClearPedTasks(PlayerPedId())return end;local D=exports['np-taskbarskill']:taskBar(20000,math.random(8,10))if D<=0 then exports['mythic_notify']:DoLongHudText('error','You messed up the wirings.')ClearPedTasks(PlayerPedId())return end;local D=exports['np-taskbarskill']:taskBar(1500,math.random(3,5))if D<=0 then exports['mythic_notify']:DoLongHudText('error','You messed up the wirings.')ClearPedTasks(PlayerPedId())return end;ClearPedTasks(PlayerPedId())local i=GetVehicleNumberPlateText(c)SetVehicleFixed(c)SetVehicleDeformationFixed(c)SetVehicleUndriveable(c,false)TriggerServerEvent("cfx_vehicletuning:server:fixEverything",i)TriggerServerEvent('cfx_vehicletuning:server:removeItem','packaged_main_kit',1)TriggerServerEvent("cfx_vehicletuning:server:saveStatus",i)exports['mythic_notify']:DoLongHudText('inform','Maintenance fully repaired!')else exports['mythic_notify']:DoCustomHudText('error','There is no vehicle nearby.',5000)end end else exports['mythic_notify']:DoCustomHudText('error','You\'re not a mechanic.',5000)end end)function playAnim(E,F,G)RequestAnimDict(E)while not HasAnimDictLoaded(E)do Citizen.Wait(0)end;TaskPlayAnim(PlayerPedId(),E,F,1.0,-1.0,G,49,1,false,false,false)RemoveAnimDict(E)end;function checkHasItem(H,A)local I=ESX.GetPlayerData().inventory;for r=1,#I do local item=I[r]if H==item.name and item.count>=A then return true end end;return false end;function loadAnimDict(J)while not HasAnimDictLoaded(J)do RequestAnimDict(J)Citizen.Wait(5)end end;function GetVehicleStatusList(i)local K=nil;if VehicleStatus[i]~=nil then K=VehicleStatus[i]end;return K end;function GetVehicleStatus(i,n)local K=nil;if VehicleStatus[i]~=nil then K=VehicleStatus[i][n]end;return K end;function SetVehicleStatus(i,n,o)TriggerServerEvent("cfx_vehicletuning:server:updatePart",i,n,o)end;function SendStatusMessage(L)if L~=nil then TriggerEvent('chat:addMessage',{template='<div class="chat-message advert"><div class="chat-message-body"><strong>{0} :</strong><br><br> <strong>^2'..Config.ValuesLabels["engine"]..':^0</strong> {1} <br><strong>^2'..Config.ValuesLabels["body"]..':^0</strong> {2} <br><strong>^2'..Config.ValuesLabels["radiator"]..':^0</strong> {3} <br><strong>^2'..Config.ValuesLabels["axle"]..':^2</strong> {4}<br><strong>^2'..Config.ValuesLabels["brakes"]..':^0</strong> {5}<br><strong>^2'..Config.ValuesLabels["clutch"]..'^0:</strong> {6}<br><strong>^2'..Config.ValuesLabels["fuel"]..':^0</strong> {7}</div></div>',args={'[^3 VEHICLE STATUS ^0]',round(L["engine"]).." / "..Config.MaxStatusValues["engine"].." (^3Advanced Repairkit^0)",round(L["body"]).." / "..Config.MaxStatusValues["body"].." (^3Body Kit^0)",round(L["radiator"]).." / "..Config.MaxStatusValues["radiator"]..".0 (^3Radiator^0)",round(L["axle"]).." / "..Config.MaxStatusValues["axle"]..".0 (^3Axle^0)",round(L["brakes"]).." / "..Config.MaxStatusValues["brakes"]..".0 (^3Brakes^0)",round(L["clutch"]).." / "..Config.MaxStatusValues["clutch"]..".0 (^3Clutch^0)",round(L["fuel"]).." / "..Config.MaxStatusValues["fuel"]..".0 (^3Jerry Can^0)"}})end end;function round(M,N)return tonumber(string.format("%."..(N or 1).."f",M))end