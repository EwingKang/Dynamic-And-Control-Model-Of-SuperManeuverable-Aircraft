# Dynamic-And-Control-Model-Of-SuperManeuverable-Aircraft
This project is a MATLAB simulink model of an supermaneuverable test vehicle X-31.  
In addition to the original work done by Snell, I construct my aircraft dynamics using Quaternion so that the model will never encounter any singularity as Eular angle would.  
The controller is also planted around the aircraft dynamic model: the Nonlinear Dynamic Inversion (NDI) controller, and the gain scheduling controller.  
Finally, a maneuver generator uses recursive method to calculate controller command from desire path that simulate the pilot action.  
  
# Usage
You can specify the initial condition and/or parameters in the corresponding _init.m file  
- Model:  
  * X31dynamics_03.slx  
- NDI controller with Maneuver Generator:  
  * X31dynamics_03_controller_NDI_MG.slx  
- Gain scheduling controller with Maneuver Generator:  
  * X31dynamics_03_controller_GainS_MG.slx  


# Citataion
This vast majority of numerical model and control method is based on the work of   
Snell, Sidney Antony, "Nonlinear dynamic-inversion flight control of supermaneuverable aircraft", University of Minnesota, 1991.  
In this Ph.D. thesis, the author kindly provided all the aerodynamic data he collected and estimated from different source, along with the dimension and inertial data of the aircraft. He also designed the NDI controller and the gain scheduling logic. All of the detail he mensioned is implemented in the simulation, except for the dynamics and kinematecs using quaternion.

# Author
康心奕 Kang Hsin-Yi (Ewing Kang)
