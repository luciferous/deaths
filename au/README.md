
Go to
https://www.abs.gov.au/statistics/health/causes-death/provisional-mortality-statistics/latest-release#data-download
and download the "Provisional mortality statistics weekly dashboard", or run:

```
wget https://www.abs.gov.au/statistics/health/causes-death/provisional-mortality-statistics/jan-oct-2020/Provisional%20Mortality%20Statistics%2C%20Weekly%20Dashboard%2C%20Jan-Oct%202020%20with%20SDRs.xlsx
```

Convert the spreadsheet to a CSV.

```
./au-to-csv.R Provisional\ Mortality\ Statistics,\ Weekly\ Dashboard,\ Jan-Oct\ 2020\ with\ SDRs.xlsx Table\ 1.1 > Provisional\ Mortality\ Statistics,\ Weekly\ Dashboard,\ Jan-Oct\ 2020\ with\ SDRs.csv
```

Go to https://www.bdm.vic.gov.au/research-and-family-history/research-and-data-services/death-statistics/deaths-registered-per-month and download "Death registrations by month", or run:

``` 
wget https://www.bdm.vic.gov.au/sites/default/files/embridge_cache/emshare/original/public/2021/01/48/2b7cc4d8d/Death%20Registrations%20by%20Month.XLSX
```

Convert the spreadsheet to a CSV.

```
./au-to-csv.R Death\ Registrations\ by\ Month.XLSX Sheet1 > Death\ Registrations\ by\ Month.csv
```

Compile and format the CSVs into one CSV.

```
./main > au-deaths.csv
```

Update the spreadsheet at
https://docs.google.com/spreadsheets/d/1eSaKBxUfWB1payf2OjEZt5x83CaeK_RIuq8u1heji9E/edit#gid=1434566235,
replacing the sheet.
