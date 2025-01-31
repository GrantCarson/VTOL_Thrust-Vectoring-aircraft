filename = 'GyroReadings6hrsCut.csv';
dataT = csvread(filename);

GxT = dataT(:, 2);
GxRawData = transpose(GxT);

L = size(GxRawData,2);
Fs = 410.735;
T = 1/Fs;

average = mean(GxRawData(1:L));
meanVector = average*transpose(ones(L,1));
%Unbias the sensorValues
GxUnbiased = GxRawData-meanVector;

N = length(GxUnbiased);
J = floor(log2(N));
m  = zeros(numel(J-2),1);
for i=1:J-2
    m(i) = 2^i;
end

y = GxUnbiased;

%allan Variance Equation a[m]
a = zeros(J-2,1);
for i=1:J-2
   M = Mfunc(m(i),N);
   first =summer(m(i),N,y);
   second =((2*M)-1);
   a(i)=first/second;
end

[MinimumVal,MinimumIndex] = min(a);
m0 = 2^MinimumIndex;
t0 = m0*T;
test = t0/(10*T);
N1to2 = floor(t0/(10*T));
test2 = log2(N1to2);
N1 = floor(log2(N1to2));

m1  = zeros(4,1);
for i=1:N1
    m1(i) = 2^i;
end


%allan Variance Equation  a[m1]
a1 = zeros(N1,1);
for i=1:N1
   M = Mfunc(m1(i),N);
   first =summer(m1(i),N,y);
   second =((2*M)-1);
   a1(i)=first/second;
end

%define Hr
Hr = zeros(5,1);
for i = 1:N1
Hr(i) = 1/((2^i)*T);
end

HrT = transpose(Hr);
CR1 = CRF(m1,1,N,N1,T);
invCR = inv(CR1);

R0 = inv(HrT*invCR*Hr)*HrT*invCR*a1;
Q0 = (3*R0)/(t0^2);
CR = CRF(m,R0,N,(J-2),T);
CQ = CRF(m,Q0,N,(J-2),T);
C = CR+CQ;

%H
H=zeros(J-2,2);
for i=1:J-2
    H(i,1) = ((2^(i))*T)/3;
    H(i,2) = 1/((2^(i))*T);
end

HT = transpose(H);
QR = zeros(2,1);
Cinv = inv(C);

QR = inv(HT*Cinv*H)*HT*Cinv*a


asdf2 = 1;


function out = CRF(m,R,N,N1,T)
    out = zeros(N1,N1);
    for i = 1:N1
            for j =i:N1
                out(i,j) = CrEq(m(i),m(j),R,N,T);
                if(i ~= j)
                out(j,i) = out(i,j);    
                end
            end
    end
end
           

%Calculate one value of the CR matrix
function out = CrEq(m1,m2,R,N,T)
            p = m2/m1;
            M1 = N/m1;
            M2 = N/m2;
        numerator = (3*M2-4)*(R^2);
        denominator = (M1-1)*(M2-1)*(p^2)*((m1*T)^2);
        out = numerator/denominator;
end

%sigma of the Allan variance Equation
function sigma = summer(m,N,y)
    sigma = 0;
    M = Mfunc(m,N);
    for k = 2:M-1
    curr = ((z(k,m,y) -z(k-1,m,y))^2);
    sigma = sigma + curr;
    end
end

%M
function out = Mfunc(m,N)
out = floor(N/m);
end

%Zk 
function out = z(x,m,y)
out = (sum(y((m*(x-1))+1:(m*(x-1))+m)))/m;
end

