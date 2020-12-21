BASEPROGRAMS = server-select wdbblaster server-epoll
PROGRAMS = $(BASEPROGRAMS)
all: $(PROGRAMS)

variants = $(1) $(addsuffix -unsafe,$(1)) $(addsuffix -O0,$(1))

O ?= 3
PTHREAD = 1
include ../common/rules.mk
LDFLAGS := $(filter-out -no-pie,$(LDFLAGS))
LIBS := -lpthread
CXXFLAGS += -Wno-unused-result

UNSAFEFLAGS := -U_FORTIFY_SOURCE -fno-stack-protector $(if $(ISLINUX),-no-pie,)

%.o: %.cc $(BUILDSTAMP)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(O) $(DEPCFLAGS) -o $@ -c $<

%-unsafe.o: %.cc $(BUILDSTAMP)
	$(CXX) $(CPPFLAGS) $(UNSAFEFLAGS) $(CXXFLAGS) -O1 $(DEPCFLAGS) -o $@ -c $<

%-O0.o: %.cc $(BUILDSTAMP)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -O0 $(DEPCFLAGS) -o $@ -c $<

%-O1.o: %.cc $(BUILDSTAMP)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -O1 $(DEPCFLAGS) -o $@ -c $<


$(BASEPROGRAMS): %: %.o helpers.o
	$(CXX) $(CXXFLAGS) $(LDFLAGS) $(O) -o $@ $^

$(addsuffix -O0,$(BASEPROGRAMS)): %: %.o helpers-O0.o
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -O0 -o $@ $^

$(addsuffix -unsafe,$(BASEPROGRAMS)): %: %.o helpers-unsafe.o
	$(CXX) $(CXXFLAGS) $(UNSAFEFLAGS) $(LDFLAGS) -O1 -o $@ $^



clean:
	rm -f $(call variants,$(BASEPROGRAMS)) *.o *.core
	rm -rf $(DEPSDIR) *.dSYM

.PHONY: all clean
.PRECIOUS: %-O0.o %-O1.o %-unsafe.o
