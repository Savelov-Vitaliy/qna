class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  expose :questions, -> { Question.all }
  expose :question

  def create
    question.author = current_user
    if question.save
      redirect_to question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def destroy
    if current_user.author?(question)
      question.destroy
      redirect_to questions_path
    else
      flash.now[:notice] = 'You don`t have permission to delete this question.'
      render :show
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def answer
    @answer ||= question.answers.new(author: current_user)
  end

  helper_method :answer
end
