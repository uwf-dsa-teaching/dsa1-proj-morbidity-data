SHELL := /bin/bash
CXX = g++
CXXFLAGS = -g -std=c++14 -Wall -Werror=return-type -Werror=uninitialized -Wno-sign-compare
RM = rm -rf

TESTS = test-stats test-week test-state test-morbidity
CATCH = test/catch/catch.o

all: main $(TESTS)

main: main.o morbidity.o state.o stats.o week-data.o
	$(CXX) $(CXXFLAGS) -o $@ $^

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $<

$(CATCH): test/catch/catch.cpp
	$(CXX) $(CXXFLAGS) -o $@ -c $<

test-all: $(TESTS)

test-week: week-data.o $(CATCH) test/test-week.o
	$(CXX) $(CXXFLAGS) -o $@ $^
	./$@ --success

test-stats: stats.o week-data.o $(CATCH) test/test-stats.o
	$(CXX) $(CXXFLAGS) -o $@ $^
	./$@ --success

test-state: state.o week-data.o stats.o $(CATCH) test/test-state.o
	$(CXX) $(CXXFLAGS) -o $@ $^
	./$@ --success

test-morbidity: morbidity.o state.o week-data.o stats.o $(CATCH) test/test-morbidity.o
	$(CXX) $(CXXFLAGS) -o $@ $^
	./$@ --success

test-mem: test-state test-morbidity
	valgrind --leak-check=full --error-exitcode=1 ./test-state --success
	valgrind --leak-check=full --error-exitcode=1 ./test-morbidity --success

test-query1: main
	echo -e "data.csv\n1\nHawaii\n99" | ./main

test-query2: main
	echo -e "data.csv\n2\nFlorida\n99" | ./main

test-query3: main
	echo -e "foo.bar\ndata.csv\n3\n99" | ./main

test-run: main test-query1 test-query2 test-query3

clean:
	$(RM) *.dSYM test/*.dSYM *.o *.gc* $(CATCH) $(TESTS) test/*.o main

.PHONY: all main test-all test-week test-stats test-state test-morbidity test-query1 test-query2 test-query3 test-mem test-run clean

