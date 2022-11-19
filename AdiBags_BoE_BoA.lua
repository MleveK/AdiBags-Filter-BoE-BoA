--[[
AdiBags_Bound - Adds BoE/BoA filters to AdiBags.
Copyright 2022 MleveK
All rights reserved.
--]]

local _, ns = ...

local addon = LibStub('AceAddon-3.0'):GetAddon('AdiBags')
local L = setmetatable({}, {__index = addon.L})
-- Localization
do
  L["Bound"] = "Bound"
  L["Put BOE/BOA in their own sections."] = "Put BOE/BOA in their own sections."

  local locale = GetLocale()
  if locale == "frFR" then

  elseif locale == "deDE" then
    
  elseif locale == "esMX" then
    
  elseif locale == "ruRU" then
    
  elseif locale == "esES" then
    
  elseif locale == "zhTW" then
    
  elseif locale == "zhCN" then
    
  elseif locale == "koKR" then
    
  end
end

-- Filter
local setFilter = addon:RegisterFilter("Bound", 92, 'ABEvent-1.0')
setFilter.uiName = L['Bound']
setFilter.uiDesc = L['Put BOE/BOA in their own sections.']

function setFilter:OnInitialize()
  self.db = addon.db:RegisterNamespace('Bound', {
    profile = { enableBoE = true, enableBoA = true },
    char = {  },
  })
end

function setFilter:Update()
  self:SendMessage('AdiBags_FiltersChanged')
end

function setFilter:OnEnable()
  addon:UpdateFilters()
end

function setFilter:OnDisable()
  addon:UpdateFilters()
end

function setFilter:Filter(slotData)
  local tooltip = C_TooltipInfo.GetBagItem(slotData.bag, slotData.slot)
	TooltipUtil.SurfaceArgs(tooltip)

	for _, lines in ipairs(tooltip.lines) do
		TooltipUtil.SurfaceArgs(lines)
	end

  for i = 1,3 do
    if tooltip.lines[i] then
      local t = tooltip.lines[i].leftText
      if self.db.profile.enableBoE and t == ITEM_BIND_ON_EQUIP then
        return L["BoE"]
      elseif self.db.profile.enableBoA and (t == ITEM_ACCOUNTBOUND or t == ITEM_BIND_TO_BNETACCOUNT or t == ITEM_BNETACCOUNTBOUND) then
        return L["BoA"]
      end
    end
  end
end

function setFilter:GetOptions()
  return {
    enableBoE = {
      name = L['Enable BoE'],
      desc = L['Check this if you want a section for BoE items.'],
      type = 'toggle',
      order = 10,
    },
    enableBoA = {
      name = L['Enable BoA'],
      desc = L['Check this if you want a section for BoA items.'],
      type = 'toggle',
      order = 20,
    },
  }, addon:GetOptionHandler(self, false, function() return self:Update() end)
end