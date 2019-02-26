TARGET:=Pump_Mix


CC=arm-none-eabi-gcc
OBJCOPY=arm-none-eabi-objcopy
AS=arm-none-eabi-as
AR=arm-none-eabi-ar
GDB=arm-none-eabi-gdb
SIZE=arm-none-eabi-size  #打印生成文件大小

#选择链接文件==========================================这里需要修改，在ld文件夹中选你要的ld文件
LINK_FILE:=./lib/ld/stm32_flash128k_ram20k.ld

#使用到的头文件路径
INCLUDE =  -I ./lib/cmsis
INCLUDE += -I ./lib
INCLUDE += -I ./lib/inc
INCLUDE += -I ./usr

#扫描包含的源文件文件文件夹，全部都要加入，否则无法找到文件
#.c文件路径
vpath %.c ./lib/src
vpath %.c ./lib/cmsis
vpath %.c ./lib
vpath %.c ./usr
#.s文件路径
vpath %.s ./lib/startup

#汇编源文件添加=========================================这里需要修改，在startup文件夹内找相应的启动文件
#.s文件
OBJS_S = startup_stm32f10x_md.s

#.c文件
OBJS_C += core_cm3.c
OBJS_C += system_stm32f10x.c
#st库源文件添加
#OBJS_C += stm32f10x_gpio.c
#OBJS_C += stm32f10x_rcc.c

#用户源文件添加==========================================个人的源文件在这里添加
OBJS_C += main.c
OBJS_C += stm32f10x_gpio.c
OBJS_C += stm32f10x_rcc.c

#所有目标.o 链接时调用。不需要修改
OBJS =  $(OBJS_C:%.c=%.o) 
OBJS += $(OBJS_S:%.s=%.o)

#c语言编译选项
CDEFS =  -DSTM32F10X_MD  #=================================这里需要修改，根据实际而定
CDEFS += -DUSE_STDPERIPH_DRIVER
MCUFLAGS= -c -mcpu=cortex-m3 -mthumb -mtune=cortex-m3  #stm32编译选项
COMMONFLAGS=-O1 -g -Wall -Werror #OPTLVL:=1 #编译优化级别 O[0, 1, 2, 3, s]

ASFLAGS=-mcpu=cortex-m3 -gdwarf-2 #汇编编译参数
CFLAGS=$(COMMONFLAGS) $(MCUFLAGS) $(CDEFS) $(INCLUDE) #gcc编译参数
LDFLAGS=$(COMMONFLAGS) -fno-exceptions -ffunction-sections -fdata-sections \
        -nostartfiles -Wl,--gc-sections,-T$(LINK_FILE)#链接编译参数


#目标输出文件
$(TARGET): ELF
	$(OBJCOPY) -O ihex   $(TARGET).elf $(TARGET).hex
	$(OBJCOPY) -O binary $(TARGET).elf $(TARGET).bin
	#printf size of the target
	$(SIZE) -B $(TARGET).hex  
	mv *.o ./output
	mv *.elf ./output
	mv *.bin ./output
	mv *.hex ./output

#编译所有.c文件
objs_o: $(OBJS_C)
	$(CC) $(CFLAGS) $(INCLUDE) $^ 
#编译所有.s文件
objs_s: $(OBJS_S)
	$(AS) $(ASFLAGS) $(INCLUDE) $^ 
#链接所有.o文件
ELF: $(OBJS)
	$(CC) $(INCLUDE) -o $(TARGET).elf $(LDFLAGS) $^ 

#防止冲突用的
.PHONY: clean load

clean:
	rm -f ./output/*.o
	rm -f ./output/*.elf
#	rm -f ./output/*.hex
#	rm -f ./output/*.bin

load: ./output/$(TARGET).bin
# 使用st-link下载	
	st-flash write $^ 0x08000000



