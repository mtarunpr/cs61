BASEPROGRAMS = incr-basic \
	incr-volatile incr-atomic incr-mutex \
	incr-trymutex incr-spinlock
PROGRAMS = $(BASEPROGRAMS) incr-basic-O0
all: $(PROGRAMS)

variants = $(1) $(addsuffix -unsafe,$(1)) $(addsuffix -O0,$(1))

O ?= 3
PTHREAD = 1
include ../common/rules.mk

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


diffs.txt: always
	rm -f diffs.txt; last=; for i in $(patsubst %,%.cc,$(DB_PROGRAMS)); do if test -n "$$last"; then diff -u $$last $$i >>diffs.txt; fi; last="$$i"; done

clean:
	rm -f $(call variants,$(BASEPROGRAMS)) *.o *.core data diffs.txt
	rm -rf $(DEPSDIR) *.dSYM

.PHONY: all clean
.PRECIOUS: %-O0.o %-O1.o %-unsafe.o
