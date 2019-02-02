class AnswersController < ApplicationController
  expose :answers, -> { Answer.all }
  expose :answer

  def create
    @answer = Answer.new(answer_params)

    if @answer.save
      redirect_to @answer.question
    else
      render :new
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:question_id, :body)
  end
end
