# In the attached file (w_data.dat), you’ll find daily weather data. 
# Download this text file, then write a Ruby program to output 
# the day number (column one) with the smallest temperature spread 
# (the maximum temperature is the second column, the minimum the third column).
w_file = 'w_data.dat'

File.open(w_file, 'r') do |file|
    line_num = 0
    day = -1
    min_diff = Float::INFINITY

    day_col = 0
    max_temp_col = 2
    min_temp_col = 3

    start_data_table_row = 7
    end_data_table_row = 37

    HDDay_col_num = 4
    HRP_col_num = 6
    WxType_col_num = 8
    mxs_col_num = 12

    def add_null_value(list, col_num)
        list.insert(col_num, "NULL")
    end

    def santitize_w_data(list, hdday_col_num, hrp_col_num, wxtype_col_num)
        if list[hdday_col_num].include?('.') && list[hdday_col_num] != "NULL"
            add_null_value(list, hdday_col_num)
        end
        if list[hrp_col_num].include?('.') && list[hrp_col_num] != "NULL"
            add_null_value(list, hrp_col_num)
        end
        if !list[wxtype_col_num].match(/[A-Za-z]/) && list[wxtype_col_num] !="NULL"
            add_null_value(list, wxtype_col_num)
        end
    end

    def remove_non_numeric_chars(data, col_num)
        data[col_num].tr('^0-9.', '')
    end

    def santitize_cols(data, max_temp_col, min_temp_col, mxs_col_num)
        remove_non_numeric_chars(data, max_temp_col)
        remove_non_numeric_chars(data, min_temp_col)
        remove_non_numeric_chars(data, mxs_col_num)
    end

    file.each_line do |line|
        line_num += 1
        if line_num >= start_data_table_row && line_num < end_data_table_row
            data = line.strip.split
            santitize_w_data(data, HDDay_col_num, HRP_col_num, WxType_col_num)
            santitize_cols(data, max_temp_col, min_temp_col, mxs_col_num)
            max_temp = data[max_temp_col].tr('^0-9.', '').to_i
            min_temp = data[min_temp_col].tr('^0-9.', '').to_i
            diff = (max_temp - min_temp).abs
            if !data.empty? && min_diff > diff
                min_diff = diff
                day = data[day_col]
            end
        end
    end
    puts "Day with smallest difference between max temperature and min temperature: #{day} (#{min_diff})"
end