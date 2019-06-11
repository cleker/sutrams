set(0,'DefaultFigureVisible','on');
plot_salt = figure;%('position', [-1500 100 1000 800]);

period = 601;%nod(end).itout;
x_matrix=reshape(nod(period).terms{xnod_idx},[inp.nn1,inp.nn2]);%Ssutra_lab
y_matrix=reshape(nod(period).terms{ynod_idx},[inp.nn1,inp.nn2]);%sutra_lab

pa_matrix = reshape(nod(period).terms{1,4},[inp.nn1,inp.nn2]); 
contourf(x_matrix,y_matrix,pa_matrix,100,'LineColor','none');%plot XZ section
%set(gcf,'Position',[-1500 100 1000 800])
xlabel('x (m)','FontSize',12);
ylabel('z (m)','FontSize',12);
colormap jet;
colorbar
c = colorbar;
%caxis([0 0.035]);
c.Label.String = 'Pressure (pa)';
c.FontSize= 12;
%%%%%%%
fileID = fopen('pressure_ics.txt','w');
fprintf(fileID,'%d   %d   %d   %d\n',nod(period).terms{1,4});
fclose(fileID);