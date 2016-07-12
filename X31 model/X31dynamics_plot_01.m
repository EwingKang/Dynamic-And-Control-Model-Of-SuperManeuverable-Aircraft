%{
****************************** DISCLAIMER *********************************
    I, ±d¤ß«³, personally create and debug all parts of this simulation program.
However, it is not me nor anyone that truely "invent" the numerical aircraft 
model like this one. It is based on the long history of all mathematical, 
science, and engineering of humanity. Like Isaac Newton said, "standing on
 the shoulders of giants".
    The aerodynamical parameter of the vehicle in this project comes from 
the thesis written by Snell [1]. In his work, he collected and estimated the
data from multiple source including all major aero-astro research and develop
institude around the world. Also, the method to model the dynamics of the 
vehicle and the controller implemented including the NDI and Gain Scheduling 
also came from his thesis.              
    The quaternion kinematics mainly reference to the toturial paper done by 
Trawny [2], where he collected and organized all fundamental properties and
mathematical operation of such system.                   
    This model is released to improve our ability to understand and develop 
control methodology of aerial vehicle system similar to this one. It is 
released free of charge now and always will be so in the hope of sharing the
knowledge as much as possible and making this world a better place. 
    However, despite my greatest effort to ensure the correctness of the 
code, it is not garantee to be free of bug or other issue. You are free to 
use and modify the program to meet your need but I'm not responsible for any
potential risk or damaged of any kind.
    Long live and prosper
***************************** Liscence: GPLv2 ****************************
Dynamic Model of Super-Maneuverable Aircraft
Copyright (C) 2016 Hsin-Yi Kang
DAA, NCKU
f039281310@yahoo.com.tw
This program is free software; you can redistribute it and/or modify it   
under the terms of the GNU General Public License as published by the Free 
Software Foundation; either version 2 of the License, or (at your option) 
any later version. This program is distributed in the hope that it will be 
useful, but WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General 
Public License for more details. You should have received a copy of the GNU 
General Public License along with this program; if not, write to the Free 
Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, 
MA 02110-1301, USA. 
**************************** Main Reference *******************************
X31:
    [1] Snell, Sidney Antony, "Nonlinear Dynamic-Inversion Flight Control 
of Supermaneuverable Aircraft", Ph.D thesis, UoMinnesota, 1991
Quaternion:
    [2] Nikolas Trawny and StergiosI. Roumeliotis, "Indirect Kalman Filter 
for 3D Attitude Estimation," University of Minnesota, 2005.
                         ***Side Reference***
X31:
    [3] David F. Fisher, John H. Del Frate, and David M. Richwinc, "In-Flight 
Flow Visualization Characteristics of the NASA F-18 High Alpha Research 
Vehicle at High Angles of Attack", Technical Memorandum4193, NASA, Edwards, 
CA, 1990.
    [4] W. B. W. a. W. P. Fellers, "Tail Configurations for Highly 
Maneuverable Aircraft," AGARD, 1981.

Quaternion:
    [5] Nikolas Trawnyand StergiosI. Roumeliotis, "Indirect Kalman Filter 
for 3D Attitude Estimation," University of Minnesota, 2005.
    [6] W. G. Breckenridge, "Quaternions -Proposed Standard Conventions" 
JPL, Tech. Rep. INTEROFFICE MEMORANDUM 343-79-1199, 1999.
    [7] D. M. Henderson, "EularAngles, Quaternions, and Transformation 
Matrices," Mission Planning and Analysis Division, NASA, July 1977.
%}
%% plot all data
%function quaternionACdynamics_plot()
%close all;
close(findobj('type','figure','name','x31 animation'));
close(findobj('type','figure','name','rotation pqr'));
close(findobj('type','figure','name','absolute speed VxeVyeVze'));
close(findobj('type','figure','name','position XYZ'));
close(findobj('type','figure','name','Aerodynamics related'));
close(findobj('type','figure','name','Body Velocity'));
close(findobj('type','figure','name','Heading Vector'));
close(findobj('type','figure','name','Path top-down'));
close(findobj('type','figure','name','Path longitudinal'));
close(findobj('type','figure','name','Path lateral'));
close(findobj('type','figure','name','Actuater Commands'));
close(findobj('type','figure','name','Actuater Sensor'));
close(findobj('type','Heading and Desire'));
close(findobj('type','Right wing Direction'));

figure('name','rotation pqr')
plot(x31sim_time.data,x31sim_stateR.data(:,1),'r'); hold on
plot(x31sim_time.data,x31sim_stateR.data(:,2),'g'); hold on
plot(x31sim_time.data,x31sim_stateR.data(:,3),'b');
legend('p','q','r');
%{
figure('name','quaternion')
plot(x31sim_time.data,x31sim_stateR.data(:,4),'r'); hold on
plot(x31sim_time.data,x31sim_stateR.data(:,5),'g'); hold on
plot(x31sim_time.data,x31sim_stateR.data(:,6),'b'); hold on
plot(x31sim_time.data,x31sim_stateR.data(:,7),'cyan');
legend('cos(theta/2)','ax*sin(theta/2)','ay*sin(theta/2)','az*sin(theta/2)');
%}
figure('name','absolute speed VxeVyeVze')
plot(x31sim_time.data,x31sim_stateX.data(:,1),'r'); hold on
plot(x31sim_time.data,x31sim_stateX.data(:,2),'g'); hold on
plot(x31sim_time.data,x31sim_stateX.data(:,3),'b');
legend('Vxe','Vye','Vze');

figure('name','position XYZ')
plot(x31sim_time.data,x31sim_stateX.data(:,4),'r'); hold on
plot(x31sim_time.data,x31sim_stateX.data(:,5),'g'); hold on
plot(x31sim_time.data,x31sim_stateX.data(:,6),'b');
legend('X','Y','Z');

figure('name','Aerodynamics related')
plot(x31sim_time.data,x31sim_stateA.data(:,1),'r'); hold on
plot(x31sim_time.data,x31sim_stateA.data(:,2)*180/pi,'g'); hold on
plot(x31sim_time.data,x31sim_stateA.data(:,3)*180/pi,'b');
legend('Vinf','alpha','beta');

figure('name','Body Velocity')
plot(x31sim_time.data,x31sim_stateB.data(:,1),'r'); hold on
plot(x31sim_time.data,x31sim_stateB.data(:,2),'g'); hold on
plot(x31sim_time.data,x31sim_stateB.data(:,3),'b');
legend('Vxb','Vyb','Vzb');

figure('name','Heading Vector')
plot(x31sim_time.data,x31sim_stateHeading.data(:,1),'r'); hold on
plot(x31sim_time.data,x31sim_stateHeading.data(:,2),'g'); hold on
plot(x31sim_time.data,x31sim_stateHeading.data(:,3),'b');
legend('x','y','z');

figure('name','Path top-down')
plot(x31sim_stateX.data(:,5),x31sim_stateX.data(:,4));
xlabel('y');    ylabel('x');

figure('name','Path longitudinal')
plot(x31sim_stateX.data(:,4),x31sim_stateX.data(:,6));
xlabel('x');    ylabel('z');
set(gca,'YDir','Reverse');      axis equal;

figure('name','Path lateral')
plot(x31sim_stateX.data(:,5),x31sim_stateX.data(:,6));
xlabel('y');    ylabel('z');
set(gca,'YDir','Reverse');

figure('name','Actuater Commands')
plot(x31sim_time.data,x31sim_control.data(:,1),'r'); hold on
plot(x31sim_time.data,x31sim_control.data(:,3),'b'); hold on
plot(x31sim_time.data,x31sim_control.data(:,2),'g'); hold on
plot(x31sim_time.data,x31sim_control.data(:,7),'color',[0.2 0.8 0.2]); hold on  % TVC y
plot(x31sim_time.data,x31sim_control.data(:,5),'k'); hold on
plot(x31sim_time.data,x31sim_stateR.data(:,1)*180/pi,'color',[0.7 0 0]); hold on
plot(x31sim_time.data,x31sim_stateR.data(:,2)*180/pi,'color',[0 0 0.5]); hold on
plot(x31sim_time.data,x31sim_stateR.data(:,3)*180/pi,'color',[0 0.7 0]);
legend('ailron (deg)','canard','rudder','TVC-y','throttle (kN)','p (deg/s)','q','r');

figure('name','Actuater Sensor')
plot(x31sim_time.data,x31sim_control.data(:,8),'r'); hold on
plot(x31sim_time.data,x31sim_control.data(:,10),'b'); hold on
plot(x31sim_time.data,x31sim_control.data(:,9),'g'); hold on
plot(x31sim_time.data,x31sim_control.data(:,14),'color',[0.2 0.8 0.2]); hold on  % TVC y
plot(x31sim_time.data,x31sim_control.data(:,12),'k');
plot(x31sim_time.data,x31sim_stateR.data(:,1)*180/pi,'color',[0.7 0 0]); hold on
plot(x31sim_time.data,x31sim_stateR.data(:,2)*180/pi,'color',[0 0 0.5]); hold on
plot(x31sim_time.data,x31sim_stateR.data(:,3)*180/pi,'color',[0 0.7 0]);
legend('ailron (deg)','canard','rudder','TVC y','throttle (kN)','p (deg/s)','q','r');

%{
figure('name','Heading and Desire')
plot(x31sim_time.data,x31sim_stateHeading.data(:,1),'r'); hold on
plot(x31sim_time.data,x31sim_stateHeading.data(:,2),'g'); hold on
plot(x31sim_time.data,x31sim_stateHeading.data(:,3),'b'); hold on 
%plot(x31sim_controltime.data,x31sim_stateDesireHeading.data(:,1),'color',[0.7 0 0]); hold on
%plot(x31sim_controltime.data,x31sim_stateDesireHeading.data(:,2),'color',[0 0.7 0]); hold on
%plot(x31sim_controltime.data,x31sim_stateDesireHeading.data(:,3),'color',[0 0 0.7]);
legend('x','y','z','xd','yd','zd');
%}

figure('name','Right wing Direction')
plot(x31sim_time.data,x31sim_stateHeading.data(:,4),'r'); hold on
plot(x31sim_time.data,x31sim_stateHeading.data(:,5),'g'); hold on
plot(x31sim_time.data,x31sim_stateHeading.data(:,6),'b'); hold on 
%plot(x31sim_controltime.data,x31sim_stateDesireHeading.data(:,4),'color',[0.7 0 0]); hold on
%plot(x31sim_controltime.data,x31sim_stateDesireHeading.data(:,5),'color',[0 0.7 0]); hold on
%plot(x31sim_controltime.data,x31sim_stateDesireHeading.data(:,6),'color',[0 0 0.7]);
legend('x','y','z','xd','yd','zd');
