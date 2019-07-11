clear all
capture log close
set more off

log using 06-07.log, replace
*********************************************
* For Year 2006-2007
import delimited "C:\Users\bnuzy\Dropbox\Codes and data\Panel\Every 2 years Oil, c=0.25\06-07.csv" , clear

* Set Entity Time
gen modate = ym(year, month) 
format modate %tm 
xtset leasenumber modate

******************************************** 
* Oil Production Pregression with Gas Price
xtreg dlsumofoil dloil_price82 l.dloil_price82 dlgas_price82 l.dlgas_price82 dincrease_rate l.dincrease_rate seasons i.year, fe r
nlcom _b[dloil_price82] + _b[l.dloil_price82]
nlcom _b[dlgas_price82] + _b[l.dlgas_price82]

xtpcse dlsumofoil dloil_price82 l.dloil_price82 dlgas_price82 l.dlgas_price82 dincrease_rate l.dincrease_rate seasons i.year i.leasenumber, pairwise
nlcom _b[dloil_price82] + _b[l.dloil_price82]
nlcom _b[dlgas_price82] + _b[l.dlgas_price82]

capture log close
