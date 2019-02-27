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

## makefile 

详细请查看makefile内容

## 修改记录：   
>2018.12.21      
*修改优化makefile   
>2019.02.11   
*修改makefile,将输出文件整理到output文件夹内    


## 不足之处
* 使用到的源文件(.c,.s)需要在makefile中“登记”，以前版本是编译文件夹内所有源文件，当前仅编译使用的文件，对未使用的不做编译
* 编译输出不能直接输出到output文件夹内，makefile中通过mv将输出文件移到output文件夹中（如有解决方案，欢迎来讨论）
 
## 编译：
	make
## stlink下载：
	make load
## 清除编译选项
	make clean
	
## 相关咨询，可加群一起学习讨论
QQ:81154350       备注:开源电子电路开发