% plot all data
%function quaternionACdynamics_plot()
%close all;
close(findobj('type','figure','name','Heading Vector V£q£^'));
close(findobj('type','figure','name','Aerodynamics states'));
close(findobj('type','figure','name','Slow state motion'));
close(findobj('type','figure','name','Fast state motion'));
close(findobj('type','figure','name','3D Path'));
close(findobj('type','figure','name','Actuater Commands'));
close(findobj('type','figure','name','Actuater Sensor'));

figure('name','Aerodynamics states')
sz = size(x31control_time.data);
plot(x31sim_time.data,x31sim_stateA.data(:,1),'r'); hold on
plot(x31control_time.data,x31control_cmdMG.data(:,2)*180/pi(),'--g'); hold on
plot(x31sim_time.data,x31sim_stateA.data(:,2)*180/pi(),'g'); hold on
plot([x31control_time.data(1), x31control_time.data(sz(1))] , [0 , 0],'--b'); hold on
plot(x31sim_time.data,x31sim_stateA.data(:,3)*180/pi(),'b');
legend('Vinf (m/s)','£\_{cmd}','£\ (deg)','£]_{cmd}','£] (deg)');
clearvars sz
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

figure('name','Heading Vector V£q£^')
sz = size(x31control_time.data);
plot([x31control_time.data(1), x31control_time.data(sz(1))] , [x31control_cmdVelAng.data(:,1),x31control_cmdVelAng.data(:,1)],'--r'); hold on
plot([x31control_time.data(1), x31control_time.data(sz(1))] , [x31control_cmdVelAng.data(:,2)*180/pi(),x31control_cmdVelAng.data(:,2)*180/pi()],'--g'); hold on
plot([x31control_time.data(1), x31control_time.data(sz(1))] , [x31control_cmdVelAng.data(:,3)*180/pi(),x31control_cmdVelAng.data(:,3)*180/pi()],'--b'); hold on
plot(x31control_time.data,x31control_stateVelAng.data(:,1),'r'); hold on
plot(x31control_time.data,x31control_stateVelAng.data(:,2)*180/pi(),'g'); hold on
plot(x31control_time.data,x31control_stateVelAng.data(:,3)*180/pi(),'b');
legend('V_{cmd}','£q_{cmd}','£^_{cmd}','V (m/s)','£q (deg)','£^ (deg)');
clearvars sz

figure('name','Slow state motion')
plot(x31control_time.data,x31control_cmdSlowState.data(:,1)*180/pi,'--r'); hold on
plot(x31control_time.data,x31control_cmdSlowState.data(:,2)*180/pi,'--g'); hold on
plot(x31control_time.data,x31control_cmdSlowState.data(:,3)*180/pi,'--b'); hold on
plot(x31control_time.data,x31control_stateAeroAugDot.data(:,2)*180/pi,'r'); hold on
plot(x31control_time.data,x31control_stateAeroAugDot.data(:,3)*180/pi,'g'); hold on
plot(x31control_time.data,x31control_stateAeroAugDot.data(:,5)*180/pi,'b');
legend('£\ dot_{cmd}','£] dot_{cmd}','£g dot_{cmd}','£\ dot','£] dot','£g dot');    ylabel('deg');

figure('name','Fast state motion')
plot(x31control_time.data,x31control_cmdSlowState.data(:,4)*180/pi,'--r'); hold on
plot(x31control_time.data,x31control_cmdSlowState.data(:,5)*180/pi,'--g'); hold on
plot(x31control_time.data,x31control_cmdSlowState.data(:,6)*180/pi,'--b'); hold on
plot(x31sim_time.data,x31sim_stateR.data(:,1)*180/pi,'r'); hold on
plot(x31sim_time.data,x31sim_stateR.data(:,2)*180/pi,'g'); hold on
plot(x31sim_time.data,x31sim_stateR.data(:,3)*180/pi,'b');
legend('p_{cmd}','q_{cmd}','r_{cmd}','p','q','r');    ylabel('deg');

%{ 
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
 %}

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
