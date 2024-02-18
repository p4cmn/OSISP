СС := gcc
CDEBUGFLAGS := -std=c11 -g2 -ggdb -pedantic -W -Wall -Wextra 
CFLAGS := -std=c11 -pedantic -W -Wall -Wextra -Werror

TARGET := program
SOURCEDIR := source
BUILDDIR := build
DEBUGDIR := $(BUILDDIR)/debug
RELEASEDIR := $(BUILDDIR)/release

SOURCES := $(wildcard $(SOURCEDIR)/*.c)
OBJECTS_DEBUG := $(patsubst $(SOURCEDIR)/%.c,$(DEBUGDIR)/%.o,$(SOURCES))
OBJECTS_RELEASE := $(patsubst $(SOURCEDIR)/%.c,$(RELEASEDIR)/%.o,$(SOURCES))
DEBUGTARGET := $(DEBUGDIR)/$(TARGET)
RELEASETARGET := $(RELEASEDIR)/$(TARGET)

.DEFAULT_GOAL := all
all: debug release
debug: $(DEBUGTARGET)
release: $(RELEASETARGET)

$(DEBUGTARGET): $(OBJECTS_DEBUG)
	@$(CC) $(CDEBUGFLAGS) -o $@ $^

$(RELEASETARGET): $(OBJECTS_RELEASE)
	@$(CC) $(CFLAGS) -MMD -o $@ $^

$(DEBUGDIR)/%.o: $(SOURCEDIR)/%.c
	@$(CC) $(CDEBUGFLAGS) -c -o $@ $<

$(RELEASEDIR)/%.o: $(SOURCEDIR)/%.c
	@$(CC) $(CFLAGS) -MMD -c -o $@ $<

# Очистка
clean:
	@rm -rf $(DEBUGDIR)/*.o $(DEBUGTARGET) $(RELEASEDIR)/*.o $(RELEASETARGET)

.PHONY: all debug release clean

include $(wildcard *.d)






