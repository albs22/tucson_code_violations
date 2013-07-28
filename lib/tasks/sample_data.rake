namespace :db do
  desc "Fill DB with sample code violations"
  task populate: :environment do
    Violation.create!(lat: 32.2263,
                      long: -110.9469,
                      date_entered: DateTime.new(2013, 7, 15),
                      description: "Discarded Couch Out By Sidewalk - Has Been There A Couple Weeks.",
                      status: "Field",
                      violation_type: "Refuse",
                      violation_address: "1663 E 9th St",
                      photo_name: "v_001_sm.jpg"
                      )
                      
    Violation.create!(lat: 32.25558,
                      long: -110.96658,
                      date_entered: DateTime.new(2013, 7, 18),
                      description: "Trash In Bags On Property, Has Been There For Several Weeks.",
                      status: "Pending",
                      violation_type: "Refuse",
                      violation_address: "322 E Kelso St",
                      photo_name: "v_002_sm.jpg"
                      )
                      
   # 1.times do |n|
   end
        









end
