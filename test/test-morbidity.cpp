#include <string>
#include "catch/catch.hpp"
#include "../morbidity.hpp"

const std::string INVALID_STATE = "foo";

TEST_CASE("Testing Morbidity class")
{
	Morbidity dataset;
	CHECK(!dataset.load("foo.bar"));
	CHECK(dataset.load("data.csv"));

	CHECK(Approx(-1.0) == dataset.getMean(INVALID_STATE));
	CHECK(Approx(1036.78).epsilon(0.01) == dataset.getMean("Alabama"));
	CHECK(Approx(81.17).epsilon(0.01) == dataset.getMean("Alaska"));

	CHECK(16 == dataset.getStateOutlierCount("Alabama"));
	auto outliers = dataset.getStateOutliers("Alabama");
	CHECK("2020-07-25 - total deaths: 1333" == outliers.at(0));
	CHECK("2021-02-06 - total deaths: 1503" == outliers.at(12));

	CHECK_THAT(dataset.getOutlierInfoForAllStates(), Catch::Contains("West Virginia: 19"));
}
