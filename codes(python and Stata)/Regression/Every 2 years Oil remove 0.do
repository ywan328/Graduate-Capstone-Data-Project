clear all
capture log close
set more off

log using 06-07.log, replace
*********************************************
* For Year 2006-2007
import delimited "C:\Users\bnuzy\Dropbox\Codes and data\Panel\Every 2 years Oil, remove0\06-07.csv" , clear

* Set Entity Time
gen modate = ym(year, month) 
format modate %tm 
xtset leasenumber modate
set matsize 1000

gen t=year-1989
gen pqgas= lsumofgas*dlgas_price82


******************************************** 
* Oil Production Regression
* With Gas Price
xtreg dlsumofoil dloil_price82 l.dloil_price82 dlgas_price82 l.dlgas_price82 dincrease_rate l.dincrease_rate seasons i.year, fe r
nlcom _b[dloil_price82] + _b[l.dloil_price82]
nlcom _b[dlgas_price82] + _b[l.dlgas_price82]


* With Weighted Gas Price (Only for Remove 0)
xtreg dlsumofoil dloil_price82 l.dloil_price82 pqgas l.pqgas dincrease_rate l.dincrease_rate seasons i.year, fe r
nlcom _b[dloil_price82] + _b[l.dloil_price82]
nlcom _b[pqgas] + _b[l.pqgas]


capture log close
