# Implementation of rainwater capturing problem using two pointers
# pseudocode:
# while left_pointer < right_pointer
#  if the height at left_pointer <= the height at right_pointer
#     - update the left_bound to be the greater value between the current left_bound and the height at left_pointer
#     - increment total_water to be the difference between left_bound and the height at left_pointer
#     - move left_pointer forward by one
#  else
#     - update the right_bound to be the greater value between the current right_bound and the height at right_pointer
#     - increment total_water to be the difference between right_bound and the height at right_pointer
#    - move right_pointer back by one 
#
# return total_water

def efficient_solution(heights):
    total_water = 0
    left_pointer = 0
    right_pointer = len(heights) - 1
    left_bound = 0
    right_bound = 0

    # Write your code here
    while left_pointer < right_pointer:
        if heights[left_pointer] <= heights[right_pointer]:
            left_bound = max(heights[left_pointer], left_bound)
            total_water += left_bound - heights[left_pointer]
            left_pointer += 1
        else:
            right_bound = max(heights[right_pointer], right_bound)
            total_water += right_bound - heights[right_pointer]
            right_pointer -= 1
    
    return total_water


test_array = [4, 2, 1, 3, 0, 1, 2]
print(efficient_solution(test_array))
# Print 6
