print("Giraffe\nAcademy")
print("Giraffe\"Academy")
print("Giraffe\\Academy")

phrase = "Giraffe Academy"
print(phrase)
print(phrase + " is cool")
print(phrase.lower())
print(phrase.upper())
print(phrase.isupper())
print(phrase.upper().isupper())
print(len(phrase))
print(phrase[0])
print(phrase.index("G"))
print(phrase.index("a"))
print(phrase.index("Acad")) #index of first letter in the string
print(phrase.replace("Giraffe", "Elephant")) #replaces first string with second string
print(phrase) #phrase is still the same because strings are immutable