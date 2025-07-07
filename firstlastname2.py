# create 2 lists n append all d first names to one list and last names to another list
#type-2
sci_names=['albert einstein','sri ramanujan','nikola tesla','abdul kalam','jj thomson']
f_name,l_name=[],[]
for every in sci_names:
    f_name.append(every.split()[0])
    l_name.append(every.split()[1])
print('first names:',f_name)
print('last names:',l_name)
