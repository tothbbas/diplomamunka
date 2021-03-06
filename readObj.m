function [V,F] = readObj(filename)
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
    data(cellfun('isempty',data)) = [];
    if ~isempty(data)
       type = char(data(1));
    else
       type = 'nothing'; 
    end
    switch type
        case 'v' % vertex
            V = [V; [str2double(data(2)),str2double(data(3)),str2double(data(4))]];
        case 'f' % face
            F = [F; [str2double(data(2)),str2double(data(3)),str2double(data(4))]];   
    end
end % loop
end

