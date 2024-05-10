% Fruit name 
fruits = {'Apple', 'Banana', 'Guava', 'Strawberry'};

% average Hue and Saturation values 
fruit_hues = [0.1497, 0.07481, 0.0658, 0.1243];
fruit_sats = [0.2824, 0.2878, 0.1803,  0.1631];

% User's image selection using a dialog box

[filename, pathname] = uigetfile({'*.jpg;*.png;*.bmp'}, 'Select a fruit image');

% Check for a file selected
if ~isequal(filename, 0)
  % Combined path and filename for full path
  path = fullfile(pathname, filename);
  I = imread(path);

  % Convert image to HSV color space
  HSV = rgb2hsv(I);

  % Extract average Hue and Saturation
  avg_hue = mean2(HSV(:,:,1));
  avg_sat = mean2(HSV(:,:,2));

  % Minimum distance calculation and fruit identification
  min_dist = inf;
  fruit_idx = -1;
  for i = 1:length(fruits)
    dist = sqrt((avg_hue - fruit_hues(i))^2 + (avg_sat - fruit_sats(i))^2);
    if dist < min_dist
      min_dist = dist;
      fruit_idx = i;
    end
  end

  % Determine identified fruit name
  if fruit_idx == -1
    frt_name = 'Unknown Fruit';
  else
    frt_name = fruits{fruit_idx};
  end
  
  % Display results
  figure;  % Create a new figure window
  subplot(2,2,1);
  imshow(I);
  title('Original Image');

  subplot(2,2,2);
  imshow(HSV);
  title('HSV Image');

  subplot(2,2,3, 'FontSize', 12);
  text(0.5, 0.5, sprintf('Identified Fruit: %s\nAverage Hue: %.4f\nAverage Saturation: %.4f', ...
                          frt_name, avg_hue, avg_sat), ...
       'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
  title('Analysis Results');

  
  subplot(2,2,4);
  imshow(I);
  if strcmp(frt_name, 'Unknown')
      text(size(I,2)/2, size(I,1)/2, 'Unknown Fruit', ...
          'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
          'FontSize', 16, 'Color', 'red');
  else
      text(size(I,2)/2, size(I,1)/2, frt_name, ...
          'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
          'FontSize', 16, 'Color', 'green');
  end
  title('Output ');
  sgtitle('Fruit detection using color analysis');
  
  fprintf('\nThe given fruit is: %s\n\n', frt_name);
else
  fprintf('No image selected.\n');
end
