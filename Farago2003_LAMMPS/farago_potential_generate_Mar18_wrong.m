clear, clc, close all

%%% PARAMETERS %%%
sigma = 1.00;
epsilon = 1.00;

r_init = 0.000001;
r_max = sigma * 2.5;
r = (r_init:.01:r_max+0.01)';
N=(1:length(r))';



fileID = fopen('farago2003_tabulated_potential_Mar18.dat','w');
fprintf(fileID,'# Tabulated potential for water-free Farago 3-bead lipid model\n\n');
%force = - gradient of energy. explicitly calculating the vectors after
%sybolic diff from wolfram alpha to avoid silly mistakes.
V_11= (4*0.1875*((1.1 ./ r).^12 - (1.1 ./ r).^6))- (4*0.1875*((1.1 / 2.5)^12 - (1.1 / 2.5)^6)) - (((7.97202*(2.5)^6-28.2459)/((2.5)^13)).*(r-2.5)) - (0.5*((367.197-(55.8041*2.5^6))/(2.5^14)).*(r-2.5).^2);
F_11=0.101837 + (28.2459./(r.^13)) - (7.97202./(r.^7)) - (0.0355861.*r);
A=[N r V_11 F_11]';
A(:,1)=[1;0.000001;0;0];% zero correction 
fprintf(fileID,'HEAD_HEAD\n');
fprintf(fileID,'N 251 R 0.000001 2.500000\n\n');
fprintf(fileID,'%d %1.6f %1.6f %1.6f\n',A);

fprintf(fileID,'\n\n');
V_22=(4*1.75*((1.05 ./ r).^12 - (1.05 ./ r).^6))-(4*1.75*((1.05 / 2.5)^12 - (1.05 / 2.5)^6)) - ((56.284*(2.5^6)-150.852)/(2.5^13)).*(r-2.5) - (0.5*((1961.08-(393.988*2.5^6))/2.5^14).*(r-2.5).^2);
F_22=0.723553 + (150.852./r.^13) - (56.284./r.^7) - (0.25294.*r);
A=[N r V_22 F_22]';
A(:,1)=[1;0.000001;0;0];% zero correction 
fprintf(fileID,'TAIL1_TAIL1\n');
fprintf(fileID,'N 251 R 0.000001 2.500000\n\n');
fprintf(fileID,'%d %1.6f %1.6f %1.6f\n',A);

fprintf(fileID,'\n\n');
V_33=(4*1.875*((1 ./ r).^12 - (1 ./ r).^6) - 4*1.875*((1 / 2.5)^12 - (1 / 2.5)^6) - ( ((45*2.5^6-90)/2.5^13).*(r-2.5) )-0.5*((45*((7*r.^6-26)./r.^14))).*(r-2.5).^2);
F_33=(51187.5 - 38025.* r + 7110* r.^2 - 7875* r.^6 + 5512.5* r.^7 - 990* r.^8 + 0.073124 * r.^15)./r.^15;
A=[N r V_33 F_33]';
A(:,1)=[1;0.000001;0;0];% zero correction 
fprintf(fileID,'TAIL2_TAIL2\n');
fprintf(fileID,'N 251 R 0.000001 2.500000\n\n');
fprintf(fileID,'%d %1.6f %1.6f %1.6f\n',A);

fprintf(fileID,'\n\n');
V_23=4*375*((0.525 ./ r).^2 - (0.525 ./ r).^1) - 4*375*((0.525 / 2.5)^2 - (0.525 / 2.5)^1)  - ((-826.875 + 787.5 *2.5)/2.5^3).*(r-2.5)-0.5*((4725 *(-2.1 + 2.5))/2.5^5).*(r-2.5).^2;
F_23=(24.696 + (826.875./r.^3) - (787.5./r.^2) + 19.3536 .*r);
A=[N r V_23 F_23]';
A(:,1)=[1;0.000001;0;0];% zero correction 
fprintf(fileID,'TAIL1_TAIL2\n');
fprintf(fileID,'N 251 R 0.000001 2.500000\n\n');
fprintf(fileID,'%d %1.6f %1.6f %1.6f\n',A);

fprintf(fileID,'\n\n');
V_12=4*1.1375*(1.15 ./ r).^12 - 4*1.1375*(1.15 / 2.5)^12 - (-292.124/2.5^13).*(r-2.5)-(0.5*(3797.61/2.5^14)*(r-2.5).^2);
F_12=(-0.0274457 + (292.124./r.^13) + (0.0101941 .*r));
A=[N r V_12 F_12]';
A(:,1)=[1;0.000001;0;0];% zero correction 
fprintf(fileID,'HEAD_TAIL1\n');
fprintf(fileID,'N 251 R 0.000001 2.500000\n\n');
fprintf(fileID,'%d %1.6f %1.6f %1.6f\n',A);

fprintf(fileID,'\n\n');
V_13=4*200*(1.4 ./ r).^18 - 4*200*(1.4 / 2.5)^18 - (-(6.14706*10^6)/2.5^19)*(r-2.5) -0.5*(116794140/2.5^20)*(r-2.5).^2;
F_13=(-3.37938 + ((6.14706*10^6)./r.^19) + (1.28417*r));
A=[N r V_13 F_13]';
A(:,1)=[1;0.000001;0;0];% zero correction 
fprintf(fileID,'HEAD_TAIL2\n');
fprintf(fileID,'N 251 R 0.000001 2.500000\n\n');
fprintf(fileID,'%d %1.6f %1.6f %1.6f\n',A);

fclose(fileID);
