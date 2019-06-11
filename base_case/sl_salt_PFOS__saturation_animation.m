set(0,'DefaultFigureVisible','on');
plot_PFOS = figure('position', [-1500 -200 1000 800]);
writerObj=VideoWriter('Salt_PFOS_concentration.mp4','MPEG-4');
open(writerObj);
period = nod(end).itout;
x_matrix=reshape(nod(1).terms{xnod_idx},[inp.nn1,inp.nn2]);%Ssutra_lab
y_matrix=reshape(nod(1).terms{ynod_idx},[inp.nn1,inp.nn2]);%sutra_lab
row1=1;
row2=241
col1=201
col2=261;
for i=0:1:period
clc;
clf;
if i==0
    i=1;
end
%%%%%%salt
subplot(3,1,1)
Salt_matrix = reshape(nod(i).terms{salt_idx},[inp.nn1,inp.nn2]); 
contourf(x_matrix(row1:row2,col1:col2),y_matrix(row1:row2,col1:col2),Salt_matrix(row1:row2,col1:col2),100,'LineColor','none');%plot XZ section
%axis equal
%xlabel('x (m)','FontSize',12);
ylabel('z (m)','FontSize',12);
colormap jet;
colorbar
c = colorbar;
caxis([0 0.035]);
c.Label.String = 'Concentration (kg/m3)';
c.FontSize= 12;
title([num2str(i)]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(3,1,2)
Sat_matrix = reshape(nod(i).terms{saturation_idx},[inp.nn1,inp.nn2]); 
contourf(x_matrix(row1:row2,col1:col2),y_matrix(row1:row2,col1:col2),Sat_matrix(row1:row2,col1:col2),100,'LineColor','none');%plot XZ section
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
subplot(3,1,3)
PFOS_matrix = reshape(nod(i).terms{PFOS_idx},[inp.nn1,inp.nn2]); 
contourf(x_matrix(row1:row2,col1:col2),y_matrix(row1:row2,col1:col2),PFOS_matrix(row1:row2,col1:col2),100,'LineColor','none');%plot XZ section
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