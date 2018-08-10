function output = findD(Vs_req)
%插值求最大速度对应的直径%
k=1;
output=zeros(length(Vs_req)/21,8);
for i=1:length(Vs_req)/21
    for j=1:10001
        d=0.0001*j+7.4999;
        v(i,j)=interp1(Vs_req(k:k+20,2),Vs_req(k:k+20,3),d,'spline');
    end
        vmax1=max(v');
        vmax=vmax1(1,i);
        d_max=interp1(Vs_req(k:k+20,3),Vs_req(k:k+20,2),vmax,'spline');
        output(i,1)=Vs_req(k,1);        %v_d第一列为盘面比
        output(i,2)=d_max;           %第二列是直径最优值
        output(i,3)=vmax;            %第三列是速度最大值
        output(i,4)=interp1(Vs_req(k:k+20,3),Vs_req(k:k+20,4),vmax,'spline');%第四列为螺距
        output(i,5)=interp1(Vs_req(k:k+20,3),Vs_req(k:k+20,5),vmax,'spline');%第五列为效率
        output(i,6)=interp1(Vs_req(k:k+20,3),Vs_req(k:k+20,6),vmax,'spline');%第六列为推力系数
        output(i,7)=interp1(Vs_req(k:k+20,3),Vs_req(k:k+20,7),vmax,'spline');%第七列为扭矩系数
        output(i,8)=interp1(Vs_req(k:k+20,3),Vs_req(k:k+20,8),vmax,'spline');%第八列为进速系数
        k=k+21;
end

end

