function x_cambermid=CST_camber_mid(wl,wu,x,N1,N2)
x_cambermid=(cst_y(x,wu,N1,N2)+cst_y(x,wl,N1,N2))/2;