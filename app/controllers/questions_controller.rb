class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  expose :questions, -> { Question.all }
  expose :question

  def show
    @answer = Answer.new
  end

  def create
    if question.save
      redirect_to question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
