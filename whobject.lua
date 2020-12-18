local dxfont = renderCreateFont("Trebuchet MS", 12, 5)

local objTable = {
    [11705] = 'Прослушка',
    [1719] = 'Глушилка',
    [1654] = 'Бомба',
}


function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end
    while true do
        for k, v in ipairs(getAllObjects()) do
            local px, py, pz = getCharCoordinates(PLAYER_PED)
            if doesObjectExist(v) and objTable[getObjectModel(v)] and isObjectOnScreen(v) then -- and not isObjectAttached(v)
                local model = getObjectModel(v)
                local ok, x, y, z = getObjectCoordinates(v)
                if ok then
                    local dist = getDistanceBetweenCoords3d(x, y, z, px, py, pz)
                    if (dist > 1 and dist < 300) then
                        local x, y = convert3DCoordsToScreen(x, y, z)
                        local str = objTable[model] .. string.format('(%.1f m)', dist)
                        local nx = renderGetFontDrawTextLength(dxfont, str) / 2
                        renderFontDrawText(dxfont, str, x - nx, y, getCol(model))
                    end
                end
            end
        end
        wait(0)
    end
end

local cols = {
    [11705] = 0xFF6495ED,
    [1719] = 0xFF6495ED,
    [1654] = 0xFF6495ED,
}

function getCol(obj)
    if cols[obj] then
        return cols[obj]
    end
    if obj < 373 then
        return 0xFF9A7652
    end
    return 0xFFCCCCCC
end