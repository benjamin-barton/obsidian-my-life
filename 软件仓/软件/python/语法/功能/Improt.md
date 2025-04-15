Import 和 from import 区别就是前缀  
Import numpy  
就得numpy.array  
不过你可以 import numpy as np  
这样 np.array  
From numpy import *  
就不需要前缀，但这样导入的东西太多，可以指定  
From matplotlib import pyplot as plt  
因为pyplot是一个模块，他并不是一个小函数，所以用了简写，他是类似matlab的用法

![Exported image](Exported%20image%2020250404144803-0.png)

我自己也可以创建module，而且不需要放在同一个文件夹