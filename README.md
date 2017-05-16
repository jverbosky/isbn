## ISBN Validator ##

A web app developed using Ruby, Sinatra, HTML and CSS for validating ISBN-10 and ISBN-13 numbers.

----------

**Running the App**

----------

To run the ISBN validator app locally:

1. Make sure that [Ruby](https://www.ruby-lang.org/en/documentation/installation/) is installed.
2. Make sure that the [Sinatra](https://github.com/sinatra/sinatra) gem is installed.  *Note that installing the Sinatra gem will install other gems necessary to run the game locally, such as rack.*
3. Navigate to the directory which contains **app.rb** in a terminal (command prompt) session.
4. Run the following command to launch the Sinatra web server:

	ruby app.rb

To open the app locally once it is running, use the following URL:

[http://localhost:4567](http://localhost:4567/)

----------

**Validating ISBN Numbers**

----------

To determine the validity of a 10- or 13-digit ISBN number, do the following:

1. Specify a potential ISBN number in the input field.
2. Select the **Submit** button.
3. The validity status of the provided number will be listed on the subsequent page.

*Note that reference ISBN numbers are available to allow for quick validation.*

----------

**Unit Tests Overview**

----------

Tests have been developed to verify that the methods used by the app are working as intended.

Unit Tests:

- **test\_isbn_check.rb** > **isbn_check.rb** (32 tests)

----------

**Running Unit Tests**

----------

Unit tests can be run by doing the following:

1. Navigate to the directory which contains **app.rb** in a terminal (command prompt) session.
2. Run the following command for the unit test file:<br>

    ruby test\_isbn_check.rb

The resulting output will indicate the success of the unit tests:

	Run options: --seed 60249

	# Running:

	................................

	Finished in 0.004909s, 6518.5157 runs/s, 6518.5157 assertions/s.

	32 runs, 32 assertions, 0 failures, 0 errors, 0 skips

----------

Enjoy!