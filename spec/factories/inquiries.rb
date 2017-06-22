FactoryGirl.define do
  factory :inquiry do
    user_id 1
    unit_id 1
    start_date Date.new(2016, 6, 20)
    end_date Date.new(2016, 6, 21)

  end
end
