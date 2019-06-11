clear x_matrix y_matrix Temp_matrix Salt_matrix Sat_matrix density_matrix PFOS_matrix
clear PFOS_mass PFOS_out PFOS_sob PFOS_liq
set(0,'DefaultFigureVisible','on');
period = nod(end).itout;
x_matrix=reshape(nod(1).terms{xnod_idx},[inp.nn1,inp.nn2]);%Ssutra_lab
y_matrix=reshape(nod(1).terms{ynod_idx},[inp.nn1,inp.nn2]);%sutra_lab

%%caculate elements area: only use for the elemet delta x are the same for top and botton
%% delta y are different between left and right
inp.drwdu = 0;
inp.urhow0 = 4;

por_matrix = reshape(inp.por_actual,[inp.nn1,inp.nn2]); 
for i=0:1:period
if i==0
    i=1;
end
%%%%density
Temp_matrix = reshape(nod(i).terms{temp_idx},[inp.nn1,inp.nn2]);
Salt_matrix = reshape(nod(i).terms{salt_idx},[inp.nn1,inp.nn2]);
%mesh(x_matrix,y_matrix,Salt_matrix);
Sat_matrix = reshape(nod(i).terms{saturation_idx},[inp.nn1,inp.nn2]);
%Sat_matrix(Sat_matrix<1)=0;
%density_matrix = inp.rhow0+inp.bdrwdu.*(Salt_matrix-inp.burhow0)+...
%               inp.drwdu.*(Temp_matrix-inp.urhow0);
density_matrix = 1000;          
%%%caculate PFOS concentration in each elemets from nodes
x1=0;%inp.chi1_3
PFOS_matrix = reshape(nod(i).terms{PFOS_idx},[inp.nn1,inp.nn2]); 
PFOS_mass_matrix = (por_matrix.*Sat_matrix.*density_matrix+...
                  (1-por_matrix).*inp.rhos.*x1.*inp.rhow0).*PFOS_matrix.*VOL;
PFOS_mass_liq = (por_matrix.*Sat_matrix.*density_matrix).*PFOS_matrix.*VOL;
PFOS_mass_sob = ( (1-por_matrix).*inp.rhos.*x1.*inp.rhow0).*PFOS_matrix.*VOL;
PFOS_mass(i) = sum(sum(PFOS_mass_matrix)); 
PFOS_liq(i) = sum(sum(PFOS_mass_liq));
PFOS_sob(i) = sum(sum(PFOS_mass_sob));
%xlabel('x (m)','FontSize',12);
%ylabel('z (m)','FontSize',12);
end

%set(gcf,'Position',[500 100 1000 800])
delt=1;%inp.delt
x_time = 1:delt:period;

subplot(3,1,1)
plot(x_time,PFOS_mass)
ylabel('Total mass (kg)')
hold on
subplot(3,1,2)
plot(x_time,PFOS_liq)
ylabel('Solute (kg)')
subplot(3,1,3)
plot(x_time,PFOS_sob)
xlabel('Period (day)') 
ylabel('Adsorbate (kg)')