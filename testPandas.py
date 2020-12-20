# We import pandas into Python
import pandas as pd

# We read in a stock data data file into a data frame and see what it looks like
xls = pd.ExcelFile('/Users/michaelkirschbaum/Desktop/Python/excelToSQL/rpeTables.xlsx')

# to read all sheets to a map
sheet_to_df_map = {}
for sheet_name in xls.sheet_names:
    sheet_to_df_map[sheet_name] = xls.parse(sheet_name)

# We display the DataFrame
print(sheet_to_df_map)