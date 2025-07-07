# create 2 lists n append all d first names to one list and last names to another list
sci_names=['albert einstein','sri ramanujan','nikola tesla','abdul kalam','jj thomson']
f_name,l_name=[],[]
for every in sci_names:
    fn=every.split()[0]
    ln=every.split()[1]
    f_name.append(fn)
    l_name.append(ln)
print('first names:',f_name)
print('last names:',l_name)
