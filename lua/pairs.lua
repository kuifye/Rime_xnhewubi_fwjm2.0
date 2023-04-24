-- local function moveCursorToLeft()
--    -- local osascript = [[]]
--    -- os.execute(osascript)
--    local pythonProgram = "cmd"
--    -- local pythonProgram = "python C:\\Users\\58330\\AppData\\Roaming\\Rime\\lua\\left.py"
--    local command = "start /b " .. pythonProgram
--    os.execute(command)
-- end

local pairTable = {
   ["\""] = "\"",
   ["“"] = "”",
   ["'"] = "'",
   ["‘"] = "’",
   ["("] = ")",
   ["「"] = "」",
   ["["] = "]",
   ["【"] = "】",
   ["〔"] = "〕",
   ["［"] = "］",
   ["〚"] = "〛",
   ["〘"] = "〙",
   ["{"] = "}",
   ["『"] = "』",
   ["〖"] = "〗",
   ["｛"] = "｝"
};

local function processor(key, env)
   local engine = env.engine
   local context = engine.context
   local composition = context.composition
   local segment = composition:back()
   -- local candidate_count = segment.menu:candidate_count() -- 候选项数量
   -- local selected_candidate=segment:get_selected_candidate() -- 焦点项
 
   if context:has_menu() or context:is_composing() then
      local keyvalue = key:repr()
      local idx = -1
      if keyvalue == 'space' or keyvalue == '1' then
         idx = 0
      elseif string.find(keyvalue, '^[2-9]$') then
         idx = tonumber(keyvalue) - 1
      elseif keyvalue == '0' then
         idx = 9
      end

      if idx >= 0 and idx < segment.menu:candidate_count() then
         local candidateText = segment:get_candidate_at(idx).text -- 获取指定项 从0起
         local pairedText = pairTable[candidateText]

         if pairedText then
            engine:commit_text(candidateText)
            engine:commit_text(pairedText)
            context:clear()
            
            -- moveCursorToLeft()
 
            return 1 -- kAccepted 收下此key
         end
      end
   end
 
   -- return 0 -- kRejected librime 不處理
   return 2 -- kNoop 此processor 不處理
end
 
return processor