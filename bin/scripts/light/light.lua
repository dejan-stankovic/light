---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by k.
--- DateTime: 10/10/19 22:13
---

local ffi = require "ffi"

---@class
local light = {}

---@vararg string
function light.define (code)
    ffi.cdef(code)
end

---@vararg string
function light.sizeof(type)
    return ffi.sizeof(ffi.new(type))
end

---@vararg string
---@vararg userdata
function light.cast(type, data)
    return ffi.cast(type .. "*", data)
end

---@vararg string
---@vararg table
---@return userdata
function light.value(types, data)
    local ctype = ffi.typeof(types)
    local cdata = ffi.new(ctype)
    if type(data) == "table" then
        for k, v in pairs(data) do
            cdata[k] = v
        end
    else
        cdata = data
    end
    return cdata
end

function light.entity(types, data)
    if data then
        local cdata = light.value(types, data)
        return entity_value("pos", light.sizeof(types), cdata)
    else
        return entity()
    end
end

function light.column_v(rows, types, data)
    return column(rows, light.sizeof(types), data)
end

light.type = {
    EcsOnLoad       = 0,
    EcsPostLoad     = 1,
    EcsPreUpdate    = 2,
    EcsOnUpdate     = 3,
    EcsOnValidate   = 4,
    EcsPostUpdate   = 5,
    EcsPreStore     = 6,
    EcsOnStore      = 7,
    EcsManual       = 8,
    EcsOnAdd        = 9,
    EcsOnRemove     = 10,
    EcsOnSet        = 11,
}

return light