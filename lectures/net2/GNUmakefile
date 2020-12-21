PROGRAMS = client server
all: $(PROGRAMS)

O = 2
WANT_TSAN = 1
include ../common/rules.mk
LDFLAGS := $(filter-out -no-pie,$(LDFLAGS))
LIBS := -lpthread
CXXFLAGS += -Wno-unused-result

%.o: %.cc $(BUILDSTAMP)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(DEPCFLAGS) $(O) -o $@ -c $<

%.noopt.o: %.cc $(BUILDSTAMP)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(DEPCFLAGS) -O0 -o $@ -c $<

%: %.o helpers.o
	$(CXX) $(CXXFLAGS) $(O) -o $@ $^ $(LDFLAGS) $(LIBS)


clean:
	rm -f $(PROGRAMS) *.o *.core
	rm -rf $(DEPSDIR) *.dSYM

.PRECIOUS: %.noopt.o
.PHONY: all clean
