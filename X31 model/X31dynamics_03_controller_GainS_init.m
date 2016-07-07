function X31dynamics_03_controller_GainS_init()
X31_controller.gains = X31controller_init();
X31_controller.aero_poly = X31controller_init_poly();
X31_controller.physical = X31controller_physical_init();
assignin('base', 'X31_controller', X31_controller);
end

function controller_gains = X31controller_init()

controller_gains.longi = controller_gains_longi();
controller_gains.latrl = controller_gains_latrl();
controller_gains.outer = controller_gains_outer();

end

function polynomial = X31controller_init_poly()
% [ODD or EVEN function] [a=alpha, b=beta]
% polynomial order : [1 2 3 4 5 6 0, ODD=1/EVEN=0 ]
polynomial.fig2_2(1).a = [+0.068166435 , +0.000838565 , -7.53902E-05 , +1.05377E-06 , -4.55181E-09 , -1.73074E-13 , +0.0         , 1];        % [ODD ][a] Cl
polynomial.fig2_2(1).b = [+0.009653169 , -0.000177299 , +2.91271E-05 , -4.79288E-07 ,  2.16121E-09 ,  +0.0000E+00 , +0.003815982 , 0];        % [EVEN][a] Cd
polynomial.fig2_2(2).a = [-2.98973E-05 , +2.87863E-06 , -1.12387E-07 , +1.83108E-09 , -1.36183E-11 ,  3.85119E-14 , +0.002310071 , 0];        % [EVEN][a] Cl delta canard
polynomial.fig2_2(2).b = [-0.161987094 , -0.061576775 , +0.001116867 , -4.89738E-06 , -1.82458E-08 ,  1.83146E-10 , -0.015086919 , 1];        % [ODD ][a] canard lift offset
polynomial.fig2_2(3).a = [  0          ,            0 ,            0 ,            0 ,            0 ,            0 ,           -1 , 0];        % [EVEN][a] CY 
polynomial.fig2_2(3).b = [+0.000129449 , -1.68066E-05 , +4.58837E-07 , -4.98703E-09 ,    1.931E-11 ,            0 , +0.003236518 , 0];        % [EVEN][a] CY with rudder(deg)
polynomial.fig2_2(4).a = [+0.010568349 , -0.001180732 , +3.75585E-05 , -4.51658E-07 , +1.81067E-09 , +4.91796E-13 , -0.083588788 , 0];        % [EVEN][a] Cl with beta(rad)
polynomial.fig2_2(4).b = [-0.009013965 , -0.000415504 , +1.97183E-05 , -2.69626E-07 , +1.27567E-09 ,  -6.5435E-13 , +0.175202791 , 0];        % [EVEN][a] Cn with beta
polynomial.fig2_2(5).a = [+0.009368111 , -0.001403253 , +5.02484E-05 ,   -6.593E-07 , +2.89722E-09 , +2.46726E-13 , -0.078285489 , 0];        % [EVEN][a] Cl with p
polynomial.fig2_2(5).b = [+0.001564168 , -0.001140853 , +5.19084E-05 , -7.95876E-07 , +3.84628E-09 , +1.11711E-12 , -0.000286817 , 1];        % [ODD ][a] Cn with p
polynomial.fig2_2(6).a = [-0.022525193 , +0.003573161 , -0.000125695 , +1.67113E-06 , -7.98271E-09 , +4.30185E-12 , -0.0758901   , 1];        % [ODD ][a] Cl with r
polynomial.fig2_2(6).b = [+0.017397535 , -0.001987539 , +6.01596E-05 , -6.69396E-07 , +2.49322E-09 , +3.48365E-13 , -0.32966209  , 0];        % [EVEN][a] Cn with r
polynomial.fig2_2(7).a = [+5.11295E-05 , -6.16355E-06 , +1.57143E-07 ,  -1.7579E-09 , +8.54994E-12 , -1.20465E-14 , +0.002346565 , 0];        % [EVEN][a] Cl with ailron(deg)
polynomial.fig2_2(7).b = [+2.49532E-05 , -2.72807E-06 , +7.90021E-08 , -1.01864E-09 ,  +5.8109E-12 , -1.07828E-14 , +0.000760346 , 0];        % [EVEN][a] Cn with ailron(deg)
polynomial.fig2_2(8).a = [+1.61374E-05 , -1.74829E-06 , +4.94371E-08 , -6.15656E-10 ,  +3.3101E-12 , -5.31398E-15 , +0.000507964 , 0];        % [EVEN][a] Cl with rudder(deg)
polynomial.fig2_2(8).b = [-9.46234E-05 ,  1.16858E-05 , -3.46362E-07 ,  4.56883E-09 , -2.82200E-11 ,  6.61620E-14 , -1.91018E-03 , 0];        % [EVEN][a] Cn with rudder(deg)
polynomial.fig2_2(9).a = [+0.002907947 , +8.80921E-05 , -6.66764E-06 , +1.44272E-07 , -1.34607E-09 ,  +4.6273E-12 , +0           , 1];        % [ODD ][a] Cm0 (4.65% static instability)
polynomial.fig2_2(9).b = [           0 ,            0 ,            0 ,            0 ,            0 ,            0 ,           -3 , 0];        % [EVEN][a] Cm with q
polynomial.fig2_2(10).a = [-4.46671E-05 , +3.84916E-06 , -1.32161E-07 , +1.54809E-09 ,  -5.0072E-12 ,  -9.9798E-15 , +0.005052863 , 0];       % [EVEN][a] Cm with canard(deg)
polynomial.fig2_2(10).b = [-0.137580555 , -0.070398444 , +0.001549639 ,  -1.2966E-05 ,  4.63561E-08 ,            0 , -0.099241141 , 1];       % [ODD ][a] canard pitching-moment offset(deg)

end

function physical = X31controller_physical_init()
physical.inertia.mass = 10617;
physical.inertia.Ixx = 22682;
physical.inertia.Iyy = 77095;
physical.inertia.Izz = 95561;
physical.inertia.Ixy = 0;
physical.inertia.Ixz = 1125;
physical.inertia.Iyz = 0;

physical.geometry.Sref = 57.7;
physical.geometry.b = 13.11;
physical.geometry.Cbar = 4.4;
physical.geometry.Xp = 7;
physical.geometry.Xc = 9.68;
physical.geometry.Xr = 7.91;
physical.geometry.Xt = 8.5;

physical.size.fuselage.length = 20;
physical.size.fuselage.radius = 3;
physical.size.fuselage.offset_x = 0;
physical.size.mainwing.span = 13.11;
physical.size.mainwing.center_chord = 8.8;
physical.size.mainwing.offset_x = -3;
physical.size.mainwing.offset_z = 1.5;
physical.size.canard.span = 6;
physical.size.canard.center_chord = 4;
physical.size.canard.offset_x = 9.68;
physical.size.canard.offset_z = 0;
physical.size.fin.height = 3;
physical.size.fin.base_width = 4;
physical.size.fin.tip_width = 2;
physical.size.fin.offset_x = -7.91;
physical.size.fin.offset_z = -1.2;
end

function longi = controller_gains_longi()

longi.P_gain = 1;   % (4.3.8)
longi.I_gain = 3;
longi.omega = 10;   % below (4.3.8)
end

function latrl = controller_gains_latrl()
latrl.omega = 10;        % below (4.6.10)

latrl.P_gain.mat1_1.alpha = [   4.291263281177592 ,  8.017154942156836 , 12.491258225693656, 16.969405896379428 ,               ...
                               22.9429657153931   , 28.551014045819528 , 34.284101345601314, 45.387292198545694 , 56.975472477102855   ];
latrl.P_gain.mat1_1.gain =  [   1.9535443155296193,  2.0868827043468876,  2.328408449398834,  2.6786270990790726,               ...
                                3.218047235071591 ,  3.9343461152818993,  4.677733963583678,  6.40932146979771  ,  7.841666456021515   ];
latrl.P_gain.mat1_2.alpha = [   4.1250659786311346,  7.930418361894041 , 12.712221701314334, 17.164344983820897 ,               ...
                               22.807460421017403 , 28.657773348239296 , 34.27466125505287 , 45.91129193536225  , 57.395540664146644   ];
latrl.P_gain.mat1_2.gain =  [   0.1781183714015011,  0.1704533756470826,  0.157017011831895,  0.1377935434377082,               ...
                                0.1070181592863491,  0.0569681630565566, -0.022000308173482, -0.2396914331050444, -0.537384393963734   ];
latrl.P_gain.mat2_1.alpha = [   4.0458218558461425,  7.864120104491718 , 12.445655156991698, 16.8084487858428   ,               ...
                               22.697878655431417 , 28.369705532572404 , 34.0446224372592  , 45.28711844766776  , 56.85878370823631    ];
latrl.P_gain.mat2_1.gain =  [   0.1740783281324640, -0.4516319207977144, -1.241174617050040, -2.0455575771744527,               ... 
                               -3.1627245098138843, -4.1905652514205   , -4.935668472570919, -6.2472835201919   , -7.439912178164482   ];
latrl.P_gain.mat2_2.alpha = [   4.225667849803855 ,  7.980571642069862 , 12.69877670916081 , 17.113059386615305 ,               ...
                               22.91541320690299  , 28.544354760785104 , 34.469102082621994, 45.97924463884255  , 57.367251364043305   ];
latrl.P_gain.mat2_2.gain =  [  -0.9090229777694749, -0.926639267700355 , -0.950449312985951, -0.9594658489921862,               ... 
                               -0.9799216681590086, -0.9688759767323513, -0.898638211251184, -0.7696225770918016, -0.6511095937179926  ];

latrl.I_gain.mat1_1.alpha = [   3.7687758970930716,  7.865159104634721 , 12.386036642670994, 17.019044758573678 ,               ...
                               22.74416336443406  , 28.49150139355831  , 34.37241432765255 , 45.57281221034816  , 56.9726681716451     ];
latrl.I_gain.mat1_1.gain =  [   1.9474581690290913,  2.7457587706974884,  3.937727482649149,  4.950665129392615 ,               ...
                               5.521749521216641  ,  5.066574301040889 ,  3.441908157564130,  1.1235309505585498,  4.592683738159598   ];
latrl.I_gain.mat1_2.alpha = [   4.0805369127516755,  7.838926174496642 , 12.56375838926175 , 17.181208053691265 ,               ...
                               22.87248322147648  , 28.56375838926173  , 34.46979865771812 , 45.63758389261745  , 57.12751677852351    ];
latrl.I_gain.mat1_2.gain =  [   0.7881586420395007,  0.69322699602435  ,  0.464315140267656,  0.1400396765084673,               ...
                               -0.3301229491804718, -0.8241234771340129, -1.237647087056339, -1.2572573613522011, -0.5795729975762138  ];
latrl.I_gain.mat2_1.alpha = [   3.902407671641406 ,  7.819983803169961 , 12.178216549046795, 16.971964058462845 ,               ...
                               22.854241384186203 , 28.725463730669823 , 34.35141979355462 , 45.696013780160136 , 56.998701682670635   ];
latrl.I_gain.mat2_1.gain =  [  -0.9130641574434737, -3.288856323833766 , -6.425385317445015, -9.847029938426331 ,               ...
                               -13.957682567840298,-17.045749617574835 ,-17.446685434422104,-16.821629195428894 ,-12.320260177650947   ];
latrl.I_gain.mat2_2.alpha = [   3.926097071137683 ,  7.895572916252561 , 12.405947726033176, 17.023052129264897 ,               ... 
                               22.927908230359094 , 28.717130004341044 , 34.49668378177677 , 45.622258017838064 , 57.16050305384658    ];
latrl.I_gain.mat2_2.gain =  [  -2.5263985599773564, -2.564804199217974 , -2.712916952227694, -2.8491633525686173,               ...
                               -3.0061212093264373, -2.9673538152808403, -2.703201251751131, -2.0681506299303987, -1.0534880318789452  ];

end

function outer = controller_gains_outer()
outer.alpha.P_gain = 1;     % (4.7.1)
outer.alpha.I_gain = 2;     % (4.7.1)
outer.alpha.omega = 1;      % above (4.7.1)
outer.alpha.h_a = 1/15;      % below (4.7.1) % *******WARNING*******  THIS IS STRANGE
outer.mu.P_gain = 1.5;       %(3.2.8)

end