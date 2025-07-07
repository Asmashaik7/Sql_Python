#assignment-Find the sum of all the even nos, odd nos, nos div by 3,nos div by 4,nos div by 5 and nos div by 10
#find number of values respesctively(count)
numbers=[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100]
even_sum = 0
even_count=0
odd_sum=0
odd_count=0
for everynum in numbers:
    if everynum%2==0:
        even_sum=even_sum+everynum
        even_count=even_count+1
    elif everynum!=0:
        odd_sum=odd_sum+everynum
        odd_count=odd_count+1   
print("Sum of even numbers from 1-100 :",even_sum)
print("Number of even numbers in 1-100 :",even_count)
print("Sum of odd numbers from 1-100 :",odd_sum)
print("Number of odd numbers in 1-100 :",odd_count)

three_sum=0
three_count=0
for everynum in numbers:
    if everynum%3==0:
        three_sum=three_sum+everynum
        three_count=three_count+1
print("Sum of numbers divisible by 3 from 1-100 :",three_sum)
print("Number of numbers divisible by 3 in 1-100 :",three_count)

four_sum=0
four_count=0
for everynum in numbers:
    if everynum%4==0:
        four_sum=four_sum+everynum
        four_count=four_count+1
print("Sum of numbers divisible by 4 from 1-100 :",four_sum)
print("Number of numbers divisible by 4 in 1-100 :",four_count)

five_sum=0
five_count=0
for everynum in numbers:
    if everynum%5==0:
        five_sum=five_sum+everynum
        five_count=five_count+1
print("Sum of numbers divisible by 5 from 1-100 :",five_sum)
print("Number of numbers divisible by 5 in 1-100 :",five_count)

ten_sum=0
ten_count=0
for everynum in numbers:
    if everynum%10==0:
        ten_sum=ten_sum+everynum
        ten_count=ten_count+1
print("Sum of numbers divisible by 10 from 1-100 :",ten_sum)
print("Number of numbers divisible by 10 in 1-100 :",ten_count)
