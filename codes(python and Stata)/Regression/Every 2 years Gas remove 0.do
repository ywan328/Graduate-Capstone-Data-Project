clear all
capture log close
set more off

log using 00-01.log, replace
*********************************************
* For Year 2000-2001
import delimited "C:\Users\bnuzy\Dropbox\Codes and data\Panel\Every 2 years Gas, remove 0\00-01.csv" , clear

* Set Entity Time
gen modate = ym(year, month) 
format modate %tm 
xtset leasenumber modate

gen t=year-1989
gen pqoil= lsumofoil*dloil_price82

******************************************** 
* Gas Production
* With Oil Price
xtreg dlsumofgas dlgas_price82 l.dlgas_price82 dloil_price82 l.dloil_price82 dincrease_rate l.dincrease_rate seasons i.year, fe r
nlcom _b[dloil_price82] + _b[l.dloil_price82]
nlcom _b[dlgas_price82] + _b[l.dlgas_price82]

* With Weighted Oil Price (Only for Remove 0)
xtreg dlsumofgas dlgas_price82 l.dlgas_price82 pqoil l.pqoil dincrease_rate l.dincrease_rate seasons i.year, fe r
nlcom _b[dlgas_price82] + _b[l.dlgas_price82]
nlcom _b[pqoil] + _b[l.pqoil]


capture log close
