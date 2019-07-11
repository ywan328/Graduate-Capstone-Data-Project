clear all
capture log close
set more off

log using 706Panelshort.log, replace
*********************************************
* For Year 2006-2007
import delimited "C:\Users\bnuzy\Dropbox\Codes and data\Panel\Every 2 years Gas, c=0.25\06-07.csv" , clear

* Set Entity Time
gen modate = ym(year, month) 
format modate %tm 
xtset leasenumber modate


******************************************** 
* Gas Production with Oil Price
xtreg dlsumofgas dlgas_price82 l.dlgas_price82 dloil_price82 l.dloil_price82 dincrease_rate l.dincrease_rate seasons i.year, fe r
nlcom _b[dloil_price82] + _b[l.dloil_price82]
nlcom _b[dlgas_price82] + _b[l.dlgas_price82]


capture log close
