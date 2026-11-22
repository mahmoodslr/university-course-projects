filename = 'Project.xlsx';
[num1, txt1, raw1] = xlsread(filename, 'TrafficLight');
[num2, txt2, raw2] = xlsread(filename, 'Time');

for i = 1:size(num1, 1)
    lights(i).name = raw1{i+1, 1};
    lights(i).x = num1(i, 1);
    lights(i).y = num1(i, 2);
    lights(i).greenDuration = num2(i, 1);
    lights(i).redDuration = num2(i, 2);
end

target = 2;
time = 0;
dt = 0.1; 
carX = lights(1).x;
carY = lights(1).y;
waiting = false;
moveStart = 0;

figure;

while true
    cla;
    hold on;
    for i = 1:size(num1, 1)-1
        plot([lights(i).x, lights(i+1).x], [lights(i).y, lights(i+1).y], 'k');
    end
    for i = 1:size(num1, 1)
        state = lightstate(time, lights(i).greenDuration, lights(i).redDuration);
        if state == 1
            plot(lights(i).x, lights(i).y, 'go', 'MarkerSize', 14, 'MarkerFaceColor', 'g');
        else
            plot(lights(i).x, lights(i).y, 'ro', 'MarkerSize', 14, 'MarkerFaceColor', 'r');
        end
    end

    if target > size(num1, 1)
        plot(carX, carY, 'bo', 'MarkerSize', 12, 'MarkerFaceColor', 'b');
        title(['Time: ', num2str(time, '%.3f'), ' - Finished']);
        pause(dt);
        break;
    end

    x1 = lights(target-1).x;
    y1 = lights(target-1).y;
    x2 = lights(target).x;
    y2 = lights(target).y;
    distance = distancecalc(x1, y1, x2, y2);

    if waiting == false
        travelTime = time - moveStart;
        if travelTime < distance
            percent = travelTime / distance;
            carX = x1 + percent * (x2 - x1);
            carY = y1 + percent * (y2 - y1);
            title(['Time: ', num2str(time, '%.3f'), ' - Moving from ', lights(target-1).name, ' to ', lights(target).name]);
        else
            carX = x2;
            carY = y2;
            state = lightstate(time, lights(target).greenDuration, lights(target).redDuration);
            if state == 0
                waiting = true;
                cycleTime = lights(target).greenDuration + lights(target).redDuration;
                remainTime = cycleTime - mod(time, cycleTime);
                title(['Time: ', num2str(time, '%.3f'), ' - Waiting at ', lights(target).name, ' (Red light ', num2str(remainTime, '%.2f'), 's remaining)']);
            else
                target = target + 1;
                moveStart = time;
            end
        end

    else

        state = lightstate(time, lights(target).greenDuration, lights(target).redDuration);
        cycleTime = lights(target).greenDuration + lights(target).redDuration;
        remainTime = cycleTime - mod(time, cycleTime);
        if state == 1
            waiting = false;
            target = target + 1;
            moveStart = time;
        else
            title(['Time: ', num2str(time, '%.3f'), ' - Waiting at ', lights(target).name, ' (Red light ', num2str(remainTime, '%.2f'), 's remaining)']);
        end

    end

    plot(carX, carY, 'bo', 'MarkerSize', 12, 'MarkerFaceColor', 'b');
    time = time + dt;
    pause(dt);
end