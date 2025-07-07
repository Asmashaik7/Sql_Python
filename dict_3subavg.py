#dict -avg of 3 subs
#collect marks n store them in a dict
#find avg of 3 subs
marks={}
calc={}

maths=input("ënter math marks: ")
science=input("ënter science marks: ")
social=input("ënter social marks: ")

marks["maths"]= maths
marks['science']= science
marks['social'] = social

marks["maths_n"]= int(maths)
marks['science_n']= int(science)
marks['social_n'] = int(social)

calc['total']=int(maths)+int(science)+int(social)
calc['avg']=(int(maths)+int(science)+int(social))/3

marks['calculations']=calc

print("marks  :",marks, "\n\n","calculations :",marks.get('calculations'))


