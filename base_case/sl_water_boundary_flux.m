
fileID = fopen('NODEWISE_FLUID_MSSS.DAT','r');
formatSpec = '%f %f ';
size = [2 Inf];
B = fscanf(fileID,formatSpec,size);
%clear size
%B_row = size(B,2);
fclose(fileID);
%nod_bnd = B(1,1:inp.npbc);
%period = 2400;
for m = 1:period
Qflux(m).PBC = B(:,inp.npbc*(m-1)+1:inp.npbc*m);%[M/s]
end
inp.delt=3600;
period_day = 100;%inp.itmax/(86400/inp.delt);
n = 86400/inp.delt;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(0,'DefaultFigureVisible','on');
plot_flux = figure('position', [-1500 -200 1000 800]);
writerObj=VideoWriter('Boundary_water_flux.mp4','MPEG-4');
open(writerObj)
for j=300:324
    Q_flux_period = -Qflux(j).PBC(2,1:inp.npbc)*inp.delt;
    plot(nod(1).terms{xnod_idx}(B(1,1:inp.npbc)),Q_flux_period);%M/s->M/h->M/d
    xlabel('x (m)','FontSize',12);
    ylabel('Flow mass (kg/h)','FontSize',12);
    axis([-20 30 -80 30]);
    title([num2str(j)]);
    pause(2)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    frame = getframe(plot_flux);%h->save title axis colorbar etc.
    writeVideo(writerObj,frame);
end
close(writerObj);