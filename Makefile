## Name of Project

NAME = executable_file

## Color for compilating (pink)

COLOR = \0033[1;35m

## List of Directories

INC_DIR = inc
OBJ_DIR = obj
SRC_DIR = src

# Add dirs here

TEMPLATE_DIR = template_dir

## Compilating Utilities

FAST = -Ofast

# DEBUG = -g3 -fsanitize=address

FLAGS = -Wall -Wextra -Werror $(FAST) #$(DEBUG) -D_REENTRANT

INC = $(INC_DIR:%=-I./%)

CC = clang $(FLAGS) $(INC)

## List of Headers and C files 

INC_H = template_header

TEMPLATE_FT = template_file

SRC_FT = main

## List of Utilities

SRC = $(SRC_FT:%=$(SRC_DIR)/%.c) \
	$(TEMPLATE_FT:%=$(SRC_DIR)/$(TEMPLATE_DIR)/%.c)

OBJ = $(SRC:$(SRC_DIR)%.c=$(OBJ_DIR)%.o)

OBJ_DIRS = $(OBJ_DIR) \
	$(TEMPLATE_DIR:%=$(OBJ_DIR)/%)

INCLUDES = $(INC_H:%=./$(INC_DIR)/%.h)

## Rules of Makefile

all: $(NAME)
	@echo "$(COLOR)$(NAME) \033[100D\033[40C\0033[1;30m[All OK]\0033[1;37m"

$(OBJ_DIRS):
	@mkdir -p $@
	@echo "$(COLOR)$@ \033[100D\033[40C\0033[1;32m[Created]\0033[1;37m"
	@#@echo "$(COLOR)Creating :\t\0033[0;32m$@\0033[1;37m"

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c $(INCLUDES)
	@$(CC) -c $< -o $@
	@echo "$(COLOR)$(@:$(OBJ_DIR)/%=%) \033[100D\033[40C\0033[1;32m[Compiled]\0033[1;37m"

$(NAME): $(OBJ_DIRS) $(SRC) $(INCLUDES)
	@$(MAKE) -j $(OBJ)
	@echo "$(COLOR)Objects \033[100D\033[40C\0033[1;32m[Created]\0033[1;37m"
	@$(CC) $(OBJ) -o $@
	@echo "$(COLOR)$(NAME) \033[100D\033[40C\0033[1;32m[Created]\0033[1;37m"

clean:
	@rm -rf $(OBJ_DIR)
	@echo "$(COLOR)Objects \033[100D\033[40C\0033[1;31m[Removed]\0033[1;37m"

fclean: clean
	@rm -f $(NAME)
	@echo "$(COLOR)$(NAME) \033[100D\033[40C\0033[1;31m[Removed]\0033[1;37m"

re: fclean all

define print_random_fortune
	@i=$$((RANDOM % 6));\
	if [ $${i} = "0" ] ; \
	then \
	f="\"Any excuse will serve a tyrant.\"\n\t\t-- Aesop" ; \
	elif [ $${i} = "1" ] ; \
	then \
	f="Women complain about sex more than men.  Their gripes fall into two\n\
	categories: (1) Not enough and (2) Too much.\n\
	\t\t-- Ann Landers" ; \
	elif [ $${i} = "2" ] ; \
	then \
	f="You are a bundle of energy, always on the go." ; \
	elif [ $${i} = "3" ] ; \
	then \
	f="Suffering alone exists, none who suffer;\n\
	The deed there is, but no doer thereof;\n\
	Nirvana is, but no one is seeking it;\n\
	The Path there is, but none who travel it.\n\
	\t\t-- \"Buddhist Symbolism\", Symbols and Values" ; \
	elif [ $${i} = "4" ] ; \
	then \
	f="The girl who remembers her first kiss now has a daughter who can't even\n\
	remember her first husband." ; \
	else \
	f="I have nothing to tell you" ; \
	fi ; \
	echo "\0033[1;37m$${f}\0033[1;37m"
endef

define print_aligned_coffee
	@t=$(NAME); \
	l=$${#t};\
	i=$$((8 - l / 2));\
	echo "\0033[1;32m\033[3C\033[$${i}CAnd Your program \"$(NAME)\"\0033[1;37m"
endef

coffee: all clean
	@echo ""
	@echo "                    {"
	@echo "                 {   }"
	@echo "                  }\0033[1;34m_\0033[1;37m{ \0033[1;34m__\0033[1;37m{"
	@echo "               \0033[1;34m.-\0033[1;37m{   }   }\0033[1;34m-."
	@echo "              \0033[1;34m(   \0033[1;37m}     {   \0033[1;34m)"
	@echo "              \0033[1;34m| -.._____..- |"
	@echo "              |             ;--."
	@echo "              |            (__  \ "
	@echo "              |             | )  )"
	@echo "              |   \0033[1;96mCOFFEE \0033[1;34m   |/  / "
	@echo "              |             /  / "
	@echo "              |            (  / "
	@echo "              \             | "
	@echo "                -.._____..- "
	@echo ""
	@echo ""
	@echo "\0033[1;32m\033[3C          Take Your Coffee"
	$(call print_aligned_coffee)
	@echo ""
	$(call print_random_fortune)

.PHONY: all clean fclean re coffee