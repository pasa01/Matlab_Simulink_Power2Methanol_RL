%% Load in Data from External sources

% Load in
Amb_exp         = table2struct(readtable('.\Data\AmbTunis.xlsx'));
WT_exp          = table2struct(readtable('.\Data\WT_PowerCurves\VestasV112.xlsx'));
AEL_exp         = table2struct(readtable('.\Data\Electrolyzer.xlsx'));
Inverter_exp    = table2struct(readtable('.\Data\Inverter.xlsx'));
SMR_exp         = table2struct(readtable('.\Data\SMR.xlsx'));
MES_exp         = table2struct(readtable('.\Data\MES.xlsx'));

% Assign to Structs
AMB.LU          = Amb_exp;
WT.PowerCurve   = WT_exp;
AEL.LU          = AEL_exp;
PV.Inv_LU       = Inverter_exp;
SMR.LU          = SMR_exp;
MES.LU          = MES_exp;


%% Basic Parameters

% Thermodynamics
th.M_H2         = 2.016;
th.M_O2         = 31.99;
th.M_H2O        = 18.02;
th.M_CH4        = 16.04;
th.M_C2H6       = 30.07;
th.M_CO2        = 44.01;
th.M_SG         = 11.7;