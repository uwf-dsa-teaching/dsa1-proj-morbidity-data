#include <sstream>

#include "../state.hpp"
#include "catch/catch.hpp"

TEST_CASE("Testing State class on calculation") {
  State bama("Alabama");
  CHECK("Alabama" == bama.getName());

  bama.addWeek("2020-05-02,1000");
  bama.addWeek("2020-05-09,1020");
  bama.addWeek("2020-05-16,1170");
  bama.addWeek("2020-05-23,1010");
  bama.addWeek("2020-05-30,1030");
  bama.addWeek("2020-06-06,1080");

  CHECK(Approx(1051.66).epsilon(0.001) == bama.getMeanDeaths());

  CHECK(Approx(58.71).epsilon(0.001) == bama.getStDev());

  CHECK(1 == bama.getOutlierCount());
  auto outliers = bama.getOutlierInfos();
  CHECK("2020-05-16 - total deaths: 1170" == outliers.at(0));
}

TEST_CASE("Testing State class on rule of three") {
  State bama("Alabama");
  CHECK("Alabama" == bama.getName());
  State bama1(bama);
  CHECK("Alabama" == bama1.getName());
  State bama2;
  bama2 = bama;
  CHECK("Alabama" == bama2.getName());
}
