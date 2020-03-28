

PL = 19.2e-3;
PW = 23.7e-3;
W2 = 19.5e-3;
SW = 2.6e-3;
sep = 2.3e-3;
TL = 11.15e-3;
d = 13.5e-3;
h = 1.588e-3;
insx = 1.38e-3;
insy = 7.25e-3;
tr = 3.5e-3;

% Use the rectangle shape primitives in Antenna Toolbox(TM). Boolean subtraction operation is used among
% the shape primitives for this purpose.
N1 = 2; %50;
N2 = 2; %10;
p = antenna.Rectangle('Length',PW,'Width',PL,'NumPoints',60);
s = antenna.Rectangle('Length',PW,'Width',SW,'NumPoints' ,[N1 N2 N1 N2],...
    'Center',[0,PL/2+sep]);
h1 = antenna.Rectangle('Length',insx,'Width',insy,'NumPoints',[N2 N1 N2 N1],...
    'Center',[-tr/2 - insx/2, -PW/2 + insy/2]);
h2 = antenna.Rectangle('Length',insx,'Width',insy,'NumPoints',[N2 N1 N2 N1],...
    'Center',[tr/2 + insx/2, -PW/2 + insy/2]);
h3 = antenna.Rectangle('Length',tr,'Width',TL,'NumPoints' ,[N1 N2 N1 N2],...
    'Center',[0,-PL/2 - TL/2]);
patch = p + s - h1 - h2 + h3;
 figure
 show(patch)

% _Define ground shape_
%
% Create the ground plane shape for the antenna. 

Wgp = 41.5e-3;
Lgp = 33.2e-3;
p2  = antenna.Rectangle('Length',Lgp,'Width',Wgp,'NumPoints',10);
% 
% %%
% % _Define stack_
% %
% % Use the pcbStack to define the metal and dielectric layers and the feed
% % for the single U-slot patch antenna. The layers are defined top-down. In
% % this case, the top-most layer is a metal layer defined by the U-slot
% % patch shape. The second layer is a dielectric material, air in this case,
% % and the third layer is the metal ground plane.
% 
d1 = dielectric('Name','Rogers RT5880(lossy)','EpsilonR',2.20,'LossTangent',0.0009);
slotPatch = pcbStack;
slotPatch.Name = 'U-Slot Patch';
slotPatch.BoardThickness = h;
slotPatch.BoardShape = p2;
slotPatch.Layers = {patch,d1,p2};
slotPatch.FeedLocations = [0 -20e-3 1 3];
slotPatch.FeedDiameter = 0.9e-3;
figure
show(slotPatch)
% 
% %% Calculate and Plot Reflection Coefficient
% Mesh the structure by using a maximum edge length which is one-tenth the
% wavelength at the highest frequency of operation which is 6 GHz for this
% example. Compute and plot the reflection coefficient for this antenna
% over the band. The reflection coefficient is plotted with a reference
% impedance of 50 ohms.
%
figure
mesh(slotPatch,'MaxEdgeLength',.01,'MinEdgeLength',.001,'GrowthRate',0.7)

%%
freq = linspace(3e9,6e9,200);
s1 = sparameters(slotPatch,freq);
s11Fig = figure;
rfplot(s1,1,1)
s11Ax = gca(s11Fig);
hold(s11Ax,'on');

%% Calculate and plot pattern
% Plot the radiation pattern for this antenna at the frequencies of best
% match in the band.
figure
pattern(slotPatch,3.9e9)

%%
figure
pattern(slotPatch,4.96e9)

