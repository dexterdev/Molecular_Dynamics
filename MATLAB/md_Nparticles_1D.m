% Exactly adapted from https://www.utwente.nl/ctw/msm/education/msm_courses/apie-script-single.pdf
% Algorithm 1  ( as in page 25 , but for N particles and one dimensional case)
clc,clear;
k=100;
m=1;
x_e=1;

N=50; % N particles
M1=eye(N+1);
temp=M1(2:end,1:end-1);
temp_=M1(2:end,1:end-1)';
M1=-2*M1(1:N,1:N)+temp+temp_;
M1(1)=-1;
M1(end)=-1;
M2=zeros(1,N)';
M2(1)=-1;
M2(end)=1;
x0 = cumsum(ones(1,N))-1;% initial positions in [1st particle 2nd particle ...] order

v0 = randn(1,N);% initial velocities from normal dist in [1st particle 2nd particle ...] order

tf = 10;% tf final time
dt = 0.0001; % step 

Nt=tf/dt; % total steps
x=zeros(3,N);
x(2,:)=x0-dt*v0;
x(3,:)=x0;
E1=[];
E2=[];
fid = fopen ('md_test.xyz', 'w');
for n=0:Nt
    x(1,:)= x(2,:);
    x(2,:)= x(3,:);
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
    for j=1:N
        fprintf (fid, '18\t%f\t0\t0\n', x(2,j));
    end
    
end
fclose(fid);