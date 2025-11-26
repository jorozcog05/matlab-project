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
       

    uicontrol(convolution_panel,'Style', 'text', 'Position', [120 630 120 20], ...
        'String', 'Input Signal');
   
    uicontrol(convolution_panel,'Style', 'text', 'Position', [500 630 140 20], ...
        'String', 'Impulse Response');
    
     xamplitude_label = uicontrol(convolution_panel,'Style', 'text', 'Position', [100 586 140 20], ...
        'String', 'Amplitude');
     xduration_label = uicontrol(convolution_panel,'Style', 'text', 'Position', [100 571 140 20], ...
        'String', 'Duration');
     uicontrol(convolution_panel,'Style', 'text', 'Position', [100 556 140 20], ...
        'String', 'Start time');
     uicontrol(convolution_panel,'Style', 'text', 'Position', [100 541 140 20], ...
        'String', 'End Time');
     uicontrol(convolution_panel,'Style', 'text', 'Position', [100 526 140 20], ...
        'String', 'Time Step');

     hamplitude_label = uicontrol(convolution_panel,'Style', 'text', 'Position', [450 586 140 20], ...
        'String', 'Amplitude');
     hduration_label = uicontrol(convolution_panel,'Style', 'text', 'Position', [450 571 140 20], ...
        'String', 'Duration');

     xamplitude = uieditfield(convolution_panel,"numeric",'Position', [200 590 100 15], "Limits",[0 5],'Value',1);
     xcustom = uieditfield(convolution_panel,"text",'Position', [200 590 100 15], 'Visible', 'off');
     xduration = uieditfield(convolution_panel,"numeric",'Position', [200 574 100 15], "Limits",[0 5],'Value',2);
     start_time = uieditfield(convolution_panel,"numeric",'Position', [200 559 100 15], "Limits",[-20 0],'Value',-5);
     end_time = uieditfield(convolution_panel,"numeric",'Position', [200 544 100 15], "Limits",[0 20],'Value',5);
     time_step = uieditfield(convolution_panel,"numeric",'Position', [200 529 100 15], "Limits",[0.001 1],'Value',0.02);

     hamplitude = uieditfield(convolution_panel,"numeric",'Position', [550 590 100 15], "Limits",[0 5],'Value',1);
     hcustom = uieditfield(convolution_panel,"text",'Position', [550 590 100 15], 'Visible', 'off');
     hduration = uieditfield(convolution_panel,"numeric",'Position', [550 574 100 15], "Limits",[0 5],'Value',2);

    % Dropdown menus for input and impulse response selection (Moved higher)
     inputMenu = uicontrol(convolution_panel,'Style', 'popupmenu', ...
        'Position', [120 600 180 30], ...
        'String', {'Rectangular Pulse', 'Triangular Pulse', ...
        'Exponential Decay', 'Sine Wave', 'Unit Step','Ramp','Custom'}, ...
        'Callback', @(src,event) signal_selection(src,xamplitude_label,xduration_label,xamplitude,xcustom,xduration,'x(t) = '));

     impulseMenu = uicontrol(convolution_panel,'Style', 'popupmenu', ...
        'Position', [500 600 180 30], ...
        'String', {'Rectangular Pulse', 'Triangular Pulse', ...
        'Exponential Decay', 'Sine Wave', 'Unit Step','Ramp','Custom'}, ...
        'Callback', @(src,event) signal_selection(src,hamplitude_label,hduration_label,hamplitude,hcustom,hduration,'h(t) = '));
    

    % Button to compute and visualize convolution (Moved higher)
    uicontrol(convolution_panel,'Style', 'pushbutton', 'Position', [320 600 150 30], ...
        'String', 'Run Convolution', ...
        'Callback', @(src,event) runConvolution(fig, inputMenu, impulseMenu,xamplitude,xcustom, ...
            xduration,start_time,end_time,time_step,hamplitude,hcustom,hduration));

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

function signal_selection(src,amplitude_label,duration_label,amplitude,custom,duration,amplitude_label_value)
    inputIdx = get(src, 'Value');
    if inputIdx == 7
        % Custom
        amplitude_label.String = amplitude_label_value;
        amplitude.Visible = "off";
        custom.Visible = "on";
        duration_label.Visible = "off";
        duration.Visible = "off";
    else
        amplitude_label.String = 'amplitude';
        amplitude.Visible = "on";
        custom.Visible = "off";
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


function runConvolution(fig, inputMenu, impulseMenu,samplitude,scustom, ...
    sduration,sstart_time,send_time,stime_step,ramplitude,rcustom,rduration)
    % Time vector 
    
    start_t = get(sstart_time,'Value');
    end_t = get(send_time,'Value');
    dt = get(stime_step,'Value');
    t = start_t:dt:end_t;

    xamplitude = get(samplitude,'Value');
    xcustom = get(scustom,'Value');
    xduration = get(sduration,'Value');

    hamplitude = get(ramplitude,'Value');
    hcustom = get(rcustom,'Value');
    hduration = get(rduration,'Value');

    % Get user selections
    inputIdx = get(inputMenu, 'Value');
    impulseIdx = get(impulseMenu, 'Value');
    
    % Generate selected signals
    x = getFunction(inputIdx, t,xamplitude,xcustom,xduration);
    h = getFunction(impulseIdx, t,hamplitude,hcustom,hduration);

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
        flipped_h = getFunction(impulseIdx, -t + tau,hamplitude,hcustom,hduration);

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

function y = getFunction(index, tin,amplitude,custom,duration)
    % Function selector based on dropdown index
    switch index
        case 1 % Rectangular Pulse
            y = amplitude*(tin >= -duration/2 & tin <= duration/2);
        case 2 % Triangular Pulse
            y = amplitude*((1 - abs(tin)) .* (abs(tin) <= duration/2));
        case 3 % Exponential Decay
            y = amplitude*(exp(-abs(tin)) .* (tin >= 0));
        case 4 % Sine Wave
            y = amplitude*(sin(2 * pi * 0.5 * tin) .* (abs(tin) <= duration/2));
        case 5 % Unit Step Function
            y = amplitude*(tin >= 0);  % Heaviside step function
        case 6 % Ramp function
            y = tin.*(tin>=0); % Ramp Function
        case 7 % Custom
            custom = "@(t)" + custom;
            f = str2func(custom);
            y = [];
            for i = tin
                y = [y,f(i)];
            end
    end
end