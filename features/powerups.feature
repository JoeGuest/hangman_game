Feature: Powerups

  Scenario: Player uses show definition powerup
    Given an existing game
    When player uses show definition powerup
    Then score is reduced by cost of powerup
    And definition is shown to user