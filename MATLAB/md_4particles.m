% Exactly adapted on https://www.utwente.nl/ctw/msm/education/msm_courses/apie-script-single.pdf
% Algorithm 1  (see this too https://www.youtube.com/watch?v=JOSK7Zy8iko or /home/devanandt/Downloads/Coupled Oscillators Coordinates PTW.mp4 )
clc,clear;
k=1000000;
m=10;
x_e=1;

N=4; % 4 particles
M1=[-1 1 0 0;1 -2 1 0;0 1 -2 1;0 0 1 -1];%for force matrix for 4 particles
M2=[-1 0 0 1]';%for force matrix for xe
x0 = cumsum(ones(1,N)-1)+randn(1,N);% initial positions in [1st particle 2nd particle] order

v0 = randn(1,N);% initial velocities from normal dist in [1st particle 2nd particle] order

tf = 1;% tf final time
dt = 0.0001; % step 

Nt=tf/dt; % total steps
x=zeros(3,N);
v=zeros(2,N);
x(2,:)=x0-dt*v0;
x(3,:)=x0;
% X=zeros(Nt,2);
% X(1:2,:)=[xn;xn_plus_1];
E1=[];
E2=[];
fid = fopen ('md_test.xyz', 'w');
for n=0:Nt
    x(1,:)= x(2,:);
    x(2,:)= x(3,:);
%     X(n+1,:)=x(2,:);
    f_n=k*(M1*x(2,:)' + M2*x_e);
    a_n=f_n'/m;
    x(3,:) = 2*x(2,:)-x(1,:)+((dt^2)*a_n);
    vn=(x(3,:)-x(1,:))/(2*dt);
    K=0.5*m*sum(vn.^2);
    P=0.5*k*sum((x(2,2:N)-x(2,1:N-1)-x_e).^2);
    E1=[E1 K];
    E2=[E2 P];
    fprintf (fid, '%d\n', N);
    fprintf (fid, 'frame num. %d\n', n);
    fprintf (fid, '18\t%f\t0\t0\n', x(2,1));
    fprintf (fid, '18\t%f\t0\t0\n', x(2,2));
    fprintf (fid, '18\t%f\t0\t0\n', x(2,3));
    fprintf (fid, '18\t%f\t0\t0\n', x(2,4));
    
end
fclose(fid);

