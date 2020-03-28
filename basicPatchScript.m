
%% Antenna Properties 
% Design antenna at frequency 5000000000Hz
antennaObject = design(patchMicrostripInsetfed,5000000000);
% Properties changed 
antennaObject.Length = 0.0192;
antennaObject.Width = 0.0237;
antennaObject.Height = 0.001588;
antennaObject.PatchCenterOffset = [-0.003 0];
antennaObject.FeedOffset = [-0.02 0];
antennaObject.GroundPlaneLength = 0.0415;
antennaObject.GroundPlaneWidth = 0.0332;
% Update substrate properties 
antennaObject.Substrate.Name = 'duroid5880';
antennaObject.Substrate.EpsilonR = 2.2;
antennaObject.Substrate.LossTangent = 0;
antennaObject.Substrate.Thickness = 0.001588;

%% Antenna Analysis 
% Define plot frequency 
plotFrequency = 5000000000;
% Define frequency range 
freqRange = (4500:50:5500) * 1e6;
% show for patchMicrostripInsetfed
figure;
show(antennaObject) 
% pattern for patchMicrostripInsetfed
figure;
pattern(antennaObject, plotFrequency) 
% elevation for patchMicrostripInsetfed
figure;
patternElevation(antennaObject, plotFrequency) 
% impedance for patchMicrostripInsetfed
figure;
impedance(antennaObject, freqRange) 
% s11 for patchMicrostripInsetfed
figure;
s = sparameters(antennaObject, freqRange); 
rfplot(s) 
% azimuth for patchMicrostripInsetfed
figure;
patternAzimuth(antennaObject, plotFrequency) 
% current for patchMicrostripInsetfed
figure;
current(antennaObject, plotFrequency) 

