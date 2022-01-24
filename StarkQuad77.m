% -----------------------PID Control of a Quadcopter-----------------------
clear all; clc;
open('StarkQuad77.m')
% Quadcopter's parameters:

% Fully loaded

m=10.800;                                           % Kg

Ixx=5.296671410;                                    % Kg.m2
Iyy=5.790964671;                                    % Kg.m2
Izz=3.348512883;                                    % Kg.m2


I=[Ixx 0 0; 0 Iyy 0; 0 0 Izz];

% The thrust factor is calculated by dividing the maximum thrust by the
% squared rad/s of the propeller

% The drag factor is calculated by multiplying the thrust factor by tan (4
% deg)

% l is the length between two opposed propellers 


b=1.0444e-4;                                        % Thrust factor (N/rpm^2)
d=7.3031e-6;                                        % Drag factor (Nm/rpm^2)
l=0.41123*2;                                        % Distance between two opposite propellers (m)

speed_rpm=4809;                                     % Nominal Speed of the motors in rpm
speed_rads=505;                                     % Nominal Speed of the motors in rad/s

% General Parameters:

g=9.81;                                             % Gravitational Acceleration


% Upper and Lower Limits

u1_max=b*4*speed_rads^2;
u1_min=0;
u2_max=b*l*speed_rads^2;
u2_min=-u2_max;
u3_max=u2_max;
u3_min=u2_min;
u4_max=d*l*2*speed_rads^2;
u4_min=-u4_max;


C=load('trajectory.mat');
Ct=load('Plottrajectory.mat');
x=57;
y=95;
z=0;

x=[x;(Ct.xt).'];
y=[y;(Ct.yt).'];
z=[z;(Ct.zt+0.43).'];
Index=0:1:length(x)-1;
Index=(Index).';
Index=int32(Index);
M=[x z y];
CP=load('plot.mat');
Xd=C.x-57;
Yd=C.y-95;
Zd=C.z;
t=C.t;
Time=zeros(1,length(Xd));
for i=1:length(Xd)
    Time(i)=t*(i-1);
end
Final_Time_1=Time(length(Time));

Psi_d=10;
Phi_d=20;
Tetta_d=30;
xp=CP.x(end);
yp=CP.y(end);

sim('StarkQuadSimCL7772.slx');