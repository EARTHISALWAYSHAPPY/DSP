w = linspace(-3*pi, 3*pi, 2000);
X = (1 - exp(-1i*w)) ./ (1 + 0.8*exp(-1i*w)); %<--- sample / sample = ./

YL = [-5 20];

figure(1);
A = subplot(2,1,1);
line(w, abs(X), 'Color', 'g');
set(A, 'XLim', [w(1) w(end)], 'YLim', YL);
title('Magnitude Spectrum')
grid on

A = subplot(2,1,2);
line(w, angle(X), 'Color', 'r');
set(A, 'XLim', [w(1) w(end)], 'YLim', [-pi pi]);
title('Phase Spectrum')
grid on

%continuous time use line
%discrate time use stem
