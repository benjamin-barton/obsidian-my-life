
### **1. 路径操作**
#### **跨平台路径拼接**
```python
import os

# 智能拼接路径（自动适配Windows/Unix分隔符）
path = os.path.join("folder", "subfolder", "file.txt")  
# Windows → "folder\subfolder\file.txt"
# Linux → "folder/subfolder/file.txt"
```

#### **路径分解**
```python
dir_path, filename = os.path.split("/home/user/file.txt")  # ("/home/user", "file.txt")
base, ext = os.path.splitext("data.json")                # ("data", ".json")
```

#### **绝对路径与规范化**
```python
abs_path = os.path.abspath("file.txt")      # 获取绝对路径
norm_path = os.path.normpath("a/../b//c")   # 规范化路径 → "b/c"
```

---

### **2. 文件/目录管理**
#### **检查路径是否存在**
```python
os.path.exists("file.txt")       # 是否存在
os.path.isfile("file.txt")      # 是否是文件
os.path.isdir("folder")         # 是否是目录
```

#### **创建与删除**
```python
os.mkdir("new_folder")          # 创建单层目录
os.makedirs("a/b/c", exist_ok=True)  # 创建多层目录（exist_ok避免报错）
os.remove("file.txt")           # 删除文件
os.rmdir("empty_folder")        # 删除空目录
shutil.rmtree("folder")         # 删除非空目录（需import shutil）
```

#### **遍历目录**
```python
files = os.listdir(".")         # 列出当前目录所有条目
for root, dirs, files in os.walk("project"):  # 递归遍历
    print(f"目录: {root}, 文件: {files}")
```

---

### **3. 文件属性**
```python
size = os.path.getsize("file.txt")          # 文件大小（字节）
mtime = os.path.getmtime("file.txt")       # 最后修改时间（时间戳）
atime = os.path.getatime("file.txt")       # 最后访问时间
```

---

### **4. 环境变量与进程**
#### **环境变量**
```python
os.environ["PATH"]                         # 获取PATH变量
os.environ["MY_VAR"] = "value"             # 设置环境变量（仅当前进程有效）
```

#### **执行系统命令**
```python
os.system("ls -l")                         # 执行命令（返回状态码）
output = os.popen("date").read()           # 获取命令输出（过时，建议用subprocess）
```

---

### **5. 其他实用功能**
#### **重命名/移动文件**
```python
os.rename("old.txt", "new.txt")            # 重命名或移动文件
```

#### **获取当前工作目录**
```python
cwd = os.getcwd()                          # 当前工作目录
os.chdir("/tmp")                           # 切换工作目录
```

#### **操作系统信息**
```python
os.name                                    # 'posix'(Linux/Mac) 或 'nt'(Windows)
os.sep                                     # 当前系统的路径分隔符（/ 或 \）
```

---

### **6. 安全注意事项**
- **路径注入风险**：避免直接拼接用户输入的路径，用 `os.path.abspath` 和 `os.path.normpath` 规范化。
- **跨平台兼容性**：始终使用 `os.path.join` 替代硬编码分隔符。

---

### **经典应用场景**
#### **案例1：批量重命名文件**
```python
for idx, filename in enumerate(os.listdir(".")):
    if filename.endswith(".jpg"):
        os.rename(filename, f"image_{idx}.jpg")
```

#### **案例2：递归查找特定文件**
```python
for root, _, files in os.walk("project"):
    for file in files:
        if file.endswith(".py"):
            print(os.path.join(root, file))
```

#### **案例3：跨平台临时文件**
```python
import tempfile
temp_file = os.path.join(tempfile.gettempdir(), "temp.data")
```

---

### **总结**
- **核心用途**：文件/路径操作、目录遍历、环境变量管理。
- **黄金法则**：  
  - 用 `os.path` 处理路径（而非字符串拼接）。  
  - 用 `os.makedirs` 替代 `os.mkdir` 创建多层目录。  
  - 优先使用 `os.walk` 递归遍历目录。
