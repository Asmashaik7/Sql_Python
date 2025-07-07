Python 3.13.3 (tags/v3.13.3:6280bb5, Apr  8 2025, 14:47:33) [MSC v.1943 64 bit (AMD64)] on win32
Enter "help" below or click "Help" above for more information.
veg
Traceback (most recent call last):
  File "<pyshell#0>", line 1, in <module>
    veg
NameError: name 'veg' is not defined
veg=['brinjal','okra','bottle guard','kothmir']
veg
['brinjal', 'okra', 'bottle guard', 'kothmir']
for each_item in veg:
    print(each_item)
    print(veg)

brinjal
['brinjal', 'okra', 'bottle guard', 'kothmir']
okra
['brinjal', 'okra', 'bottle guard', 'kothmir']
bottle guard
['brinjal', 'okra', 'bottle guard', 'kothmir']
kothmir
['brinjal', 'okra', 'bottle guard', 'kothmir']
for each_item in veg:
    print(each_item)

brinjal
okra
bottle guard
kothmir
fam_names=['jaffer','asma','ayman','zoya']
fam_names
['jaffer', 'asma', 'ayman', 'zoya']
fam_names[2]
'ayman'
#change into uppercase
fam_names.upper()
Traceback (most recent call last):
  File "<pyshell#13>", line 1, in <module>
    fam_names.upper()
AttributeError: 'list' object has no attribute 'upper'
fam_names[0].upper()
'JAFFER'
for each_item in fam_names:
    print(fam_names.upper())

Traceback (most recent call last):
  File "<pyshell#17>", line 2, in <module>
    print(fam_names.upper())
AttributeError: 'list' object has no attribute 'upper'
for each_item in fam_names:
    print(fam_names[].upper())
    
SyntaxError: invalid syntax. Perhaps you forgot a comma?

for each_item in fam_names:
    print(each_item.upper())

    
JAFFER
ASMA
AYMAN
ZOYA
for each in fam_names:
    x=each.upper()
    print(x)

JAFFER
ASMA
AYMAN
ZOYA
>>> for each in fam_names:
...     print(each.islower())
... 
...     
True
True
True
True
>>> for each in fam_names:
...     x=each.upper()
...     print(x.islower())
... 
...     
False
False
False
False
>>> for each in fam_names:
...     x=each.upper()
...     print(x)
...     print(x.islower())
... 
JAFFER
False
ASMA
False
AYMAN
False
ZOYA
False
>>> for each in fam_names
SyntaxError: expected ':'
>>> for each in fam_names:
...     len(each)
... 
6
4
5
4


for each in fam_names:
    print(each.upper() ,each.lower() ,each.capitalize())

JAFFER jaffer Jaffer
ASMA asma Asma
AYMAN ayman Ayman
ZOYA zoya Zoya
number=[12,14,24,56,76,78]
number
[12, 14, 24, 56, 76, 78]
for each in number:
    number[0]+100
    print(each)

112
12
112
14
112
24
112
56
112
76
112
78
for each in number:
    number+100
    print(each)

Traceback (most recent call last):
  File "<pyshell#50>", line 2, in <module>
    number+100
TypeError: can only concatenate list (not "int") to list
for each in number:
    each+100
    print(each)

112
12
114
14
124
24
156
56
176
76
178
78
for each in number:
    print(each+100)

112
114
124
156
176
178
