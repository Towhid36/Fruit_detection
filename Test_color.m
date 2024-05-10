
% Get the user's image selection using a dialog box
[filename, pathname] = uigetfile({'*.jpg;*.png;*.bmp'}, 'Select a fruit image');

% Check if a file was selected
if ~isequal(filename, 0)
  % Combine path and filename for full path
  path = fullfile(pathname, filename);
  
  % Read the image
  I = imread(path);
end
% % Replace 'path/to/your/image.jpg' with the actual path to your image
% I = imread('');
HSV = rgb2hsv(I);

% Access Hue channel (first channel)
hue_channel = HSV(:,:,1);

% Access Saturation channel (second channel)
saturation_channel = HSV(:,:,2);

% You can further analyze these channels or calculate average Hue and Saturation:
avg_hue = mean2(hue_channel);
avg_saturation = mean2(saturation_channel);

fprintf('Average Hue: %f\n', avg_hue);
fprintf('Average Saturation: %f\n', avg_saturation);