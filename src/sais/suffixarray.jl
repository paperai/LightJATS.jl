mutable struct SuffixArray
    data::Vector{Int}
    lcparray::Vector{Int}
end

Base.getindex(sa::SuffixArray, i::Int) = sa.data[i]

function SuffixArray(text::Vector{Int})
    sa = sais(text)
    lcparray = StringMatch.lcparray(sa, text)
    SuffixArray(sa, lcparray)
end

"""
    lcparray

Kasai's algorithm for linear-time construction of LCP array from Suffix Array
"""
function lcparray(sa::Vector{Int}, text::Vector{T}) where T<:Integer
    n = length(sa)
    lcps = similar(sa)
    rank = similar(sa)
    for i = 1:n
        rank[sa[i]] = i
    end

    lcp = 0
    for i = 1:n
        rank[i] > 1 || continue
        j = sa[rank[i]-1]
        while i+lcp <= n && j+lcp <= n && text[i+lcp] == text[j+lcp]
            lcp += 1
        end
        lcps[rank[i]] = lcp
        lcp > 0 && (lcp -= 1)
    end
    lcps[1] = 0
    lcps
end
