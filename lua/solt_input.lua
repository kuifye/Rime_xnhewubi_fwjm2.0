--[[
solt_input_filter: 候选项重排序，使单字优先，词组次之，三字词其次
--]]

local function translator(input, seg)
   local first = true
   local l = {}
   local l_3 = ''
   for cand in input:iter() do
      table.insert(l, cand)
      if (utf8.len(cand.text) == 3) then
         if first then
            l_3 = cand
            first = false
         end
      end
   end
end

return translator
