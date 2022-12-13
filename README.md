# Software-tracker
This is a tracker of applications running oh the HPC cluster


## Files:
1. **apps_dalma.sh** : This script is responsible for getting all applications running in dalma nodes with Cpu usage more than 50% associated with number of Cpus used in each of them,
it creates the following files.

      a. **Dalma_Results.csv**:includes each application with its associated Cpus used.
      
      b. **All_Dalma_Results**:includes each running nodes and applications running on it.
2. **apps_jubail.sh** : This script is responsible for getting all applications running in jubail nodes with Cpu usage more than 50% associated with number of Cpus used in each of them,
it creates the following files.

      a. **Jubail_Results.csv**:includes each application with its associated Cpus used.
      
      b. **All_Jubail_Results**:includes each running nodes and applications running on it.
3. **parser_dalma.py**: This script is responsible for reading **Dalma_Results.csv** and convert it to a bar chart in html format called  **dalma_plot.html** 
4. **parser_jubail.py**: This script is responsible for reading **Jubail_Results.csv** and convert it to a bar chart in html format called  **jubail_plot.html**
5. **accumulator.sh** : This script is responsible for accumulating dalma and Jubail results, it generated the following files:

      a. **Apps.csv**: list of all apps running on dalma and Jubail
      
      b. **Final_apps** :list of all apps running on dalma and Jubail organized alphapetically
      
      c. **dalma_apps_final**: list of number of Cpus running in dalma for each app in **Final_apps**
      
      d. **jubail_apps_final**: list of number of Cpus running in jubail for each app in **Final_apps**

6. **accumulated_chart.py** :This script is resoinsible for creating the accumulated chart that includes per each application in **Final_apps**, number of Cpus running in Dalma and jubail in an html chart in **accumulated_chart.html**
7. **App_searcher.sh** : this script takes application/s name/s as input and returns which nodes that these applications are running on in dalma and jubail

## Steps:

1. bash apps_dalma.sh
2. bash apps_jubail.sh
3. python parser_dalma.py
4. python parser_jubail.py
5. bash accumulator.sh
6. python accumulated_chart.py
7. bash App_searcher.sh $application_name (for example **bash App_searcher.sh matlab**)

