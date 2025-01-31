A repository of the code I developed to generated accurate oriantation for the VTOL_Thrust-Vectoring-aircraft

Created the code for a simple running Unscented Kalman Filter that was turned raw Gyroscope, Accelerometer, and Magnetometer reading into accurate orientations for a PID to control motor RPM and servo angle for stabilization and flight of the UAV.

A UKF is a type of Kalman filter adept at state estimate for highly non-linear systems. The general idea is to probduce several sample points (Sigma points) around the current stat estimate based on the covariance and then propgate the sigma points through a nonlinear map. Because of this the UKF avoids the need to calculate the Jacobian to reduce computation load.                                                                                      

I used Standard and overlapping Allanvariance to generate Q-values from our Gyroscope and accelerometer data to put into a custom Unscented Kalman Filter reducing experimental optimization time delay and improving accuracy.
