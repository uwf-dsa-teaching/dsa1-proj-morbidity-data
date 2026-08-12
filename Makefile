CXX = g++
CXXFLAGS = -g -std=c++14 -Wall -Werror=return-type  \
			-Werror=uninitialized -Wno-sign-compare
TESTS = test-stats test-week test-state test-morbidity
CATCH = test/catch/catch.o
RM = rm -rf

main: main.o morbidity.o state.o stats.o week-data.o
	$(CXX) $(CXXFLAGS) -o $@ $^

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $<

test-all: $(TESTS)

test-week: week-data.o $(CATCH) test/test-week.o
test-stats: stats.o week-data.o $(CATCH) test/test-stats.o
test-state: state.o week-data.o stats.o $(CATCH) test/test-state.o
test-morbidity: morbidity.o state.o week-data.o stats.o $(CATCH) \
	test/test-morbidity.o

$(TESTS):
	$(CXX) $(CXXFLAGS) -o $@ $^
	./$@ --success

test-mem: test-state test-morbidity
	valgrind --leak-check=full --error-exitcode=1 ./test-state --success
	valgrind --leak-check=full --error-exitcode=1 ./test-morbidity --success

test-run: main
	./main < input.txt

clean:
	$(RM) *.dSYM test/*.dSYM *.o *.gc* $(CATCH) \
	$(TESTS) test/*.o main
