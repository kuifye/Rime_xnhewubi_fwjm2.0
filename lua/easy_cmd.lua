local function cmd(order)
  local osascript = order
  local command = "start /b " .. osascript
  os.execute(osascript)
end

local function easy_cmd(key, env)
  local engine = env.engine
  local context = engine.context
  local composition = context.composition
  local segment = composition:back()

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

    local candidateText = segment:get_candidate_at(idx).text
    local startPos = 5
    local endPos = string.len(candidateText)
    if endPos >= 5 then
      local order = string.sub(candidateText, startPos, endPos)
      local sub_cand = string.sub(candidateText, 1, 4)
      if sub_cand == 'cmd_' then
          context:clear()
          local command = "start /b " .. order
          cmd(command)
          return 1 -- kAccepted 收下此key
      end
    end
    
  end
     -- return 0 -- kRejected librime 不處理
  return 2 -- kNoop 此processor 不處理
end
     
return easy_cmd