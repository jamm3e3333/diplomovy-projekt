figure('position',[100 25 800 700])
subplot(211)
p = plot(t,y,t,y1,t,y2,t,y3);
p(1).LineWidth = 3.5;
p(1).Color = [round(3/255,2),round(165/255,2),round(252/255,2)];
p(2).LineWidth = 3.5;
p(2).Color = [round(28/255,2),round(237/255,2),round(202/255,2)];
p(3).LineWidth = 3.5;
p(3).Color = [round(207/255,2),round(168/255,2),round(240/255,2)];
p(4).LineWidth = 3.5;
p(4).Color = [round(234/255,2),round(240/255,2),round(134/255,2)];
grid on
yMax =  max(max([y y1 y2 y3]))+0.1*max(max([y y1 y2 y3]));
yMin = min(min([y y1 y2 y3]))+0.1*min(min([y y1 y2 y3]));

xlim([0 t(end,1)])
ylim([yMin yMax])

xlabel('t[s]','FontSize',12);
ylabel('y(t)','FontSize',12);
title('Prùbìh regulace - regulované velièiny','FontSize',12);
legend(sprintf('v_z\\infty(%.2f)',y(end,1)),sprintf('v_y\\infty(%.2f)',y1(end,1)),...
    sprintf('v_x\\infty(%.2f)',y2(end,1)),...
    sprintf('\\omega_z\\infty(%.2f)',y3(end,1))...
    ,'FontSize',12,'location','northeast','NumColumns',2);

subplot(212)
p_1 = plot(t,w,t,w1,t,w2,t,w3,'--');
p_1(1).Color = [round(3/255,2),round(165/255,2),round(252/255,2)];
p_1(2).Color = [round(28/255,2),round(237/255,2),round(202/255,2)];
p_1(3).Color = [round(207/255,2),round(168/255,2),round(240/255,2)];
p_1(4).Color = [round(234/255,2),round(240/255,2),round(134/255,2)];

for i = 1:4
    p_1(i).LineWidth = 2.5;
end
grid on
title('Prùbìh regulace - žádané velièiny','FontSize',12);
ylim([  min(min([w w1 w2 w3]))+0.1*min(min([w w1 w2 w3]))  max(max([w w1 w2 w3]))+0.1*max(max([w w1 w2 w3])) ]);
xlim([0 t(end,1)]);
legend('w_1','w_2','w_3','w_4','FontSize',11);
xlabel('t[s]','FontSize',12);
ylabel('w(t)','FontSize',12);

%vykreslení pro  1. stavový regulátor
%----------------------------------------------------------------------------
figure('position', [200 50 800 800])
subplot(211)
p1 = plot(t,x_stav);
p1(1).LineWidth = 2.5;
p1(1).Color = [round(3/255,2),round(165/255,2),round(252/255,2)];
p1(2).Color = [round(28/255,2),round(237/255,2),round(202/255,2)];
p1(5).Color = [round(207/255,2),round(168/255,2),round(240/255,2)];
p1(8).Color = [round(234/255,2),round(240/255,2),round(134/255,2)];

for i = 2:8
    if(i == 2 || i == 5 || i == 8)
        p1(i).LineWidth = 2.5;
    else
        p1(i).LineWidth = 0.5;
    end
    
end
title('Prùbìh regulace - stavové velièiny pro 1. stavový regulátor','FontSize',12.5);
ylim([(min(min(x_stav))+(0.1*min(min(x_stav)))   ) (max(max(x_stav))+(0.1*max(max(x_stav)))  )]);
xlim([0 t(end,1)]);
xlabel('t[s]','FontSize',12);
ylabel('y(t)','FontSize',12);
grid on
lgd = legend(sprintf('v_x'),...
    sprintf('v_z'),...
    sprintf('\\omega_y'),...
    sprintf('\\alpha_y'),...
    sprintf('v_y'),...
    sprintf('\\omega_x'),...
    sprintf('\\alpha_x'),...
    sprintf('\\omega_z'),...
    'Location','northeast','FontSize',11);
lgd.NumColumns = 2;

subplot(212)
p2 = plot(t,w,t,u,t,y);
p2(1).LineWidth = 1.5;
p2(1).Color = [round(3/255,2),round(165/255,2),round(252/255,2)];
p2(2).LineWidth = 2.5;
p2(2).Color = [round(28/255,2),round(237/255,2),round(202/255,2)];
p2(3).LineWidth = 3.5;
p2(3).Color = [round(219/255,2),round(42/255,2),round(42/255,2)];
grid on
title('Prùbìh regulace pro 1. stavový regulátor','FontSize',12.5);
legend('w','u','y \rightarrow v_z','FontSize',11);
ylim([min(min([u w y]))+0.1*min(min([u w y])) max(max([u w y]))+0.1*max(max([u w y]))]);
xlim([0 t(end,1)]);
xlabel('t[s]','FontSize',12);
ylabel('w(t)','FontSize',12);
%----------------------------------------------------------------------------

%vykreslení pro 2. stavový regulátor
%----------------------------------------------------------------------------
figure('position', [300 75 800 800])
subplot(211)
p3 = plot(t,x_stav1);
p3(1).LineWidth = 2.5;
p3(1).Color = [round(3/255,2),round(165/255,2),round(252/255,2)];
p3(2).Color = [round(28/255,2),round(237/255,2),round(202/255,2)];
p3(5).Color = [round(207/255,2),round(168/255,2),round(240/255,2)];
p3(8).Color = [round(234/255,2),round(240/255,2),round(134/255,2)];

for i = 2:8
    if(i == 2 || i == 5 || i == 8)
        p3(i).LineWidth = 2.5;
    else
        p3(i).LineWidth = 0.5;
    end
    
end
title('Prùbìh regulace - stavové velièiny pro 2. stavový regulátor','FontSize',12.5);
ylim([(min(min(x_stav1))+(0.1*min(min(x_stav1)))   ) (max(max(x_stav1))+(0.1*max(max(x_stav1)))  )]);
xlim([0 t(end,1)]);
xlabel('t[s]','FontSize',12);
ylabel('y(t)','FontSize',12);
grid on
lgd = legend(sprintf('v_x'),...
    sprintf('v_z'),...
    sprintf('\\omega_y'),...
    sprintf('\\alpha_y'),...
    sprintf('v_y'),...
    sprintf('\\omega_x'),...
    sprintf('\\alpha_x'),...
    sprintf('\\omega_z'),...
    'Location','southeast','FontSize',11);
lgd.NumColumns = 2;

subplot(212)
p4 = plot(t,w1,t,u1,t,y1);
p4(1).LineWidth = 1.5;
p4(1).Color = [round(3/255,2),round(165/255,2),round(252/255,2)];
p4(2).LineWidth = 2.5;
p4(2).Color = [round(28/255,2),round(237/255,2),round(202/255,2)];
p4(3).LineWidth = 3.5;
p4(3).Color = [round(219/255,2),round(42/255,2),round(42/255,2)];
grid on
xlabel('t[s]','FontSize',12);
ylabel('w(t)','FontSize',12);
title('Prùbìh regulace pro 2. stavový regulátor','FontSize',12.5);
legend('w','u','y \rightarrow v_y','FontSize',11);
ylim([min(min([u1 w1 y1]))+0.1*min(min([u1 w1 y1])) max(max([u1 w1 y1]))+0.1*max(max([u1 w1 y1]))]);
xlim([0 t(end,1)]);
%----------------------------------------------------------------------------


%vykreslení  pro 3. stavový regulágor
%----------------------------------------------------------------------------
figure('position', [400 100 800 800])
subplot(211)
p5 = plot(t,x_stav2);
p5(1).LineWidth = 2.5;
p5(1).Color = [round(3/255,2),round(165/255,2),round(252/255,2)];
p5(2).Color = [round(28/255,2),round(237/255,2),round(202/255,2)];
p5(5).Color = [round(207/255,2),round(168/255,2),round(240/255,2)];
p5(8).Color = [round(234/255,2),round(240/255,2),round(134/255,2)];

for i = 2:8
    if(i == 2 || i == 5 || i == 8)
        p5(i).LineWidth = 2.5;
    else
        p5(i).LineWidth = 0.5;
    end
    
end
title('Prùbìh regulace - stavové velièiny pro 3. stavový regulátor','FontSize',12.5);
ylim([(min(min(x_stav2))+(0.1*min(min(x_stav2)))   ) (max(max(x_stav2))+(0.1*max(max(x_stav2)))  )]);
xlim([0 t(end,1)]);
xlabel('t[s]','FontSize',12);
ylabel('y(t)','FontSize',12);
grid on
lgd = legend(sprintf('v_x'),...
    sprintf('v_z'),...
    sprintf('\\omega_y'),...
    sprintf('\\alpha_y'),...
    sprintf('v_y'),...
    sprintf('\\omega_x'),...
    sprintf('\\alpha_x'),...
    sprintf('\\omega_z'),...
    'Location','northeast','FontSize',11);
lgd.NumColumns = 2;

subplot(212)
p6 = plot(t,w2,t,u2,t,y2);
p6(1).LineWidth = 1.5;
p6(1).Color = [round(3/255,2),round(165/255,2),round(252/255,2)];
p6(2).LineWidth = 2.5;
p6(2).Color = [round(28/255,2),round(237/255,2),round(202/255,2)];
p6(3).LineWidth = 3.5;
p6(3).Color = [round(219/255,2),round(42/255,2),round(42/255,2)];
grid on
title('Prùbìh regulace pro 3. stavový regulátor','FontSize',12.5);
legend('w','u','y \rightarrow v_x','FontSize',11);
ylim([min(min([u2 w2 y2]))+0.1*min(min([u2 w2 y2])) max(max([u2 w2 y2]))+0.1*max(max([u2 w2 y2]))]);
xlim([0 t(end,1)]);
xlabel('t[s]','FontSize',12);
ylabel('w(t)','FontSize',12);
%----------------------------------------------------------------------------

%vykreslení pro 4. stavový regulátor
%----------------------------------------------------------------------------
figure('position', [500 125 800 800])
subplot(211)
p7 = plot(t,x_stav3);
p7(1).LineWidth = 2.5;
p7(1).Color = [round(3/255,2),round(165/255,2),round(252/255,2)];
p7(2).Color = [round(28/255,2),round(237/255,2),round(202/255,2)];
p7(5).Color = [round(207/255,2),round(168/255,2),round(240/255,2)];
p7(8).Color = [round(234/255,2),round(240/255,2),round(134/255,2)];

for i = 2:8
    if(i == 2 || i == 5 || i == 8)
        p7(i).LineWidth = 2.5;
    else
        p7(i).LineWidth = 0.5;
    end
    
end
title('Prùbìh regulace - stavové velièiny pro 4. stavový regulátor','FontSize',12.5);
ylim([(min(min(x_stav3))+(0.1*min(min(x_stav3)))   ) (max(max(x_stav3))+(0.1*max(max(x_stav3)))  )]);
xlim([0 t(end,1)]);
xlabel('t[s]','FontSize',12);
ylabel('y(t)','FontSize',12);
grid on
lgd = legend(sprintf('v_x'),...
    sprintf('v_z'),...
    sprintf('\\omega_y'),...
    sprintf('\\alpha_y'),...
    sprintf('v_y'),...
    sprintf('\\omega_x'),...
    sprintf('\\alpha_x'),...
    sprintf('\\omega_z'),...
    'Location','northeast','FontSize',11);
lgd.NumColumns = 2;

subplot(212)
p8 = plot(t,w3,t,u3,t,y3);
p8(1).LineWidth = 1.5;
p8(1).Color = [round(3/255,2),round(165/255,2),round(252/255,2)];
p8(2).LineWidth = 2.5;
p8(2).Color = [round(28/255,2),round(237/255,2),round(202/255,2)];
p8(3).LineWidth = 3.5;
p8(3).Color = [round(219/255,2),round(42/255,2),round(42/255,2)];
grid on
title('Prùbìh regulace pro 4. stavový regulátor','FontSize',12.5);
legend('w','u','y \rightarrow \omega_z','FontSize',11,'Location','southeast');
ylim([min(min([u3 w3 y3]))+0.1*min(min([u3 w3 y3])) max(max([u3 w3 y3]))+0.1*max(max([u3 w3 y3]))]);
xlim([0 t(end,1)]);
xlabel('t[s]','FontSize',12);
ylabel('w(t)','FontSize',12);
%----------------------------------------------------------------------------