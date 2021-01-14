figure('position',[1100 350 500 400])
p9 = plot3(sx,sy,sz,'k','LineWidth',3.5);
set(gca,'color',[round(209/255,2) round(209/255,2) round(209/255,2)])
p9(1).Color = [round(39/255,2) round(135/255,2) round(245/255,2)];
grid on
title('Poloha helikoptéry v prùbìhu øízení','FontSize',14);
xlim([min(sx) max(sx)]);
ylim([min(sy) max(sy)]);
zlim([min(sz) max(sz)]);
xlabel('x [m]','FontSize',11);
ylabel('y [m]','FontSize',11);
zlabel('z [m]','FontSize',11);
legend('trajektorie systému','FontSize',11,'Location','southoutside');
legend('boxoff');

figure('position',[1200 400 500 400])
subplot(211)
p10 = plot(sx,sy);
grid on
p10(1).LineWidth = 2.5;
p10(1).Color = [round(35/255,2) round(217/255,2) round(171/255,2)];
title('Poloha helikoptéry v jednotlivých osách','FontSize',12);
xlim([min(sx) max(sx)]);
ylim([min(sy) max(sy)]);
xlabel('x [m]','FontSize',11)
ylabel('y [m]','FontSize',11)
legend('trajektorie systému','FontSize',11,'Location','southeast');
legend('boxoff');

subplot(212)
p11 = plot(sx,sz)
grid on
p11(1).LineWidth = 2.5;
p11(1).Color = [round(35/255,2) round(217/255,2) round(171/255,2)];
xlim([min(sx) max(sx)]);
ylim([min(sz) max(sz)]);
xlabel('x [m]','FontSize',11)
ylabel('z [m]','FontSize',11)
legend('trajektorie systému','FontSize',11,'Location','southeast');
legend('boxoff');