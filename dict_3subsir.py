marks = {}
calcu={}
maths = input("Enter math marks :")
science = input("Enter Science Marks :")
social = input("Enter social marks :")

# collected values
marks["maths"]= maths
marks['science']= science
marks['social'] = social
# modified values
marks["maths_n"]= int(maths)
marks['science_n']= int(science)
marks['social_n'] = int(social)

# calculations
calcu['total'] =  int(maths) + int(science) + int(social)
calcu['average'] = (int(maths) + int(science) + int(social))/3

marks['calculations'] = calcu
print("marks  :",marks, "\n\n","calculations :",(marks.get('calculations')))
