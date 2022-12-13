import pandas as pd
import plotly
import plotly.express as px
import plotly.io as pio

#Read a comma-separated values (csv) "Jubail_Results.csv" file into DataFrame "df".
df = pd.read_csv('Jubail_Results.csv')

#Generate a bar chart from the df data frame
fig = px.bar(df, x = 'Application', y = 'Processes', title='Application utilization')

#Write the results into html file
pio.write_html(fig,'jubail_plot.html')

