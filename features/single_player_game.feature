Feature: Single player game

  Scenario: player starts a game
    Given a new player
    When player starts a new game
    Then new game is generated

    Given an existing game
    When player requests new game
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

    When player guesses an invalid character
    Then ignore guess
    And notify player that they are rebellious

    When player enters more than one character
    Then ignore guess
    And notify player that they are greedy

    When player guesses final letter of word
    Then notify player that they are clever

    When player guesses whole word correctly
    Then notify player that they are clever

    When player guesses whole word incorrectly
    Then player loses life
    And notify player that they are wrong

    When player loses last life
    Then notify player that they are dead
    And show answer

  Scenario: game is over
    Given a finished game
    Then prevent further guesses        
