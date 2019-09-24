# output binary
BIN := App.exe

src_path = ./Src
inc_path = ./Inc
dep_path = ./Dependencies

# source files
SRCS = $(subst $(src_path)/,,$(wildcard $(src_path)/*.c))

# files included in the tarball generated by 'make dist' (e.g. add LICENSE file)
DISTFILES := $(BIN)

# intermediate directory for generated object files
OBJDIR = ./Obj
# intermediate directory for generated dependency files
DEPDIR := ./Dependencies

# object files, auto generated from source files
#OBJS := $(patsubst %,$(OBJDIR)/%.o,$(basename $(SRCS)))
OBJS = $(SRCS:.c=.o)
OBJS2 = Rizk_MinaRaouf_Wael_Khaled.o
# dependency files, auto generated from source files
DEPS := $(patsubst %,$(DEPDIR)/%.d,$(basename $(SRCS)))

dep_files = $(src_files:.c=.d)
dep_files2 = $(addprefix $(DEPDIR)/,$(dep_files))



vpath %.c ./src

# print for debugging
print-%  :
	@echo $* = $($*)

# C compiler
CC := gcc

# linker
LD := gcc


# C flags
CFLAGS := -std=c11
# C/C++ flags
CPPFLAGS := -g -Wall -Wextra -pedantic
# linker flags
LDFLAGS :=
# flags required for dependency generation; passed to compilers
DEPFLAGS = -MT $@ -MD -MP -MF $(DEPDIR)/$*.d

# compile C source files
COMPILE.c = $(CC) $(DEPFLAGS) $(CFLAGS) -c -I$(inc_path) $< -o $@ 
# link object files to binary
LINK.o = $(LD) $(LDFLAGS) $(LDLIBS) -o $@


all : $(BIN)

.PHONY: clean
clean:
	$(RM) -r $(OBJS) $(DEPS) $(BIN)

$(BIN) : $(OBJS) $(OBJS2)
	$(LINK.o) $^

%.o : %.c
%.o : %.c $(DEPDIR)/%.d
	$(CC) $(DEPFLAGS) $(CFLAGS) -c -I$(inc_path) $< -o $@  



.PRECIOUS = $(DEPDIR)/%.d
$(DEPDIR)/%.d: ;

-include $(DEPS)