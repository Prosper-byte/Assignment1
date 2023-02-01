###Dictionaries
monthConversions = {
    1: "January",
    'Feb': 'February',
    'Mar': 'March',
    'Apr': 'April',
    'May': 'May',
    'Jun': 'June',
    'Jul': 'July',
    'Aug': 'August',
    'Sep': 'September',
    'Oct': 'October',
    'Nov': 'November',
    'Dec': 'December',
}

print(monthConversions['Jun'])
print(monthConversions.get(1, 'Not a valid key'))

##While Loop
i = 1
while i <= 10:
    print(i)
    i += 1
print ("Done with loop")
'''''
##guessing game
secret_word = "giraffe"
guess = ""
guess_count = 0
guess_limit = 3
out_of_guesses = False
while guess != secret_word and not(out_of_guesses):
    if guess_count < guess_limit:
        guess = input("Enter guess: ")
        guess_count +=1
    else:
        out_of_guesses = True
if out_of_guesses:
    print("out of guesses, you lose!")
else:
    print ("You win")
'''
'''''
##for loop
friends = ["Jim", "Karen", "Kevin"]
for friend in friends:
    print(friend)
 '''''
'''''
for i in range(10):
    print(i)
'''

'''''
for i in range(3, 10):
    print(i)
'''
'''
friends = ["Jim", "Karen", "Kevin"]
for index in range (len(friends)):
    print(friends[index])

for index in range (5):
    if index == 0:
        print("first iteration of the loop")
    else:
        print("not first")
'''

##exponential function
'''
def raise_to_power(base_num, pow_num):
    result = 1
    for index in range(pow_num):
        result = result * base_num
    return result

print(raise_to_power(2,3))
'''
'''
##2D lists and nested loops
number_grid = [
     [1,2,3],
     [4,5,6],
     [7,8,9],
     [0]
 ]
print(number_grid[0][0])
print(number_grid[2][0])

for row in number_grid:
    for col in row:
        print(col)

friends = ["Jim", "Karen", "Kevin"]
for name in friends:
    for letter in name:
        print (letter)
'''
'''
##Build a translator: any vowels become a g
def translate(phrase):
    translation = ""
    for letter in phrase:
        if letter in "AEIOUaeiou":
            translation = translation + "g"
        else:
            translation = translation + letter
    return translation

print(translate(input("Enter a phrase: ")))

def translate(phrase):
    translation = ""
    for letter in phrase:
        if letter.lower() in "aeiou":
            if letter.isupper():
                translation = translation + "G"
            else:
                translation = translation + "g"
        else:
            translation = translation + letter
    return translation

print(translate(input("Enter a phrase: ")))
'''
'''
try:
    value = 10/0
    number = int(input("Enter a number: "))
    print(number)
except ZeroDivisionError as err:
    print("err")
except ValueError:
    print("Invalid Input")
#writing files
employee_file = open("employees.txt", "w")
employee_file.write("Kelly - Human resources")
employee_file.close()
'''
#classes and object
