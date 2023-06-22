local function farsi(key, env)
  local engine = env.engine
  local context = engine.context
  local config = engine.schema.config
  local len = #env.engine.context.input
  local alphabet = config:get_string('speller/alphabet')
  local found_match_flag = false -- 假设尚未找到匹配

  for i = 1, #alphabet do
    if ( key:repr() == string.sub(alphabet, i, i) ) then
      -- 如果key的repr()等于str中的某个字符，执行if块的内容
      found_match_flag = true -- 标记为已找到匹配
			context:push_input(key:repr())
			goto commit_flag
      break -- 找到匹配后跳出循环
		end
  end
	if ( key:repr() == 'semicolon' ) then
		found_match_flag = true -- 标记为已找到匹配
		context:push_input(';')
		goto commit_flag
	end
	if ( key:repr() == 'Shift+colon' ) then
		found_match_flag = true -- 标记为已找到匹配
		context:push_input(':')
		goto commit_flag
	end
	if ( key:repr() == 'minus' or key:repr() == 'Shift+underscore') then
		found_match_flag = true -- 标记为已找到匹配
		context:push_input('-')
		goto commit_flag
	end
	if ( string.find ( key:repr() , 'Shift%+' ) == 1 and string.find ( key:repr() , 'Release%+' ) == nil ) then
		for i = 1, #alphabet do
			local repr = string.gsub( key:repr(), "Shift%+", "" )
			if ( repr == string.upper( string.sub(alphabet, i, i) ) ) then
				found_match_flag = true -- 标记为已找到匹配
				context:push_input(repr)
				goto commit_flag
				break
			end
		end
	end

	::commit_flag::
  if ( found_match_flag ) then
		local script_text = context:get_script_text()    --获取带分词的编码
		engine:commit_text(script_text)
		context:clear()
		return 1 -- kNoop
	end

  return 2 -- kNoop
end

return farsi