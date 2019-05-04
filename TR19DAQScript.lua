-- Triton Racing TR-19 Data Aquasition Scripting
-- Author: Matt G., Cameron B., Weifan O.

tog = 0
res = 0
setTickRate(100)
initSer(6, 115200, 8, 0, 1)   -- Set up aux serial port for NEXTION display
setGpio(2, 0)

function onTick()
    -- DAQ Switch
    local arm = getGpio(2)
    if arm == 0 then
        stopLogging()
    end
    if arm == 1 then
        startLogging()
    end
    -- END of DAQ Switch

    -- Oil pressure warning light
    if getAnalog(2) < 20 then
        if tog >= 40 then
            tog = 0
        end

        if tog < 20 then
            setGpio(0, 1)
            tog = tog + 1
        else
            setGpio(0, 0)
            tog = tog + 1
        end
    else
        setGpio(0, 1)
    end
    -- END of oil pressure warning light

    -- Local var used for printing numbers
    local neg = 0
    local x2 = 0    -- 0.01
    local x1 = 0    -- 0.1
    local z0 = 0    -- 1
    local z1 = 0    -- 10
    local z2 = 0    -- 100
    local z3 = 0    -- 1000
    local z4 = 0    -- 10000

    -- Print GPS spd
    local spd = getGpsSpeed ()
    spd = math.floor(spd)
    z0 = math.floor(spd % 10)
    spd = spd / 10
    z1 = math.floor(spd % 10)
    writeCSer(6, 0x74) --t
    writeCSer(6, 0x31) --1
    writeCSer(6, 0x2e) --.
    writeCSer(6, 0x74) --t
    writeCSer(6, 0x78) --x
    writeCSer(6, 0x74) --t
    writeCSer(6, 0x3d) --=
    writeCSer(6, 0x22) --
    if z1 ~= 0 then
        writeCSer(6, (48+z1))
    end
    writeCSer(6, (48+z0))
    writeCSer(6, 0x22) --"
    writeCSer(6, 0xff)
    writeCSer(6, 0xff)
    writeCSer(6, 0xff)


    -- Print engine RPM
    local RPM = getTimerRpm (1)
    RPM = math.floor(RPM)
    z0 = math.floor(RPM % 10)
    RPM = RPM / 10
    z1 = math.floor(RPM % 10)
    RPM = RPM / 10
    z2 = math.floor(RPM % 10)
    RPM = RPM / 10
    z3 = math.floor(RPM % 10)
    RPM = RPM / 10
    z4 = math.floor(RPM % 10)
    RPM = RPM / 10
    writeCSer(6, 0x74) --t
    writeCSer(6, 0x32) --2
    writeCSer(6, 0x2e) --.
    writeCSer(6, 0x74) --t
    writeCSer(6, 0x78) --x
    writeCSer(6, 0x74) --t
    writeCSer(6, 0x3d) --=
    writeCSer(6, 0x22) --"
    if (z4 ~= 0) then
        writeCSer(6, (48+z4))
    end
    if (z4 ~= 0 or z3~= 0) then
        writeCSer(6, (48+z3))
    end
    writeCSer(6, (48+z2))
    writeCSer(6, (48+z1))
    writeCSer(6, (48+z0))
    writeCSer(6, 0x22) --"
    writeCSer(6, 0xff)
    writeCSer(6, 0xff)
    writeCSer(6, 0xff)

    -- Print coolant Temp
    local cTemp = getAnalog (1)
    cTemp = math.floor(cTemp)
    z0 = math.floor(cTemp % 10)
    cTemp = cTemp / 10
    z1 = math.floor(cTemp % 10)
    cTemp = cTemp / 10
    z2 = math.floor(cTemp % 10)
    writeCSer(6, 0x74) --t
    writeCSer(6, 0x33) --3
    writeCSer(6, 0x2e) --.
    writeCSer(6, 0x74) --t
    writeCSer(6, 0x78) --x
    writeCSer(6, 0x74) --t
    writeCSer(6, 0x3d) --=
    writeCSer(6, 0x22) --"
    if (z2 ~= 0) then
        writeCSer(6, (48+z2))
    end
    if (z2 ~= 0 or z1~= 0) then
        writeCSer(6, (48+z1))
    end
    writeCSer(6, (48+z0))
    writeCSer(6, 0x22) --"
    writeCSer(6, 0xff)
    writeCSer(6, 0xff)
    writeCSer(6, 0xff)

    -- Print oil pressure
    local gear = getAnalog (2)
    gear = math.floor(gear * 100)
    x2 = math.floor(gear % 10)
    gear = gear / 10
    x1 = math.floor(gear % 10)
    gear = gear / 10
    z0 = math.floor(gear % 10)
    gear = gear / 10
    z1 = math.floor(gear % 10)
    writeCSer(6, 0x74) --t
    writeCSer(6, 0x36) --6
    writeCSer(6, 0x2e) --.
    writeCSer(6, 0x74) --t
    writeCSer(6, 0x78) --x
    writeCSer(6, 0x74) --t
    writeCSer(6, 0x3d) --=
    writeCSer(6, 0x22) --"
    if (z1 ~= 0) then
        writeCSer(6, (48+z1))
    end
    writeCSer(6, (48+z0))
    writeCSer(6, 0x2e) --.
    writeCSer(6, (48+x1))
    writeCSer(6, (48+x2))
    writeCSer(6, 0x22) --"
    writeCSer(6, 0xff)
    writeCSer(6, 0xff)
    writeCSer(6, 0xff)


    -- Print battery volt
    local volt = getAnalog (8)
    volt = math.floor(volt * 100)
    x2 = math.floor(volt % 10)
    volt = volt / 10
    x1 = math.floor(volt % 10)
    volt = volt / 10
    z0 = math.floor(volt % 10)
    volt = volt / 10
    z1 = math.floor(volt % 10)
    writeCSer(6, 0x74) --t
    writeCSer(6, 0x34) --4
    writeCSer(6, 0x2e) --.
    writeCSer(6, 0x74) --t
    writeCSer(6, 0x78) --x
    writeCSer(6, 0x74) --t
    writeCSer(6, 0x3d) --=
    writeCSer(6, 0x22) --"
    if (z1 ~= 0) then
        writeCSer(6, (48+z1))
    end
    writeCSer(6, (48+z0))
    writeCSer(6, 0x2e) --.
    writeCSer(6, (48+x1))
    writeCSer(6, (48+x2))
    writeCSer(6, 0x22) --"
    writeCSer(6, 0xff)
    writeCSer(6, 0xff)
    writeCSer(6, 0xff)

    -- Print STANG
    local stAng = getAnalog (4)
    stAng = stAng*20
    stAng = math.floor(stAng)
    z0 = math.floor(stAng % 10)
    stAng = stAng / 10
    z1 = math.floor(stAng % 10)
    stAng = stAng / 10
    z2 = math.floor(stAng % 10)
    writeCSer(6, 0x6a) --j
    writeCSer(6, 0x31) --1
    writeCSer(6, 0x2e) --.
    writeCSer(6, 0x76) --v
    writeCSer(6, 0x61) --a
    writeCSer(6, 0x6c) --l
    writeCSer(6, 0x3d) --=
    if (z2 ~= 0) then
        writeCSer(6, (48+z2))
    end
    if (z2 ~= 0 or z1~= 0) then
        writeCSer(6, (48+z1))
    end
    writeCSer(6, (48+z0))
    writeCSer(6, 0xff)
    writeCSer(6, 0xff)
    writeCSer(6, 0xff)



    -- Print gear
    local gear = calcGear(40.64, 2.75, 2.846, 1.947, 1.556, 1.333, 1.190, 1.083)
                            -- Wheel dia, final drive, 1st, 2nd.....
    z0 = math.floor(gear % 10)
    writeCSer(6, 0x74) --t
    writeCSer(6, 0x37) --7
    writeCSer(6, 0x2e) --.
    writeCSer(6, 0x74) --t
    writeCSer(6, 0x78) --x
    writeCSer(6, 0x74) --t
    writeCSer(6, 0x3d) --=
    writeCSer(6, 0x22) --"
    if gear == nil then
        writeCSer(6, 0x4e)  -- N
    else
        writeCSer(6, (48+gear)) -- gear num
    end
    writeCSer(6, (48+z0))
    writeCSer(6, 0x22) --"
    writeCSer(6, 0xff)
    writeCSer(6, 0xff)
    writeCSer(6, 0xff)

end