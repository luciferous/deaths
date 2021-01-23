# Australia


These datasets contain only the doctor-certified deaths (i.e.,
coroner-certified deaths are missing).

Go to
https://www.abs.gov.au/statistics/health/causes-death/provisional-mortality-statistics/latest-release#data-download
and download

- "Provisional mortality statistics weekly dashboard"
- "Doctor certified deaths by week of occurrence, 2015-19"

Or run:

```
$ wget https://www.abs.gov.au/statistics/health/causes-death/provisional-mortality-statistics/jan-oct-2020/Provisional%20Mortality%20Statistics%2C%20Weekly%20Dashboard%2C%20Jan-Oct%202020%20with%20SDRs.xlsx
$ wget https://www.abs.gov.au/statistics/health/causes-death/provisional-mortality-statistics/jan-oct-2020/Doctor%20certified%20deaths%20by%20week%20of%20occurrence%2C%202015-19.xlsx
```

Convert the spreadsheet to a CSV.

```
$ ./au-to-csv.R Provisional\ Mortality\ Statistics,\ Weekly\ Dashboard,\ Jan-Oct\ 2020\ with\ SDRs.xlsx Table\ 1.1 > Provisional\ Mortality\ Statistics,\ Weekly\ Dashboard,\ Jan-Oct\ 2020\ with\ SDRs.csv
$ ./au-to-csv.R Doctor\ certified\ deaths\ by\ week\ of\ occurrence\,\ 2015-19.xlsx Table\ 2.3 > Doctor\ certified\ deaths\ by\ week\ of\ occurrence\,\ 2015-19.csv
```

Compile and format the CSVs.

```
./main > au-deaths.csv
```

Update the
[spreadsheet](https://docs.google.com/spreadsheets/d/1eSaKBxUfWB1payf2OjEZt5x83CaeK_RIuq8u1heji9E/edit#gid=1434566235),
replacing it.
