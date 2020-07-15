Feature: Shout

  Shouty allows users to "hear" other users "shouts" as long as they are close enough to each other.

  To do:
    - only shout to people within a certain distance

  Background:
    Given a person named Lucy
    And a person named Sean

  Rule: Shouts can be heard by other users

    Scenario: Listener hears a message
      When Sean shouts "free bagels at Sean's"
      Then Lucy should hear Sean's message

    Scenario: Listener hears a different message
      Given the range is 100
      And a person named Sean is located at 0
      And a person named Lucy is located at 50
      When Sean shouts "Free coffee!"
      Then Lucy should hear Sean's message

  Rule: Shouts should only be heard if listener is within range

    Scenario: Listener is within range
      Given the range is 100
      And people are located at
        | name     | Sean | Lucy |
        | location |  0   | 50   |
      When Sean shouts
      Then Lucy should hear a shout

    Scenario: Listener is out of range
      Given the range is 100
      And people are located at
        | name     | Sean | Larry |
        | location |  0   | 150   |
      When Sean shouts
      Then Larry should not hear a shout

  Rule: Listener should be able to hear multiple shouts

    Scenario: Two shouts
      Given a person named Sean
      And a person named Lucy
      When Sean shouts "Free bagels!"
      And Sean shouts "Free toast!"
      Then Lucy hears the following messages:
        | Free bagels  |
        | Free toast   |
