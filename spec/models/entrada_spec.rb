require "rails_helper"

RSpec.describe Entrada, type: :model do

  describe 'Associacao' do
    it { should belong_to :pesquisa }
    it { should have_many :exemplos }
  end

end
