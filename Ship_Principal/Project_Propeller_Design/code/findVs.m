function Vs_req = findVs(PD_req,den,n,w,t)
%到某一螺旋桨直径下设计所需的航速
%输入:海水密度den,螺旋桨转速n,伴流系数w,推力减额分数t
%输出:最优航速

Vs = PD_req(:,3);%从矩阵中提取航速
[ PE1, PE2, PE3 ] = calPE(Vs);%PE1压载功率, PE2满载功率, PE3超满载功率
R = (PE1.*1000)./(Vs.*0.514);%计算阻力
Kt2 = (R./PD_req(:,2).^4)./((1-t)*den*n^2);%计算需要的推力系数
delta_Kt=Kt2-PD_req(:,6);

k=1;
PD_len=length(Kt2)/21;
Vs_req=zeros(PD_len,8);
for i=1:1:PD_len
    Vs_req(i,1) = PD_req(k,1);%第一列盘面比
    Vs_req(i,2) = PD_req(k,2);%第二列直径
    %第三列插值确定需要的航速
    Vs_req(i,3) = interp1(delta_Kt(k:k+20,1),PD_req(k:k+20,3),0,'spline'); 
    %第四列插值确定需要的螺距
    Vs_req(i,4) = interp1(delta_Kt(k:k+20,1),PD_req(k:k+20,4),0,'spline');  
    %第五列插值确定需要的效率
    Vs_req(i,5) = interp1(delta_Kt(k:k+20,1),PD_req(k:k+20,5),0,'spline');  
    %第六列插值确定需要的推力系数
    Vs_req(i,6) = interp1(delta_Kt(k:k+20,1),PD_req(k:k+20,6),0,'spline');  
    Vs_req(i,7) = PD_req(k,8);%第七列计算扭矩系数
    Vs_req(i,8) = 0.514*Vs_req(i,3)*(1-w)/n/Vs_req(i,2);%第八列计算进速系数
    k=k+21;
end

