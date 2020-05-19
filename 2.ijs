load 'plot'
load 'trig'
load 'numeric'
load '~addons/graphics/fvj4/dwin.ijs'

NB. matrix multiplication
mp=: +/ . *

NB. Hénon map
henon=: 3 : '({:y) , 1 + (0.3*{.y) + _1.4* *: {:y'

NB. Koch snowflake
mid=: -:@+
tri1=: 2r3&*@[ + 1r3&*@]
tri2=: 1r3&*@[ + 2r3&*@]
nor=: _1 1 &*@|.
bulge=: mid + (%:%12)&*@nor@:-
segdiv=: [ , tri1 , bulge ,: tri2
refine=: ,/@([ segdiv"1 (1&|.))

NB. do simple unit tests
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

NB. Exercise 3
NB. I think the blips persist..
0 : 0
't nt'=: |: henon^:(i.1000) 0 0
'point; pensize 3' plot t;nt
)

NB. Exercise 4
0 : 0
plot +/\ _1+2*?.1000#2
)

NB. Exercise 5
NB. (a)
0 : 0
f5a=: 1: ` ] ` *: ` (^&3) ` (^&4) ` (^&5) ` (^&6) ` (^&7) ` (^&8) ` (^&9)
'pensize 3' plot (steps 0 1 1000) ; (f5a`:0) steps 0 1 1000
)
NB. (b)
f5b1=: 1:
f5b2=: 3 : '1 - (y^2)%!2'
f5b3=: 3 : '1 - ((y^2)%!2) + (y^4)%!4'
f5b4=: 3 : '1 - ((y^2)%!2) + ((y^4)%!4) - (y^6)%!6'
f5b=: f5b1`f5b2`f5b3`f5b4
0 : 0
'pensize 3' plot (steps _6 6 1000) ; (f5b`:0) steps _6 6 1000
)

NB. Exercise 6
NB. uncomment to plot
d6=: steps 0 2p1 1000
NB. (a) f6r=: cos@+:
NB. (b) f6r=: cos@*&3
NB. (c) f6r=: cos@*&17
NB. (d) f6r=: ]
NB. (e) f6r=: +&2 @ *&3 @ cos
NB. (f) f6r=: +&2 @ *&5 @ cos
NB. (g) f6r=: >:@cos
NB. (h) f6r=: *&3 @ cos @ -: @ *&3
NB. (i) f6r=: cos @ %&3 @ *&5
NB.
f6x=: f6r * cos
f6y=: f6r * sin
0 : 0
plot (f6x d6);f6y d6
)

NB. Exercise 7
NB. (a)
f7a=: *: + ^
NB. (b)
f7b=: sin + cos + 1:
NB. (c)
f7c=: ^@* + -@[ + +:@]
NB. (d)
f7d=: %:@+ % sin@+
NB. test
'test_7a' ; test_result (f7a = (3 : '(*:y)+^y')) i.1000
'test_7b' ; test_result (f7b = (3 : '(sin y)+(cos y)+1')) i.1000
'test_7c' ; test_result (i.1000) (f7c = (4 : '(^(x*y))+(-x)+2*y')) i._1000
'test_7d' ; test_result (i.1000) (f7d = (4 : '(%:(x+y))% sin x+y')) i._1000

NB. Exercise 8
NB. (a) f(x) = e^(x) + ln(x)
NB. (b) f(x) = max(0, x)
NB. (c) f(x) = sin(x) + cos(x) - x
NB. (d) f(x) = ln(x+1)
NB. test
f8a=: ^ + ^.
f8b=: 0: >. ]
f8c=: 1&o. + 2&o. + -
f8d=: [: ^. ] + 1:
'test_8a' ; test_result (f8a = (3 : '(^y)+^.y')) i.1000
'test_8b' ; test_result (f8b = (3 : '0 >. y')) i.1000
'test_8c' ; test_result (f8c = (3 : '(sin y)+(cos y)-y')) i.1000
'test_8d' ; test_result (f8d = (3 : '^.(y+1)')) i.1000

NB. Exercise 9
NB. (a) f(x, y) = x^y + log(x, y)
NB. (b) f(x, y) = max(x - y, x + y)
NB. (c) f(x, y) = x^(2 + y^2)
NB. (d) f(x, y) = x^2 + y^2
NB. test
f9a=: ^ + ^.
f9b=: - >. +
f9c=: [ ^ 2: + ] ^ 2:
f9d=: ([ ^ 2:) + ] ^ 2:
'test_9a' ; test_result (i.1000) (f9a = (4 : '(x^y) + x^.y')) i._1000
'test_9b' ; test_result (i.1000) (f9b = (4 : '(x-y) >. x+y')) i._1000
'test_9c' ; test_result (i.1000) (f9c = (4 : 'x^(2+y^2)')) i._1000
'test_9d' ; test_result (i.1000) (f9d = (4 : '(x^2)+y^2')) i._1000

NB. Exercise 10
NB. Adverb

NB. Exercise 11
NB. (a)
0 : 0
255 0 0 dpoly refine^:5 |: 2 1 o./ 1r2p1*i.4
)
NB. (b)
0 : 0
250 0 0 dpoly refine^:5 |: 2 1 o./ 2r5p1*i.5
)

NB. Exercise 12
NB. I refuse to draw that weird laughing face.

NB. Exercise 13
NB. the ratio controls 1) how much the bulging point would
NB. go beyond the original segment, and 2) the bulging direction.
ratio13=: 0.5
bulge13=: mid + ratio13&*@nor@:-
segdiv13=: [ , tri1 , bulge13 ,: tri2
refine13=: ,/@([ segdiv13"1 (1&|.))
0 : 0
255 0 0 dpoly refine13^:5 |: 2 1 o./ 2r3p1*i.3
)

NB. Exercise 14
NB. (a)
square14a=: |: 2 1 o./ 1r2p1*i.4
draw14a=: 4 : 'x dpoly (refine^:y) square14'
0 : 0
dclear ''
255 255 0 draw14a 4
0 255 0   draw14a 3
0 255 255 draw14a 2
0 0 255   draw14a 1
255 0 255 draw14a 0
)
NB. (b)
NB.ratio14b=: _0.2
bulge14b=: mid + (-@%:%12)&*@nor@:-
segdiv14b=: [ , tri1 , bulge14b ,: tri2
refine14b=: ,/@([ segdiv14b"1 (1&|.))

square14b=:1 1,_1 1,_1 _1,:1 _1
draw14b=: 4 : 'x dpoly (refine14b^:y) square14b'
0 : 0
dclear ''
255 0 255 draw14b 0
0 0 255   draw14b 1
0 255 255 draw14b 2
0 255 0   draw14b 3
255 255 0 draw14b 4
)

NB. Exercise 15
henon_tacit=: {:, 1 + (*&0.3@{.) + (*&_1.4@*:@{:)
NB. test on 1000 randomly generated pairs
'test henon tacit' ; test_result (henon"1 (*/"1@:=) henon_tacit"1) ? 1000 2 $ 100

NB. Exercise 16
fibo=: {: , {. + {:

NB. Exercise 17
tribo=: (_2&{.) , +/

NB. Exercise 18
NB. a0 (x, y) -> (x, 0.5y)
NB. a1 (x, y) -> (x, -y)
NB. a2 (x, y) -> (x, 0)
NB. a3 (x, y) -> (-y, x)
NB. a4 (x, y) -> (y, x)
NB. a5 (x, y) -> (x+0.5, y)
NB. a1 mp a3 (x, y) -> (y, x)
NB. a3 mp a1 (x, y) -> (-y, -x)
NB. a6 rotate 45 degrees counterclockwise
NB. a5 mp a6 move then rotate
NB. a6 mp a5 rotate then move

NB. Exercise 19
NB. (a)
t19a=: 2 0 0 , 0 1r3 0 ,: 0 0 1
NB. (b)
t19b=: 1 0 0 , 0 _1 0 ,: 0 0 1
NB. (c)
NB. rotate matrix
rot19=: (cos , -@sin , 0:) , (sin , cos , 0:) ,: (0: , 0: , 1:)
t19c=: rot19 1r3p1
NB. (d)
t19d=: 1 0 0 , 0 1 0 ,: 2 3 0
NB. (e)
t19e=: t19d mp t19c
NB. (f)
t19f=: t19c mp t19d
NB. test
0 : 0
lshape19=: (0 0,2 0,2 1,1 1,1 3,:0 3),.1
dclear ''
250 250 250 dpoly lshape19
200 200 200 dpoly lshape19 mp t19f
)

NB. Exercise 20
NB. not much related since matrix multiplication is not commutative.
NB. if we take t19d as m1 and t19c as m2, the two transformations
NB. (m1 mp m2) and (m2 mp m1) are not the same: in (m1 mp m2) the rotation affects the translation,
NB. while in (m2 mp m1) two transformations are reserved.