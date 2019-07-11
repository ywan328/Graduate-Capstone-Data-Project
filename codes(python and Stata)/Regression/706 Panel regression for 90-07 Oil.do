clear all
capture log close
set more off

log using df_panel_remo.log, replace
*********************************************
* For Year 1990-2007
import delimited "C:\Users\bnuzy\Dropbox\Codes and data\Panel\90-97 Oil\df_panel_remo.csv" , clear

* Set Entity Time
gen modate = ym(year, month) 
format modate %tm 
xtset leasenumber modate
set matsize 1000

gen t=year-1989
gen pqgas= lsumofgas*dlgas_price82

**********************************
* Groupwise Heteroscedasticity Test for Oil Production
qui xtreg dlsumofoil dloil_price82 l.dloil_price82 dlgas_price82 l.dlgas_price82 dincrease_rate l.dincrease_rate seasons ,fe
xttest3
* Random Effect Test for Oil Production
qui xtreg dlsumofoil dloil_price82 l.dloil_price82 dlgas_price82 l.dlgas_price82 dincrease_rate l.dincrease_rate seasons ,re r
xtoverid

******************************************** 
* Oil Panel Regression
* With Gas Price
xtreg dlsumofoil dloil_price82 l.dloil_price82 dlgas_price82 l.dlgas_price82 dincrease_rate l.dincrease_rate seasons i.year, fe r
nlcom _b[dloil_price82] + _b[l.dloil_price82]
nlcom _b[dlgas_price82] + _b[l.dlgas_price82]
xtpcse dlsumofoil dloil_price82 l.dloil_price82 dlgas_price82 l.dlgas_price82 dincrease_rate l.dincrease_rate seasons i.year i.leasenumber, pairwise
nlcom _b[dloil_price82] + _b[l.dloil_price82]
nlcom _b[dlgas_price82] + _b[l.dlgas_price82]
xtpcse dlsumofoil dloil_price82 l.dloil_price82 dlgas_price82 l.dlgas_price82 dincrease_rate l.dincrease_rate seasons i.year i.leasenumber, pairwise corr(ar1)
nlcom _b[dloil_price82] + _b[l.dloil_price82]
nlcom _b[dlgas_price82] + _b[l.dlgas_price82]

* With Weighted Gas Price (Only for Remove 0)
xtreg dlsumofoil dloil_price82 l.dloil_price82 pqgas l.pqgas dincrease_rate l.dincrease_rate seasons i.year, fe r
nlcom _b[dloil_price82] + _b[l.dloil_price82]
nlcom _b[pqgas] + _b[l.pqgas]
xtpcse dlsumofoil dloil_price82 l.dloil_price82 pqgas l.pqgas dincrease_rate l.dincrease_rate seasons i.year i.leasenumber, pairwise
nlcom _b[dloil_price82] + _b[l.dloil_price82]
nlcom _b[pqgas] + _b[l.pqgas]
xtpcse dlsumofoil dloil_price82 l.dloil_price82 pqgas l.pqgas dincrease_rate l.dincrease_rate seasons i.year i.leasenumber, pairwise corr(ar1)
nlcom _b[dloil_price82] + _b[l.dloil_price82]
nlcom _b[pqgas] + _b[l.pqgas]


capture log close
