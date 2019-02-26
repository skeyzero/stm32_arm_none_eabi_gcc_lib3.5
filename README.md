# stm32 工程  包含 Lib3.5官方库

## 环境参数
* linux
* arm-none-eabi-gcc
* stm32 Lib3.5

## 目录结构
>makefile    
>>usr ---- 用户源文件头文件存放地方    
>>output ---- 编译输出    
>>lib ---包含启动文件，函数库等   

## 使用方法    
* 拷贝工程，放在个人工作目录即可     

## makefile 详细说明



### 修改记录：   
>2018.12.21      
*修改优化makefile   
>2019.02.11   
*修改makefile,将输出文件整理到output文件夹内    
 
# 编译：
	make
# stlink下载：
	make load
# 清除编译选项
	make clean