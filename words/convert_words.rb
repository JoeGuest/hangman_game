file = File.new("new_words.txt", "w")

File.readlines("words.txt").each do |word|
  file.write(word) if word.length > 4
end
