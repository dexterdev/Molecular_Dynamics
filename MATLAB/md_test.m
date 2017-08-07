% based on https://www.utwente.nl/ctw/msm/education/msm_courses/apie-script-single.pdf
% Algorithm 1  (see this too https://www.youtube.com/watch?v=JOSK7Zy8iko or /home/devanandt/Downloads/Coupled Oscillators Coordinates PTW.mp4 )
clc,clear;
k=10000000;
m=100;
x_e=1;

N=4; % 4 particles
M1=[-1 1 0 0;1 -2 1 0;0 1 -2 1;0 0 1 -1];%for force matrix
M2=[-1 0 0 1]';%for force matrix for xe
x0 = [-0.2 1 1.6 2];% initial positions in [1st particle 2nd particle] order

v0 = randn(1,4);% initial velocities from normal dist in [1st particle 2nd particle] order

tf = 10;% tf final time
dt = 0.001; % step 

Nt=tf/dt; % total steps
x=zeros(2,4);
v=zeros(2,4);
xn=x0-dt*v0;
xn_plus_1=x0;
% X=zeros(Nt,2);
% X(1:2,:)=[xn;xn_plus_1];

fid = fopen ('md_test.xyz', 'w');
for n=0:Nt
    x(1,:)= xn;
    x(2,:)= xn_plus_1;
%     X(n+1,:)=x(2,:);
    f_n=k*(M1*x(2,:)' + M2*x_e);
    a_n=f_n'/m;
    xn= xn_plus_1;
    xn_plus_1 = 2*x(2,:)-x(1,:)+((dt^2)*a_n);
    vn=(xn_plus_1-x(1,:))/(2*dt);
    fprintf (fid, '4\n');
    fprintf (fid, 'frame num. %d\n', n);
    fprintf (fid, '18\t%f\t0\t0\n', x(2,1));
    fprintf (fid, '18\t%f\t0\t0\n', x(2,2));
    fprintf (fid, '18\t%f\t0\t0\n', x(2,3));
    fprintf (fid, '18\t%f\t0\t0\n', x(2,4));
    
end
fclose(fid);

