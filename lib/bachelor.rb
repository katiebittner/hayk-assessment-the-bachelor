def get_first_name_of_season_winner(data, season)
  winner = data[season].find do |contestant|
    contestant["status"].downcase == "winner"
  end
  winner["name"].split(" ").first
end

def get_contestant_name(data, occupation)
  find_contestant_by_property(get_all_contestants(data), "occupation", occupation, "first")["name"]
end

def count_contestants_by_hometown(data, hometown)
  find_contestant_by_property(get_all_contestants(data), "hometown", hometown, "all").length
end

def get_occupation(data, hometown)
  find_contestant_by_property(get_all_contestants(data), "hometown", hometown, "first")["occupation"]
end

def get_average_age_for_season(data, season)
  sum = data[season].reduce(0.0) do |sum, contestant|
    sum + contestant["age"].to_f
  end
  (sum / data[season].length).round
end

def get_all_contestants(data)
  data.map {|season, info| info}.flatten
end

def find_contestant_by_property(contestants, property_name, property_value, all_or_first)
  if all_or_first == "first"
    first_contestant = contestants.find do |contestant|
      contestant[property_name] == property_value
    end
    return first_contestant
  end
  if all_or_first == "all"
    all_contestants = contestants.find_all do |contestant|
      contestant[property_name] == property_value
    end
    return all_contestants
  end
end
