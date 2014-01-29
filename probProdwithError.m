function [ prod, error ] = probProdwithError( set, binNum )
% Calculate the product of individual probability with error

prod = zeros(1,binNum);
cnt = zeros(1, binNum);
maxerror = zeros(1, binNum);
minerror = ones(1, binNum);


for i = 1: length(set)
    if ( ~isempty( set(i).prob) )
        binN = sum( set(i).prob(:,2) );
        locN = size( set(i).prob, 1);
        t = 0;
        for j = 1 : locN
            t = t + set(i).prob(j, 5) * set(i).prob(j,6);
        end
        prod(binN) = prod(binN) + t;
        cnt(binN) = cnt(binN) + 1;
        if t > maxerror(binN)
            maxerror(binN) = t;
        else if t < minerror(binN)
                minerror(binN) = t;
            end
        end
    end
end

prod = prod ./ cnt;
error = [ prod - minerror; maxerror - prod ];

end

