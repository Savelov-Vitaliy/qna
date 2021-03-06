require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }

  describe 'Authenticated user.' do
    before { login(question.author) }

    describe 'POST #create' do
      context 'with valid attributes' do
        it 'saves a new author.answer in the database' do
          expect { post :create, params: { question_id: question, answer: attributes_for(:answer) } }.to change(question.author.answers, :count).by(1)
        end

        it 'saves a new question.answer in the database' do
          expect { post :create, params: { question_id: question, answer: attributes_for(:answer) } }.to change(question.answers, :count).by(1)
        end

        it 'redirects to index view' do
          post :create, params: { question_id: question, answer: attributes_for(:answer) }
          expect(response).to redirect_to question_path(question)
        end
      end

      context 'with invalid attributes' do
        it 'does not save the answer' do
          expect { post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid) } }.to_not change(Answer, :count)
        end

        it 'render question show view' do
          post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid) }
          expect(response).to render_template 'questions/show'
        end
      end
    end

    describe 'DELETE #destroy' do
      let!(:answer) { create(:answer) }

      describe 'Authenticated user is author' do
        before { login(answer.author) }
        it 'delete from the database' do
          expect { delete :destroy, params: { id: answer } }.to change(Answer, :count).by(-1)
        end

        it 'redirects to index view' do
          delete :destroy, params: { id: answer }
          expect(response).to redirect_to question_path(answer.question)
        end
      end

      describe 'Authenticated user is not author' do
        it 'delete from the database' do
          expect { delete :destroy, params: { id: answer } }.to_not change(Answer, :count)
        end

        it 'redirects to index view' do
          delete :destroy, params: { id: answer }
          expect(response).to redirect_to question_path(answer.question)
        end
      end
    end
  end

  describe 'Unauthenticated user.' do
    describe 'POST #create' do
      it 'tries save a new answer in the database' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer) } }.to_not change(Answer, :count)
      end

      it 'redirects to question show view' do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'DELETE #destroy' do
      let!(:answer) { create(:answer) }

      it 'don`t delete from the database' do
        expect { delete :destroy, params: { id: answer } }.to_not change(Answer, :count)
      end

      it 'redirects to question show view' do
        delete :destroy, params: { id: answer }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
