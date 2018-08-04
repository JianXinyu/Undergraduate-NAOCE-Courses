function yy=dynamic_equation(uu)
u=uu(1);v=uu(2);w=uu(3);r=uu(4);fx=uu(5);fy=uu(6);fz=uu(7);fr=uu(8);
m=128;
W=1254.4;
B=1254.4;
xG=0;yG=0;zG=0.054;
xB=0;yB=0;zB=0;
Izz=14.213;
Xudot=-33.48;Xwdot=0;Yvdot=-110.8941;Zwdot=-147.576;Nrdot=-12.75;Yrdot=0;
Xu=-4.9217;Yv=-3.0591;Zw=-4.4132;Nr=-1.3881;Xuu=-139.8007;Yvv=-350.2618;Zww=-327.2375;Nrr=-51.1709;
M_RB=[m 0 0 -m*yG;0 m 0 m*xG;0 0 m 0;-m*yG m*xG 0 Izz];
M_A=-[Xudot 0 0 0 ;0 Yvdot 0 Yrdot;0 0 Zwdot 0;0 Yrdot 0 Nrdot];
M=M_RB+M_A;
C_RB=[0 0 0 -m*v;0 0 0 m*u;0 0 0 0;m*v -m*u 0 0];
C_A=[0 0 0 Yvdot*v+Yrdot*r;0 0 0 -Xudot*u-Xwdot*w;0 0 0 0;-Yvdot*v-Yrdot*r Xudot*u+Xwdot*w 0 0];
C=C_RB+C_A;
D=[-Xu-Xuu*abs(u) 0 0 0;0 -Yv-Yvv*abs(v) 0 0;0 0 -Zw-Zww*abs(w) 0;0 0 0 -Nr-Nrr*abs(r)];
g=[0;0;0;0];
Tao=[fx;fy;fz;fr];
V=[u;v;w;r];
 yy=M\(Tao-C*V-D*V-g);
