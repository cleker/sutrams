set(0,'DefaultFigureVisible','on');
plot_PFOS = figure('position', [-1500 -200 1000 800]);
writerObj=VideoWriter('Salt_PFOS_concentration.mp4','MPEG-4');
open(writerObj);
period = 2400;
x_matrix=reshape(nod(1).terms{xnod_idx},[inp.nn1,inp.nn2]);%Ssutra_lab
y_matrix=reshape(nod(1).terms{ynod_idx},[inp.nn1,inp.nn2]);%sutra_lab

for i=0:1:period
clc;
clf;
if i==0
    i=1;
end
subplot(4,1,1)
Temp_matrix = reshape(nod(i).terms{temp_idx},[inp.nn1,inp.nn2]); 
contourf(x_matrix,y_matrix,Temp_matrix,100,'LineColor','none');%plot XZ section
%set(gcf,'Position',[-1500 100 1000 800])
%axis equal
%xlabel('x (m)','FontSize',12);
ylabel('z (m)','FontSize',12);
colormap parula;
colorbar
c = colorbar;
%caxis([0 0.035]);
c.Label.String = 'Temperature (°C)';
c.FontSize= 12;
title([num2str(i)]);
%%%%%%salt
subplot(4,1,2)
Salt_matrix = reshape(nod(i).terms{salt_idx},[inp.nn1,inp.nn2]); 
contourf(x_matrix,y_matrix,Salt_matrix,100,'LineColor','none');%plot XZ section
%axis equal
%xlabel('x (m)','FontSize',12);
ylabel('z (m)','FontSize',12);
colormap jet;
colorbar
c = colorbar;
caxis([0 0.035]);
c.Label.String = 'Concentration (kg/m3)';
c.FontSize= 12;
%title([num2str(i)]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(4,1,3)
Sat_matrix = reshape(nod(i).terms{saturation_idx},[inp.nn1,inp.nn2]); 
contourf(x_matrix,y_matrix,Sat_matrix,100,'LineColor','none');%plot XZ section
%axis equal
%xlabel('x (m)','FontSize',12);
ylabel('z (m)','FontSize',12);
colormap jet;
colorbar
c = colorbar;
%caxis([0 0.035]);
c.Label.String = 'Saturation (-)';
c.FontSize= 12;
%title([num2str(i)]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(4,1,4)
PFOS_matrix = reshape(nod(i).terms{PFOS_idx},[inp.nn1,inp.nn2]); 
contourf(x_matrix,y_matrix,PFOS_matrix,100,'LineColor','none');%plot XZ section
%axis equal
xlabel('x (m)','FontSize',12);
ylabel('z (m)','FontSize',12);
colorbar
c = colorbar;
%caxis([0 10]);
c.Label.String = 'Concentration (kg/m3)';
c.FontSize= 12;
%title([num2str(i)]);
%%%%%%%mp4
frame = getframe(plot_PFOS);%h->save title axis colorbar etc.
writeVideo(writerObj,frame);
end

close(writerObj);