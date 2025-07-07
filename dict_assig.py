#assignment on Dictionary about personal details without get()

personal_details={}
current_year=2025
name=input("Ënter your name: ")
year_of_birth=input("Ënter your year of birth: ")
edu=input("Enter your education: ")
voter_id=input("Ënter your voter id: ")
pin_code=input("Enter your pin code: ")
mobile_number=input("Enter your mobile number: ")
age=current_year-int(year_of_birth)

personal_details['names_n']=str(name)
personal_details['age_n']=int(age)
personal_details['edu_n']=str(edu)                     
personal_details['voter_id_n']=str(voter_id)
personal_details['pin_code_n']=int(pin_code)
personal_details['mobile_number_n']=str(mobile_number)

                
print("Hi ",personal_details['names_n'])
print("Below are your details, ")
print("Age: ",personal_details['age_n'])
print("Edu: ",personal_details['edu_n'])
print("Voter ID: ",personal_details['voter_id_n'])
print("Pin code: ",personal_details['pin_code_n'])
print("Mobile Number: ",personal_details['mobile_number_n'])
print("Thanks ")
        
        


            


