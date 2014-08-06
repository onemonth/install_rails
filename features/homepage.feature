Feature: Homepage
  In order to know how to install rails
  As a visitor to the site
  I want to start the lesson

  Scenario: Navigate the user to the start of the lesson
    Given I am on the homepage
    When I click "Start now"
    Then I am asked about my OS
