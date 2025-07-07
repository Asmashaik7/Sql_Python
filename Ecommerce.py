#Ecommerce Assignment
#iphone=350, ipod=200, no shipping-national customer,
#iphone=350, ipod=200, shipping charges=500 and customs duty=1000-international cust
#data part

iphone_cost=350
ipod_cost=200
Shipping=500
customs_duty=1000
bill=0

name=str(input("Enter customer name: "))
age=int(input("Enter age: "))
email=str(input("Enter email: "))
passid=str(input("Enter passport number: "))
num_iphone=int(input("How many iphones do you want: "))
num_ipod=int(input("How many ipods do you want: "))

#Logic
country=(passid[0:2])
#country='IN34546576'[0:2]

if country=='IN':
    bill=(num_iphone*iphone_cost)+(num_ipod*ipod_cost)
    print("Your bill is ",bill)
elif country=='US'or 'UK':
    bill=(num_iphone*iphone_cost)+(num_ipod*ipod_cost)+Shipping+customs_duty
    print("Your bill is ",bill,"including shipping and customs duty")
#elif country=='UK':
   # bill=(num_iphone*iphone_cost)+(num_ipod*ipod_cost)+Shipping+customs_duty
    #print("Your bill is ",bill,"including shipping and customs duty")

