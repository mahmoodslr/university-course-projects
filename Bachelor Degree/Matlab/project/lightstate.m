function state = lightstate(t,green,red)

cycle = green + red;

if mod(t,cycle) < green
    state = 1;
else
    state = 0;  
end


end