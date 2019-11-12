function [f] = db2lin(db)
    f = 10^(db/10);
end