function val =  X31dynamics_03_controller_MG_iter_3_2_9_10(alpha, V_dot_d, Chi_dot_d, Gamma_dot_d, V, rho, gamma, g, mu_c, Sref, M)
%   combine (3.2.10) and (3.2.9)
val = M*V*(cos(gamma)*sin(mu_c)*Chi_dot_d + cos(mu_c)*Gamma_dot_d) + M*g*cos(gamma)*cos(mu_c) - Lift_f(V, rho, alpha, Sref) +...     %(3.2.10)
    - tan(alpha)*(M*V_dot_d + Drag_f(V, rho, alpha, Sref) + M*g*sin(gamma));     %(3.2.9)
end

function L = Lift_f(V, rho, alpha, Sref)
alpha = 180 / pi * alpha;   % convert to degree for polynomials
a_abs = abs(alpha);

X31_controller = evalin('base','X31_controller');
X31_controller_aero_poly = X31_controller.aero_poly;
i = 1;      % figer 2.2.1a is the lift coefficient
CL = X31_controller_aero_poly.fig2_2(i).a(6)*a_abs^6 + X31_controller_aero_poly.fig2_2(i).a(5)*a_abs^5 + X31_controller_aero_poly.fig2_2(i).a(4)*a_abs^4 +...
                X31_controller_aero_poly.fig2_2(i).a(3)*a_abs^3 + X31_controller_aero_poly.fig2_2(i).a(2)*a_abs^2 + X31_controller_aero_poly.fig2_2(i).a(1)*a_abs + X31_controller_aero_poly.fig2_2(i).a(7);
if alpha<0
    CL = -CL + 2*X31_controller_aero_poly.fig2_2(i).a(7);   % this is an odd function
end
L = 0.5*rho*V^2*Sref*CL;
end

function D = Drag_f(V, rho, alpha, Sref)
alpha = 180 / pi * alpha;   % convert to degree for polynomials
a_abs = abs(alpha);

X31_controller = evalin('base','X31_controller');
X31_controller_aero_poly = X31_controller.aero_poly;
i = 1;      % figer 2.2.1b is the Drag coefficient
CD = X31_controller_aero_poly.fig2_2(i).b(6)*a_abs^6 + X31_controller_aero_poly.fig2_2(i).b(5)*a_abs^5 + X31_controller_aero_poly.fig2_2(i).b(4)*a_abs^4 +...
                X31_controller_aero_poly.fig2_2(i).b(3)*a_abs^3 + X31_controller_aero_poly.fig2_2(i).b(2)*a_abs^2 + X31_controller_aero_poly.fig2_2(i).b(1)*a_abs + X31_controller_aero_poly.fig2_2(i).b(7);
D = 0.5*rho*V^2*Sref*CD;
end