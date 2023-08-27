# In this demonstration, the average of three lists is calculated using four 
# different approaches:

# - sequential approach
# - async approach
# - threading approach
# - multiprocessing approach
# The goal is to make this calculation as efficient 
# as possible and see which approaches work well and which ones struggle.


import time
import threading
import asyncio
from multiprocessing import Process

# Function to calculate the average of a list of numbers
def cal_average(num):
  sum_num = 0
  for t in num:
    sum_num = sum_num + t
  avg = sum_num / len(num)
  time.sleep(1)  # Simulating some computation time
  return avg

# Sequential execution
def main_sequential(list1, list2, list3):
  s = time.perf_counter()
  # Calculate averages sequentially
  cal_average(list1)
  cal_average(list2)
  cal_average(list3)
  elapsed = time.perf_counter() - s
  print("Sequential Programming Elapsed Time: " + str(elapsed) + " seconds")

# Asynchronous average calculation
async def cal_average_async(num):
  sum_num = 0
  for t in num:
    sum_num = sum_num + t
  avg = sum_num / len(num)
  await asyncio.sleep(1)  # Introducing an asynchronous delay
  return avg

# Asynchronous execution
async def main_async(list1, list2, list3):
  s = time.perf_counter()
  tasks = [cal_average_async(list1), cal_average_async(list2), cal_average_async(list3)]
  await asyncio.gather(*tasks)
  elapsed = time.perf_counter() - s
  print("Asynchronous Programming Elapsed Time: " + str(elapsed) + " seconds")

# Threading execution
def main_threading(list1, list2, list3):
  s = time.perf_counter()
  lists = [list1, list2, list3]
  threads = []
  for i in range(len(lists)):
    x = threading.Thread(target=cal_average, args=(lists[i],))
    threads.append(x)
    x.start()
  for t in threads:
    t.join()
  elapsed = time.perf_counter() - s
  print("Threading Elapsed Time: " + str(elapsed) + " seconds")

# Multiprocessing execution
def main_multiprocessing(list1, list2, list3):
  s = time.perf_counter()
  lists = [list1, list2, list3]
  processes = [Process(target=cal_average, args=(lists[x],)) for x in range(len(lists))]
  for p in processes:
    p.start()
  for p in processes:
    p.join()
  elapsed = time.perf_counter() - s
  print("Multiprocessing Elapsed Time: " + str(elapsed) + " seconds")

# Entry point
if __name__ == '__main__':
  l1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  l2 = [2, 4, 6, 8, 10]
  l3 = [1, 3, 5, 7, 9, 11]
  main_sequential(l1, l2, l3)
  loop = asyncio.get_event_loop()
  loop.run_until_complete(main_async(l1, l2, l3))
  main_threading(l1, l2, l3)
  main_multiprocessing(l1, l2, l3)


############# Results #############

# $ python3 script.py 
# Sequential Programming Elapsed Time: 3.002864601992769 seconds
# Asynchronous Programming Elapsed Time: 1.0012806809972972 seconds
# Threading Elapsed Time: 1.0015618040051777 seconds
# Multiprocessing Elapsed Time: 1.0052746580040548 seconds

###################################
