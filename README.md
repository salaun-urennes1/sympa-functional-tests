# Functional tests for Sympa

These are end-to-end functional tests, helfull to qualify a new Sympa version.

Uses [Test::BDD::Cucumber CPAN module](https://metacpan.org/release/Test-BDD-Cucumber)

## Running the tests

All tests: `pherkin`

A set of features: `pherkin features/cli_family.feature`

## Writing new tests

Each `.feature` file in the `features/` directory defines a set of sequencial tests. These tests are organized as User Stories, writen in the [Gherkin language](https://docs.behat.org/en/latest/user_guide/gherkin.html): Given initial conditions When I perfom actions Then I expect results. 

Parsing of feature files is performed by the `features/step_definitions/` scripts. These should be enriched to support new conditions/actions/checks. 
