%% Modeling and Analysis of Single Layer Multi-band U-Slot Patch Antenna
% The standard rectangular microstrip patch is a narrowband antenna and
% provides 6-8 dBi Gain with linear polarization. This example based on the
% work done in [1],[2], models a broadband patch antenna using a slot in the
% radiator and develops a dual-band and a tri-band variation from it. In
% the process, the single wide response has been split into multiple narrow
% band regions catering to specific bands in the WiMAX standard. These
% patch antennas have been probe-fed. 

%   Copyright 2017 The MathWorks, Inc.

%% Building the Single U-Slot Patch 
% _Define Parameters_ 
% The basic U-slot patch antenna consists of a rectangular patch radiator
% within which a U-shaped slot has been cut out. As discussed in [1], the
% patch itself is on an air substrate and thick so as to enable higher
% bandwidths to be achieved. The presence of the slot structure achieves
% additional capacitance within the structure which combines with the
% inductance of the long probe feed to create a double resonance within
% the band. The geometry parameters based on [2] are defined and shown in a
% drawing below.

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
%%
% <<../SingleUSlot.PNG>>

%%
% _Define radiator shape - Single U-slot_ 
%
% Use the rectangle shape primitives in Antenna Toolbox(TM) to create the
% U-slot patch radiator shape. Boolean subtraction operation is used among
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
Uslot_patch = p + s - h1 - h2 + h3;
% figure
% show(Uslot_patch)
%%
% _Define ground shape_
%
% Create the ground plane shape for the antenna. The groundplane in this
% case is rectangular and 71 mm x 52 mm in size.

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
slotPatch.Layers = {Uslot_patch,d1,p2};
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

%% Dual-band U-Slot Patch Antenna
% _Define Parameters_ 
%
% To achieve dual-band behavior as shown in [1], [2], the double resonance
% is modified such that the two contributing resonances, i.e. from the patch
% and from the slot do not merge. To do so the existing slot parameters are
% adjusted and a second slot is introduced into the structure. The
% parameters for the double U-slot are listed below as per [2] and a figure
% annotated with the variables used is shown.

%%
% 
% <<../DoubleUSlot.PNG>>
% 
%

%% 
% _Create Double U-slot radiator_
%
% As before use the shape primitives, to create the geometry by using
% Boolean operations.
% 


%% 
% _Modify Layers in Stack_
%
% Modify the existing stack by introducing the new radiator in the Layers
% property.



%% 
% _Mesh and Plot Reflection Coefficient_
%
% Mesh the structure at the highest frequency of operation and calculate
% the reflection coefficient.

%% Triple-Band U-slot Patch Antenna Parameters
% For triple-band operation a third U-slot is introduced and the existing
% slot parameters are adjusted. The parameters are shown below based on
% [2].

%%
% 
% <<../TripleUSlot.png>>
% 
%
%% 
% _Create Triple U-slot radiator_
%
%% 
% _Modify Layers in Stack_
%

%% 
% _Mesh and Plot Reflection Coefficient_
%


%%

% %% Conclusion
% % The models of the multi-band single layer U-slot patch antenna as
% % discussed in [1], and [2] have been built and analyzed and agree well
% % with results reported.
% 
% %% Reference
% %
% % [1] K. F. Lee, S. L. S. Yang and A. Kishk, "The versatile U-slot patch
% % antenna," 2009 3rd European Conference on Antennas and Propagation,
% % Berlin, 2009, pp. 3312-3314.
% %
% % [2] W. C. Mok, S. H. Wong, K. M. Luk and K. F. Lee, "Single-Layer
% % Single-Patch Dual-Band and Triple-Band Patch Antennas," in IEEE
% % Transactions on Antennas and Propagation, vol. 61, no. 8, pp. 4341-4344,
% % Aug. 2013.