require "spec_helper"

describe Game do
  before do
    @player = Player.new
    @answer = Answer.new
    @game = Game.new(@player, @answer)
  end

  describe "#make_guess" do
    it "makes guess" do
      guess = @game.make_guess("g")
      expect(@game.guesses).to include guess
    end
  end

  describe "#check_guess" do
    context "when correct" do
      it "displays message" do
        @game.make_guess(@answer.word[0])
        expect(@game.message).to eq "correct!"
      end
    end

    context "when incorrect" do
      it "causes player to lose life" do
        letter = (("a".."z").to_a - @answer.word.split("")).first
        @game.make_guess letter

        expect(@player.lives).to eq 9
      end

      context "when player dead" do
        before do 
          @player = Player.new(1)
          @answer = Answer.new("Avengers")
          @game = Game.new(@player, @answer)
        end

        it "displays message" do
          @game.make_guess "t"

          expect(@game.message).to eq "Game over :("
        end
      end

      context "when player still alive" do
        it "displays message" do
          @game.make_guess "t"
        end
      end
    end

    context "when duplicate" do
      it "displays message" do
        @game.make_guess(@answer.word[0])
        @game.make_guess(@answer.word[0])

        expect(@game.message).to eq "Have we met before?"        
      end
    end
    context "when invalid" do
      it "displays message" do
        @game.make_guess "1"

        expect(@game.message).to eq "Feeling special? You can only use a-z"
      end
    end

    context "when too many letters" do
      it "displays message" do
        @game.make_guess("a" * (@answer.word.length + 1))

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
        expect(@answer).to receive(:complete!)

        @game.make_guess "t"
      end
    end

    context "when player wins" do
      before do 
        @player = Player.new(1)
        @answer = Answer.new("Win")
        @game = Game.new(@player, @answer)
      end

      it "displays message" do
        @game.make_guess "W"
        @game.make_guess "i"
        @game.make_guess "n"

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
      @game.make_guess "t"

      expect(@game.guesses).to be @answer.guesses
    end
  end

  describe "#wrong_guesses" do
    it "returns wrong_guesses from Answer" do
      @game.make_guess "t"

      expect(@game.wrong_guesses).to be @answer.wrong_guesses
    end
  end

end