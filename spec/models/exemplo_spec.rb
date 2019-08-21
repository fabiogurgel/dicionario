require "rails_helper"

RSpec.describe Exemplo, type: :model do

  describe "Associacao" do
    it { should belong_to :entrada }
  end
end
