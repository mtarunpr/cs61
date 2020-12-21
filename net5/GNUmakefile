DB_PROGRAMS = $(sort $(patsubst %.cc,%,$(wildcard weensydb-??.cc)))
PROGRAMS = wdbclient wdbclientloop wdbblaster $(DB_PROGRAMS)

all: $(PROGRAMS)

O = 2
PTHREAD = 1
include ../common/rules.mk
CXXFLAGS += -Wno-unused-result

%.o: %.cc $(BUILDSTAMP)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(DEPCFLAGS) $(O) -o $@ -c $<

%.noopt.o: %.cc $(BUILDSTAMP)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(DEPCFLAGS) -O0 -o $@ -c $<

%: %.o helpers.o
	$(CXX) $(CXXFLAGS) $(O) -o $@ $^ $(LDFLAGS) $(LIBS)


diffs.txt: always
	rm -f diffs.txt; last=; for i in $(patsubst %,%.cc,$(DB_PROGRAMS)); do if test -n "$$last"; then diff -u $$last $$i >>diffs.txt; fi; last="$$i"; done

clean:
	rm -f $(ALLPROGRAMS) *.o *.core data diffs.txt
	rm -rf $(DEPSDIR) *.dSYM

.PRECIOUS: %.noopt.o
.PHONY: all clean
