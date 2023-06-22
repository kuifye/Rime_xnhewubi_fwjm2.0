-- 使得处理器能够处理上屏
function split(str,delimiter)
  local dLen = string.len(delimiter)
  local newDeli = ''
  for i=1,dLen,1 do
      newDeli = newDeli .. "["..string.sub(delimiter,i,i).."]"
  end

  local locaStart,locaEnd = string.find(str,newDeli)
  local arr = {}
  local n = 1
  while locaStart ~= nil
  do
      if locaStart>0 then
          arr[n] = string.sub(str,1,locaStart-1)
          n = n + 1
      end

      str = string.sub(str,locaEnd+1,string.len(str))
      locaStart,locaEnd = string.find(str,newDeli)
  end
  if str ~= nil then
      arr[n] = str
  end
  return arr
end

function last_code_is_space(script_text) 
  if (string.sub(script_text,-1) == '_') then
    return true
  else
    return false
  end
end

function last_code_is_semicolon(script_text) 
  if (string.sub(script_text,-1) == ';') then
    return true
  else
    return false
  end
end

function last_code_is_commitkey(script_text) 
  if (last_code_is_semicolon(script_text) or last_code_is_space(script_text)) then
    return true
  else
    return false
  end
end

local function auto_select(key, env)
  local engine = env.engine
  local context = engine.context
  local config = engine.schema.config
  local len = #env.engine.context.input
  local auto_code = tonumber(config:get_string('speller/auto_code')) or 4                  --------------------手动或自动识别上屏
  local auto_select_phrase = config:get_string('speller/auto_select_phrase') or 'false'    --------------------是否自动上屏
  local commit_key = 'space' 
  local commit_key_code = '_' 
  local commit_key_semicolon = 'semicolon'
  local commit_key_semicolon_code = ';'
  local commit_key_apostrophe = 'apostrophe'
  local commit_key_flag = false
  local alphabet = config:get_string('speller/alphabet')
  local found_match_flag = false -- 假设尚未找到匹配

  for i = 1, #alphabet do
    if key:repr() == string.sub(alphabet, i, i) then
      -- 如果key的repr()等于str中的某个字符，执行if块的内容
      found_match_flag = true -- 标记为已找到匹配
      break -- 找到匹配后跳出循环
    end
  end

  if (not found_match_flag) then                --判断当前输入是否为空格或分号
    return 2 -- kAccepted
  end

  if (key:repr() == commit_key or key:repr() == commit_key_semicolon or key:repr() == commit_key_apostrophe) then                --判断当前输入是否为空格或分号
    commit_key_flag = true
  end

  if(auto_select_phrase == 'true') then
    if (len <= 1 and commit_key_flag) then
      if (key:repr() == commit_key_semicolon) then
        context:push_input(';')   
      end
      if (key:repr() == commit_key_apostrophe) then
        context:push_input("'")  
      end
      if (key:repr() == commit_key) then
        context:push_input(" ")  
      end
      local commit_text = context:get_commit_text()
      engine:commit_text(commit_text)
      context:clear()
      return 1 -- kAccepted
    end

    if (len > 1 and commit_key_flag) then
      if (key:repr() == commit_key_semicolon) then
        context:push_input(';')   
      end
      if (key:repr() == commit_key_apostrophe) then
        context:push_input("'")  
      end
      if (context:has_menu() == false)then     --如果没有对应的词汇就去掉空格直到有一个对应的词为止
        context:pop_input(1) 
      end
      local commit_text = context:get_commit_text()
      engine:commit_text(commit_text)
      context:clear()
      return 1 -- kAccepted
    end
  end

  -- if (auto_code ~= 0 and len >= auto_code and found_match_flag) then                                                        ------------------------------------n码上屏
  --   local script_text = context:get_script_text()    --获取带分词的编码
  --   local script_text1 = {}
  --   script_text1 = context:get_property("script_text1")
  --   local script_text2 = {}   
  --   script_text2 = context:get_property("script_text2")
  --   local script_text3 = {}   
  --   script_text3 = context:get_property("script_text3")
  --   local script_text4 = {}   
  --   script_text4 = context:get_property("script_text4")
  --   context:set_property("script_text1", script_text)
  --   context:set_property("script_text2", script_text1)
  --   context:set_property("script_text3", script_text2)
  --   context:set_property("script_text4", script_text3)
  --   if (len >= 4) then
  --     local split_text = {}
  --     split_text = split(script_text, " ")
  --     local split_text1 = {}
  --     split_text1 = split(script_text1, " ") 
  --     local split_text2 = {}
  --     split_text2 = split(script_text2, " ")
  --     local split_text3 = {}
  --     split_text3 = split(script_text3, " ")
  --     local split_text4 = {}
  --     split_text4 = split(script_text4, " ")
  -- local position = 0

  local script_text = context:get_script_text()    --获取带分词的编码
  split_text = {}                                  --命名编码数组
  split_text = split(script_text, " ")             --以空格分割编码，放入命名好的数组内
  if (auto_code ~= 0 and len >= auto_code ) then                                                  ------------------------------------顶功码上屏
    if (len >= 5) then
      context:pop_input(1)
      local script_text1 = context:get_script_text()
      split_text1 = {}                                  --命名编码数组
      split_text1 = split(script_text1, " ")             --以空格分割编码，放入命名好的数组内

      context:pop_input(1)
      local script_text2 = context:get_script_text()
      split_text2 = {}                                  --命名编码数组
      split_text2 = split(script_text2, " ")             --以空格分割编码，放入命名好的数组内
      
      context:pop_input(1)
      local script_text3 = context:get_script_text()
      split_text3 = {}                                  --命名编码数组
      split_text3 = split(script_text3, " ")             --以空格分割编码，放入命名好的数组内

      context:pop_input(1)
      local script_text4 = context:get_script_text()
      split_text4 = {}                                  --命名编码数组
      split_text4 = split(script_text4, " ")             --以空格分割编码，放入命名好的数组内
      local position = 4

      
      local spilt_position = #split_text4
      for i=1, #split_text4-1 do
        if (#split_text[i] ~= #split_text1[i] or #split_text1[i] ~= #split_text2[i] or #split_text2[i] ~= #split_text3[i] or #split_text3[i] ~= #split_text4[i]) then
          spilt_position = i
          break
        else
          position = #split_text[i] + position
        end
      end

      context:pop_input(len-position)

      local commit_text = context:get_commit_text()
      engine:commit_text(commit_text)
      context:clear()
      for i=spilt_position,#split_text do
        context:push_input(split_text[i]) 
      end
      return 2
    end
  end

  if (commit_key_flag) then                                          -- 连按两次空格上屏
    if (last_code_is_commitkey(script_text)) then
      local commit_text = context:get_commit_text()
      engine:commit_text(commit_text)
      context:clear()
      return 1
    end
  end

  return 2 -- kNoop
end

return auto_select