FactoryGirl.define do
  factory :pesquisa, :class => Pesquisa do
    word { Faker::Lorem.word }
  end

  factory :pesquisa_com_entrada, class: Pesquisa do
    word { Faker::Lorem.word }

    after(:create) do |pesquisa|
      2.times do
        entrada = FactoryGirl.create(:entrada, pesquisa_id: pesquisa.id)
        4.times do
          FactoryGirl.create(:exemplo, entrada_id: entrada.id)
        end
      end
    end
  end

end
