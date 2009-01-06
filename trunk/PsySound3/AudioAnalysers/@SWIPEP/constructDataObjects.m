function obj = constructDataObjects(obj, dataBuffer, timePoints)
%  CONSTRUCTDATAOBJECTS Constructs the appropriate data objects
%
% Analogous to assignoutputs
%
% Get the p data
p = dataBuffer.p.get();

% Get the s data
s = dataBuffer.s.get();

% Get the t data
t = dataBuffer.t.get();

oDataRate = get(obj,'outputDataRate');

% format for TimeSeries
tsPitch = createDataObject('tSeries',p,t);
tsPitch.Name = 'SWIPEP Pitch';
tsPitch.DataInfo.Unit = 'Hz';
tsPitch.TimeInfo.Increment= 1/oDataRate;
output{1} = tsPitch;

tsPitchStrength = createDataObject('tSeries',s,t);
tsPitchStrength.Name = 'SWIPEP Pitch Strength';
tsPitchStrength.TimeInfo.Increment= 1/oDataRate;
output{2} = tsPitchStrength;

%Assign outputs to the obect
obj = set(obj, 'output', output);

% end constructDataObjects
