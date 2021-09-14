function [fitresult, gof] = createFit1(performance)
%CREATEFIT1(PERFORMANCE)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      Y Output: performance
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  另请参阅 FIT, CFIT, SFIT.

%  由 MATLAB 于 06-Jun-2021 20:00:27 自动生成


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( [], performance );

% Set up fittype and options.
ft = fittype( 'sin1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf 0 -Inf];
opts.StartPoint = [0.682089080188959 0.0698131700797732 -0.400585120877505];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, xData, yData );
legend( h, 'performance', 'untitled fit 1', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
ylabel( 'performance', 'Interpreter', 'none' );
grid on


