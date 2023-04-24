--lua语言中的注释用“--”
local function translator(input, seg)

    if (input == "time") then         --关键字更改，你也可以用or语句定义多个关键字
        yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), " "))
        yield(Candidate("time", seg.start, seg._end, os.date("%H点%M分"), " "))
        yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), " "))
        yield(Candidate("time", seg.start, seg._end, os.date("%H点%M分%S秒"), " "))
    end

    if (input == "date") then
        ------------------------------------------------------------------------------------
        --普通日期1，类似2022年01月02日
        date1=os.date("%Y年%m月%d日")
        date_y=os.date("%Y") --取年
        date_m=os.date("%m") --取月
        date_d=os.date("%d") --取日
        --yield(Candidate("date", seg.start, seg._end, date1, " "))
        ------------------------------------------------------------------------------------
        --普通日期2，类似2022年1月1日
        num_m=os.date("%m")+0
        num_m1=math.modf(num_m)
        num_d=os.date("%d")+0
        num_d1=math.modf(num_d)
        date2=os.date("%Y年")..tostring(num_m1).."月"..tostring(num_d1).."日"
        yield(Candidate("date", seg.start, seg._end, date2, " "))
        ------------------------------------------------------------------------------------
        --普通日期3，类似1月1日
        num_m=os.date("%m")+0
        num_m1=math.modf(num_m)
        num_d=os.date("%d")+0
        num_d1=math.modf(num_d)
        date3=tostring(num_m1).."月"..tostring(num_d1).."日"
        yield(Candidate("date", seg.start, seg._end, date3, " "))
        yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d"), " "))
        yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d"), " "))
        ------------------------------------------------------------------------------------
        --大写日期，类似二〇二〇年十一月二十六日
        date_y=date_y:gsub("%d",{
        ["1"]="一",
        ["2"]="二",
        ["3"]="三",
        ["4"]="四",
        ["5"]="五",
        ["6"]="六",
        ["7"]="七",
        ["8"]="八",
        ["9"]="九",
        ["0"]="〇",
        })
        date_y=date_y.."年"
        date_m=date_m:gsub("%d",{
        ["1"]="一",
        ["2"]="二",
        ["3"]="三",
        ["4"]="四",
        ["5"]="五",
        ["6"]="六",
        ["7"]="七",
        ["8"]="八",
        ["9"]="九",
        ["0"]="",
        })
        date_m=date_m.."月"
        if num_m1==10 then date_m="十月" end
        if num_m1==11 then date_m="十一月" end
        if num_m1==12 then date_m="十二月" end
        date_d=date_d:gsub("%d",{
        ["1"]="一",
        ["2"]="二",
        ["3"]="三",
        ["4"]="四",
        ["5"]="五",
        ["6"]="六",
        ["7"]="七",
        ["8"]="八",
        ["9"]="九",
        ["0"]="",
        })
        date_d=date_d.."日"
        if num_d1>9 then
        if num_d1<19 then
        date_d="十"..string.sub(date_d,4,#date_d)
        end
        end
        if num_d1>19 then date_d=string.sub(date_d,1,3).."十"..string.sub(date_d,4,#date_d) end
        date4=date_y..date_m..date_d
        yield(Candidate("date", seg.start, seg._end, date4, " "))
        ------------------------------------------------------------------------------------
        --英文日期
            local date_d=os.date("%d")
            local date_m=os.date("%m")
            local date_y=os.date("%Y")
            local date_m1=""
            local date_m2=""
            if date_m=="01" then 
               date_m1="Jan."
               date_m2="January"
            end
            if date_m=="02" then 
               date_m1="Feb."
               date_m2="February"
            end
            if date_m=="03" then 
               date_m1="Mar."
               date_m2="March"
            end
            if date_m=="04" then 
               date_m1="Apr."
               date_m2="April"
            end
            if date_m=="05" then 
               date_m1="May."
               date_m2="May"
            end
            if date_m=="06" then 
               date_m1="Jun."
               date_m2="June"
            end
            if date_m=="07" then 
               date_m1="Jul."
               date_m2="July"
            end
            if date_m=="08" then 
               date_m1="Aug."
               date_m2="August"
            end
            if date_m=="09" then 
               date_m1="Sept."
               date_m2="September"
            end
            if date_m=="10" then 
               date_m1="Oct."
               date_m2="October"
            end
            if date_m=="11" then 
               date_m1="Nov."
               date_m2="November"
            end
            if date_m=="12" then 
               date_m1="Dec."
               date_m2="December"
            end
        
             if date_d=="0" then 
               symbal="st" 
             elseif date_d=="1" then
               symbal="nd" 
             elseif date_d=="2" then 
               symbal="rd" 
             else
               symbal="th"
             end
        date5=date_m1.." "..date_d..symbal..", "..date_y
        date6=date_m2.." "..date_d..symbal..", "..date_y
        
        yield(Candidate("date", seg.start, seg._end, date5, " "))
        yield(Candidate("date", seg.start, seg._end, date6, " "))
        yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d"), " "))
    end

    if (input == "week") then
        local day_w=os.date("%w")
        local day_w1=""
        local day_w2=""
        local day_w3=""
        if day_w=="0" then 
            day_w1="星期日" 
            day_w2="Sunday" 
            day_w3="Sun." 
        end
        if day_w=="1" then
            day_w1="星期一" 
            day_w2="Monday" 
            day_w3="Mon." 
        end
        if day_w=="2" then
            day_w1="星期二" 
            day_w2="Tuesday" 
            day_w3="Tues." 
        end
        if day_w=="3" then 
            day_w1="星期三" 
            day_w2="Wednesday" 
            day_w3="Wed." 
        end
        if day_w=="4" then 
            day_w1="星期四" 
            day_w2="Thursday" 
            day_w3="Thur." 
        end
        if day_w=="5" then 
            day_w1="星期五"  
            day_w2="Friday" 
            day_w3="Fri." 
        end
        if day_w=="6" then 
            day_w1="星期六" 
            day_w2="Saturday" 
            day_w3="Sat." 
        end
        yield(Candidate("date", seg.start, seg._end, day_w1, " "))
        yield(Candidate("date", seg.start, seg._end, day_w2, " "))
        yield(Candidate("date", seg.start, seg._end, day_w3, " "))
        yield(Candidate("week", seg.start, seg._end, os.date("%w"),""))
    end
end
return translator