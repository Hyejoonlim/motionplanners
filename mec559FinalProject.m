%% General Parameters
% The environment
l = 30;
w = 20;

% Start ang goal
start = [3 18];
goal = [28, 12];


% The obstales Limits
Cobs1 = [5	7;  0	8;  5	7; 12	20
         10	15; 4	14; 18	20;  0	8
        18	20; 12   20; 23  26;  8 12];           
          
Cobs2 = [5	7;  0	8;  5	7; 12	20
         9	15; 8	10; 9	15;  16	18
        22	25; 2   10; 22  25;  14 18];  

Cobs3 = [5	7;  0	8;  5	7; 12	16
         9	15; 8	10; 9	15;  16	18
        12	15; 8   12; 22  28;  2 6
        18	24; 10   13; 23  28;  16 20]; 

Cobs4 = [5	7;  0	8;  5	12; 14	18
         14	18; 10	14; 10	20;  4	7
        26	30; 2   5; 24  26;  8 10
        20	25; 10   13; 24  26;  14 18];

Cobs5 = [3	7;  12	14;  5	7; 12	20
         10	16; 16 18; 10	20;  2	6
        16	18; 8  12; 10  14;  10 12
        24	26; 12   16; 24  28;  16 18
        22	26; 6   9; 26  28;  5 10];
           
                    
%% Random Sampling multiple search tress
% Plotting the enviroments and getting the obstacle space
figure(1)
multipleSearchTree(start, goal, Cobs1, l, w)

figure(2)
multipleSearchTree(start, goal, Cobs2, l, w)

figure(3)
multipleSearchTree(start, goal, Cobs3, l, w)

figure(4)
multipleSearchTree(start, goal, Cobs4, l, w)

figure(5)
multipleSearchTree(start, goal, Cobs5, l, w)

%% Circular Sampling
figure(6)
circleSampling(start, goal, Cobs1, l, w)

figure(7)
circleSampling(start, goal, Cobs2, l, w)

figure(8)
circleSampling(start, goal, Cobs3, l, w)

figure(9)
circleSampling(start, goal, Cobs4, l, w)

figure(10)
circleSampling(start, goal, Cobs5, l, w)

%% Safe Sampling
figure(11)
safeExpansion(start, goal, Cobs1, l, w)

figure(12)
safeExpansion(start, goal, Cobs2, l, w)

figure(13)
safeExpansion(start, goal, Cobs3, l, w)

figure(14)
safeExpansion(start, goal, Cobs4, l, w)

figure(15)
safeExpansion(start, goal, Cobs5, l, w)