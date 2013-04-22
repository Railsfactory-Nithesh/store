Order.transaction do
(10..30).each do |i|
Order.create(:name => "Customer #{i}" , :address => "#{i} Main Street" , :pay_type => "Check" )
end
end