@echo off
Setlocal EnableDelayedExpansion
:: **********************************************
:: *        INPUT VARIABLES - TO MODIFY         *
:: **********************************************
:: Select stationID. For list of station (no password/user required):
:: ftp://client_climate@ftp.tor.ec.gc.ca/Pub/Get_More_Data_Plus_de_donnees/Station%20Inventory%20EN.csv
SET stationID=49568
:: Output folder (where CSV files will be saved).
SET out_folder="C:\Users\fbergeron\Desktop\test
:: select the years you want to download [Inclusive]
SET start_year=2012
SET end_year=2012
:: if you don't want all the months, modified accordingly [Inclusive]
SET start_month=1
SET end_month=12
:: timeframe: 1 for hourly data | timeframe: 2 for daily data | timeframe: 3 for monthly data
SET timeframe=1

:: **********************************************
:: * SCRIPT IS BELOW - NO MODIFICATION REQUIRED *
:: **********************************************
:: Confirmtaion before downloading
:PROMPT
echo Historical Data Download from Env. Can. Archives
echo/
echo Will download data from stationID %stationID% for years %start_year% to %end_year% using months %start_month% to %end_month%
echo Are you sure (y/n)?
echo/
SET /p confirmation=
IF /I "%confirmation%" NEQ "Y" GOTO END
:: Download loop
FOR /L %%y IN (%start_year%,1,%end_year%) DO (
  FOR /L %%m IN (%start_month%,1,%end_month%) DO (
    :: Adding trailing 0 to months if below 10
    SET print_m=00%%m
    SET print_m=!print_m:~-2!
    :: Outfile
    SET Outfile="%out_folder%\%%y_!print_m!_ID%stationID%.csv"
    echo !Outfile!
    pause
    :: Download comment
    SET url="http://climate.weather.gc.ca/climate_data/bulk_data_e.html?format=csv&stationID=%stationID%&Year=%%y&Month=%%m&Day=14&timeframe=%timeframe%&submit= Download+Data"
    powershell -command "& {Invoke-WebRequest -Uri \"!url!\" -Method Get -Outfile \"!Outfile!\"}"

  )
)
:END
echo ************************************************************************
echo Download complete under %out_folder%
echo ************************************************************************
echo Continue to exit
Endlocal
pause
