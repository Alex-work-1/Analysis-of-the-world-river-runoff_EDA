import os
import csv
import datetime

from pathlib import Path
from TableDataProcessing import TableDataProcessing

import numpy as np



csv_file_name = "data (100 years).csv"




# setting variables of directories
initial_path = os.getcwd()
data_path = Path(initial_path).parents[1] / "data"
raw_data_path = data_path / "raw"
grdc_raw_data_path = raw_data_path / "grdc_raw"



raw_data_directories = [grdc_raw_data_path / directory for directory in os.listdir(grdc_raw_data_path) if "." not in directory] # getting the list of raw data continent directories as strings


def get_day_txt_file_list(directory):
    # checks if it is day txt data file and add to the list
    files_dir = [directory / File for File in os.listdir(directory) if os.path.isfile(directory / File) if File[-11:] == "Day.Cmd.txt"]

    return files_dir







def search_word_value_in_table_header(table, word):
    value = ""
    # search what row contains the "word"
    for row in table:
        #check if it is header, if not than finish task
        if row[0][0] == "#":
            if word in row:
                #find index of where value starts
                for i in row:
                    if ":" in i:
                        start_index = row.index(i) + 1
                # getting value
                value = " ".join(row[start_index:]).strip()

        else:
            break

    # if value is empty retun NA, if not - return value
    if value == "" or value.isspace() or value == "-999.000":
        print("ERROR 1: the word is not found or value is empty.")
        return "NA"
    else:
        return value


def quality_classification(quality_percentage):
    if quality_percentage == 100:
        return "A"
    elif quality_percentage >= 95:
        return "B"
    else:
        return "C"


def csv_add_row(row, csv_file_dir):
    with open(csv_file_dir, "at") as csvFile:
        writer = csv.writer(csvFile)
        writer.writerow(row)

def day_csv_data_filler(day_files_dir_list, continent_name, csv_file_dir):
    global time_range_start_needed
    global time_range_end_needed

    counter_actions = 1
    for day_file_path in day_files_dir_list:

        # parsing table
        day_data_file = tableLib.txtTableParse(day_file_path, userEncoding = "iso-8859-1")

        # check if file is not empty, otherwise skip file
        data_number_of_lines = int(search_word_value_in_table_header(day_data_file, "lines:"))

        if data_number_of_lines == 0:
            print(f"SKIP {counter_actions} Number of lines")
            counter_actions += 1
            continue


        #getting values from header
        id_value = search_word_value_in_table_header(day_data_file, "GRDC-No.:")
        station = search_word_value_in_table_header(day_data_file, "Station:")
        river = search_word_value_in_table_header(day_data_file, "River:")

        country = search_word_value_in_table_header(day_data_file, "Country:")

        Latitude = search_word_value_in_table_header(day_data_file, "Latitude")
        Longitude = search_word_value_in_table_header(day_data_file, "Longitude")

        Altitude = search_word_value_in_table_header(day_data_file, "ASL):")
        n_years = search_word_value_in_table_header(day_data_file, "years:")
        catchment_size = search_word_value_in_table_header(day_data_file, "(km²):")


        if int(n_years) < 100:
            print(f"SKIP {counter_actions} less than 100 years.")
            counter_actions += 1
            continue




        date_column_index = 0
        value_column_index = 3

        #check the quality of data
        # counting missing values
        counter = 0
        for row in day_data_file[37:]:
            if row[value_column_index] == "-999.000":
                counter += 1
        # if percentage of valid numbers is below 90% than skip file
        if ((data_number_of_lines - counter) / data_number_of_lines) * 100 < 90:
            print(f"SKIP {counter_actions} quality")
            counter_actions += 1
            continue



        # getting year minimum, maximum, mean, quality (A, B, C), summer mean, winter mean
        # getting year minimum
        csv_row_dictionary = {"ID":id_value, "Station":station, "River":river, "Country":country, "Continent":continent_name, "Lat":Latitude, "Lon":Longitude, "Alt":Altitude, "N.Years":n_years, "V.Qual":"NA", "Year":"NA", "LQ":"NA", "MQ":"NA", "HQ":"NA", "Catchment size":catchment_size, "Summer mean":"NA", "Winter mean":"NA"} #quality_class

        year_days_list = []
        winter_months_list = []
        summer_months_list = []
        last_date = datetime.date.fromisoformat(day_data_file[37][0])


        for row in day_data_file[37:]:
            current_date = datetime.date.fromisoformat(row[date_column_index])

            if row[value_column_index] == "-999.000":
                row[value_column_index] = np.nan # conver -999 into NaN
            else:
                row[value_column_index] = float(row[value_column_index]) # convert string to number



            if current_date.strftime('%m-%d') != "12-31":
                year_days_list.append(row[value_column_index])
            else:
                year_days_list.append(row[value_column_index])

                quality_percentage = ((len(year_days_list) - year_days_list.count(np.nan)) * 100) / len(year_days_list)
                quality_class = quality_classification(quality_percentage)

                csv_row_dictionary["V.Qual"] = quality_class

                mean_year = np.nanmean(year_days_list)
                csv_row_dictionary["MQ"] = round(mean_year, 2)
                csv_row_dictionary["LQ"] = round(np.nanmin(year_days_list), 2)
                csv_row_dictionary["HQ"] = round(np.nanmax(year_days_list), 2)
                csv_row_dictionary["Year"] = last_date.year

                year_days_list = []



            # summer
            if current_date.year == last_date.year and current_date.month in [6, 7, 8]:
                summer_months_list.append(row[value_column_index])

            # winter
            if current_date.year == last_date.year and current_date.month in [12, 1, 2]:
                winter_months_list.append(row[value_column_index])

            if current_date.strftime('%m-%d') == "12-31":
                csv_row_dictionary["Summer mean"] = round(np.nanmean(summer_months_list), 2)
                csv_row_dictionary["Winter mean"] = round(np.nanmean(winter_months_list), 2)
                summer_months_list = []
                winter_months_list = []

                csv_row = list(csv_row_dictionary.values())
                csv_add_row(csv_row, csv_file_dir)

            last_date = current_date

        print(f"A file {counter_actions} was added from {continent_name} folder.")
        counter_actions += 1



        ##ID Station River Country	Continent	Lat	Lon	Alt	N.Years	V.Qual	Year	LQ	MQ	HQ Catchmentsize summerMean WinterMean



def create_csv_file(file_dir, name_list):
    with open(file_dir, "wt") as csvFile:
            writer = csv.writer(csvFile)
            # header
            writer.writerow(name_list)


if __name__ == "__main__":
    tableLib = TableDataProcessing() # setting the object settings & changing name for readability

    # creating csv file & its header
    csv_file_dir = data_path / csv_file_name
    header_list = ["ID", "Station", 'River', 'Country', 'Continent', 'Lat', 'Lon', 'Alt', 'N.Years', 'V.Qual', 'Year', 'LQ', 'MQ', 'HQ', 'Catchment size', 'Summer mean', 'Winter mean']

    create_csv_file(csv_file_dir, header_list)

    for continent_dir in raw_data_directories:
        day_files_dir_list = get_day_txt_file_list(continent_dir) #day file dir list


        continent_name = os.path.basename(continent_dir)

        day_csv_data_filler(day_files_dir_list, continent_name, csv_file_dir)


