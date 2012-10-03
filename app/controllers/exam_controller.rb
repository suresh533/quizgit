class ExamController < ApplicationController
  def show
    
@exam = Exam.find(:all)

  end
end
