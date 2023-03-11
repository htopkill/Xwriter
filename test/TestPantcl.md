
# Test PANTCL pandoc filters  


##  Test Filter tcl

```tcl
# just syntax highlighting / NO code evaluation
puts [ expr (10+3) ]
```

```{.tcl}
#  No eval 
puts [ expr (10+3) ]
```

```{.tcl  eval=true}
# eval=true
puts [ expr (10+3) ]
```


## Test Filter SQLITE

```{.sqlite results="asis"  echo=false  eval=true}
/* Create/Display a sqlite database */
CREATE TABLE contacts (
    first_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    phone TEXT NOT NULL UNIQUE
        );
INSERT INTO contacts (first_name, email, phone)
       VALUES       ("Max", "musterm@mail.de","1234");
INSERT INTO contacts (first_name, email, phone)
       VALUES       ("Musterwoman", "musterw@mail.de","1235");
SELECT * from contacts;
```

```{.sqlite  results=asis  eval=true  echo=false   file="/home/myself/.bin/Xwriter/test/obj/test.sqlite" }
/*  List available tables */
/*.tables */
/* Display the first 4 item in table 'albums' */
SELECT * from  Course  LIMIT 4;
```


##  Test filter CMD

```{.cmd  echo=false  eval=true  file="temp1.sh"  }
echo Hello;
cal
```

```{.cmd  echo=false  eval=true  file="temp2.py" }
#!/usr/bin/env python3
import sys
print ("Hello Python World!")
print (sys.version)
```

```{.cmd  echo=false eval=true  file="temp3.c"   }
///usr/bin/cc -o "${0%.c}" "$0" -lm && exec "${0%.c}"
#include <stdio.h>
#include <math.h>
int main (int argc, char** argv) {
    printf("Hello C Compiler World!\n");
    float pi = 3.141492653;
    printf("pi is: %f\n",pi);
    printf("sin(pi) is: %f\n",sin(pi));
    return(0);
}
```

```{.cmd  echo=false eval=true  file="temp4.cpp"  }
///usr/bin/g++ -o "${0%.cpp}" "$0" && exec "${0%.cpp}"
#include <iostream> 
int main(int argc, char** argv) {
  using namespace std;
  int ret = 0;
  cout << "Hello C++ World!" << endl;
  return ret;
} 
```

```{.cmd  echo=false  eval=true  file="temp5.v"}
///usr/local/bin/v run $0 $@  2>&1 && exit 0
println("Hello V World!")
```

```{.cmd  echo=false  eval=true  file="temp6.go"}
//usr/bin/go run $0 $@  2>&1 && exit 0
package main
func main() {
    println("Hello Go World!")
}
```

##  Test  Graphic DOT

```{.dot  label=neato-sample app=neato  echo=false eval=true}
graph G {
  node [shape=box,style=filled,fillcolor=skyblue,
              color=black,width=0.4,height=0.4];
          n0 -- n1 -- n2 -- n3 -- n0;
}
```

```{.dot label=digraph echo=false  eval=true }
digraph G {
       main -> parse -> execute;
       main -> init [dir=none];
       main -> cleanup;
       execute -> make_string;
       execute -> printf
       init -> make_string;
       main -> printf;
       execute -> compare;
}
```

