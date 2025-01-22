%% Tunis

clear
clc

addpath(genpath("D:\OneDrive - FEV Group GmbH\Dokumente - EXT_Abschlussarbeiten\MA RL P2X\MA_Salomon\RL_experimental"));

run('InitialConditions.m');

% Set Global Parameters
global_ST       = 1;
global_time     = [0:1:8784]';

%set RL related Params
%numTimesteps = 10000;

%% Case Parameters

% Inputs
WT.n_typeA          = 2; % Wind Turbine with 3.45 MW Peak Power
WT.n_typeB          = 1; % Wind Turbine with 4.2 MW Peak Power
PV.Pmax             = 3;

Biomass             = 80000; % yearly Biomass in t


Grd.bit             = 0; % use Grid when cheap

Bttry.Cap           = 60; % Capacity of the Battery in MWh;
Bttry.eff           = 0.9;
Bttry.min           = 0.05 * Bttry.Cap;

AEL.Pmax            = 9;
AEL.POverload       = AEL.Pmax * 1.15;
AEL.Pmin            = 0.5 * AEL.POverload;


% Oxygen Storage
CGO2_cap            = 5000;
CGO2.initLvl        = 0;


% Grid Parameter
Grd.cbuy            = 60;
Fncs.Grid_purchase   = [62 60 57 54 57 64 87 111 111 87 72 60 60 60 68 77 95 117 123 127 111 96 95 82]; % hourly Grid costs €/MWh

%% SUBMODULES

run('Gasifier.m');
run('Photovoltaic.m');
run('WindTurbine.m');
run('AlkalineElectrolyzer.m');
run('AutothermalReforming.m');
run('Compressors.m');
run('MeOHsyn.m');
run('CombinedHeatPower.m');


%% Simulation of multiple Cases

mdl = "PB2M_001_003_RL";
open(mdl);


%% Generate Single Results

Results = sim(mdl);

TotalElec            = [Results.PV(end, 11) Results.WT(end, 11) Results.Grid(end, 11) Results.BAT(end, 11) Results.CHP(end, 11) Results.ElecHT(end, 11) Results.DRYER(end, 11) Results.GASF(end, 11) Results.SMR(end, 11) Results.AEL(end, 11) Results.MES(end, 11)]';
TotalHeat_850        = [Results.PV(end, 12) Results.WT(end, 12) Results.Grid(end, 12) Results.BAT(end, 12) Results.CHP(end, 12) Results.ElecHT(end, 12) Results.DRYER(end, 12) Results.GASF(end, 12) Results.SMR(end, 12) Results.AEL(end, 12) Results.MES(end, 12)]';
TotalHeat_150        = [Results.PV(end, 13) Results.WT(end, 13) Results.Grid(end, 13) Results.BAT(end, 13) Results.CHP(end, 13) Results.ElecHT(end, 13) Results.DRYER(end, 13) Results.GASF(end, 13) Results.SMR(end, 13) Results.AEL(end, 13) Results.MES(end, 13)]';
TotalHeat_90         = [Results.PV(end, 14) Results.WT(end, 14) Results.Grid(end, 14) Results.BAT(end, 14) Results.CHP(end, 14) Results.ElecHT(end, 14) Results.DRYER(end, 14) Results.GASF(end, 14) Results.SMR(end, 14) Results.AEL(end, 14) Results.MES(end, 14)]';
TotalHeat_35         = [Results.PV(end, 15) Results.WT(end, 15) Results.Grid(end, 15) Results.BAT(end, 15) Results.CHP(end, 15) Results.ElecHT(end, 15) Results.DRYER(end, 15) Results.GASF(end, 15) Results.SMR(end, 15) Results.AEL(end, 15) Results.MES(end, 15)]';
TotalHC              = [Results.PV(end, 16) Results.WT(end, 16) Results.Grid(end, 16) Results.BAT(end, 16) Results.CHP(end, 16) Results.ElecHT(end, 16) Results.DRYER(end, 16) Results.GASF(end, 16) Results.SMR(end, 16) Results.AEL(end, 16) Results.MES(end, 16)]';
TotalCO2             = [Results.PV(end, 17) Results.WT(end, 17) Results.Grid(end, 17) Results.BAT(end, 17) Results.CHP(end, 17) Results.ElecHT(end, 17) Results.DRYER(end, 17) Results.GASF(end, 17) Results.SMR(end, 17) Results.AEL(end, 17) Results.MES(end, 17)]';
TotalH2              = [Results.PV(end, 18) Results.WT(end, 18) Results.Grid(end, 18) Results.BAT(end, 18) Results.CHP(end, 18) Results.ElecHT(end, 18) Results.DRYER(end, 18) Results.GASF(end, 18) Results.SMR(end, 18) Results.AEL(end, 18) Results.MES(end, 18)]';
TotalO2              = [Results.PV(end, 19) Results.WT(end, 19) Results.Grid(end, 19) Results.BAT(end, 19) Results.CHP(end, 19) Results.ElecHT(end, 19) Results.DRYER(end, 19) Results.GASF(end, 19) Results.SMR(end, 19) Results.AEL(end, 19) Results.MES(end, 19)]';
TotalMeOH            = [Results.PV(end, 20) Results.WT(end, 20) Results.Grid(end, 20) Results.BAT(end, 20) Results.CHP(end, 20) Results.ElecHT(end, 20) Results.DRYER(end, 20) Results.GASF(end, 20) Results.SMR(end, 20) Results.AEL(end, 20) Results.MES(end, 20)]';

ResultsMatrix = [TotalElec TotalHeat_850 TotalHeat_150 TotalHeat_90 TotalHeat_35 TotalHC TotalCO2 TotalH2 TotalO2 TotalMeOH];