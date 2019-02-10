class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  expose :answers, -> { Answer.all }
  expose :answer
  expose :question

  def create
    @answer = question.answers.new(answer_params)

    if @answer.save
      redirect_to question_answers_path
    else
      redirect_to question
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
