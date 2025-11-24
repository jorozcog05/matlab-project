function convolution_gui2()
    % Create figure
    fig = uifigure('Name', 'Graphical Convolution Demo', ...
                 'NumberTitle', 'off', ...
                 'Position', [100, 100, 800, 650]);  % Increased figure height

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                        MAIN WINDOW PANEL
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    main_panel = uipanel(fig,'Position', [1, 1, 800, 650]);
    convolution_panel = uipanel(fig,'Position', [1, 1, 800, 650],Visible='off');
    statistics_panel = uipanel(fig,'Position', [1, 1, 800, 650],Visible='off');


    % Button to go to convolution
    uicontrol(main_panel,'Style', 'pushbutton', 'Position', [320 600 150 30], ...
        'String', 'General Graphical Convolution', ...
        'Callback', @(src,event) convolution_button_callback(main_panel,convolution_panel));
    
    % Button to go to statistics
    uicontrol(main_panel,'Style', 'pushbutton', 'Position', [320 500 150 30], ...
        'String', 'Probability and Statistics', ...
        'Callback', @(src,event) statistics_button_callback(main_panel,statistics_panel));

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                        CONVOLUTION PANEL
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
    % Dropdown menus for input and impulse response selection (Moved higher)
    uicontrol(convolution_panel,'Style', 'text', 'Position', [120 630 120 20], ...
        'String', 'Input Signal');
   
    uicontrol(convolution_panel,'Style', 'text', 'Position', [500 630 140 20], ...
        'String', 'Impulse Response');
    
     samplitude_label = uicontrol(convolution_panel,'Style', 'text', 'Position', [100 586 140 20], ...
        'String', 'Amplitude');
     sduration_label = uicontrol(convolution_panel,'Style', 'text', 'Position', [100 571 140 20], ...
        'String', 'Duration');
     sstart_time_label = uicontrol(convolution_panel,'Style', 'text', 'Position', [100 556 140 20], ...
        'String', 'Start time');
     send_time_label = uicontrol(convolution_panel,'Style', 'text', 'Position', [100 541 140 20], ...
        'String', 'End Time');
     stime_step_label = uicontrol(convolution_panel,'Style', 'text', 'Position', [100 526 140 20], ...
        'String', 'Time Step');

     ramplitude_label = uicontrol(convolution_panel,'Style', 'text', 'Position', [450 586 140 20], ...
        'String', 'Amplitude');
     rduration_label = uicontrol(convolution_panel,'Style', 'text', 'Position', [450 571 140 20], ...
        'String', 'Duration');
     rstart_time_label = uicontrol(convolution_panel,'Style', 'text', 'Position', [450 556 140 20], ...
        'String', 'Start time');
     rend_time_label = uicontrol(convolution_panel,'Style', 'text', 'Position', [450 541 140 20], ...
        'String', 'End Time');
     rtime_step_label = uicontrol(convolution_panel,'Style', 'text', 'Position', [450 526 140 20], ...
        'String', 'Time Step');


     samplitude = uieditfield(convolution_panel,"numeric",'Position', [200 590 100 15], "Limits",[0 100]);
     sduration = uieditfield(convolution_panel,"numeric",'Position', [200 574 100 15], "Limits",[0 100]);
     sstart_time = uieditfield(convolution_panel,"numeric",'Position', [200 559 100 15], "Limits",[0 100]);
     send_time = uieditfield(convolution_panel,"numeric",'Position', [200 544 100 15], "Limits",[0 100]);
     stime_step = uieditfield(convolution_panel,"numeric",'Position', [200 529 100 15], "Limits",[0 100]);

     ramplitude = uieditfield(convolution_panel,"numeric",'Position', [550 590 100 15], "Limits",[0 100]);
     rduration = uieditfield(convolution_panel,"numeric",'Position', [550 574 100 15], "Limits",[0 100]);
     rstart_time = uieditfield(convolution_panel,"numeric",'Position', [550 559 100 15], "Limits",[0 100]);
     rend_time = uieditfield(convolution_panel,"numeric",'Position', [550 544 100 15], "Limits",[0 100]);
     rtime_step = uieditfield(convolution_panel,"numeric",'Position', [550 529 100 15], "Limits",[0 100]);

     inputMenu = uicontrol(convolution_panel,'Style', 'popupmenu', ...
        'Position', [120 600 180 30], ...
        'String', {'Rectangular Pulse', 'Triangular Pulse', ...
        'Exponential Decay', 'Sine Wave', 'Unit Step','Ramp','Custom'}, ...
        'Callback', @(src,event) signal_selection(src,event,samplitude_label,sduration_label,sduration,'x(t) = '));

     impulseMenu = uicontrol(convolution_panel,'Style', 'popupmenu', ...
        'Position', [500 600 180 30], ...
        'String', {'Rectangular Pulse', 'Triangular Pulse', ...
        'Exponential Decay', 'Sine Wave', 'Unit Step','Ramp','Custom'}, ...
        'Callback', @(src,event) signal_selection(src,event,ramplitude_label,rduration_label,rduration,'h(t) = '));
    

    % Button to compute and visualize convolution (Moved higher)
    uicontrol(convolution_panel,'Style', 'pushbutton', 'Position', [320 600 150 30], ...
        'String', 'Run Convolution', ...
        'Callback', @(src,event) runConvolution(fig, inputMenu, impulseMenu));

    % Button to go back to main menu
    uicontrol(convolution_panel,'Style', 'pushbutton', 'Position', [100 15 150 20], ...
        'String', 'Exit', ...
        'Callback', @(src,event) exit_button_callback(main_panel,convolution_panel));

    % Axes for plotting
    ax1 = axes(convolution_panel,'Position', [0.1 0.52 0.35 0.25]); 
    title(ax1, 'Input Signal'); xlabel(ax1, 'Time'); ylabel(ax1, 'Amplitude');
    grid(ax1, 'on');

    ax2 = axes(convolution_panel,'Position', [0.55 0.52 0.35 0.25]); 
    title(ax2, 'Impulse Response'); xlabel(ax2, 'Time'); ylabel(ax2, 'Amplitude');
    grid(ax2, 'on');

    ax3 = axes(convolution_panel,'Position', [0.1 0.10 0.8 0.35]); 
    title(ax3, 'Graphical Convolution Animation'); xlabel(ax3, 'Time'); ...
        ylabel(ax3, 'Amplitude');
    grid(ax3, 'on');

    % Store axes handles in the figure for later access
    setappdata(fig, 'ax1', ax1);
    setappdata(fig, 'ax2', ax2);
    setappdata(fig, 'ax3', ax3);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                           STATISTICS PANEL
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end

function signal_selection(src,event,amplitude_label,duration_label,duration,amplitude_label_value)
    inputIdx = get(src, 'Value');
    if inputIdx == 7
        % Custom
        amplitude_label.String = amplitude_label_value;
        duration_label.Visible = "off";
        duration.Visible = "off";
    else
        amplitude_label.String = 'amplitude';
        duration_label.Visible = "on";
        duration.Visible = "on";
    end
end

function convolution_button_callback(main_panel,convolution_panel)
    main_panel.Visible = "off";
    convolution_panel.Visible = "on";
end

function statistics_button_callback(main_panel,statistics_panel)
    main_panel.Visible = "off";
    statistics_panel.Visible = "on";
end

function exit_button_callback(main_panel,convolution_panel)
    main_panel.Visible = "on";
    convolution_panel.Visible = "off";
end


function runConvolution(fig, inputMenu, impulseMenu)
    % Time vector
    dt = 0.02;  
    t = -5:dt:5; 
    
    % Get user selections
    inputIdx = get(inputMenu, 'Value');
    impulseIdx = get(impulseMenu, 'Value');
    
    % Generate selected signals
    x = getFunction(inputIdx, t);
    h = getFunction(impulseIdx, t);
    
    % Compute convolution
    conv_result = conv(x, h, 'same') * dt; 
    t_conv = linspace(2*min(t), 2*max(t), length(conv_result));

    % Retrieve stored axes handles from figure
    ax1 = getappdata(fig, 'ax1');
    ax2 = getappdata(fig, 'ax2');
    ax3 = getappdata(fig, 'ax3');

    % Plot input and impulse response
    cla(ax1); % Clear previous plots
    plot(ax1, t, x, 'b', 'LineWidth', 2);
    title(ax1, 'Input Signal'); grid(ax1, 'on');
    ylim(ax1, [-0.5, 2.5]);

    cla(ax2);
    plot(ax2, t, h, 'r', 'LineWidth', 2);
    title(ax2, 'Impulse Response'); grid(ax2, 'on');
    ylim(ax2, [-0.5, 2.5]);

    % Animation - Graphical Convolution
    cla(ax3);
    hold(ax3, 'on');
    conv_values = zeros(size(t));
    for i = 1:length(t)
        tau = t(i);
        
        % Flipped and shifted impulse response
        %flipped_h = getFunction(impulseIdx, t - tau);
        flipped_h = getFunction(impulseIdx, -t + tau);

        % Compute convolution at this shift
        conv_values(i) = sum(x .* flipped_h) * dt;

        % Clear and replot animation
        cla(ax3);
        plot(ax3, t, x, 'b', 'LineWidth', 2);
        plot(ax3, t, flipped_h, 'r--', 'LineWidth', 2);
        plot(ax3, t(1:i), conv_values(1:i), 'g', 'LineWidth', 2);
        title(ax3, 'Graphical Convolution Animation');
        legend(ax3, 'Input Signal', 'Flipped & Shifted Impulse', 'Convolution Result');
        ylim(ax3, [-0.5, 2.5]);
        grid(ax3, 'on');
        pause(0.01);
    end
end

function y = getFunction(index, t)
    % Function selector based on dropdown index
    switch index
        case 1 % Rectangular Pulse
            y = (t >= -1 & t <= 1);
        case 2 % Triangular Pulse
            y = (1 - abs(t)) .* (abs(t) <= 1);
        case 3 % Exponential Decay
            y = exp(-abs(t)) .* (t >= 0);
        case 4 % Sine Wave
            y = sin(2 * pi * 0.5 * t) .* (abs(t) <= 2);
        case 5 % Unit Step Function
            y = (t >= 0);  % Heaviside step function
        case 6 % Ramp function
            y = t.*(t>=0); % Ramp Function
        case 7 % Custom 
    end
end