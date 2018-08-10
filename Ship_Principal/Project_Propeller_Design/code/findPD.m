function PD_req = findPD(Result, Q, den, n)
%在某个螺旋桨直径下, 通过插值确定满足设计功率要求（即：螺旋桨
%要求的扭矩与设计功率与转速下的收到转矩平衡）的螺距及相应的有效推力
%与敞水效率)
%输入:Result
%     螺旋桨收到转矩D, 海水密度den, 螺旋桨转速n
%输出:每个螺旋桨直径下合适的螺距比PD
k=1;
PD_req=zeros(length(Result)/13,8);
for i=1:1:length(Result)/13
    Kq_req=Q/(den*n^2*Result(k,2)^5);%螺旋桨要求的扭矩
    PD_req(i,1)=Result(k,1);%固定盘面比
    PD_req(i,2)=Result(k,2);%固定直径
    PD_req(i,3)=Result(k,3);%固定航速
    %由扭矩系数插值得到螺距比
    PD_req(i,4)=interp1(Result(k:k+12,7),Result(k:k+12,5),Kq_req,'spline');
    %由扭矩系数插值得到敞水效率
    PD_req(i,5)=interp1(Result(k:k+12,7),Result(k:k+12,8),Kq_req,'spline');
    %由扭矩系数插值得到推力系数
    PD_req(i,6)=interp1(Result(k:k+12,7),Result(k:k+12,6),Kq_req,'spline');
    %由推力系数计算出的有效推力
    PD_req(i,7)=PD_req(i,6)*den*n^2*Result(k,2)^4;
    PD_req(i,8)=Kq_req;%对应扭矩系数
    k=k+13;
end

