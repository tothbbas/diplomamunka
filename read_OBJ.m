function [V,F] = read_OBJ(filename)
%   read_OBJ : .obj kiterjesztesu fileok beolvasasa
%   filename : .obj kiterjesztesu file
%   V : csucsok (vertices)
%   F : lapok (faces)
V = [];
F = [];
file = fopen(filename,'r');
while true
    line = fgetl(file);
    if line == -1
        break;
    end
    data = split(line,' ');
    type = char(data(1));
    switch type
        case 'v' % vertex
            V = [V; [str2double(data(2)),str2double(data(3)),str2double(data(4))]];
        case 'f' % face
            F = [F; [str2double(data(2)),str2double(data(3)),str2double(data(4))]];   
    end
end % loop
end

