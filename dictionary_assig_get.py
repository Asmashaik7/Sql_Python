#assignment on Dictionary-about personal details
personal_details={}
address={}
current_year=2025
personal_details['name']=input("Ënter your name: ")
personal_details['year_of_birth']=int(input("Ënter your year of birth in YYYY format: "))
personal_details['edu']=input("Enter your education: ")
personal_details['voter_id']=input("Ënter your voter id: ")
personal_details['pin_code']=int(input("Enter your pin code: "))
personal_details['mobile_number']=input("Enter your mobile number include +91: ")
address['house_number']=input("Enter your house number: ")
address['street_name']=input("Enter your street name: ")
address['area_name']=input("Enter your area name: ")
address['mandal_name']=input("Enter your mandal name: ")
address['district_name']=input("Enter your district name: ")
address['state_name']=input("Enter your state name: ")

personal_details['name']=personal_details['name'].upper()
personal_details['edu']=personal_details['edu'].title()
address['street_name']=address['street_name'].capitalize()
address['area_name']=address['area_name'].capitalize()
address['mandal_name']=address['mandal_name'].title()
address['district_name']=address['district_name'].title()
address['state_name']=address['state_name'].upper()

personal_details['age']=current_year-(personal_details['year_of_birth'])

personal_details.get('name',"check the keyname properly")
personal_details.get('age',"check the keyname properly")
personal_details.get('edu',"check the keyname properly")
personal_details.get('voter_id',"check the keyname properly")
personal_details.get('pin_code',"check the keyname properly")
personal_details.get('mobile_number',"check keyname properly and include 91 infront of mobile number")                
address.get('house_numbers',"check the keyname properly")
address.get('street_name',"check the keyname properly")
address.get('area_name',"check the keyname properly")
address.get('mandal_name',"check the keyname properly")
address.get('district_name',"check the keyname properly")
address.get('state_name',"check the keyname properly")

personal_details['address']=address
print("Personal details : ",personal_details)
print("Hi ",personal_details['name'])
print("Below are your details, ")
print("Age: ",personal_details['age'])
print("Education: ",personal_details['edu'])
print("Voter ID: ",personal_details['voter_id'])
print("Pin code: ",personal_details['pin_code'])
print("Mobile Number: ",personal_details['mobile_number'])
print("Thanks ")


            

