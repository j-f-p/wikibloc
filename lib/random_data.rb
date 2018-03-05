module RandomData
  def self.random_name
    first_name = random_word.capitalize
    last_name = random_word(3,10).capitalize
    "#{first_name} #{last_name}"
  end
  
  def self.random_email
    "#{random_word(5,16)}@#{random_word}.#{random_word(2,3)}"
  end
  
  def self.random_paragraph
    sentences = []
    rand(4..6).times do
      sentences << random_sentence
    end
 
    sentences.join(" ")
  end
 
  def self.random_sentence
    strings = []
    rand(3..8).times do
      strings << random_word
    end
 
    sentence = strings.join(" ")
    sentence.capitalize << "."
  end
 
  def self.random_word(min=3,max=8)
    letters = ('a'..'z').to_a
    letters.shuffle!
    letters[0,rand(min..max)].join
  end
end
