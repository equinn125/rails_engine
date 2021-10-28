FactoryBot.define do
  factory :invoice, class: Invoice do
    status { 'shipped' }
  end
end
