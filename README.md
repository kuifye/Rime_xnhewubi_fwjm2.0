# Rime_xnhewubi_fwjm2.0
在之前版本的基础上，去除了ch到e的映射，增加了映射了y到e映射，压力分布更均衡。
# xnhewubi_feijian

*rime-feijian

*本地词库，无安全隐患。

*高度客制化，自定映射。

*搭载明月词库为基础的小鹤双拼副翻译器。

*直接辅助码。

## 小鹤五笔音形输入法-对侧飞键版

### 简单介绍（introduce）：

  小鹤音码配合五笔形码辅助码、小鹤五笔zh/sh/y对侧击键飞键版，赛码器表现下，击键当量等同五笔，键长等同于小鹤音形。
  
  对侧击键率51%、码长2.20。

  需要特殊记忆的编码如下：

    现：xg 实：up 仅：jw 字：zp 及：je 种：ot 任：rw 妹：mv 为：wy 和：ht 网：wm 子：zb 阿：ab 时：uj 物：wt
  
  使用逗号、句号进行次选、三选。

### 飞键映射（map）：

    /shi-us/feng-fs/  (增加s按键频率)

    /ang-am/ao-ac/

    /eng-am/ei-ew/

    /右韵母zh-v/左韵母sh-u/左韵母y-y/  (同原版小鹤一致)

     /左韵母zh-o/右韵母sh-a/右韵母y-e/  (对侧映射)
   
   辅助码映射：
   
       礻：pu → pz    犭：qt → qo   言：y → ;
  
### 特点:

  优点：不需要特殊学习，会五笔和小鹤即可使用，难度不算高。
  
  兼容整句及打单，使用范围广。
  
  拆分了zh/sh/y等易导致双拼uiy高频率的声母，对五笔的部首进行了重映射，使得按键热力图比一般双拼更合理。
  
  # 击键当量(value):
  
![image](https://user-images.githubusercontent.com/49089769/232679706-c4ecd0b3-b317-4dec-a2d8-ea96b09d9592.png)

![image](https://user-images.githubusercontent.com/49089769/232679743-581b6f8b-ecce-4afd-bd04-49c01c678a1c.png)

### 关于热力图(hot-map):

*赛码器的一个算法会导致逗号不被按下，而被算入按键编码，因此这是去除了简码表内的逗号编码后的结果。

*显示缺少汉字是因为只包含了txt内的汉字码表，全码表在dict.yaml文件内，由于dict.ymal使用的是正则规则，容易导致显显示码长高于正常情况，没有放入赛码器内。

*部分一简码（如花，编码为h;）使用分号选重，会导致重码率偏高，而分号按键当量偏低。

*音码码表和形码码表不同，赛码器内各项显示数值会偏高。

*测试优化仅仅是同时添加了对应的简体并去除了多余的标点，没有做额外的改动。

### 如何使用该输入法(install):

  *下载[Rime-小狼毫](https://github.com/rime/squirrel/releases)，安装后右键点击【ㄓ】进入用户文件夹，将该方案置入小狼豪用户文件夹内。
  
  ![image](https://user-images.githubusercontent.com/49089769/231263797-801e79b0-7b3c-45e2-91eb-1d2d60a750c7.png)

  右击【ㄓ】选择输入法设定，勾选该方案，即可使用。

  默认为简体，通过快捷键 Control+ J 切换繁简。

  输入 分号 ; 呼出五笔及拆字模式（例：;lslsls = 龘），obhelp 呼出飞键提示，obinfo呼出更多信息。
    
*五笔：
  
![image](https://user-images.githubusercontent.com/49089769/232719730-3243ea42-d32f-40ec-90cd-8737134c806f.png)


*拆字：
  
![image](https://user-images.githubusercontent.com/49089769/232719671-c5a34b76-878c-42c9-808c-02973ba9e4a3.png)
  
  ![image](https://user-images.githubusercontent.com/49089769/231264822-8e3b34b9-d0cc-4f22-acad-4e1b29d6801a.png)

  


