Feature: Single player game

  Scenario: player starts a game
    Given a new player
    When player starts a new game
    Then new game is generated

  Scenario: player makes a guess 
    Given an incomplete word

    When player makes a correct guess
    Then fill in blank(s) with letter

    When player makes an incorrect guess
    Then player loses life
    And letter is moved to trash
    And draw hangman

    When player makes a duplicate guess
    Then ignore guess
    And notify player that they are stupid

    When player guesses final letter of word
    Then notify player that they are clever

    When player loses last life
    Then notify player that they are dead