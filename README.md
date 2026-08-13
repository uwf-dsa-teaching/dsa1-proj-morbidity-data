# Project 1 Morbidity Data Analysis

## Project Outcomes:
Develop a C++ program that uses:
- File input
- String parsing/generation (istringstream)
- Make, makefile and modular design
- Dynamic array (C array) allocation/management
- Basic statistical calculations

### Project Objective:
We'll be using the above statistical functions on a set of input data to
identify unusual morbidity data reports grouped by state. The data from the CDC
was sourced
[here](https://data.cdc.gov/NCHS/Weekly-Counts-of-Deaths-by-State-and-Select-Causes/muzy-jte6)
and
[here](https://data.cdc.gov/NCHS/Weekly-Counts-of-Deaths-by-State-and-Select-Causes/3yf8-kanr).

## Project Overview:
Data-driven apps are garnering a lot of attention in the modern world. The data
I/O component and the data analysis component are two essential parts of a
typical data-driven application.

The data I/O component concentrates on the methods for loading the data and
producing the output. To load from and save to the same data persistance module
is one solution. One of the most straightforward methods for data persistence
is based on file I/O on CSV (comma-separated values) files.

The data analysis component makes an effort to identify trends in the data and
produce insightful reports. Data analysis can be performed using statistical
functions or more complicated machine learning models. We will focus on
statistical functions here.

In this project, we will develop an app to load a real-world morbidity database
from a CSV file and allow user to query statistical metrics for data analysis
purposes.

### Statistical functions:
#### Mean:
The average, denoted **&mu;**, of a data set is usually referred to as the
*mean* of the data. For a data set `1, 2, 3, 5, 6`, the mean of that set is the
sum of all the data divided by the number of data points. e\.g\.

<img src="https://latex.codecogs.com/png.image?\dpi{110}&space;\bg_white&space;\frac{1&plus;2&plus;3&plus;5&plus;6}{5}=3.4" title="average" />

#### Standard Deviation:
Standard deviation, often denoted **&sigma;** is an important statistical
metric to represent variation of a set of observations (data). It is calculated
as follows:

<img src="https://latex.codecogs.com/png.image?\dpi{110}&space;\bg_white&space;\sigma=\sqrt{\frac{\Sigma\(x_{i}-\mu\)^{2}}{N}}" title="standard deviation formula" />

`N` is the number of data points in the set (referred to in statistics as a
_population_). Thus, for the sample data set `1, 2, 3, 5, 6`, the mean
calculated above is 3.4. Plugging in for &sigma;, we'd get

<img src="https://res.cloudinary.com/dm3fdmzec/image/upload/v1597336594/stdev.png" alt="Standard deviation example" width=600 />

One important application of the standard deviation metric is to **identify
abnormal observations, outliers**. An outlier is an observation that are not
following the general trend of the data. In some convention, an observation
(data point) that is more than two standard deviations from the mean is
considered an outlier. Outliers are usually improperly measured, or unexpected
data points.

### Project Requirements:
Your application must function as described below:
1. In order to ensure that your statistical calculations are correct, your
   program must pass all of the given tests in the cpp files in the
   [test](test/) directory.
    1. The test suites are:
        1. [test-week](test/test-week.cpp) - This tests the object used to
        store the data for a given week.
        1. [test-stats](test/test-stats.cpp) - This tests the static methods
        needed to do the necessary calculations.
        1. [test-state](test-state.cpp) - This tests the object used to store
        the data for a given state.
        1. [test-morbidity](test/test-morbidity.cpp) - This tests your file
        reading functions and is essentially an integration test. Once it
        is running, you are ready to build the main program (which should
        at that point be rather trivial).
    1. Must able to pass all tests with `make test-all`.
1. Must be able to compile a main executable using the command  `make main`.
1. Must be able to run your program using `./main` after it is compiled.
1. You can run `make test-run` to run main through pre-made inputs to reproduce
   the sample run.
1. Running the main program should prompt a user for the input file name. If
   the input file is not present, **Unable to read input file** should be
   displayed and the user should be prompted again to enter a valid
   file name.
1. Once the file has been loaded, your program should offer the ability to
   query for the following outputs:
    1. All-time average (mean) of a given state.
    1. List of weeks that are statistical outliers of a given state.
    1. List all states and their respective count of outlier weeks, whose death
       count are more than two standard deviations from the mean.
1. You will lose points on memory leaks.

## Code Organization:
Read the [Makefile](Makefile) for files required in this project. Hint: A .o
files required in the Makefile means a corresponding cpp file.

Read the tests in the cpp files in the [test](test/) directory for the expected
usages of all classes and functions.

### Classes:
Read this [document](https://plantuml.com/class-diagram) for
more information about the syntax of class diagrams (PlantUML style).

+ The stats library (not a class!)

  Two statistical functions to calculate the mean and standard deviation of
  deaths out of an array of WeekData objects.

    - ``double getMean(WeekData *weeks, int count);``
    - ``double stDev(WeekData *weeks, int count);``

+ The WeekData class

![UML of Week class](http://www.plantuml.com/plantuml/png/SoWkIImgAStDuKhEIImkLWXFJSrsIIn9LAZcqbKeBacniYekAShCIrT8IIn91GfbvfKefAGcbcGuvvVcbN1fmpLeQ29palFpYajGzAjbvWM3MK1rO5FIKqjSu0PfQ2g0jG3ba3G1rQNbmwLgkHnIyrA0JWK0)


```
class WeekData {
- std::string date
- int deathCount
+ WeekData()
+ WeekData(const std::string &inString)
+ int getDeathCount() const
+ std::string info() const
}
```

+ The State class

    - You can allocate **500** as the size for the ``weeks`` array.

![UML of State class](http://www.plantuml.com/plantuml/png/RO-zJWCn48JxUugj8dx42qI08d4D1GGf1VNcl4aix5taNLyA1C-EdQ0xW-X6ytbcrYirJ9PZw8Q0gh0nD8AFxWRKt7AfbZplWJ5IiLw9tdeql89ZKLeSpmQSuvRIUbV9YnH7k-jppyNbfFwspMGGLZlh1QI3JcG1yau9JTBTlu--vessVK_sZB7uS0eLEeftWCxLytyTSlpvJwrmahU1Qlg9a7j2EsZJCUEDzJGsnBDLUvqjU4eFajaQUfeRQJ19jytqVHDvv9tCKv_TYjZb6Bu1)

```
class State {
- std::string name
- WeekData* weeks
- int numberOfDataPoints
+ State()
+ State(std::string name)
+ State(const State& rhs)
+ State& operator=(const State& rhs)
+ ~State()
+ std::string getName() const
+ void addWeek(std::string weekData)
+ double getMeanDeaths() const
+ double getStDev() const
+ int getOutlierCount() const
+ std::vector<std::string> getOutlierInfos() const
}
```

+ The Morbidity class

    - The ``states`` instance variable is a **one dimension array of pointers**
      to the objects rather than a two dimensional array of the objects! You
      can assume that there be at most **65** states and allocate the array
      using this size.
    - The ``load()`` method should return false on a file that cannot be
      opened.

![UML of Morbidity class](http://www.plantuml.com/plantuml/png/bP3DIiKm48NtVOfPIRtY2rn4AeBWedRX4oJDj0GcCv2P22Bwx3QfuWyklBlCdEyx2HdKNBQIg9l9gS8esSSGxHbUkak8RC0bUSpJycZEKBTbEy3XeFlYuilfpxVfxUVeHGX8NEXdOJLG2yUZMewymjaI2Tabh62GuWbXHHlHyLzqk_2Xuj3IJOfirMXFcefHn7mhXUsVUikVS3R9Lz_Owz-TUahVdjUA3_kU5xcJV4Eq_s7_ARns0t8eYTu1)

```
class Morbidity {
- int numberOfStates
- State **states
+ Morbidity()
+ ~Morbidity()
+ bool load(const std::string &filename)
+ double getMean(const std::string &stateName) const
+ int getStateOutlierCount(const std::string &stateName) const
+ std::vector<std::string> getStateOutliers(const std::string &stateName) const
+ std::string getOutlierInfoForAllStates() const
}
```

### Sample data:

The data will be in the following format. For this project, it is safe assume
the data is properly formatted, that is exactly 3 columns will be present in
each row of data.

    State,Week Ending Date,All Cause
    Florida,2014-01-04,2101
    Florida,2014-01-11,3877
    Florida,2014-01-18,3800

There is a data.csv file provided in the repository. You can test your code on
it. It is suggested to make a smaller data file with some representative data
in it in testing or debugging processes.

### Sample Run:
<pre><code>
Welcome to the data viewer!
Enter the file name with the morbidity data: <b>foo.bar</b>
Unable to read input file!
Enter the file name with the morbidity data: <b>data.csv</b>
    1 - Output the mean for a state
    2 - Get a list of outliers for a state
    3 - List all states with outlier counts
    anything other than 1-3 will end the application.
Please choose an option from the above menu: <b>1</b>
Enter the name of the state to search: <b>Texas</b>
-------------------------
The mean deaths for Texas is 4000.91
-------------------------
    1 - Output the mean for a state
    2 - Get a list of outliers for a state
    3 - List all states with outlier counts
    anything other than 1-3 will end the application.
Please choose an option from the above menu: <b>2</b>
Enter the name of the state to search: <b>North Carolina</b>
-------------------------
Statistical outliers for North Carolina
    2020-12-19 - total deaths: 2588
    2020-12-26 - total deaths: 2670
    2021-01-02 - total deaths: 2837
    <b>... Sample output truncated for brevity</b>
    2021-07-24 - total deaths: 495
    2021-07-31 - total deaths: 434
    2021-08-07 - total deaths: 319
-------------------------
    1 - Output the mean for a state
    2 - Get a list of outliers for a state
    3 - List all states with outlier counts
    anything other than 1-3 will end the application.
Please choose an option from the above menu: <b>3</b>
-------------------------
    Alabama: 16 outlying weeks
    Alaska: 18 outlying weeks
    <b>... Sample output truncated for brevity</b>
    Wisconsin: 14 outlying weeks
    Wyoming: 18 outlying weeks
-------------------------
   1 - Output the mean for a state
   2 - Get a list of outliers for a state
   3 - List all states with outlier counts
   anything other than 1-3 will end the application.
Please choose an option from the above menu: <b>9999</b>
</code> </pre>

## Building and Testing

A `Makefile` is provided to automate compilation and testing:
- **Compile main program**: `make main`
- **Run interactive query tests**:
  - `make test-query1`: Runs Hawaii mortality mean query test.
  - `make test-query2`: Runs Florida death outliers query test.
  - `make test-query3`: Runs all states summary query test.
  - `make test-run`: Runs all query tests.
- **Run unit tests**: `make test-all`
- **Run individual unit tests**:
  - `make test-week`: WeekData class unit tests.
  - `make test-stats`: Statistics engine unit tests.
  - `make test-state`: State class unit tests.
  - `make test-morbidity`: Morbidity database unit tests.
- **Run memory leak check**: `make test-mem` (runs Valgrind on test-state and test-morbidity).
- **Clean build artifacts**: `make clean`

> **Note for macOS / Xcode users**: Valgrind is not natively supported on macOS. If you are using macOS command line tools (Xcode), you cannot directly execute `valgrind` / `make test-mem` locally. Please launch a **GitHub Codespaces** instance on GitHub (or use a Linux container) to run memory leak checks.

## Important Notes:
- Projects will be graded on whether they correctly solve the problem, and
  whether they adhere to good programming practices.
- Projects must be received by the time specified on the due date. Projects
  received after that time will get a penalty or zero.
- Never change the test files! The results you get will be pointless as they
  will not align with our grading.
- Never change the makefile unless you are asked to do so
- Please review the academic honesty policy.
  - Note that viewing another student's solution, whether in whole or in part,
    is considered academic dishonesty.
  - Also note that submitting code obtained through the Internet or other
    sources, whether in whole or in part, is considered academic dishonesty.
    **All programs submitted will be reviewed for evidence of academic
    dishonesty, and all violations will be handled accordingly**.

### Submission Requirements:
1. All code must be added and committed to your local git repository.
2. All code must be pushed to the GitHub repository created when you "accepted"
   the assignment.
   1. After pushing, with `git push origin main`, visit the web URL of your
   repository to verify that your code is there. If you don't see the code
   there, then we can't see it either.
3. Your code must compile and run. The auto-grading tests will indicate your score for your submission.
   1. The auto-grading build should begin automatically when you push your code
      to GitHub.
   2. If your program will not compile, the graders will not be responsible for
      trying to test it.
   3. You should get an email regarding the status of your build, if it does
      not pass, keep trying.
4. **Never remove provided files!** Some data file and input files are
   essential in testing and autograding.

## Grading Information:
- Breakdown
  + 90 pts GitHub Auto-grading
    * 10 pts test-week
    * 10 pts test-stats
    * 10 pts test-state
    * 10 pts test-morbidity
    * 10 pts query Hawaii mean
    * 10 pts query Florida for outliers
    * 10 pts list all states for outlying counts
    * 20 pts memory leak check
  + 10 pts Code style

## Checking Auto-grading Results:

After you push your code, GitHub will automatically run tests on your
submission. To view the results:

1. On your GitHub repository page, click the :arrow_forward: **Actions** tab at
   the top
2. Click on the most recent workflow run (it will show your commit message)
3. Wait until the run finishes (showing either ✅ or ❌)
4. Scroll down to "Autograding summary" section to see the summary
5. It will display:
   - **Points:** Your score (e.g., 10/10)
   - ✅ All tests passed! or ❌ Some tests failed
6. If tests failed, click the "Autograding" button above to see detailed logs:
   - Expand the **education/autograding@v1** step to see which tests failed
   - Look for :x: marks to identify specific failures

