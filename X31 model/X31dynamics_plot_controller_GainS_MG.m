% plot all data
%function quaternionACdynamics_plot()
%close all;
close(findobj('type','figure','name','Heading Vector V£q£^'));
close(findobj('type','figure','name','Aerodynamics states'));
close(findobj('type','figure','name','Motion command (Blended variable)'));
close(findobj('type','figure','name','Path top-down'));
close(findobj('type','figure','name','Path longitudinal'));
close(findobj('type','figure','name','Path lateral'));
close(findobj('type','figure','name','3D Path'));
close(findobj('type','figure','name','Actuater Commands'));
close(findobj('type','figure','name','Actuater Sensor'));

figure('name','Aerodynamics states')
plot(x31sim_time.data,x31sim_stateA.data(:,1),'r'); hold on
plot(x31control_time.data,x31control_cmdMG.data(:,2)*180/pi(),'--g'); hold on
plot(x31sim_time.data,x31sim_stateA.data(:,2)*180/pi(),'g'); hold on
plot(x31sim_time.data,x31sim_stateA.data(:,3)*180/pi(),'b');
plot(x31control_time.data,x31control_stateAeroAug.data(:,5)*180/pi(),'k');
legend('Vinf','£\_{cmd}','£\','£]','£g');

figure('name','rotation pqr')
plot(x31sim_time.data,x31sim_stateR.data(:,1),'r'); hold on
plot(x31sim_time.data,x31sim_stateR.data(:,2),'g'); hold on
plot(x31sim_time.data,x31sim_stateR.data(:,3),'b');
legend('p','q','r');
%{
figure('name','position XYZ')
plot(x31sim_time.data,x31sim_stateX.data(:,4),'r'); hold on
plot(x31sim_time.data,x31sim_stateX.data(:,5),'g'); hold on
plot(x31sim_time.data,x31sim_stateX.data(:,6),'b');
legend('X','Y','Z');

figure('name','Body Velocity')
plot(x31sim_time.data,x31sim_stateB.data(:,1),'r'); hold on
plot(x31sim_time.data,x31sim_stateB.data(:,2),'g'); hold on
plot(x31sim_time.data,x31sim_stateB.data(:,3),'b');
legend('Vxb','Vyb','Vzb');
%}
%{
figure('name','Heading Vector V£q£^')
sz = size(x31control_time.data);
plot(x31control_time.data(1), x31control_time.data(sz(1))] , [x31control_cmdVelAng.data(:,1),x31control_cmdVelAng.data(:,1)],'--r'); hold on
plot(x31control_time.data(1), x31control_time.data(sz(1))] , [x31control_cmdVelAng.data(:,2)*180/pi(),x31control_cmdVelAng.data(:,2)*180/pi()],'--g'); hold on
plot(x31control_time.data(1), x31control_time.data(sz(1))] , [x31control_cmdVelAng.data(:,3)*180/pi(),x31control_cmdVelAng.data(:,3)*180/pi()],'--b'); hold on
plot(x31control_time.data,x31control_stateVelAng.data(:,1),'r'); hold on
plot(x31control_time.data,x31control_stateVelAng.data(:,2)*180/pi(),'g'); hold on
plot(x31control_time.data,x31control_stateVelAng.data(:,3)*180/pi(),'b');
legend('V_{cmd}','£q_{cmd}','£^_{cmd}','V','£q','£^');
clearvars sz
%}

figure('name','Heading Vector V£q£^')
sz = size(x31control_time.data);
plot(x31control_time.data, x31control_cmdVelAng.data(:,1),'--r'); hold on
plot(x31control_time.data, x31control_cmdVelAng.data(:,2)*180/pi(),'--g'); hold on
plot(x31control_time.data, x31control_cmdVelAng.data(:,3)*180/pi(),'--b'); hold on
plot(x31control_time.data,x31control_stateVelAng.data(:,1),'r'); hold on
plot(x31control_time.data,x31control_stateVelAng.data(:,2)*180/pi(),'g'); hold on
plot(x31control_time.data,x31control_stateVelAng.data(:,3)*180/pi(),'b');
legend('V_{cmd}','£q_{cmd}','£^_{cmd}','V','£q','£^');
clearvars sz

figure('name','Motion command (Blended variable)')
plot(x31control_time.data,x31control_cmdBlndVar.data(:,1),'--r'); hold on
plot(x31control_time.data,x31control_cmdMG.data(:,3)*180/pi(),':g'); hold on
plot(x31control_time.data,x31control_cmdBlndVar.data(:,2)*180/pi(),'--g'); hold on
plot(x31control_time.data,x31control_cmdBlndVar.data(:,3),'--b'); hold on
plot(x31control_time.data,x31control_stateBlndVar.data(:,1),'r'); hold on
plot(x31control_time.data,x31control_stateBlndVar.data(:,2)*180/pi(),'g'); hold on
plot(x31control_time.data,x31control_stateBlndVar.data(:,3),'b');
legend('nz_{cmd}','£g dot_{cmd}','p_{cmd}','ny_{cmd}','nz (g)','p (deg/s)','ny (g)');

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

figure('name','3D Path')
plot3(x31sim_stateX.data(:,4),x31sim_stateX.data(:,5),x31sim_stateX.data(:,6));
xlabel('x');    ylabel('y');    zlabel('z');    grid on;    axis equal;
set(gca,'YDir','Reverse','ZDir','Reverse');

figure('name','Actuater Commands')
plot(x31sim_time.data,x31sim_control.data(:,1),'r'); hold on
plot(x31sim_time.data,x31sim_control.data(:,3),'b'); hold on
plot(x31sim_time.data,x31sim_control.data(:,2),'g'); hold on
plot(x31sim_time.data,x31sim_control.data(:,7),'color',[0.2 0.8 0.2]); hold on  % TVC y
plot(x31sim_time.data,x31sim_control.data(:,5),'k'); hold on
plot(x31sim_time.data,x31sim_stateR.data(:,1)*180/pi(),'color',[0.7 0 0]); hold on
plot(x31sim_time.data,x31sim_stateR.data(:,2)*180/pi(),'color',[0 0 0.5]); hold on
plot(x31sim_time.data,x31sim_stateR.data(:,3)*180/pi(),'color',[0 0.7 0]);
legend('ailron (deg)','canard','rudder','TVC-y','throttle (kN)','p (deg/s)','q','r');

figure('name','Actuater Sensor')
plot(x31sim_time.data,x31sim_control.data(:,8),'r'); hold on
plot(x31sim_time.data,x31sim_control.data(:,10),'b'); hold on
plot(x31sim_time.data,x31sim_control.data(:,9),'g'); hold on
plot(x31sim_time.data,x31sim_control.data(:,14),'color',[0.2 0.8 0.2]); hold on  % TVC y
plot(x31sim_time.data,x31sim_control.data(:,12),'k'); hold on
plot(x31sim_time.data,x31sim_stateR.data(:,1)*180/pi(),'color',[0.7 0 0]); hold on
plot(x31sim_time.data,x31sim_stateR.data(:,2)*180/pi(),'color',[0 0 0.5]); hold on
plot(x31sim_time.data,x31sim_stateR.data(:,3)*180/pi(),'color',[0 0.7 0]);
legend('ailron (deg)','canard','rudder','TVC y','throttle (kN)','p (deg/s)','q','r');

%{
figure('name','Heading and Desire')
plot(x31sim_time.data,x31sim_stateHeading.data(:,1),'r'); hold on
plot(x31sim_time.data,x31sim_stateHeading.data(:,2),'g'); hold on
plot(x31sim_time.data,x31sim_stateHeading.data(:,3),'b'); hold on 
plot(x31sim_controltime.data,x31sim_stateDesireHeading.data(:,1),'color',[0.7 0 0]); hold on
plot(x31sim_controltime.data,x31sim_stateDesireHeading.data(:,2),'color',[0 0.7 0]); hold on
plot(x31sim_controltime.data,x31sim_stateDesireHeading.data(:,3),'color',[0 0 0.7]);
legend('x','y','z','xd','yd','zd');

figure('name','Right wing Direction')
plot(x31sim_time.data,x31sim_stateHeading.data(:,4),'r'); hold on
plot(x31sim_time.data,x31sim_stateHeading.data(:,5),'g'); hold on
plot(x31sim_time.data,x31sim_stateHeading.data(:,6),'b'); hold on 
%plot(x31sim_controltime.data,x31sim_stateDesireHeading.data(:,4),'color',[0.7 0 0]); hold on
%plot(x31sim_controltime.data,x31sim_stateDesireHeading.data(:,5),'color',[0 0.7 0]); hold on
%plot(x31sim_controltime.data,x31sim_stateDesireHeading.data(:,6),'color',[0 0 0.7]);
legend('x','y','z','xd','yd','zd');
%}
