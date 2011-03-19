# -*- coding: utf-8 -*-
# WordSearch.rb
# Gyaim
#
# Created by Toshiyuki Masui on 2011/3/15.
# Copyright 2011 Pitecan Systems. All rights reserved.

class WordSearch
  attr :searchmode, true

  def charcode(s)
    sprintf("%02x",s.each_byte.to_a[0])
  end

  def dictdir
    File.expand_path("~/.gyaimdict")
  end

  def dictfile(code)
    "#{dictdir}/dict#{code}"
  end

  def dict(s)
    @dict[charcode(s)]
  end

  def setdict(s,val)
    @dict[charcode(s)] = val
  end

  def createDictCache
    File.open(@dictfile){ |f|
      f.each { |line|
        next if line =~ /^#/
        line.chomp!
        (yomi,word) = line.split(/\s+/)
        if yomi && word then
          if dict(yomi).nil? then
            setdict(yomi,[])
          end
          dict(yomi) << [yomi,word]
        end
      }
    }
    @dict.each { |code,dic|
      File.open(dictfile(code),"w"){ |f|
        Marshal.dump(dic,f)
      }
    }
  end

  # dict = NSBundle.mainBundle.pathForResource("dict", ofType:"txt")
  # dict = "../Resources/dict.txt"
  def initialize(dict)
    @dictfile = dict
    Dir.mkdir(dictdir) unless File.exist?(dictdir)
    @candidates = []
    @dict = {}
    d = dictfile(charcode("kanji"))
#    if !File.exist?(d) || File.mtime(d) < File.mtime(dict) then
    if !File.exist?(d) then
      createDictCache
    end
  end

  def search(q,limit=10)
    return if q.nil? || q == ''

    code = charcode(q)
    qq = q.gsub(/[\{\}\[\]\(\)]/){ '\\' + $& }
    pat = Regexp.new(@searchmode > 0 ? "^#{qq}$" : "^#{qq}")
    candfound = {}
    @candidates = []
    if !@dict[code] then
      File.open(dictfile(code)){ |f|
        @dict[code] = Marshal.load(f)
      }
    end
    @dict[code].each { |entry|
      yomi = entry[0]
      word = entry[1]
#      if yomi =~ pat then
      if pat.match(yomi) then
        if !candfound[word] then
          @candidates << word
          candfound[word] = true
          break if @candidates.length > limit
        end
      end
    }
  end
  
  def candidates
    @candidates
  end
end

if __FILE__ == $0 then
  ws = WordSearch.new("/Users/masui/Gyaim/Resources/dict.txt")
  ws.search("^masui")
  puts ws.candidates
  ws.search("^kanj")
  puts ws.candidates
end
