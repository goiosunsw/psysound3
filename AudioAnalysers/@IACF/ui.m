function ui(obj, parent)
% Sets up the ui for the IACF Analyser. 
% usage: ui(IACF, parent)
% 
% We rely on picking up the Tag of the uicontrol objects later, so we only
% set them up, we don't return handles to each of them. We can get the handles 
% again in the settings method with handle = findobj('Tag','YourTagHere');
% 
% Make sure the tags you use are unique. The easiest way to do this is to
% use the name of the analyser in the tag at the start, as is done below. 

objName = get(obj, 'Name');

% A popup menu, with some text above it.       
textString = textwrap({'Choose window time step (s):'}, 40);
uicontrol('Style', 'text', ...
          'FontSize', 9, ...
          'String', textString,...
          'Parent', parent, ...
          'Units', 'Characters', ...
          'Position', [1 17 46 2],...
          'HorizontalAlignment', 'left', ...
          'BackgroundColor', [0.9 0.9 0.9]);

tStr = '0.05|0.1|0.2|0.5|1|2|5';
htStep = uicontrol('Style', 'popup', ...
                   'String', tStr, ...
                   'Parent', parent, ...
                   'Tag', [class(obj), 'TimeStep'], ...
                   'Units', 'Characters',...
                   'Value', 2, ...
                   'Position', [1 15 10 2], ...
                   'Callback', @popupChk, ...
                   'BackgroundColor',[0.9 0.9 0.9]);

% Integration time text
textString = textwrap({'Choose Integration time (s):'},40);
uicontrol('Style', 'text', ...
          'FontSize', 9, ...
          'String', textString,...
          'Parent', parent, ...
          'Units', 'Characters', ...
          'Position',[1 12 46 2],...
          'HorizontalAlignment','left', ...
          'BackgroundColor',[0.9 0.9 0.9]);

IntTimeStr = '0.5|1|2|4|8|16|32';

hIntTime = uicontrol('Style',  'popup', ...
                     'String', IntTimeStr, ...
                     'Parent', parent, ...
                     'Units', 'Characters',...
                     'Value', 2, ...
                     'Position', [1 10 10 2], ...
                     'Tag', [class(obj), 'IntTime'], ...
                     'Callback', @popupChk, ...
                     'BackgroundColor',[0.9 0.9 0.9]);

  % Nested function for consistency checking of the popup controls
  function popupChk(src, ev)
  
    tStep   = str2double(popupstr(htStep));
    intTime = str2double(popupstr(hIntTime));
    
    if intTime <= tStep
      errordlg(['Window time step must be smaller than the Integration ' ...
                'time.  Please fix before running this Analyser']);
    end
  end % popupChk

end

% Position is [distanceFromLeft distanceFromBottom width height] 
% Units = Characters gives a certain amount of stability, although it may
% cause some problems on some platforms.

