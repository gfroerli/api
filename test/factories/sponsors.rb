FactoryBot.define do
  factory :sponsor do
    name { 'Hochschule für Technik Rapperswil' }
    description { 'Die HSR ist tätig in den beiden Bereichen Technik und Informationstechnologie.' }
    active { true }
    sponsor_type { 'sponsor' }
  end
end
