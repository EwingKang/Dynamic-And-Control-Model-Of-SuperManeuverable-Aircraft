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
% MATLAB R2014b %

%clf;
close(findobj('type','figure','name','X31 animation'));

% Geometry define
%load('sim_result/X31_02_sim_NDI_MG180s.mat');

% Figure:
fig_X31 = figure('name','X31 animation','Position', [80, 60, 1120, 880]);

% FIRST % axes
ax_attitude = subplot(2,2,1);
%sz = get(ax_attitude,'OuterPosition');
%set(ax_longi,'YLim',[-200 200],'YDir','Reverse','YLimMode','manual','NextPlot','add','OuterPosition',[sz(1), 0.08, sz(3), 0.92]);
% set below with 2014b bug
%set(ax_attitude,'XLim',[-15 15],'YLim',[-15 15],'zLim',[-15 15],'xDir','reverse','zDir','reverse','OuterPosition',[0, 0.48, 0.5, 0.5]);
view(ax_attitude, [30,10]);
grid on ;
axis equal;
title(ax_attitude,'attitude');
xlabel(ax_attitude,'x'); ylabel(ax_attitude,'y'); zlabel(ax_attitude,'z');

% Create 3D Aircraft Object %
    % Fuselage a cylinder
    t = 0:pi/10:2*pi();
    [ Y_fl, Z_fl, X_fl ] = cylinder( X31_physical.size.fuselage.radius/2 );
    X_fl = X_fl * X31_physical.size.fuselage.length - X31_physical.size.fuselage.length/2;
    % create a surface
    fuselage = surface(X_fl + X31_physical.size.fuselage.offset_x, Y_fl, Z_fl, 'FaceColor',[0.8 0.8 0.8] );

    % Main wing is a triangular plate
    half_mw_c = X31_physical.size.mainwing.center_chord / 2;
    half_mw_b = X31_physical.size.mainwing.span / 2;
    offset_mw_x = X31_physical.size.mainwing.offset_x;
    offset_mw_z = X31_physical.size.mainwing.offset_z;
    X_mw = [ -half_mw_c,  half_mw_c, -half_mw_c ;...
            -half_mw_c, -half_mw_c, -half_mw_c ];
    Y_mw = [ -half_mw_b,        0,  half_mw_b ;...
            -half_mw_b,        0,   half_mw_b];
    Z_mw = [0 0 0 ; 0 0 0];
    mainwing = surface( X_mw + offset_mw_x, Y_mw, Z_mw + offset_mw_z, 'FaceColor',[1 0.8 0.8] );

    % canard is a triangular plate
    half_cn_c = X31_physical.size.canard.center_chord / 2;
    half_cn_b = X31_physical.size.canard.span / 2;
    offset_cn_x = X31_physical.size.canard.offset_x;
    offset_cn_z = X31_physical.size.canard.offset_z;
    X_cn = [ -half_cn_c,  half_cn_c, -half_cn_c ;...
            -half_cn_c, -half_cn_c, -half_cn_c      ];
    Y_cn = [ -half_cn_b,      0,  half_cn_b ;...
            -half_cn_b,      0,  half_cn_b      ];
    Z_cn = [0 0 0 ; 0 0 0];
    canard = surface( X_cn + offset_cn_x, Y_cn, Z_cn + offset_cn_z,'FaceColor',[0.8 1 0.8]);

    % fin is a trapezoid
    c_base = X31_physical.size.fin.base_width;
    c_tip = X31_physical.size.fin.tip_width;
    b_fin = X31_physical.size.fin.height;
    offset_fin_x = X31_physical.size.fin.offset_x;
    offset_fin_z = X31_physical.size.fin.offset_z;
    Y_fn = [0 0 ; 0 0];
    X_fn = [  c_base/2 , - c_base/2 - 1 + c_tip ; ...
            -c_base/2 , - c_base/2 - 1               ];
    Z_fn = [ 0, -b_fin; 0, -b_fin ];

    fin = surface( X_fn + offset_fin_x, Y_fn, Z_fn + offset_fin_z, 'FaceColor',[0.8 0.8 1]);
combinedobj(1) = fuselage;
combinedobj(2) = mainwing;
combinedobj(3) = canard;
combinedobj(4) = fin;

clearvars t X_fl Y_fl Z_fl X_mw Y_mw Z_mw X_cn Y_cn Z_cn Y_fn X_fn Z_fn 
clearvars half_mw_c half_mw_b offset_mw_x offset_mw_z half_cn_c half_cn_b offset_cn_x offset_cn_z c_base c_tip b_fin offset_fin_x offset_fin_z
clearvars fuselage mainwing canard fin

% Create 3D Wind direction Object %
    arrow = [0 0.6 1.2 0.6 0.6 0.6 0.6 0.6];
    [ Y_aero, Z_aero, X_aero ] = cylinder( arrow );
    air_dir = surface(X_aero*5 + 12, Y_aero, Z_aero, 'FaceColor',[1, 0.2, 0.3]);
    
combinedobj(5) = air_dir;

clearvars arrow X_aero Y_aero Z_aero air_dir

set(ax_attitude,'XLim',[-15 15],'YLim',[-15 15],'zLim',[-10 10],'xDir','reverse','zDir','reverse','OuterPosition',[0, 0.48, 0.5, 0.5]);

% SECOND % axes
ax_longi = subplot(2,2,2);
title(ax_longi,'longitudinal view');
xlabel(ax_longi,'x');    ylabel(ax_longi,'z');
%sz = get(ax_longi,'OuterPosition');
ax_longi_ylim = [-200 200];
set(ax_longi,'YLim',ax_longi_ylim, 'YDir','Reverse','YLimMode','manual','NextPlot','add','OuterPosition',[0.5, 0.5, 0.51, 0.51]);
grid on;
        %set(ax_longi,'XLim',[0 15000],'YLim',[-1000 1000],'YDir','Reverse','XLimMode','manual','YLimMode','manual');

% THIRD axes
ax_3dplot = subplot(2,2,3);

title(ax_3dplot,'longitudinal view');
xlabel(ax_3dplot,'x');    ylabel(ax_3dplot,'y');    zlabel(ax_3dplot,'z');
ax_3dplot_xlim = [-500 500];
ax_3dplot_ylim = [-500 500];
ax_3dplot_zlim = [-500 500];
set(ax_3dplot,'XLim',ax_3dplot_xlim,'YLim',ax_3dplot_ylim,'ZLim',ax_3dplot_zlim,'XDir','Reverse','ZDir','Reverse', ...
            'XLimMode','manual','YLimMode','manual','ZLimMode','manual','DataAspectRatio',[1 1 1], ...
            'NextPlot','add','OuterPosition',[0, 0, 0.52, 0.52]);
ax_3dplot_view = 30;
view(ax_3dplot, [ax_3dplot_view 10]);
grid on;


% FOURTH % axes
ax_topdown = subplot(2,2,4);
title(ax_topdown,'topdown view');
xlabel(ax_topdown,'y');    ylabel(ax_topdown,'x');
ax_topdown_xlim = [-200 200];
set(ax_topdown,'XLim',ax_topdown_xlim, 'XLimMode','manual', 'NextPlot','add','OuterPosition',[0.5, 0, 0.51, 0.51]);
grid on;


%clearvars sz 

writerObj = VideoWriter('x31sim_attitude3');
writerObj.FrameRate = 10;
open(writerObj);
% SIMULATION %
time_step = 0.3;
j=1;
last_i = 1;
for i=2:size(x31sim_time.data)
    if floor(x31sim_time.data(i,1)/time_step) == floor(x31sim_time.data(i-1,1)/time_step)
        %jump
    else
        timemark = sprintf('Time:%f',x31sim_time.data(i,1));
        AOA = x31sim_stateA.data(i,2);
        SS = x31sim_stateA.data(i,3);
        flight_info = sprintf('Speed:%f  AOA:%f(deg)  sideslip:%f(deg) \nQ:[ %f %f %f %f ]',...
                            x31sim_stateA.data(i,1), AOA*180/pi, SS*180/pi, ...
                            x31sim_stateR.data(i,4), x31sim_stateR.data(i,5), x31sim_stateR.data(i,6), x31sim_stateR.data(i,7) );
        % claculate body rotation
        theta = 2*acos( x31sim_stateR.data(i,4) );    %Q0
        if theta ~= 0
            rx = x31sim_stateR.data(i,5)/sin(theta/2);       %Q1
            ry = x31sim_stateR.data(i,6)/sin(theta/2);       %Q2
            rz = x31sim_stateR.data(i,7)/sin(theta/2);       %Q3
        else
            rx = 1;
            ry = 0;
            rz = 0;
        end
        % calculate velocity vector rotation
        q0 = cos(-AOA/2)*cos(SS/2);
        q1 = sin(-AOA/2)*sin(SS/2);
        q2 = sin(-AOA/2)*cos(SS/2);
        q3 = cos(-AOA/2)*sin(SS/2);
        theta_a = 2*acos( q0 );    %Q0
        if theta_a ~= 0
            rx_a = q1/sin(theta_a/2);       %Q1
            ry_a = q2/sin(theta_a/2);       %Q2
            rz_a = q3/sin(theta_a/2);       %Q3
        else
            rx_a = 1;
            ry_a = 0;
            rz_a = 0;
        end
        
        rotate(combinedobj(5),[rx_a ry_a rz_a],theta_a*180/pi);     % rotate velocity
        rotate(combinedobj,[rx ry rz],theta*180/pi);                % rotate body and velocity
        
        plot(ax_longi,x31sim_stateX.data(last_i:i,4),x31sim_stateX.data(last_i:i,6));% hold on;grid on;
        if (x31sim_stateX.data(i,6) < ax_longi_ylim(1));    
            ax_longi_ylim(1) = ax_longi_ylim(1) - 200;
            set(ax_longi,'YLim',ax_longi_ylim);
        elseif (x31sim_stateX.data(i,6) > ax_longi_ylim(2));    
            ax_longi_ylim(2) = ax_longi_ylim(2) + 200;
            set(ax_longi,'YLim',ax_longi_ylim);
        end
        
        plot3(ax_3dplot,x31sim_stateX.data(last_i:i,4),x31sim_stateX.data(last_i:i,5),x31sim_stateX.data(last_i:i,6));
        if (x31sim_stateX.data(i,4) < ax_3dplot_xlim(1))
            ax_3dplot_xlim(1) = ax_3dplot_xlim(1) - 500;
            set(ax_3dplot,'XLim',ax_3dplot_xlim);  
        elseif (x31sim_stateX.data(i,4) > ax_3dplot_xlim(2))
            ax_3dplot_xlim(2) = ax_3dplot_xlim(2) + 500;
            set(ax_3dplot,'XLim',ax_3dplot_xlim);  
        end
        if (x31sim_stateX.data(i,5) < ax_3dplot_ylim(1))
            ax_3dplot_ylim(1) = ax_3dplot_ylim(1) - 500;
            set(ax_3dplot,'YLim',ax_3dplot_ylim);  
        elseif (x31sim_stateX.data(i,5) > ax_3dplot_ylim(2))
            ax_3dplot_ylim(2) = ax_3dplot_ylim(2) + 500;
            set(ax_3dplot,'YLim',ax_3dplot_ylim);  
        end
        if (x31sim_stateX.data(i,6) < ax_3dplot_zlim(1))
            ax_3dplot_zlim(1) = ax_3dplot_zlim(1) - 500;
            set(ax_3dplot,'ZLim',ax_3dplot_zlim);  
        elseif (x31sim_stateX.data(i,6) > ax_3dplot_zlim(2))
            ax_3dplot_zlim(2) = ax_3dplot_zlim(2) + 500;
            set(ax_3dplot,'ZLim',ax_3dplot_zlim);  
        end
        ax_3dplot_view = ax_3dplot_view + 2;    % rotate the view
        view(ax_3dplot, [ax_3dplot_view,10]);
        
        plot(ax_topdown,x31sim_stateX.data(last_i:i,5),x31sim_stateX.data(last_i:i,4));
        if (x31sim_stateX.data(i,5) < ax_topdown_xlim(1));    
            ax_topdown_xlim(1) = ax_topdown_xlim(1) - 200;
            set(ax_topdown,'XLim',ax_topdown_xlim);
        elseif (x31sim_stateX.data(i,5) > ax_topdown_xlim(2));    
            ax_topdown_xlim(2) = ax_topdown_xlim(2) + 200;
            set(ax_topdown,'XLim',ax_topdown_xlim);
        end
        
        
        txt_time = text(-8,26,timemark,'Parent',ax_attitude,'Units','characters','VerticalAlignment','top','HorizontalAlignment','left') ;
        txt_info = text(-8,25,flight_info,'Parent',ax_attitude,'Units','characters','VerticalAlignment','top','HorizontalAlignment','left') ;
        drawnow;
        % frame_X31(j) = getframe(fig_X31); % if we want to capture everything
        frame = getframe(fig_X31);
        writeVideo(writerObj,frame);
        
        rotate(combinedobj,[rx ry rz],-theta*180/pi);            % reset attitude
        rotate(combinedobj(5),[rx_a ry_a rz_a],-theta_a*180/pi);  % reset velocity
        delete(txt_time);   % clear text
        delete(txt_info);
        
        j=j+1;
        last_i = i;     % last index for continuous plotting
    end
end

clearvars i j last_i 
clearvars q0 q1 q2 q3 rx ry rz rx_a ry_a rz_a theta theta_a
clearvars AOA SS flight_info timemark txt_time txt_info frame
clearvars ax_attitude combineobj ax_longi ax_longi_ylim ax_3dplot ax_3dplot_xlim ax_3dplot_ylim ax_3dplot_zlim ax_3dplot_view ax_topdown ax_topdown_xlim

% figure('name','Movie')
% movie(F,1,100)

close(writerObj);