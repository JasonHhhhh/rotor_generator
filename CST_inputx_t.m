function t=CST_inputx_t(wl,wu,x,N1,N2)
%input CST paras
%output thickness at x

t=cst_y(x,wu,N1,N2)-cst_y(x,wl,N1,N2);
