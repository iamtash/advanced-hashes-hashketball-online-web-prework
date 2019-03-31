require "pry"

def game_hash
  game_hash = {
    :home => {
      :team_name => "Brooklyn Nets",
      :colors => ["Black", "White"],
      :players => {
        "Alan Anderson" => {
          :number => 0,
          :shoe => 16,
          :points => 22,
          :rebounds => 12,
          :assists => 12,
          :steals => 3,
          :blocks => 1,
          :slam_dunks => 1
        },
        "Reggie Evans" => {
          :number => 30,
          :shoe => 14,
          :points => 12,
          :rebounds => 12,
          :assists => 12,
          :steals => 12,
          :blocks => 12,
          :slam_dunks => 7
        },
        "Brook Lopez" => {
          :number => 11,
          :shoe => 17,
          :points => 17,
          :rebounds => 19,
          :assists => 10,
          :steals => 3,
          :blocks => 1,
          :slam_dunks => 15
        },
        "Mason Plumlee" => {
          :number => 1,
          :shoe => 19,
          :points => 26,
          :rebounds => 12,
          :assists => 6,
          :steals => 3,
          :blocks => 8,
          :slam_dunks => 5
        },
        "Jason Terry" => {
          :number => 31,
          :shoe => 15,
          :points => 19,
          :rebounds => 2,
          :assists => 2,
          :steals => 4,
          :blocks => 11,
          :slam_dunks => 1
        }
      }
    },
    :away => {
      :team_name => "Charlotte Hornets",
      :colors => ["Turquoise", "Purple"],
      :players => {
        "Jeff Adrien" => {
          :number => 4,
          :shoe => 18,
          :points => 10,
          :rebounds => 1,
          :assists => 1,
          :steals => 2,
          :blocks => 7,
          :slam_dunks => 2
        },
        "Bismak Biyombo" => {
          :number => 0,
          :shoe => 16,
          :points => 12,
          :rebounds => 4,
          :assists => 7,
          :steals => 7,
          :blocks => 15,
          :slam_dunks => 10
        },
        "DeSagna Diop" => {
          :number => 2,
          :shoe => 14,
          :points => 24,
          :rebounds => 12,
          :assists => 12,
          :steals => 4,
          :blocks => 5,
          :slam_dunks => 5
        },
        "Ben Gordon" => {
          :number => 8,
          :shoe => 15,
          :points => 33,
          :rebounds => 3,
          :assists => 2,
          :steals => 1,
          :blocks => 1,
          :slam_dunks => 0
        },
        "Brendan Haywood" => {
          :number => 33,
          :shoe => 15,
          :points => 6,
          :rebounds => 12,
          :assists => 12,
          :steals => 22,
          :blocks => 5,
          :slam_dunks => 12
        }
      }
    }
  }

  game_hash
end

def num_points_scored(player_name)

  game_hash.find do |location, team_data|
    if team_data[:players].keys.include?(player_name)
      return team_data[:players][player_name][:points]
    end
  end

end

def shoe_size(player_name)
  #binding.pry
  game_hash.find do |location, team_data|
    if team_data[:players].keys.include?(player_name)
      return team_data[:players][player_name][:shoe]
    end
  end
end

def team_colors(team_name)
  #binding.pry
  game_hash.find{|location, team_data|
    return team_data[:colors] if team_data[:team_name] == team_name
  }
end

def team_names
  #binding.pry
  game_hash.map {|location, team_data| team_data[:team_name]}
end

def player_numbers(team_name)
  #binding.pry
  game_hash.map{|location, team_data|
      if team_data[:team_name] == team_name
        team_data[:players].map {|player, stats| stats[:number]}
      end
    }.flatten.delete_if {|element| element == nil}

end

def player_stats(player_name)
  #binding.pry
  game_hash.map{|location, team_data|
    team_data[:players][player_name]}.delete_if {|element| element == nil}[0]
end

def big_shoe_rebounds

shoe_sizes = []
  game_hash.each {|location, team_data|
    team_data.each {|attribute, data|
      shoe_sizes << data.map {|player, stats| stats[:shoe]} if data.class == Hash
    }
  }

  biggest_shoe = shoe_sizes.flatten.uniq!.max

  players_data = game_hash.map {|location, team_data|
    game_hash[location][:players]}
  players_data_merged = players_data[0].merge(players_data[1])

  players_data_merged.map {|player, data|

    return data[:rebounds] if data[:shoe] == biggest_shoe
  }

end

def most_points_scored
  player_points = []
    game_hash.each {|location, team_data|
      team_data.each {|attribute, data|
        if data.class == Hash
          player_points << data.map {|player, stats| stats[:points]}
        end
      }
    }

    most_points = player_points.flatten.uniq!.max

    players_data = game_hash.map {|location, team_data|
      game_hash[location][:players]}
      binding.pry
    players_data_merged = players_data[0].merge(players_data[1])
    binding.pry

    players_data_merged.map {|player, data|
      return player if data[:points] == most_points
    }
end

def winning_team
  team_points = {}

  game_hash.map {|location, team_data|

    team_points[location] = eval team_data[:players].map {|player, stats|
      stats[:points]
    }.join '+'
  }

  game_hash[team_points.key(team_points.values.max)][:team_name]

end

def player_with_longest_name
  players_data = game_hash.map {|location, team_data|
    game_hash[location][:players]
  }
  players_name_length = {}
  players_data[0].merge(players_data[1]).keys.each {|player|
    players_name_length[player] = player.length
  }
  players_name_length.key(players_name_length.values.max)
end

def long_name_steals_a_ton?
  player_steals = []
  game_hash.each {|location, team_data|
    team_data.each {|attribute, data|
      if data.class == Hash
        player_steals << data.map {|player, stats| stats[:steals]}
      end
    }
  }
  most_steals = player_steals.flatten.uniq!.max

  players_data = game_hash.map {|location, team_data|
    game_hash[location][:players]}
  players_data_merged = players_data[0].merge(players_data[1])

  player_with_longest_name == players_data_merged.find {|player, data|
    player if data[:steals] == most_steals
  }.first ? true : false

end
