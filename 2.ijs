load 'plot'
load 'trig'
load 'numeric'
load '~addons/graphics/fvj4/dwin.ijs'

num_passed=: #@I.
num_failed=: # - #@I.
test_result=: ('√'"_) ; num_passed ; ('x'"_) ; num_failed

NB. Exercise 1
NB. (a)
f1a=: [: % +&3
NB. (b)
f1b=: [: +&3 %
NB. (c)
f1c=: [: +/ *:
NB. (d)
f1d=: [: *: +/
NB. (e)
f1e=: [: ^ [: - *:
NB. (f)
f1f=: [: *: [: ^ -
NB. (g)
f1g=: ^@-
NB. (h)
f1h=: -&^

NB. Exercise 2
f2a=: ^@%
NB. (a) monadic f(x) = e^(1/x)
NB.     dyadic  f(x, y) = e^(x/y)
f2b=: ^&%
NB. (b) monadic f(x) = e^(1/x)
NB.     dyadic  f(x, y) = (1/x)^(1/y)
f2c=: (*/)@:(-&1)
NB. (c) monadic applied on list: each element -1 then multiply all
NB. test
'test_2a_monadic' ; test_result (f2a = (3 : '^%y')) i.1000
'test_2a_dyadic' ; test_result (i.1000) (f2a = (4 : '^ x % y')) i._1000
'test_2b_monadic' ; test_result (f2b = (3 : '^%y')) i.1000
'test_2b_dyadic' ; test_result (i.1000) (f2b = (4 : '(%x)^(%y)')) i._1000
'test_2c' ; test_result (f2c = (3 : '*/ y-1')) i.1000 1000
