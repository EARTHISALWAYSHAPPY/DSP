clear;
clc;
close all;
% Gigital Filter : low pass -> band pass
% - define Center Freq, Cutoff Freq, Bandwidth (rad/sample)
% Generate FIR hd[n] : (2/(pi*n) * sin(n*wc) * cos(n*w0);
wc = pi/8;          % cutoff (rad/sample)
w0 = 0.5*pi;        % center frequency 
M  = 10;           
L  = 2*M + 1;

n = -M:M;          

%% LOW-PASS 
hLP = zeros(1,L);
for x = 1:L
    if n(x) == 0
        hLP(x) = wc/pi;                     % l'Hospital at n=0
    else
        hLP(x) = sin(wc*n(x)) / (pi*n(x));  % ideal low-pass
    end
end

%% HIGH-PASS 
hHP = zeros(1,L);
for x = 1:L
    if n(x) == 0
        hHP(x) = 1 - hLP(x);
    else
        hHP(x) = -hLP(x);
    end
end

%% BAND-PASS
hBP = zeros(1,L);
for x = 1:L
    hBP(x) = 2 * hLP(x) * cos(w0*n(x));
end

% BAND-REJECT 
hBR = zeros(1,L);
for x = 1:L
    if n(x) == 0
        hBR(x) = 1 - hBP(x);
    else
        hBR(x) = -hBP(x);
    end
end

% MANUAL DTFT 
w = linspace(-3*pi, 3*pi, 1001);

HLP = zeros(1,L);
HHP = zeros(1,L);
HBP = zeros(1,L);
HBR = zeros(1,L);

for iw = 1:length(w)
    sLP = 0; 
    sHP = 0; 
    sBP = 0; 
    sBR = 0;

    for k = 1:L
        sLP = sLP + hLP(k) * exp(-1j * w(iw) * n(k));
        sHP = sHP + hHP(k) * exp(-1j * w(iw) * n(k));
        sBP = sBP + hBP(k) * exp(-1j * w(iw) * n(k));
        sBR = sBR + hBR(k) * exp(-1j * w(iw) * n(k));
    end

    HLP(iw) = sLP;
    HHP(iw) = sHP;
    HBP(iw) = sBP;
    HBR(iw) = sBR;
end

%% PLOT ONLY MAGNITUDE 

% Low-pass
figure(1);
plot(w/(2*pi), abs(HLP), 'LineWidth', 1.2); grid on;
title('Low-pass Magnitude (manual DTFT)');

% High-pass
figure(2);
plot(w/(2*pi), abs(HHP), 'LineWidth', 1.2); grid on;
title('High-pass Magnitude (manual DTFT)');

% Band-pass
figure(3);
plot(w/(2*pi), abs(HBP), 'LineWidth', 1.2); grid on;
title('Band-pass Magnitude');

% Band-reject
figure(4);
plot(w/(2*pi), abs(HBR), 'LineWidth', 1.2); grid on;
title('Band-reject Magnitude');

