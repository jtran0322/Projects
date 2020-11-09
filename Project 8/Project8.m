% Project 8
% Johnny Tran
% CS 109, Koehler, Fall 2020

%script
figure
analyze_it("low income");
figure
analyze_it("black or african american");
figure
analyze_it("asian");
figure
analyze_it("white");
figure
analyze_it("hispanic");

function [corrcoef1, corrcoef2] = analyze_it(opt)
load('CookCountyFoodInsecurity.mat'); % load in code
pR = (povertyRate/100); % percent of population in each district below the poverty line
noCar = (withoutCars./population); % percent of population in each district who do not have access to a vehicle

    if (opt == "low income")
        pop = (lowIncomeFoodDesert./population); % percent of population in each district who live >0.5 miles away from a supermarket
        label = {'% population in district who are low income'; 'and live >0.5 miles away from a supermarket'}; % y-axis label
        group = {'Low Income'}; % group label
    elseif (opt == "black or african american")
        pop = (blackFoodDesert./population); % percent of population in each district who live >0.5 miles away from a supermarket
        label = '% population in district who are black or african american and live >0.5 miles away from a supermarket'; % y-axis label
        group = {'black or african american'}; % group label
    elseif (opt == "white")
        pop = (whiteFoodDesert./population); % percent of population in each district who live >0.5 miles away from a supermarket
        label = '% population in district who are white and live >0.5 miles away from a supermarket'; % y-axis label
        group = {'white'}; % group label
    elseif (opt == "asian")
        pop = (asianFoodDesert./population); % percent of population in each district who live >0.5 miles away from a supermarket
        label = '% population in district who are asian and live >0.5 miles away from a supermarket'; % y-axis label
        group = {'asian'}; % group label 
    elseif (opt == "hispanic")
        pop = (hispanicFoodDesert./population); % percent of population in each district who live >0.5 miles away from a supermarket
        label = '% population in district who are hispanic and live >0.5 miles away from a supermarket'; % y-axis label
        group = {'hispanic'}; % group label
    end
    
corrcoef1 = corrcoef_mine(pR, pop); %correlation coefficient for first subplot 
corrcoef2 = corrcoef_mine(pop, noCar); %correlation coefficient for second subplot 
    
subplot(2,1,1); % first subplot
plot(pR,pop,'b.'); % plot
xlabel('% population in district below poverty line'); % x axis label
ylabel(label); % y axis label
title(["Correlation Coefficient = " + corrcoef1; group]); % title

subplot(2,1,2); % second subplot 
plot(pop,noCar,'b.'); % plot
xlabel(label); % x axis label
ylabel({'% population in district who do not'; 'have access to a car'}); % y axis label
title(["Correlation Coefficient = " + corrcoef2; group]); % title
end

function [corr_coef_xy] = corrcoef_mine(x, y)
n = numel(x); % Number of elements in array x
N  = (1 / (n - 1));

%Mean formula
sumX = 0;
sumY = 0;
for (i = 1:n)
    sumX = sumX + x(i);
    sumY = sumY + y(i);
end
meanX = sumX ./ n; %mean of X array
meanY = sumY ./ n; %mean od y array

%Standard Deviation formula 
sumX2 = 0;
sumY2 = 0;
for (i = 1:n)
    sumX2 = sumX2 + (x(i) - meanX)^2;
    sumY2 = sumY2 + (y(i) - meanY)^2;
end
stdX = sqrt(N * sumX2); %standard deviation for x array
stdY = sqrt(N * sumY2); %standard deviation for y array

%Variance formula 
varX = stdX^2; %x variance
varY = stdY^2; % y variance

%Covariance formula
sumXY = 0;
for (i = 1:n)
   sumXY = sumXY + ((x(i) - meanX) * (y(i) - meanY)); 
end
covarXY = (N * sumXY); %covariance of x/y

%Correlation Coefficient Formula
corrcoXY = (covarXY / sqrt(varX * varY));
corr_coef_xy = corrcoXY; %Correlation coefficient viarable for x/y
end



