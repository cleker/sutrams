
clear all
close all
% project name

% read input files
fil = readFIL;
%inp  = inpObj( fil.basename);
nod  = readNOD_MS( fil.basename);
%ele  = readELE_MS(fil.basename);
%bcop = readBCOP(name);
%bcof = readBCOF(name);

% index for p c and s
xnod_idx  = strcmp(nod(1).label,'X');
ynod_idx  = strcmp(nod(1).label,'Y');
znod_idx  = strcmp(nod(1).label,'Z');
p_idx  = strcmp(nod(1).label,'Pressure');
temp_idx  = strcmp(nod(1).label,'Temperature');
salt_idx  = strcmp(nod(1).label,'SALT');
PFOS_idx  = strcmp(nod(1).label,'PFOS');
saturation_idx  = strcmp(nod(1).label,'Saturation');
%sm_idx = strcmp(nod(1).label,'SM');

