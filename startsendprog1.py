#prog on startswith() and endswith()
#all the words starting with 's' should be in slist and all the words starting with 'a' should be in 'a' list
s=[] 
a=[]
others=[]
name=['s400','S440','Sri','apple','banana','Amoxyline','bcomplex','paracetamole','cat','dog','satin','Asma','sk']
for everyword in name:
    if everyword.lower().startswith("s"):
        s.append(everyword)
    elif everyword.lower().startswith("a"):
        a.append(everyword)
    else: others.append(everyword)

print("Words starts with s are ",s)
print("Words starts with a are ",a)
print("Words starts with other letters are ",others)








