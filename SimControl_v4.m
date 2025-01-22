%% Tunis

clear
clc

addpath(genpath("D:\OneDrive - FEV Group GmbH\Dokumente - EXT_Abschlussarbeiten\MA RL P2X\MA_Salomon\RL_experimental\PB2M_001_007_RL"));

run('InitialConditions.m');

% Set Global Parameters
global_ST       = 1;
global_time     = [0:1:8784]';


%% CASE

WT.n_typeA          = 1; % Wind Turbine with 3.45 MW Peak Power
WT.n_typeB          = 2; % Wind Turbine with 4.2 MW Peak Power
PV.Pmax             = 4;

AEL.Pmax            = 12;
AEL.rLmax           = 1.15;
AEL.rLmin           = 0.2;
AEL.POverload       = AEL.rLmax * AEL.Pmax;
AEL.Pmin            = AEL.rLmin * AEL.Pmax;

Gasf.rLmax          = 1;
Gasf.rLmin          = 0.5;

Bttry.bit           = 1;
Bttry.Cap           = 50; % Capacity of the Battery in MWh;
Bttry.min           = 0.2 * Bttry.Cap;
Bttry.initSOC       = 0.5;
Bttry.eff           = 0.9;

CGH2.bit            = 1;
CGH2.Cap            = 10; % Capacity of the Hydrogen Storage in t
CGH2.min            = 0.1 * CGH2.Cap;
CGH2.initSOC        = 0.9;

chp.bit             = 0; % Use CHP to burn Syngas in Case of Shortage

CGO2.Cap            = 5000;
CGO2.initLvl        = 0;


%% SUBMODULES

run('Gasifier.m');
run('Photovoltaic.m');
run('WindTurbine.m');
run('AlkalineElectrolyzer.m');
run('AutothermalReforming.m');
run('Compressors.m');
run('MeOHsyn.m');
run('CombinedHeatPower.m');


%% Controller Calibration

Ctrl.CHP.req_max = 0.75;
Ctrl.AEL.fac = AEL.eff / 120;


%% Simulation of multiple Cases

mdl = "PB2M_001_007";
open(mdl);


%% Generate Result Matrix

Results = sim(mdl);

Modules = {'PV', 'WT', 'GRID', 'BAT', 'CHP', 'DRY', 'GASF', 'ATR', 'EL', 'CGH2', 'CGO2', 'MES', 'DIST'};
Flows = {'Elec', 'Heat', 'Cold', 'Steam', 'Oxygen', 'BiomassWet', 'BiomassDry', 'TotalSyngasRaw', 'TotalSyngasReformed', 'TotalHydrogen','TotalMeOHRaw' 'TotalWater' 'TotalMeOH'};

ResultsMatrix = zeros(length(Modules), length(Flows));

for j = 1:length(Flows)
    for i = 1:length(Modules)
        columnIndex = 13 + j;
        ResultsMatrix(i, j) = Results.(Modules{i})(end, columnIndex);
    end
end