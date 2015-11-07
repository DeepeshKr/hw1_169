class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
  
  attr_accessor(:word,:guesses, :wrong_guesses)

  def initialize(word)
   @word = word
   @guesses = ""
   @wrong_guesses = ""
  end
 
   
  def guess(g_letter)
     
     if (g_letter.nil?) || (g_letter.empty?) || !(g_letter.match(/[A-Za-z]/))  #[a-z]	Any single character in the range a-z
        raise ArgumentError.new("Your need to enter a valid alphabet")
     end
  
     g_letter.downcase!
  
    
      if (@guesses.include? g_letter) || (@wrong_guesses.include? g_letter)
        return false
      elsif @word.include? g_letter
       @guesses << g_letter
       return true
      else
       @wrong_guesses << g_letter
       return true
      end
   
  end
  
  def word_with_guesses
     final_word = ""
    @word.split("").each do |w|
      if @guesses.include? w
        final_word << w
      else
        final_word << "-"
      end
    end
   
   return final_word
  end
  
  def check_win_or_lose
    
    if word_with_guesses == @word
        return :win
    elsif @wrong_guesses.length >= 7
       return :lose
    else
        return :play
       
    end

  end

  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
