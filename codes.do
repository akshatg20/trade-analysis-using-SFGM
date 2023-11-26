* first normalise the variables *

gen logY = log(trade_ijt/1000)
gen logX1 = log(gdp_it/100000000000)
gen logX2 = log(gdp_jt/100000000000)
gen logX3 = log(dis_ij/1000)
gen logX4 = log(pop_it/1000000000)
gen logX5 = log(pop_jt/1000000000)
gen logX6 = log(rex_it/100)
gen logX7 = log(rex_jt/100)
gen logX10 = log(mrt_ij)

* define panel data *

xtset id year

* run panel sfa *

sfpanel logY logX1 logX2 logX3 logX4 logX5 logX6 logX7 logX10 year, 
model(tfe) dist(tn) emean(ta_ij) ort(o)

* calculate technical efficiency *

predict eff, u
sort eff
predict effi, te
egen fegrp = cut(effi), at(0, .3, .6, .9, 1)
tab fegrp
