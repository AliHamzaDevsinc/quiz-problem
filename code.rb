class Quiz
  def initialize(file)
    @totalQuestion = 0
    @correct = 0
    @data = []
    @file = file
    @totalTime = 50
    @endTime = 0
  end

  def readFromFile
    require "csv"
    @data = CSV.read(@file)
    @data.shuffle!()
    @totalQuestion = @data.length
  end

  def setTimer(time)
    if time > 0
      @time = time
    else
      puts "You are assigning wrong time so default will be used for now\n"
    end
  end

  def takeQuiz
    @data.each do |row|
      puts "\nQuestion: " + row[0]
      print "Answer:   "
      ans = gets
      if ans.downcase.strip == row[1].downcase.strip
        @correct += 1
      end
    end
  end

  def printResult
    require "colorize"
    print "\n\t\t\t\t\t\t=========================================================\n".red
    print "\n\t\t\t\t\t\t              ----> QUIZ RESULT <----                    \n".blue
    print "\n\t\t\t\t\t\t=========================================================\n".red

    print "\n\n\t\t\t\t\t\t\t\t\t" + "Quiz Ended".colorize(:color => :white, :background => :red)

    per = (@correct * 100)/@totalQuestion
    if per >= 90
      print "\n\t\t\t\t\t\t\t\t" + "Geat!!  Well Done".colorize(:color => :white, :background => :black)
    end

    print "\n\t\t\t\t\t\t\t\tTotal Questions:  " + @totalQuestion.to_s
    puts "\n\t\t\t\t\t\t\t\tCorrect Answers:  " + @correct.to_s
  end

  def startQuiz
    require "timeout"
    require "colorize"

    readFromFile()
    print "\nPress Enter to start a quiz "
    inp = gets
    while inp.ord != 10 do
      print "\nPress Enter to start a quiz "
      inp = gets
    end
    begin
      Timeout::timeout(@totalTime) do
        takeQuiz()
      end
    rescue Timeout::Error
      puts "\n\n🚧 Time limit exceed".red
    end
    # else
    print "\nPress Enter to get result "
    inp = gets
    while inp.ord != 10 do
      print "\nPress Enter to get result  "
      inp = gets
    end
    printResult()
  end
end


q = Quiz.new("problems.csv")
q.startQuiz

