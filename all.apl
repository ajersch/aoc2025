d1 ← {
    i1←({×0.5-'L'=⊃⍵}×{⍎1↓⍵})¨⊃⎕NGET⍵1
    i2←(×0.5-'L'=⊃¨i)⌿⍨(⍎1∘↓)¨i←⊃⎕NGET⍵1
    c ← {+⌿0=100|50++⍀⍵}
    (c i1), c i2
}

d2 ← {
    ⍝ vector of ranges
    i←⍎¨',-'{(~⍵∊⍺)⊆⍵}⊃⊃⎕NGET⍵1
    ⍝ vector containing every value in each range
    n←⊃,⌿({1-⍨⍺+⍳1+⍵-⍺}⌿⊢)⌺(⍪2 2)⊢i
    
    ⍝ sum of elements whose first half matches their second
    p1 ← +⌿n/⍨{s(↑≡↓)⍨⌈2÷⍨≢s←⍕⍵}¨n

    ⍝ invalid check for part 2
    v ← {
        ⍝ string representation of the input number
        s ← ⍕⍵
        ⍝ length of the string
        l ← ≢s
        ⍝ divisors of the length
        d ← (⍳l-1)/⍨0=(⍳l-1)|l
        ⍝ chunks a vector into pieces of size ⍺
        c ← {⍵⊂⍨¯1↓1,0=⍺|⍳≢⍵}
        ⍝ checks all elements of ⍵ match
        eq ← {⊃∧⌿⍵≡1⌽⍵}
        ⍝ all equal for at least one chunk size
        ∨⌿{eq ⍵ c s}¨d
    }
    ⍝ sum of elements that are invalid for part 2
    p2 ← +⌿n/⍨v¨n

    p1,p2
}

d3 ← {
    ⍝ rank 2 array of digits
    i←(⍎¨↑)¨⊃⎕NGET⍵1
    j ← {
        ⍝ base case take max digit
        ⍺=1:⌈⌿⍵
        ⍝ max digit with last ⍺ digits removed
        m ← ⌈⌿(⍺-1)↓⌽⍵
        ⍝ recursive call on digits after m
        m,(⍺-1)∇⍵↓⍨⊃⍸m=⍵
    }

    ⍝ decodes max digits in decimal
    p1 ← +⌿(10⊥2j⊢)¨i
    p2 ← +⌿(10⊥12j⊢)¨i
    p1,p2
}

d4 ← {
    ⍝ rank 2 array with 1s where @s are and 0s elsewhere
    i←↑'@'=⊃⎕NGET⍵1
    ⍝ one iteration of life
    a←{⍵∧~4<⍨({2 2 ⌷⍵-⍨+⌿+⌿⍵}⌺3 3)⍵}

    ⍝ one iteration of life
    p1 ← (+⌿+⌿i)-+⌿+⌿a i
    ⍝ fixed point of life
    p2 ← (+⌿+⌿i)-+⌿+⌿a⍣≡ i
    p1,p2
}

d5 ← {
    ⍝ ranges as rank 2 array
    r ← ⍎¨↑'-'(≠⊆⊢)¨⊃⎕NGET(1⊃⍵)1
    ⍝ indices
    i ← ⍎¨⊃⎕NGET(2⊃⍵)1

    ⍝ count of indices that appear within ranges
    p1 ← +⌿{∨⌿(⍵≤r[;2])∧⍵≥r[;1]}¨i

    ⍝ union of ranges
    u ← {
        ⍝ base case, no ranges left
        0=≢⍵:1+-⌿⌽⍺
        ⍝ ranges do not overlap: add magnitude of previous range
        (1 1⊃⍵)>2⊃⍺:((1⊃⍵)∇1↓⍵)+1+-⌿⌽⍺
        ⍝ ranges overlap: extend range
        (⍺⌈0,1 2⊃⍵)∇1↓⍵
    }

    ⍝ reduce rank of r to a vector of pairs
    r ← ↓r
    ⍝ sort ranges by lower bound, then take the union
    p2 ← (1∘⊃u⊢)r[⍋r]
    p1,p2
}

d6 ← {
    i←⊃⎕NGET⍵1
    ⍝ numbers for part 1
    n←↑⍎¨¯1↓i
    ⍝ operations
    o←⊃¯1↑i
    o←o⌿⍨~' '=o
    ⍝ reduce over each column with proper operation
    c←+⌿{⊃⍵='*':×⌿1↓⍵~0 ⋄ +⌿1↓⍵~0}⍤1
    p1←c⍉o⍪n

    ⍝ operations
    o←⊃¯1↑i
    ⍝ partition vertical numbers by operation
    n←(↓⍉↑¯1↓i)⊂⍨~' '=o
    ⍝ convert non-empty entries into numbers
    n←{⍎¨⍵⌿⍨~∧⌿¨' '=⍵}¨n
    ⍝ remove whitespace from operations
    o←o⌿⍨~' '=o
    ⍝ same computation as part 1
    p2←c o,↑n

    p1,p2
}

d7 ← {
    ⍝ remove empty lines and make input binary
    i←'S^'∊⍨{↑⍵/⍨2|⍳≢⍵}⊃⎕NGET'7.in'1
    ⍝ scan matrix multiplication of partial splits, take sign
    ⍝ find splits and + reduce
    p1←1++⌿2(+⌿⊣∧(~⊢))⌿×(i[1;]+.×⊢)¨+.×⍀{⍵(⌽∨(-⊣)⌽⊢)∘.=⍨⍳≢⍵}¨↓1↓i
    ⍝ matrix multiplication for spilts
    p2←+⌿↑({⍺(⊖∨(-⊣)⊖⊢)∘.=⍨⍳≢⍺}+.×⊢)⌿↓⊖i
    p1,p2
}




 d11←{
    ⍝ vector of node name, neighbours
    i←':'(≠⊆⊢)¨⊃⎕NGET⍵1

    ⍝ names of all the nodes
    n←⊃¨i
    n←n,⊂'out'

    ⍝ adjacency matrix
    a←↑↑{∨⌿{∨/⍵⍷↑n}¨' '(≠⊆⊢)2⊃⍵}¨i
    a←a⍪0

    ⍝ generates ⍵ powers of ⍺
    ⍝ needed since scan was too slow to generate all matrices
    p←{
        0=⍵:⍺
        m←⍺,⍨⊂a+.×⊃⍺
        m∇⍵-1
    }

    ⍝ powers of adjacency matrix give number of walks
    ⍝ sum of walks of length 1 to 100 gives number of paths
    w←↑+⌿(⊂a)p 100

    ⍝ indices of important nodes
    you←n⍳⊂'you'
    svr←n⍳⊂'svr'
    dac←n⍳⊂'dac'
    fft←n⍳⊂'fft'
    out←n⍳⊂'out'

    ⍝ paths from you→out
    p1←w[you;out]
    ⍝ paths from svr→fft times paths from fft→dac times paths from dac→out
    p2←w[svr;fft]×w[fft;dac]×w[dac;out]

    p1,p2
 }

d12 ← {
    ⍝ drop first 30 lines since shapes don't matter
    i←30↓⊃⎕NGET⍵1
    ⍝ 7 × total number of presents
    n←{7×+⌿⍎6↓⍵}¨i
    ⍝ area of each region
    s←×/↑{⍎¨'x'(≠⊆⊢)5↑⍵}¨i
    ⍝ sum of regions that fit all presents
    p1←+⌿s>n

    p1, 'no part 2'
}


run ← 'd1 ''1.in''' 'd2 ''2.in''' 'd3 ''3.in''' 'd4 ''4.in''' 'd5 ''5a.in'' ''5b.in'''
'cmpx' ⎕CY 'dfns'
cmpx run