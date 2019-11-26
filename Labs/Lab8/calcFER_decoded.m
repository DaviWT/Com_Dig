function [FER_novo] = calcFER_decoded(N,BER)
    BER_novo = BER;
    n_novo = N;
    t = 1;
    FER_novo = 0;
    for j = (t+1):n_novo
        FER_novo = FER_novo + nchoosek(n_novo,j)*(BER_novo)^j*(1-BER_novo)^(n_novo-j);
    end
end
