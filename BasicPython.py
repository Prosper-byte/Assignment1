print ("Hello World")

print ("   /|")
print ("  / |")
print (" /  |")
print ("/___|")

##variables and data
character_name = "John"
character_age = "60"
Is_male = True
print("my name is " + character_name + ",")

character_name = "Luke"
character_age = "30"
print ("and I am " + character_age + ".")
print("But " + character_name + " does not like being " + character_age)

print("Giraffe\nAcademy")
print("Giraffe\"s Academy")
print("Giraffe\Academy")

phrase = "Giraffe Academy"
print(phrase + " is cool")
print(phrase.lower())
print(phrase.upper())
print(phrase.islower())
print(phrase.upper().isupper())
print(len(phrase))
print(phrase[0])
print(phrase.index("G"))
print(phrase.index("e"))
print(phrase.replace("Academy","& Elephant"))

###Working with numbers
from math import *
my_num = -5
print(floor(3.7))
print(ceil(3.7))
print(sqrt(81))

##get input from users
#name = input("Enter your name: ")
#age = input("Enter your age: ")
#print("Hello " + name + "! You are " + age + " years old")


##building a very basic calculator
'''
num1 = input("Enter a number: ")
num2 = input("Enter another number: ")
result = float(num1) + float(num2)
print(result)

##mad Libs Game

color = input("Enter a color: ")
plural_noun = input("Enter a plural noun: ")
celebrity = input("Enter a celebrity: ")

print("Roses are " + color)
print(plural_noun + " are blue")
print("I love " + celebrity)
'''
''''
## list
friends = ["Kevin", "Karen", "Jim", "Oscar", "Toby"]
friends[1] = "Mike"
print(friends[-1])
print(friends[1:])

lucky_numbers = [4,8,15,16,23,42]
friends = ["Kevin", "Karen", "Jim", "Oscar", "Toby"]

#friends.extend(lucky_numbers)
#friends.append("Creed")
#friends.insert(1,"Kelly")
friends.remove("Jim")
print(friends.index("Toby"))
print(friends)
friends2 = friends.copy()
print(friends2)

#Tuples
coordinates =(4,5)
print(coordinates[1])

#function
def say_hi(name, age):
    print("Hello " + name + ', you are ' + age + "!")
say_hi("Mike", "25")
say_hi("Prosper", "39")

def say_hi2(name, age):
    print("Hello " + name + ', you are ' + str(age))
say_hi2("Mike", 25)
say_hi2("Prosper", 39)

#####Return statement
def cube(num):
    return num * num * num

result = cube(4)
print(result)

####If statement
is_male = False
is_tall = True

if is_male or is_tall:
    print("You are a male or tall or both")
else:
    print("you are neither male nor tall")

if is_male and is_tall:
    print("You are a tall male")
else:
    print("you are either not male or not tall or not both")

if is_male and is_tall:
    print("You are a tall male")
elif is_male and not(is_tall):
    print("You are a short male")
elif not(is_male) and is_tall:
    print("You are not a male but are tall")
else:
    print("you are not a male and you are not tall")

##comparison operators and If statements
def max_num(num1, num2, num3):
    if num1 >= num2 and num1>= num3:
        return num1
    elif num2 >= num3 and num2>= num1:
        return num2
    else:
        return num3

print(max_num(600,600,500))
'''
####building a better calculator
num1 = float(input("Enter first number: "))
op = input("Enter operator: ")
num2 = float(input("Enter second number: "))

if op == "+":
    print(num1 + num2)
elif op == "-":
    print(num1 - num2)
elif op == "/":
    print(num1 / num2)
elif op == "*":
    print(num1 * num2)
else:
    print("Invalid operator")








