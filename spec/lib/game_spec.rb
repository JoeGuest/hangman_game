require "spec_helper"

describe Game do
  before do
    @player = Player.new
    @answer = Answer.new("Hello")
    @game = Game.new(@player, @answer)
  end

  describe "#new_guess" do
    it "makes guess" do
      guess = @game.new_guess("H")
      expect(@game.guesses).to include guess
    end
  end

  describe "#handle_guess" do
    context "when correct" do
      it "displays message" do
        @game.new_guess(@answer.word[0])
        expect(@game.message).to eq "correct!"
      end
    end

    context "when incorrect" do
      it "causes player to lose life" do
        letter = (("a".."z").to_a - @answer.word.split("")).first
        @game.new_guess letter

        expect(@player.lives).to eq 9
      end

      context "when player dead" do
        before do 
          @player = Player.new(1)
          @answer = Answer.new("Avengers")
          @game = Game.new(@player, @answer)
        end

        it "displays message" do
          @game.new_guess "t"

          expect(@game.message).to eq "Game over :("
        end
      end

      context "when player still alive" do
        it "displays message" do
          @game.new_guess "t"
        end
      end
    end

    context "when duplicate" do
      it "displays message" do
        @game.new_guess(@answer.word[0])
        @game.new_guess(@answer.word[0])

        expect(@game.message).to eq "Have we met before?"        
      end
    end
    context "when invalid" do
      it "displays message" do
        @game.new_guess "1"

        expect(@game.message).to eq "Feeling special? You can only use a-z"
      end
    end

    context "when too many letters" do
      it "displays message" do
        @game.new_guess("a" * (@answer.word.length + 1))

        expect(@game.message).to eq "Don't be greedy! One letter..."
      end
    end
  end

  describe "end game" do
    context "when player loses" do
      before do 
        @player = Player.new(1)
        @answer = double("Answer", word: "Avengers", guess!: :incorrect)
        @game = Game.new(@player, @answer)
      end

      it "automatically completes Answer" do
        expect(@answer).to receive(:completed?)
        expect(@answer).to receive(:autocomplete!)

        @game.new_guess "t"
      end
    end

    context "when player wins" do
      before do 
        @player = Player.new(1)
        @answer = Answer.new("Win")
        @game = Game.new(@player, @answer)
      end

      it "displays message" do
        @game.new_guess "W"
        @game.new_guess "i"
        @game.new_guess "n"

        expect(@game.message).to eq "You win!"
      end
    end
  end

  describe "#completed?" do
    it "returns true if Player.dead?" do
      allow(@player).to receive(:dead?).and_return(true)

      expect(@game.completed?).to eq true
    end

    it "returns true if Answer.completed?" do
      allow(@answer).to receive(:completed?).and_return(true)

      expect(@game.completed?).to eq true
    end

    it "returns false if game incomplete" do
      expect(@game.completed?).to eq false      
    end
  end

  describe "#guesses" do
    it "returns guesses from Answer" do
      @game.new_guess "t"

      expect(@game.guesses).to be @answer.guesses
    end
  end

  describe "#wrong_guesses" do
    it "returns wrong_guesses from Answer" do
      @game.new_guess "t"

      expect(@game.wrong_guesses).to be @answer.wrong_guesses
    end
  end

  describe "scoring" do
    it "updates total" do
      @game.new_guess "h"

      expect(@game.score).to eq 80
    end

    it "calculates running total" do
      @game.new_guess "h"
      @game.new_guess "t"  
      @game.new_guess "l"

      expect(@game.score).to eq 100
    end

    it "calculates running total on full word" do
      @game.new_guess "b"
      @game.new_guess "i"

      @game.new_guess "h"

      @game.new_guess "hello"

      # the two l's above == 10 + 10 instead of 5 + 5
      # todo: write test to demonstrate

      expect(@game.score).to eq 720
    end

    it "adds bonus for game complete" do
      @game.new_guess "h"
      @game.new_guess "e"

      # duplicate doesn't count twice  
      @game.new_guess "l"
      @game.new_guess "l"
      
      # lose life
      @game.new_guess "t"

      # finish game
      @game.new_guess "o"

      expect(@game.score).to eq 610
    end
  end

  it "calculates streaks" do
    @game.new_guess "h"
    @game.new_guess "e"

    expect(@game.score).to eq 110
  end
end