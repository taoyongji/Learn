# LeetCode

### 反转字符串 
```
编写一个函数，其作用是将输入的字符串反转过来。输入字符串以字符数组 char[] 的形式给出。

不要给另外的数组分配额外的空间，你必须原地修改输入数组、使用 O(1) 的额外空间解决这一问题。

你可以假设数组中的所有字符都是 ASCII 码表中的可打印字符。

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/reverse-string
```

### 示例 1：
```
输入：["h","e","l","l","o"]
输出：["o","l","l","e","h"]
```

### 示例 2：
```
输入：["H","a","n","n","a","h"]
输出：["h","a","n","n","a","H"]
```

### 解答
```java
class Solution {
    public void reverseString(char[] s) {
        int r = 0;
        int l = s.length-1;
        int size = (r + l + 1) / 2;
        char t;
        while (r < size) {
            t = s[r];
            s[r] = s[l];
            s[l] = t;
            r++;
            l--;
        } 
    }
}
```



### Fizz Buzz

```
写一个程序，输出从 1 到 n 数字的字符串表示。

1. 如果 n 是3的倍数，输出“Fizz”；

2. 如果 n 是5的倍数，输出“Buzz”；

3.如果 n 同时是3和5的倍数，输出 “FizzBuzz”。

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/fizz-buzz
```

### 示例
```
n = 15,

返回:
["1","2","Fizz","4","Buzz","Fizz","7","8","Fizz","Buzz","11","Fizz","13","14","FizzBuzz"]
```

### 解答
```java
class Solution {
    public List<String> fizzBuzz(int n) {
        List<String> list = new ArrayList<>();
        int k = 1;
        while (k <= n) {
            int f = 0;
            if (k % 3 == 0) {
                f = 1;
                if (k % 5 == 0) {
                    list.add("FizzBuzz");
                }
                else {
                    list.add("Fizz");
                }
            }
            
            if (k % 5 == 0 && k % 3 != 0) {
                f = 1;
                list.add("Buzz");
            }
        
            if (f == 0) {
                list.add(Integer.toString(k));
            }
            k++;
        }
        return list;
    }
}
​```

```



### 验证回文串

```
给定一个字符串，验证它是否是回文串，只考虑字母和数字字符，可以忽略字母的大小写。
说明：本题中，我们将空字符串定义为有效的回文串。
来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/valid-palindrome/
```

### 示例 1:

```
输入: "A man, a plan, a canal: Panama"
输出: true
```

### 示例 2:

```
输入: "race a car"
输出: false
```

### 解答

```c
bool isPalindrome(char * s){
    if (s == NULL)
        return false;
    if (strlen(s) == 0 || strlen(s) == 1)
        return true;
    //返回结果
    bool isPan = true;
    //去掉多余符号后总数
    int count = 0;
    //动态分配
    char *b = malloc(strlen(s) * sizeof(char));
    //计算出输入字符串长度并将字母存入数组
    for (int i = 0;; i++) {
        if (s[i] == '\0')
            break;
        if ((s[i] >= 65 && s[i] <= 90) || (s[i] >= 97 && s[i] <= 122) || (s[i] >= 48 && s[i] <= 57)) {
            //变为小写
            if (s[i] >= 65 && s[i] <= 90) {
                b[count] = s[i] + 32;
                count++;
                continue;
            }
            b[count] = s[i];
            count++;
        }
    }
    //判断长度是偶数还是奇数
    //偶数
    if (count % 2 == 0) {
        int index = count / 2;
        for (int i = 0; i < index; i++) {
            if (b[index-1-i] == b[index+i])
                continue;  
            else {
                isPan = false;
                break;
            }  
        }
    }
    //奇数
    else {
        int index = count / 2;
        for (int i = 1; i <= index; i++) {
            if (b[index-i] == b[index+i])
                continue;
            else {
                isPan = false;
                break;
            }
        }
    }
    return isPan;
}
```

