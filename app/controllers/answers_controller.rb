class AnswersController < ApplicationController
  before_action :authenticate_user!
  expose :answer
  expose :question, -> { @question ||= params[:question_id] ? Question.find(params[:question_id]) : answer.question }

  def create
    answer.question = question
    answer.author = current_user
    if answer.save
      redirect_to question_path(answer.question)
    else
      render 'questions/show'
    end
  end

  def destroy
    if current_user.author?(answer)
      answer.destroy
      redirect_to answer.question
    else
      redirect_to answer.question, notice: 'You don`t have permission to delete this answer.'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
