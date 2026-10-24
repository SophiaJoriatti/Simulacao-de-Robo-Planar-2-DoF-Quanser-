clc; clear all; close all;

trajeto_valido = false;
while ~trajeto_valido
    n_caminho = input(['Entre com o número do caminho:\n' ...
    '1) Reta\n2) Semi-circulo\n3) Cúbica\n4) Coração\n> ']);

    switch n_caminho
        case 1
            Caminho.x = -1:0.07:1;
            Caminho.y = Caminho.x + 0.5;
            trajeto_valido = true;
        case 2
            Caminho.x = 0.5 + 1.2 * cosd(0:5:180);
            Caminho.y = 1.2 * sind(0:5:180);
            trajeto_valido = true;
        case 3
            Caminho.x = -1:0.05:1;
            Caminho.y = Caminho.x.^3 + 0.5;
            trajeto_valido = true;
        case 4
            theta_vetor = linspace(0, 2*pi, 200);
            esc = 0.1;
            Caminho.x = esc * 16 * (sin(theta_vetor)).^3;
            Caminho.y = esc * (13*cos(theta_vetor) - 5*cos(2*theta_vetor) - 2*cos(3*theta_vetor) - cos(4*theta_vetor));
            trajeto_valido = true;
        otherwise
            disp('Opção inválida. Tente novamente.');
    end
end

figure; plot(Caminho.x, Caminho.y, 'LineWidth', 2); axis equal; grid on;
title(sprintf('Caminho %d', n_caminho));

L1 = 1;
L2 = 1;

theta1 = [];
theta2 = [];
theta1c = [];
theta2c = [];

figure('Position', [100, 100, 1200, 600]);

for k = 1:length(Caminho.x)
    x = Caminho.x(k);
    y = Caminho.y(k);

    c_th2 = (x^2 + y^2 - (L1^2 + L2^2)) / (2*L1*L2);

    if (abs(c_th2) > 1)
        continue;
    else
        % Cotovelo para cima
        s_th2 = sqrt(1 - c_th2^2);
        th2 = atan2(s_th2, c_th2);
        k1 = L1 + L2*c_th2;
        k2 = L2*s_th2;
        r = sqrt(k1^2 + k2^2);
        th1 = atan2(y/r, x/r) - atan2(k2, k1);

        % Cotovelo para baixo
        s_th2_c = -sqrt(1 - c_th2^2);
        th2c = atan2(s_th2_c, c_th2);
        k1_c = L1 + L2*c_th2;
        k2_c = L2*s_th2_c;
        r_c = sqrt(k1_c^2 + k2_c^2);
        th1c = atan2(y/r_c, x/r_c) - atan2(k2_c, k1_c);
    end

    th1 = rad2deg(th1);
    th2 = rad2deg(th2);
    th1c = rad2deg(th1c);
    th2c = rad2deg(th2c);

    % Configuração: Cotovelo para Cima
    x1(k) = L1 * cosd(th1);
    y1(k) = L1 * sind(th1);
    x2(k) = L1 * cosd(th1) + L2 * cosd(th1 + th2);
    y2(k) = L1 * sind(th1) + L2 * sind(th1 + th2);

    theta1 = [theta1, th1];
    theta2 = [theta2, th2];

    % Configuração: Cotovelo para Baixo
    x1_c(k) = L1 * cosd(th1c);
    y1_c(k) = L1 * sind(th1c);
    x2_c(k) = L1 * cosd(th1c) + L2 * cosd(th1c + th2c);
    y2_c(k) = L1 * sind(th1c) + L2 * sind(th1c + th2c);
    
    theta1c = [theta1c, th1c];
    theta2c = [theta2c, th2c];

    % --------- Plots Animados ---------
    
    subplot(2,6,[3,4])
    axis([0 length(Caminho.x) -360 360])
    hold on; plot(theta1, 'b'); title('Junta 1'); grid on; hold off;

    subplot(2,6,[5,6])
    axis([0 length(Caminho.x) -360 360])
    hold on; plot(theta2, 'b'); title('Junta 2 / Cotovelo para Cima');
    ylabel('Ângulo da junta 2 [graus]'); set(gca, 'yaxislocation', 'right'); grid on; hold off;

    subplot(2,6,[9,10])
    axis([0 length(Caminho.x) -360 360])
    hold on; plot(theta1c, 'r'); title('Junta 1'); grid on; hold off;

    subplot(2,6,[11,12])
    axis([0 length(Caminho.x) -360 360])
    hold on; plot(theta2c, 'r'); title('Junta 2 / Cotovelo para Baixo');
    ylabel('Ângulo da junta 2 [graus]'); set(gca, 'yaxislocation', 'right'); grid on; hold off;

    subplot(2,6,[1,2,7,8])
    % Visualização Cotovelo para Cima
    plot([0 x1(k)], [0 y1(k)], 'k', 'linewidth', 2); hold on;
    plot([x1(k) x2(k)], [y1(k) y2(k)], 'k', 'linewidth', 2);
    
    plot(0, 0, 'og', 'linewidth', 2, 'markersize', 10);
    plot(0, 0, 'og', 'linewidth', 2, 'markersize', 15);
    plot(x1(k), y1(k), 'or', 'linewidth', 2, 'markersize', 10);
    plot(x1(k), y1(k), 'or', 'linewidth', 2, 'markersize', 15);
    plot(x2(k), y2(k), 'sb', 'linewidth', 2, 'markersize', 10);
    plot(x2(k), y2(k), 'sb', 'linewidth', 2, 'markersize', 15);
    
    % Visualização Cotovelo para Baixo
    plot([0 x1_c(k)], [0 y1_c(k)], 'k--', 'linewidth', 2);
    plot([x1_c(k) x2_c(k)], [y1_c(k) y2_c(k)], 'k--', 'linewidth', 2);
    
    plot(x1_c(k), y1_c(k), 'or', 'linewidth', 2, 'markersize', 10);
    plot(x1_c(k), y1_c(k), 'or', 'linewidth', 2, 'markersize', 15);
    plot(x2_c(k), y2_c(k), 'sb', 'linewidth', 2, 'markersize', 10);
    plot(x2_c(k), y2_c(k), 'sb', 'linewidth', 2, 'markersize', 15);

    % Traçado do caminho
    plot(x1, y1, 'r');
    plot(x2, y2, 'b');

    text(0, 0.2, 'junta1');
    text(x1(k), y1(k)+0.2, 'junta2');
    text(x2(k), y2(k)+0.2, 'punho');

    hold off;
    xlabel('x'); ylabel('y');
    axis equal; grid on; drawnow;
end
