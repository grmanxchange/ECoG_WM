%This function plots a pretty box plot using gramm.
%Project: ECoG_WM
%Author: D.T.
%Date: 21 September 2020

function  plotPrettyBox(data, my_color, my_xLim, my_yLim, my_axes, my_labels, my_legend)

%% Default figure parameters
set(groot, 'DefaultFigureColor', 'w', ...
    'DefaultAxesLineWidth', 0.5, ...
    'DefaultAxesXColor', [.5, .5, .5], ...
    'DefaultAxesYColor', [.5, .5, .5], ...
    'DefaultAxesBox', 'off', ...
    'DefaultAxesTickLength', [.02, .025]);

set(groot, 'DefaultAxesTickDir', 'out');
set(groot, 'DefaultAxesTickDirMode', 'manual');

%% Current figure

%Determine x and y data
x = [size(data, 1) : 1 : size(data, 2)]; %corresponds to the number of bars plotted
y = data; %corresponds to the height of each bar

%Diminish x-axis spacing
x = x - 0.5;

g = gramm('x', x, 'y', y, 'color', x); %data to be plotted

%Plot
figure;
g.geom_bar('width', 0.9);

%Change colors
g.set_color_options('map', my_color);

%Set general text layout options
g.set_text_options('font', 'Arial', 'base_size', 10, 'label_scaling', 1.2);

%Set x and ylim
if ~isempty(my_xLim)
    g.axe_property('XLim', my_xLim, 'YLim', my_yLim);
else
    my_xLim = [0, max(x)+0.5];
    my_yLim = [0, max(data)+std(data)];
    g.axe_property('XLim', my_xLim, 'YLim', my_yLim);
end

%Name x and y axis
g.set_names('x', my_axes{1}, 'y', my_axes{2});

%Set x and y ticks as well as labels
g.axe_property('XTick', sort([my_xLim, x]), 'XTickLabels', my_labels, 'YTick', my_yLim, 'YTickLabels', {num2str(my_yLim(1)), num2str(round(my_yLim(2)))});

%Daw legend if needed
g.set_layout_options('legend', my_legend);

g.draw();

%Set edge color to the same color as the main bar (this needs to be done
%once having drawn the g object)
for bari = 1 : size(x, 2)
    set(g.results.geom_bar_handle(bari), 'EdgeColor', my_color(bari, :));
end
end