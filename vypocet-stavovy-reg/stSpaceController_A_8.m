close all
clear;
clc;

%matice systemu
A = [-0.07 -0.017 16.62 -18.4 0.001 -1.0 0.02 -0.07;
    0.04 -0.65 0.14 -1.39 -0.04 0.07 -0.33 -0.03;
    0.01 0.007 -2.72 -2.22 0.0002 0.15 -0.001 -0.04;
    0 0 1 0 0 0 0 0;
    -0.007 -0.006 -0.97 0.005 -0.14 -6.91 22.3 3.76;
    -0.0006 0.003 -0.81 0.001 -0.014 -4.56 -6.26 0.63;
    0 0 0 0 0 1 0 0;
    0.007 0.015 -0.55 0.0001 0.014 -1.03 -0.92 -3.68]

%stavova matice rizeni
B = [-2.2 0.54 0 0.0001;
    -0.01 -12.1 -314.45 0;
    0.36 -0.003 -0.001 0.008;
    0 0 0 0 ;
    -0.034 -0.17 1.81 -1.0;
    0.093 -0.098 1.09 -0.25;
    0 0 0 0;
    0.25 0.04 0.04 0.73]

%vystupni matice systemu
x = ["v_x","v_y","omega_y","alpha_y","v_z","omega_x","alpha_x","omega_z"];
disp('regulovane veliciny: ');
C = [0 1 0 0 0 0 0 0;
      0 0 0 0 1 0 0 0;
      1 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 1]
  
        
%Kontrola riditelnosti pro jednotlive sloupce matice B  
disp('-----------------------------------------');
disp('-----------------------------------------');
disp('Kontrola riditelnosti');
disp('-----------------------------------------');

for i = 1: size(B,2)
    Qco{i,1} = ctrb(A,B(:,i));
    det_Qco(i,1) = det(Qco{i,1});
    if det_Qco(i,1) == 0
        disp('Nulovy determinant, system je neriditelny!');
    else
        disp('System je riditelny!');
    end
end

%Kontrola pzorovatelnosti pro jednotlive radky matice C
disp('-----------------------------------------');
disp('Kontrola pozorovatelnosti');
disp('-----------------------------------------');

for i = 1: size(C,1)
    Qob{i,1} = obsv(A,C(i,:));
    det_Qob(i,1) = det(Qob{i,1});
    
    if det_Qob == 0
        disp('System je nepozorovatelny!');
    else
        disp('System je pozorovatelny!');
    end
end

disp('-----------------------------------------');
disp('');

%vypocet prenosu systemu pro jednotlive sloupce matice B a jednotlive radky
%matice C
%zavedene symbolicke promenne s jako komplexni promenne 
syms s 
disp('-----------------------------------------');
disp('Prenos systemu');
disp('-----------------------------------------');


%jednotkova matice I*s
for i = 1:size(A,1)
    for j = 1: size(A,2)
        if i == j
            I(i,j) = s;
        else
            I(i,j) = 0;
        end
    end
end


%disp('sI - A');
sIA = I - A;
disp('-----------------------------------------');
disp('det(sI - A)');
det_sIA = det(sIA)
disp('-----------------------------------------');

disp('Determinanty pro jednotlive sloupce matice B a jednotlive radky matice C')
disp('-----------------------------------------');
for i = 1:size(B,2)
    sIABC{i,1} = sIA+(B(:,i)*C(i,:));
    sprintf('sI - A + B(%d,%d)*C(%d,%d)',size(B,2),i,i,size(C,1))
    sIABC{i,1}
    disp('-----------------------------------------');
    det_sIABC(i,1) = det(sIABC{i,1});
    sprintf('det(sI - A + B(%d,%d)*(C(%d,%d))',size(B,2),i,i,size(C,1))
    det_sIABC(i,1)
    Y(i,1) = det_sIABC(i,1) - det_sIA;
end
disp('-----------------------------------------');

disp('Jmenovatel prenosu');
disp('-----------------------------------------');
U = det_sIA

%vypocet koeficintu citatele a jmenovatele
for i = 1: size(B,2)
    for j = 1:size(B,1)
        if j == 1
            b(i,j) = double(subs(Y(i,1),s,0));
        else 
            b(i,j) = double(subs(diff(Y(i,1),s,j-1)/factorial(j-1),s,0));
        end
    end
end

for i = 1: size(B,1)
    if i == 1
        a(1,i) = double(subs(U,s,0));
    else
        a(1,i) = double(subs(diff(U,s,i-1)/factorial(i-1),s,0));
    end
end

for i = 1: size(B,2)
    b(i,:);
    G(1,i) = Y(i,1)/U;
end

disp('-----------------------------------------');
disp('Koeficienty citatelu');
disp('-----------------------------------------');
b
disp('');
disp('Koeficienty jmenovatelu');
disp('-----------------------------------------');
a
disp('-----------------------------------------');
disp('');

%---------------------------------------------------------------------------------%
%  G(s) = Y(s)/U(s) = b_n-1*s^n-1+ ... + b_2*s^2 + b_1*s + b_0 / 
%                     a_n*s^n+ ... + a_2*s^2 + a_1*s + a_0  
%---------------------------------------------------------------------------------%

for i = 1:size(A,1)
    for j = 1:size(A,1)
        if (size(A,1)-(i-1)) == j
            QcoInv(i,j) = 1;
        elseif j > (size(A,1)-(i-1))
            QcoInv(i,j) = 0;
        else
           for l = 1:(size(A,1)-i)
               QcoInv(i,l) = a(1,(l+i));
           end
        end
    end
end


disp('-----------------------------------------------------------');
disp('QCO^-1');
QcoInv
disp('-----------------------------------------------------------');

for i = 1: size(A,1)
    for j = 1: size(A,1)
       if((i+1) == j) && not(i == size(A,1))
           Ac(i,j) = 1;
       elseif not(i == size(A,1))
           Ac(i,j) = 0;
       else
           for l = 1:size(A,1)
               Ac(i,l) = -a(1,l);
           end
       end
    end    
end

disp('-----------------------------------------------------------');
disp('AC');
Ac
disp('-----------------------------------------------------------');

disp('-----------------------------------------------------------')
disp('Transformacni matice Tc');
disp('-----------------------------------------------------------')
disp('-----------------------------------------------------------')

for i = 1:size(B,2)
    disp('-----------------------------------------------------------')
    sprintf('Tco{%d,1} = ',i)
    Tc{i,1} = Qco{i,1}*QcoInv;
    Tc{i,1}
    disp('-----------------------------------------------------------')
    sprintf('TcoInv{%d,1} = ',i)
    TcInv{i,1} = inv(Tc{i,1});
    TcInv{i,1}
    disp('-----------------------------------------------------------')    
end

%---------------------------------------------------------------------------------%
% TC = QCO*QCO^-1
%---------------------------------------------------------------------------------%
% BC = TC^-1*B 
%---------------------------------------------------------------------------------%
% CCT = CT*TC
%---------------------------------------------------------------------------------%

%metoda transformace

for i = 1:(size(A,1)-1)
    if i == 1
        aw = conv([1 1],[1 1]);
    else
        aw = conv(aw,[1 1]);
    end
end

aw = aw(1,1:(length(aw)-1));

disp('-----------------------------------------------------------')
disp('');
disp('-----------------------------------------------------------')
disp('coeffs a: ');
aw
disp('-----------------------------------------------------------')

disp('-----------------------------------------------------------')
disp('stavovy regulator');

for i = 1:size(B,2)
   kt(i,:) = (aw-a)*TcInv{i,1};
   
   disp('-----------------------------------------------------------')
   sprintf('Aw{%d,1} = ',i)
   Aw{i,1} = A - (B(:,i)*kt(i,1));
   Aw{i,1}
   disp('-----------------------------------------------------------')
   disp('');
   
   disp('-----------------------------------------------------------')
   sprintf('AwInv{%d,1}',i)
   AwInv{i,1} = inv(Aw{i,1});
   AwInv{i,1}
   disp('-----------------------------------------------------------')
   disp('');
   
   kw(i,1) = inv(-C(i,:)*AwInv{i,1}*B(:,i));
end

disp('-----------------------------------------------------------')
disp('kt');
kt
disp('-----------------------------------------------------------')
disp('');
 

disp('-----------------------------------------------------------')
disp('kw');
kw
disp('-----------------------------------------------------------')
disp('');

disp('Regulovane veliciny: ');
disp('');
for i = 1:size(C,1)
    for j = 1:size(C,2)
        if(C(i,j))
            sprintf('(%d) - %s',i,x(1,j))
        end
    end
end
disp('-----------------------------------------------------------')
%spusteni simulace
sim('ControlKT8_8');
%spusteni skriptu na vykresleni
run('display_s_8_8_Script.m');
%spusteni skriptu na vykresleni
run('display_location.m');
