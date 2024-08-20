# The attached soccer.dat file contains the results from the English Premier League. 
# The columns labeled ‘F’ and ‘A’ contain the total number of goals scored for and against 
# each team in that season (so Arsenal scored 79 goals against opponents, and had 36 
# goals scored against them). Write a program to print the name of the team with the smallest 
# difference in ‘for’ and ‘against’ goals.

soccer_file = "soccer.dat"

File.open(soccer_file, 'r') do |file|
    line_num = 0
    team = ""
    min_diff = Float::INFINITY

    team_name_col = 1
    for_col = 6
    against_col = 7
    
    start_data_table_row = 4
    end_data_table_row = 24


    file.each_line do |line|
        line_num += 1
        if line_num >= start_data_table_row && line_num <= end_data_table_row
            data = line.tr('-', '').strip.split
            for_score = data[for_col].to_i
            against_score = data[against_col].to_i
            diff = (for_score - against_score).abs
            if !data.empty? && min_diff > diff
                min_diff = diff
                team = data[team_name_col]
            end
        end
    end
    puts "Team with smallest difference between For score and Against score: #{team} (#{min_diff})"
end