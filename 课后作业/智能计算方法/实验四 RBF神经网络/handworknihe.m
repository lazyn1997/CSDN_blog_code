clc;
clear;
M = 10;
centers = [];
deltas = [];
set = {};
gap = 0.01;
X = -9: 1: 8; 
P = length(X);
Y = [-129 -32 -118 -138 -125 -97 -55 -23 -4 2 1 -31 -72 -121 -142 -174 -155 -77];
A = randperm(M);
for i = 1: M 
    centers(i) = X(A(i));
end 
done = 0; 
while(~done) 
    for i = 1: M 
       set{i} = [];
    end 
    for i = 1: P 
        distance = 100;
        for j = 1: M 
            curr = abs(X(i) - centers(j)); 
            if curr < distance 
                sets = j;
                distance = curr;
            end 
        end 
        set{sets} = [set{sets}, X(i)];  
    end
    for i = 1: M 
        new_centers(i) = sum(set{i})/length(set{i}); 
        sum1(i) = abs(centers(i) - new_centers(i));
    end 
    if sum(sum1) > gap 
        done = 0;      
        centers = new_centers; 
    else 
        done = 1; 
    end    
end

for i = 1: M
    curr = abs(centers - centers(i)); 
    [curr_2, b] = min(curr); 
    curr(b) = 100; 
    curr_2 = min(curr); 
    deltas(i) = 2*curr_2; 
end
for i = 1: P 
    for j = 1: M 
        curr = abs(X(i) - centers(j)); 
        K(i, j) = exp(-curr^2/(2*deltas(j)^2) );  
    end 
end 
weights = K'*K\K'*Y'; 
X1 = -9: .1: 8;   
for i = 1: length(X1) 
    sum = 0; 
    for j = 1:M 
        curr = weights(j)*exp(-abs(X1(i) - centers(j))^2/(2*deltas(j)^2)); 
        sum = sum + curr; 
    end 
    Y1(i)=sum; 
end 
figure;
scatter(X, Y, 'o'); 
hold on; 
plot(X1, Y1, 'b-')
