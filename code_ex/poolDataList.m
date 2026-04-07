function yout = poolDataList(yin, nVars, polyorder, usesine)
% Returns cell array of strings labelling each column of poolData output
% Copyright 2015, All Rights Reserved
% Code by Steven L. Brunton

ind = 1;
yout{ind} = '1';
ind = ind + 1;

for i = 1:nVars
    yout{ind} = yin{i};
    ind = ind + 1;
end

if polyorder >= 2
    for i = 1:nVars
        for j = i:nVars
            yout{ind} = [yin{i}, yin{j}];
            ind = ind + 1;
        end
    end
end

if polyorder >= 3
    for i = 1:nVars
        for j = i:nVars
            for k = j:nVars
                yout{ind} = [yin{i}, yin{j}, yin{k}];
                ind = ind + 1;
            end
        end
    end
end

if polyorder >= 4
    for i = 1:nVars
        for j = i:nVars
            for k = j:nVars
                for l = k:nVars
                    yout{ind} = [yin{i}, yin{j}, yin{k}, yin{l}];
                    ind = ind + 1;
                end
            end
        end
    end
end

if polyorder >= 5
    for i = 1:nVars
        for j = i:nVars
            for k = j:nVars
                for l = k:nVars
                    for m = l:nVars
                        yout{ind} = [yin{i}, yin{j}, yin{k}, yin{l}, yin{m}];
                        ind = ind + 1;
                    end
                end
            end
        end
    end
end

if usesine
    for k = 1:10
        for i = 1:nVars
            yout{ind} = ['sin(' num2str(k) yin{i} ')'];
            ind = ind + 1;
        end
        for i = 1:nVars
            yout{ind} = ['cos(' num2str(k) yin{i} ')'];
            ind = ind + 1;
        end
    end
end