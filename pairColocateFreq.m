function coloc_fre = pairColocateFreq( ua, ub, records ) 
% give a pair of user with ID (1-95) and the records set
% find their co-locating frequency



ra = records(records(:,1) == ua, :);
rb = records(records(:,1) == ub, :);

ia = 1;
ib = 1;
coloc = zeros(1,1);
c = 1;
while ia <= size(ra,1) && ib <= size(rb,1)
    if ra(ia,2) > rb(ib,2)
        ib = ib + 1;
        continue
    else if ra(ia,2) < rb(ib,2)
            ia = ia + 1;
            continue
        else if ra(ia,3) == rb(ib,3)
               coloc(c) = ra(ia,3);
               c = c + 1;
            end
            ia = ia + 1;
            ib = ib + 1;
        end
    end
end

coloc_fre = c - 1;
end
