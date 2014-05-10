namespace :index do
  task :generate do
    t = Trie.new
    #       key     value
    t.insert("사랑하", "동사")
    t.insert("사랑주", "동사")
    t.insert("사랑받", "동사")
    t.insert("사람", "명사")
    t.insert("사랑", "명사")

    puts t.find_all.inspect
    k = t.find_prefix('사랑')  # '사랑하' / '사랑주' / '사랑받' 출력
    k.each do |item, value|
      puts item.to_s, value.to_s # 실제로는 '하' / '주' / '받'이 출력된다.
    end
  end
end
