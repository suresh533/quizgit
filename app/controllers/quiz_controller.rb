

class QuizController < ApplicationController
  def index
  end
  
  def start
	 total = 5
	 all = Question.find(:all).map {|x| x.id}
	 session[:questions] = all.sort_by{rand}[0..(total-1)]
	 
	 session[:total]   = total
	 session[:current] = 0
	 session[:correct] = 0
	 
	 redirect_to :action => "question"
  end
  def question
          
         
	 @current = session[:current]
	 @total   = session[:total]
	 if @current >= @total
		redirect_to :action => "end"
		return
	 end
	
	 @question = Question.find(session[:questions][@current])
	 @choices = @question.choices.sort_by{rand}
	 
	 
	 session[:question] = @question
	 session[:choices] = @choices
	 
	 
	
  end

  def answer
	 @current = session[:current]
	 @total   = session[:total]
	 
	 choiceid = params[:choice]
	 
	 @question = session[:question]
	 @choices  = session[:choices]
	 UserAnswer.create(:question_id=>session[:question].id,:choice_id=>choiceid)
	 @choice = choiceid ? Choice.find(choiceid) : nil
	 if @choice and @choice.correct
		@correct = true
		session[:correct] += 1
	 else
		@correct = false
	 end
	 
	 session[:current] += 1
   redirect_to :action=>"question"
  end

  def end
	 @correct = session[:correct]
	 @total   = session[:total]
	 @score = @correct * 100 / @total
  end
  
  
  def submitresult
    
    @addresult = Exam.new 
     @correct = session[:correct]
    @addresult.score=@correct
  
    @addresult.user_id = current_user.id
    @addresult.email = current_user.email
    @addresult.save
    
    
end

  

end
