class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  expose :answer # , parent: :question
  expose :question, -> { @question ||= params[:question_id] ? Question.find(params[:question_id]) : answer.question }

  def create
    answer.question = question
    answer.author = current_user
    if answer.save
      redirect_to question_answers_path
    else
      render 'questions/show'
    end
  end

  def destroy
    if answer.author? current_user
      answer.destroy
      redirect_to question_path(id: question)
    else
      flash.now[:notice] = 'You don`t have permission to delete this answer.'
      render :show
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
