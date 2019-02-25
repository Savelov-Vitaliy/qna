require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:questions) }
  it { should have_many(:answers) }

  describe 'Is the author?' do
    let(:user) { create(:user) }
    let(:question) { create(:question) }

    it 'is the author' do
      expect(question.author).to be_author_of(question)
    end

    it 'isn`t the author' do
      expect(user).to_not be_author_of(question)
    end
  end
end
