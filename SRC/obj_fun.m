function A = obj_fun(x, Testset, t_final, t_off)

b = [x(1:7), x(14), x(15)];
beta = x(13);

A = zeros(1,length(Testset));

for i = 1:length(Testset)
    
    if contains(Testset(i).name,'40')
        
        if ~contains(Testset(i).name,'140')
        A(i) = obj_fun_all(b, x(8), Testset(i), t_final(1),  t_off(1), beta, 0.005);
        else
        A(i) = obj_fun_all(b, x(12), Testset(i), t_final(6),  t_off(6), beta,  0.001);    
        end
        
    elseif contains(Testset(i).name,'60')
        
        A(i) = obj_fun_all(b, x(9), Testset(i), t_final(2),  t_off(2), beta, 0.3);
        
    elseif contains(Testset(i).name,'80')
        
        A(i) = obj_fun_all(b, x(10), Testset(i), t_final(3),  t_off(3), beta, 0.5);
        
    elseif contains(Testset(i).name,'100')
        
        A(i) = obj_fun_all(b, 1, Testset(i), t_final(4),  t_off(4), beta, 1.5);
        
    elseif contains(Testset(i).name,'120')
        
        A(i) = obj_fun_all(b, x(11), Testset(i), t_final(5),  t_off(5), beta, 0.3);
        
    end
    
end


A = sum(A);
