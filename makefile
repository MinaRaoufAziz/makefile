cc = gcc

src_path = ./Src
inc_path = ./Inc
dep_path = .\Dependencies

src_files = $(subst $(src_path)/,,$(wildcard $(src_path)/*.c))
obj_files1 = $(src_files:.c=.o)
obj_files2 = Rizk_MinaRaouf_Wael_Khaled.o
dep_files = $(src_files:.c=.d)
dep_files2 = $(addprefix $(dep_path)\,$(dep_files))
link_target = app.exe
clean_files = $(obj_files1) $(link_target) 

vpath %.c ./src
vpath %.h ./Inc

# print for debugging
print-%  :
	@echo $* = $($*)

# remove compilation products

clean :
	-rm -f *.o $(clean_files)


# compile
%.o : %.c
	$(cc) -c -I$(inc_path) $< -o $@


# link
$(link_target) : $(obj_files1) $(obj_files2) #$(dep_files2)
	$(cc) $^ -o $@

all : $(link_target)