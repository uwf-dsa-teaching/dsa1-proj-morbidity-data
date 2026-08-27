#include <sstream>

#include "../week-data.hpp"
#include "catch/catch.hpp"

TEST_CASE("Testing default constructor") {
  WeekData w;
  CHECK("0000-00-00 - total deaths: 0" == w.info());
}

TEST_CASE("Testing parsing constructor") {
  WeekData w("2020-05-16,1132");
  CHECK("2020-05-16 - total deaths: 1132" == w.info());
}
