require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:questions) }
  it { should have_many(:answers) }

  describe 'Is the author?' do
    let(:user) { create(:user) }
    let(:question) { create(:question) }
    let(:answer) { create(:answer) }

    it 'is the questions author' do
      expect(question.author.author?(question)).to eq true
    end

    it 'isn`t the questions author' do
      expect(user.author?(question)).to eq false
    end

    it 'is the answers author' do
      expect(answer.author.author?(answer)).to eq true
    end

    it 'isn`t the answers author' do
      expect(user.author?(answer)).to eq false
    end
  end
end
