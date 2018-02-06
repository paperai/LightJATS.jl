module StringMatch

export lcsmatch

include("sais.jl")
include("suffixarray.jl")

isvalid(i::Int, j::Int, k::Int, l::Int) = i > 0 && i <= j && k > 0 && k <= l

function lcsmatch(seq1::Vector{Int}, seq2::Vector{Int})
    pairs = Tuple{Int,Int}[]
    buffer = [(1,length(seq1),1,length(seq2),true)]
    while !isempty(buffer)
        i,j,k,l,lmost = pop!(buffer)
        ii,jj,kk,ll = lcsubstring(seq1[i:j],seq2[k:l],lmost)
        isvalid(ii,jj,kk,ll) || continue
        ii += i - 1
        jj += i - 1
        kk += k - 1
        ll += k - 1
        append!(pairs, zip(ii:jj,kk:ll))

        left = i, ii-1, k, kk-1
        right = jj+1, j, ll+1, l
        isvalid(left...) && push!(buffer,(left...,false))
        isvalid(right...) && push!(buffer,(right...,true))
    end
    sort!(pairs)
end

function lcsubstring(seq1::Vector{Int}, seq2::Vector{Int}, leftmost::Bool)
    n1 = length(seq1)
    seq = copy(seq1)
    maxi = max(maximum(seq1), maximum(seq2))
    push!(seq, maxi+1)
    append!(seq, seq2)
    sa = SuffixArray(seq)
    lcparray = sa.lcparray
    maxlcp = 0
    for i = 2:length(lcparray)
        (sa[i-1] <= n1) == (sa[i] <= n1) && continue
        lcp = lcparray[i]
        lcp > maxlcp && (maxlcp = lcp)
    end
    maxlcp == 0 && return (0,0,0,0)

    bestp1, bestp2 = 0, 0
    for i = 1:length(lcparray)
        lcp = lcparray[i]
        lcp == maxlcp || continue
        i < length(lcparray) && lcparray[i+1] == maxlcp && continue

        s = findprev(x -> x != maxlcp, lcparray, i)
        posits = map(j -> sa[j], s:i)
        all(p -> (p <= n1) == (posits[1] <= n1), posits) && continue

        p1 = minimum(posits)
        p2 = minimum(filter(p -> p > n1, posits)) - (n1 + 1)
        if bestp1+bestp2 == 0
            (bestp1,bestp2) = (p1,p2)
        elseif leftmost && p1+p2 < bestp1+bestp2
            (bestp1,bestp2) = (p1,p2)
        elseif !leftmost && p1+p2 > bestp1+bestp2
            (bestp1,bestp2) = (p1,p2)
        end
    end
    (bestp1, bestp1+maxlcp-1, bestp2, bestp2+maxlcp-1)
end

end
