function profiles = profiles(pcodes)
profiles = {};
    for f = 1:size(pcodes,1)
        code = pcodes(f,:);
        zeropos = find(ismember(code,'0'));
        nzeros = numel(zeropos);
        switch nzeros
            case 3
                perf = '1';
            case 2
                if zeropos == [2 3]
                    if code(4) == '1'
                        perf = ['0' upper(code(1))];
                    elseif isletter(code(4))
                        perf = [code(4) upper(code(1))];
                    end
                elseif zeropos == [3 4]
                    if code(2) == '1'
                        perf = [upper(code(1)) '0'];
                    elseif isletter(code(2))
                        perf = [code(1) code(2)];
                    end
                end
            case 1
                if zeropos == 2
                    if code(3:4) == ['11']
                        perf = ['00' upper(code(1))];
                    elseif code(4) == '1'
                        perf = [(code(3)) '0' upper(code(1))];
                    elseif code(3) == '1'
                        perf = ['0' (code(4)) upper(code(1))];
                    elseif code(2) == '1'
                        perf = ['0' code(4) upper(code(1))];
                    elseif code(1) == '1'
                    perf = [code(3) code(4) upper(code(1))];
                    end
                elseif zeropos == 3
                    if code([2 4]) == ['11']
                        perf = ['0' upper(code(1)) '0'];
                    elseif code(4) == '1'
                        perf = ['0' upper(code(1)) code(2)];
                    elseif code(2) == '1'
                        perf = [code(4) upper(code(1)) '0'];
                    elseif code(1) == '1'
                        perf = [code(4) upper(code(1)) code(2)];
                    end
                elseif zeropos == 4
                    if code(2:3) == ['11']
                        perf = [upper(code(1)) '00'];
                    elseif code(2) == '1'
                        perf = [upper(code(1)) '0' (code(3))];
                    elseif code(3) == '1'
                        perf = ['1' code(2) '0'];
                    elseif code(2) == '1'
                        perf = ['10' code(3)];
                    elseif code(1) == '1'
                        perf = [code(1) code(2) code(3)];
                    end
                end
        end
        profiles{f} = perf;
    end
    profiles = profiles';
end