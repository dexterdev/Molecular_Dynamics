 %Ap for 500 lipid bilayer sheet = 30^2 , corresponds 
 %to Area per lipid = 1.8
 
 % use this script to produce XYZ file
 % convert it to pdb via vmd
 % edit it using pdbread and pdbwrite here

% Ref: https://math.stackexchange.com/questions/1585975/how-to-generate-random-points-on-a-sphere


clear,clc

apl=1.9;
r = 15; % radius of the sphere
n=round((4*pi*r^2)/apl);% number of points
u1=rand(1,n);
u2=rand(1,n);
lambda=acos(2.*u1-1)-(pi/2);
phi=2*pi.*u2;


xp1    = r.*cos(lambda).*cos(phi);
yp1    = r.*cos(lambda).*sin(phi);
zp1    = r.*sin(lambda);  


r = r-1; % radius of the sphere
xp2    = r.*cos(lambda).*cos(phi);
yp2    = r.*cos(lambda).*sin(phi);
zp2    = r.*sin(lambda);  


r = r-1; % radius of the sphere
xp3    = r.*cos(lambda).*cos(phi);
yp3    = r.*cos(lambda).*sin(phi);
zp3    = r.*sin(lambda); 

x1=[xp1;xp2;xp3];
x1=reshape(x1,[1 numel(x1)]);
y1=[yp1;yp2;yp3];
y1=reshape(y1,[1 numel(y1)]);
z1=[zp1;zp2;zp3];
z1=reshape(z1,[1 numel(z1)]);

apl=1.8;
r = 10; % radius of the sphere
n=round((4*pi*r^2)/apl);% number of points
u1=rand(1,n);
u2=rand(1,n);
lambda=acos(2.*u1-1)-(pi/2);
phi=2*pi.*u2;


xp6    = r.*cos(lambda).*cos(phi);
yp6    = r.*cos(lambda).*sin(phi);
zp6    = r.*sin(lambda); 

r = r+1; % radius of the sphere
xp5    = r.*cos(lambda).*cos(phi);
yp5    = r.*cos(lambda).*sin(phi);
zp5    = r.*sin(lambda);

r=r+1;
xp4    = r.*cos(lambda).*cos(phi);
yp4    = r.*cos(lambda).*sin(phi);
zp4    = r.*sin(lambda);  


x2=[xp4;xp5;xp6];
x2=reshape(x2,[1 numel(x2)]);
y2=[yp4;yp5;yp6];
y2=reshape(y2,[1 numel(y2)]);
z2=[zp4;zp5;zp6];
z2=reshape(z2,[1 numel(z2)]);


x=[x1 x2];
y=[y1 y2];
z=[z1 z2];
XYZ=[x;y;z]';
N=length(XYZ);


fID = fopen('vesicle_rad15.xyz','w');
fprintf(fID,'%d\n',N);  %to add number of atoms to first line
fprintf(fID,'\n');      %to leave one blank line
for i=1:N
    fprintf(fID,'L     %16.10f     %16.10f     %16.10f\n' ,  XYZ(i,:));
end
fclose(fID);
