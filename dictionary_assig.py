#assignment on Dictionary about personal details
personal_details={}
agecalc={}
current_year=2025

personal_details['name']=str(input("Ënter your name: "))
personal_details['year_of_birth']=int(input("Ënter your year of birth: "))
personal_details['edu']=str(input("Enter your education: "))
personal_details['voter_id']=str(input("Ënter your voter id: "))
personal_details['pin_code']=int(input("Enter your pin code: "))
personal_details['mobile_number']=str(input("Enter your mobile number: "))

agecalc['age']=current_year-(personal_details['year_of_birth'])

print("Personal details: ",personal_details,"\n\n")


print("Hi ",personal_details['name'])
print("Below are your details, ")
print("Age: ",agecalc['age'])
print("Edu: ",personal_details['edu'])
print("Voter ID: ",personal_details['voter_id'])
print("Pin code: ",personal_details['pin_code'])
print("Mobile Number: ",personal_details['mobile_number'])
print("Thanks ")


            

