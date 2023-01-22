## step
1. make requirement
`python make_seq/make_requirement_seq.py`
2. make sequence file from requirement
`python make_seq/read_requirement`
3. make input, top and conf file
4. run oxDNA

### template
ignore pil files

template l1
```
# structure
number_of_types = [2-6]
s0 = a b @initial 1.0 M
s1 = a b* @initial 1.0 M
s2 = a* a @initial 1.0 M
s3 = a* b @initial 1.0 M
s4 = a* b* @initial 1.0 M
s5 = ...

# length
length a = 10
length b = 10

# sequence of domains
domain a = "GTTACTTGGA"
domain b = "GCAAAAAACC"
```
template l2
```
# structure
number_of_types = [3-6]
s0 = a a* b b @initial 1.0 M
s1 = a b* b* b* @initial 1.0 M
s2 = a* a b b @initial 1.0 M

# length
length a = 5
length b = 5

# sequence of domains
domain a = "CCCTT"
domain b = "GAGTC"
```
template l3
```
# structure
number_of_types = [3-6]
s0 = f c* f @initial 1.0 M
s1 = b* c f* @initial 1.0 M
s2 = f* b d* @initial 1.0 M

# length
length a = 17
length b = 17
length c = 17
length d = 15
length e = 17
length f = 17

# sequence of domains
domain a = "GTTCCAGCACCTTCACT"
domain b = "TCAGCCGGTGGACTGAG"
domain c = "GGCAACGTCCTGTTACT"
domain d = "GAACCCGGGAAAGAC"
domain e = "TTGAAGAGTAGAGCACA"
domain f = "CCTAGAGAGGCGCACAT"
```