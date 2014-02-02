%

% load data/realitymining.mat;

% hashTable = zeros(length(s), 1);
% for i = 1:length(s)
%     if ~ isempty(s(i).my_hashedNumber)
%         hashTable(i) = s(i).my_hashedNumber;
%     end
% end
   

clear acqu_a acqu_b

ua = 2;
ub = 6;
uaid = map94_106(ua);
ubid = map94_106(ub);

event_a = s(uaid).comm;
acqu_a = zeros(1,1);
c = 1;
for i = 1:length(event_a)
    tmp = event_a(i).hashNum;
    if ~ isnan(tmp)
        acqu_a(c) = tmp;
        c = c + 1;
    end
end

sum(acqu_a == s(ubid).my_hashedNumber)


event_b = s(ubid).comm;
acqu_b = zeros(1,1);
c = 1;
for i = 1:length(event_b)
    tmp = event_b(i).hashNum;
    if ~ isnan(tmp)
        acqu_b(c) = tmp;
        c = c + 1;
    end
end

sum(acqu_b == s(uaid).my_hashedNumber)