function yy=frame(uu)
%% Frame transformation
%% Z.Feng,06/01
u=uu(1);v=uu(2);psi=uu(3);
xdot=cos(psi)*u-sin(psi)*v;
ydot=sin(psi)*u+cos(psi)*v;
yy=[xdot;ydot];
   

 

