friends = ["Kevin", "Karen", "Jim", "Oscar", "Toby"]
friends2 = ["Creed", "Andy"]
print(friends)
print(friends[0])
print(friends[1:])
print(friends[1:3])
friends[1] = "Mike"
print(friends[1])
print(friends[-1])
print(friends[-2])
print(friends[1:])
print(friends[1:3])
friends.extend(friends2)
print(friends)
friends.append("Creed")
print(friends)

