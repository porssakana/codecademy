# creating parent class School
class School:

  def __init__(self, name=str, level=str, numberOfStudents=int):
    self.name = name
    self.level = level
    self.numberOfStudents = numberOfStudents

  def getName(self):
    return self.name 

  def getLevel(self):
    return self.level

  def getNumberOfStudents(self):
    return self.numberOfStudents
  
  def setNumberOfStudents(self, new_number):
    self.numberOfStudents = new_number

  def __repr__(self):
    return f"A {self.level} school named {self.name} with {self.numberOfStudents} students"


#creating PrimarySchool class with inheritance from School
class PrimarySchool(School):

  def __init__(self, name=str, numberOfStudents=int, pickupPolicy=str):
    super().__init__(name, "primary", numberOfStudents)
    self.pickupPolicy = pickupPolicy

  def getPickupPolicy(self):
    return self.pickupPolicy

  def __repr__(self):
    parentRepr = super().__repr__()
    return parentRepr + f", the pickup policy is: {self.pickupPolicy}"


# creating HighSchool class with inheritance from School
class HighSchool(School):
  
  def __init__(self, name=str, numberOfStudents=int, sportsTeams=list):
    super().__init__(name, "high", numberOfStudents)
    self.sportsTeams = sportsTeams

  def getSportsTeams(self):
    return self.sportsTeams

  def __repr__(self):
    parentRepr = super().__repr__()
    str1 = ', '.join(str(e) for e in self.sportsTeams)
    return parentRepr + f", the school has the following sports teams: {str1}"

# test cases
mySchool = School("Codecademy", "high", 100)
print(mySchool)
print(mySchool.getName())
print(mySchool.getLevel())
mySchool.setNumberOfStudents(200)
print(mySchool.getNumberOfStudents())

print('\n')

testSchool = PrimarySchool("Codecademy", 300, "Pickup Allowed")
print(testSchool.getPickupPolicy())
print(testSchool)

print('\n')

c = HighSchool("Codecademy High", 500, ["Tennis", "Basketball"])
print(c.getSportsTeams())
print(c)
  