--  user_dir/lual/remove_dict/init.lua
-- #! /usr/bin/env lua
--
-- main_init.lua
-- Copyright (C) 2020 Shewer Lu <shewer@gmail.com>
--
-- Distributed under terms of the MIT license.
--
--------------------------------------------

--  lua_init(argv) argv 自定義
--local Notifier=require ('tools/notifier') -- 建立 notifier obj   減化 notifier connect and disconnect() 
-- 取得 librime 狀態 tab { always=true ....}


local function append_word(word)
	-- local dir_path= package.config:sub(1,1)
	-- local  filename = rime_api.get_user_data_dir() .. dir_path .. "rm_file.txt"  --部分旧版本的lib不支持该写法
	-- local fn = io.open(filename,"a+")
  local dir_split = package.config:sub(1,1)
  local spilt_line = '\r'
  if dir_split == '\\' then
    spilt_line = '\n'
  end
  local path=string.gsub(debug.getinfo(1).source,"^@(.+" .. dir_split .. ")[^" .. dir_split .. "]+$", "%1")
  local filename= path .. dir_split .. "rm_word.txt"
  local fn=io.open(filename,"a+")

  fn:write( word .. spilt_line)
  fn:close()
end 

local function print_info(word)
  local dir_split = package.config:sub(1,1)
  local spilt_line = '\r'
  if dir_split == '\\' then
    spilt_line = '\n'
  end
  local path=string.gsub(debug.getinfo(1).source,"^@(.+" .. dir_split .. ")[^" .. dir_split .. "]+$", "%1")
  local filename= path .. dir_split .. "print_info.txt"
  local fn=io.open(filename,"a+")
  fn:write( word .. spilt_line)
  fn:close()
end 

local function load_word()
	-- local dir_path= package.config:sub(1,1)
	-- local  filename = rime_api.get_user_data_dir() .. dir_path .. "rm_file.txt"  --部分旧版本的lib不支持该写法
	-- local fn = io.open(filename, "r") or io.open(filename,"w+")
  local dir_split = package.config:sub(1,1)
  local spilt_line = '\r'
  if dir_split == '\\' then
    spilt_line = '\n'
  end
  local path=string.gsub(debug.getinfo(1).source,"^@(.+" .. dir_split .. ")[^" .. dir_split .. "]+$", "%1")
  local filename= path .. dir_split .. "rm_word.txt"
  local fn= io.open(filename, "r") or io.open(filename,"w+")
  local tab={}
  for word in fn:lines() do
    tab[word] =true
  end
  fn:close()
  return tab
end

-- return set table
local function delete_candidate(cand ,tab)
  tab = tab or {}
  tab[cand.text]=true
  append_word(cand.text)
  local ctype= cand:get_dynamic_typeo()
  if ctype == "ShadowCandidate" then
    delete_candidate(cand:get_genuine() ,tab)
  elseif ctype == "UniquifiedCandidate" then
    delete_candidate(cand:get_genuine() ,tab)
  end
  return tab
end

local function lua_init(...)
  local args={...} 
  rm_tab= load_word()

  local function processor_func(key,env) -- key:KeyEvent,env_
    local Rejected, Accepted, Noop = 0,1,2 
    local engine=env.engine
    local context=engine.context
    local stat= setmetatable({}, {})
    local comp= context.composition
    stat.always=true
    stat.composing= context:is_composing()
    stat.empty= not stat.composing
    stat.has_menu= context:has_menu()
    stat.paging= not comp:empty() and comp:back():has_tag("paging")
    local s = stat
    if s.empty then end 
    if s.always then end 
    if s.has_menu then
      if key:repr() == "Control+d" then 
        local cand=context:get_selected_candidate()
        -- delete_candidate(cand ,rm_tab)
        rm_tab[cand:get_genuine().text]=true
        append_word(cand:get_genuine().text)
        context:refresh_non_confirmed_composition() 
        return Accepted
      end
    end 
    if s.composing then end 
    if s.paging then end 
    return Noop  
  end 

  local function processor_init_func(env)
    --env.connect=Notifier(env) -- 提供 7種notifier commit update select delete option_update property_update unhandle_key
    --env.connect:commit( func)
    --env.connect:update( func)
  end 

  local function processor_fini_func(env) 
    env.connect:disconnect() -- 將所有 connection  disconnect() 
  end 

  -- segmentor 
  local function segmentor_func(segs ,env) -- segmetation:Segmentation,env_
  -- 終止 後面 segmentor   打tag  
  -- return  true next segmentor check
    return true 
  end 
  local function segmentor_init_func(env)
  end 
  local function segmentor_fini_func(env)
  end 

  -- translator 
  local function translator_func(input,seg,env)  -- input:string, seg:Segment, env_
    -- yield( Candidate( type , seg.start,seg._end, data , comment )
  end 
  local function translator_init_func(env)
  end 
  local function translator_fini_func(env)
  end 

  --- filter  
  local function filter_func(input,seg,env)   -- pass filter 
    for cand in input:iter() do 
      if string.find(cand.text, '☯〔超級簡拼〕')  == nil then
        if not rm_tab[cand.text] then
          yield(cand)
        end 
      end
    end 
  end
  local function filter_init_func(env)
  end 
  local function filter_fini_func(env)
  end 

  local _tab= { 
    processor= { func=processor_func, init=processor_init_func, fini=processor_fini_func} , 
    --segmentor= { func= segmentor_func, init=segmentor_init_func , fini=segmentor_fini_func} , 
    --translator={ func=translator_func, init=translator_init_func,fini=translator_fini_func} , 
    filter=    { func=filter_func, init=filter_init_func,    fini=filter_fini_func } ,   
    --filter1=    { func=filter_func1, init=filter_init_func1,    fini=filter_fini_func1 } ,   
  }
  return _tab
end 

return lua_init    