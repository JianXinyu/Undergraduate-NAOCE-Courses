clear all;
close all;
clc;

% h1ID = fopen('wave_height_a_year.dat');
% h2ID = fopen("wave_height_hundred_year.dat");
% height1 = textscan(h1ID,'%f %f');
% height2 = textscan(h2ID,'%f %f');
% figure(1)
% set(gcf,'color','white');
% plot(height1{1,1}(:,1),height1{1,2}(:,1));
% xlabel('Time/s','FontWeight','bold');
% ylabel('Height/cm','FontWeight','bold');
% title('Wave Height Changing With Time(A Year)');
% saveas(gcf,'Wave_Height_Plot_A_Year.jpg');
% figure(2)
% set(gcf,'color','white');
% plot(height2{1,1}(:,1),height2{1,2}(:,1));
% xlabel('Time/s','FontWeight','bold');
% ylabel('Height/cm','FontWeight','bold');
% title('Wave Height Changing With Time(Hundred Year)');
% saveas(gcf,'Wave_Height_Plot_Hundred_Year.jpg');
% 
% 
% f1ID = fopen('1yearModel.dat');
% f2ID = fopen('100yearModel.dat');
% force1 = textscan(f1ID,'%f %f %f %f %f %f %f %f %f %f %f %f %f');
% force2 = textscan(f2ID,'%f %f %f %f %f %f %f %f %f %f %f %f %f');
% 
% t_force1 = 0:0.04:0.04*(length(force1{1,1})-1);
% t_force2 = 0:0.04:0.04*(length(force2{1,1})-1);
% name_force = ['Force-X ';'Force-Y ';'Force-Z '];
% for i = 11:13 %一年一遇
% 	figure(i-8)
% 	set(gcf,'color','white');
% 	plot(t_force1,force1{1,i});
% 	ylabel('Force/kg','FontWeight','bold');
% 	xlabel('Time/s','FontWeight','bold');
% 	title([name_force(i-10,:),'Changing with Time(A Year)'],'FontWeight','bold');
% 	saveas(gcf,[name_force(i-10,:),'Changing with Time(A Year).jpg']);
% 
% 	interval = 0.04;
% 	f0 = 1/interval;
% 	N = length(t_force1);
% 	mag = abs(fft(force1{1,i}));
% 	f = f0*(0:N/2-1)/N;
% 	figure(i-5);
% 	set(gcf,'color','white');
% 	plot(f(1:end),mag(1:floor(N/2)));
% 	ylabel('','FontWeight','bold');
% 	xlabel('Frequency/Hz','FontWeight','bold');
% 	title([name_force(i-10,:),'Frequency Spectrum(A Year)'],'FontWeight','bold');
% 	saveas(gcf,[name_force(i-10,:),'Frequency_Spectrum(A Year).jpg']);
% end
% for i = 11:13 %百年一遇
% 	figure(i-2)
% 	set(gcf,'color','white');
% 	plot(t_force2,force2{1,i});
% 	ylabel('Force/kg','FontWeight','bold');
% 	xlabel('Time/s','FontWeight','bold');
% 	title([name_force(i-10,:),'Changing with Time(A Hundred Years)'],'FontWeight','bold');
% 	saveas(gcf,[name_force(i-10,:),'Changing with Time(A Hundred Years).jpg']);
% 
% 	interval = 0.04;
% 	f0 = 1/interval;
% 	N = length(t_force2);
% 	mag = abs(fft(force2{1,i}));
% 	f = f0*(0:N/2-1)/N;
% 	figure(i+1);
% 	set(gcf,'color','white');
% 	plot(f(1:end),mag(1:floor(N/2)));
% 	ylabel('','FontWeight','bold');
% 	xlabel('Frequency/Hz','FontWeight','bold');
% 	title([name_force(i-10,:),'Frequency Spectrum(A Hundred Years)'],'FontWeight','bold');
% 	saveas(gcf,[name_force(i-10,:),'Frequency_Spectrum(A Hundred Years).jpg']);
% end


zeroID = fopen('zero.tsv');
motion1ID = fopen('1yearballast.tsv');
motion2ID = fopen('100yearballast.tsv');
zero = textscan(zeroID, '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f');
motion1 = textscan(motion1ID, '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f');
motion2 = textscan(motion2ID, '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f');

for i = 1:16
    motion_zero(i) = mean(zero{1,i});
    motion1{1,i} = motion1{1,i} - motion_zero(i);
    motion2{1,i} = motion2{1,i} - motion_zero(i);
end
t_motion1 = 0:0.04:0.04*(length(motion1{1,1})-1);
t_motion2 = 0:0.04:0.04*(length(motion2{1,1})-1);
name = ['    X';'    Y';'    Z';' Roll';'Pitch';'  Yaw'];
for i = 1:6%一年一遇
	figure(i+14)
	set(gcf,'color','white');
 	plot(t_motion1,motion1{1,i});
    if i <= 3
        ylabel('Distance/mm','FontWeight','bold');
        xlabel('Time/s','FontWeight','bold');
    end
    if i > 3
        ylabel('\phi /°','FontWeight','bold');
        xlabel('Time/s','FontWeight','bold');
    end
	title([name(i,:),' Motion Curve in A Year'],'FontWeight','bold');
	saveas(gcf,[name(i,:),' Motion Curve in A Year','.jpg']);

	interval = 0.04;
	f0 = 1/interval;
	N = length(t_motion1);
	mag = abs(fft(motion1{:,i}));
	f = f0*(0:N/2-1)/N;
	figure(i+20);
	set(gcf,'color','white');
 	plot(f(1:end),mag(1:floor(N/2)));
	ylabel('Power W','FontWeight','bold');
	xlabel('Frequency/Hz','FontWeight','bold');
	title([name(i,:),' Frequence Spectrum in A Year'],'FontWeight','bold');
	saveas(gcf,[name(i,:),' Frequence Spectrum in A Year.jpg']);
end
for i = 1:6%百年一遇
	figure(i+26)
	set(gcf,'color','white');
	plot(t_motion2,motion2{1,i});
    if i <= 3
        ylabel('Distance/mm','FontWeight','bold');
        xlabel('Time/s','FontWeight','bold');
    end
    if i > 3
        ylabel('\phi /°','FontWeight','bold');
        xlabel('Time/s','FontWeight','bold');
    end
	title([name(i,:),' Motion Curve in A Hundred Years'],'FontWeight','bold');
	saveas(gcf,[name(i,:),' Motion Curve in A Hundred Years','.jpg']);

	interval = 0.04;
	f0 = 1/interval;
	N = length(t_motion2);
	mag = abs(fft(motion2{:,i}));
	f = f0*(0:N/2-1)/N;
	figure(i+32);
	set(gcf,'color','white');
	plot(f(1:end),mag(1:floor(N/2)));
	ylabel('Power W','FontWeight','bold');
	xlabel('Frequency/Hz','FontWeight','bold');
	title([name(i,:),' Frequence Spectrum in A Hundred Years'],'FontWeight','bold');
	saveas(gcf,[name(i,:),' Frequence Spectrum in A Hundred Years.jpg']);
end



% force = force+0.2013;
% for i = 1:9
% 	figure(i)
% 	set(gcf,'color','white');
% 	plot(t_force1,force1{1,i+1},'LineWidth',2);
% 	ylabel('Anchor Force/N','FontWeight','bold');
% 	xlabel('Time/s','FontWeight','bold');
% 	title(['Time History of Anchor Chain No.',num2str(i)],'FontWeight','bold');
% 	saveas(gcf,['Time History of Anchor Chain No.',num2str(i),' .jpg']);
% 
% 	interval = 0.04;
% 	f0 = 1/interval;
% 	N = length(t_force1);
% 	mag = abs(fft(force1{1,i+1}));
% 	f = f0*(0:N/2-1)/N;
% 	figure(9+i);
% 	set(gcf,'color','white');
% 	plot(f(1:end),mag(1:floor(N/2)),'LineWidth',2);
% 	ylabel('Power W','FontWeight','bold');
% 	xlabel('Frequency f/Hz','FontWeight','bold');
% 	title(['Power Spectrum of Anchor Chain No.',num2str(i)],'FontWeight','bold');
% 	saveas(gcf,['Power Spectrum of Anchor Chain No.',num2str(i),' .jpg']);
% end
