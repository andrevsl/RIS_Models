function [x,Pos_x] = CS_OMP(y,A,t)
%CS_OMP �˴���ʾ�йش˺�����ժҪ
%   y = A*x������A: R*K��y:R*1��x:K*1
%   R�����ջ���t��δ֪�û���tΪϡ���
%   ������֪y��A����x
    [y_rows,y_columns] = size(y);  
    if y_rows < y_columns
        y = y';   % y should be a column vector
    end
    [R,K] = size(A);  % A: sensing matrix
    x = zeros(K,1);  % x is a column vector to be predicted
    At = zeros(R,t);  % At�����洢����������A��ѡ�����
    Pos_x = zeros(1,t);  % Pos_x�����洢A�б�ѡ����е����
    r_n = y;  % initial residual is y
    for ii = 1:t
        product = A'*r_n;  % ���㴫�о���A������в���ڻ���K*1
        [val,pos] = max(abs(product));   % Ѱ������ڻ�����ֵ������в�����ص���
        At(:,ii) = A(:,pos);
        Pos_x(ii) = pos;
        A(:,pos) = zeros(R,1);  %����A����һ�У��ɲ�Ҫ
        x_ls = (At(:,1:ii)'*At(:,1:ii))^(-1)*At(:,1:ii)'*y;  % ����С���˽�
        r_n = y - At(:,1:ii)*x_ls;  % ���²в�
    end
    x(Pos_x) = x_ls;  % �ָ�������x
end

