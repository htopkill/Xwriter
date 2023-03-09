
# Test PANTCL pandoc filters  

##  Test Filter tcl

**Without code evaluation**

```tcl
puts hello
```

**With Code evalutation**
```{.tcl  eval=true}
puts [ expr (10+3) ]
```


##  Test filter CMD

```{.cmd  eval=true }
cal
echo Hello
```

```{.cmd  eval=true file="sample.py"}
#!/usr/bin/env python3
import sys
print ("Hello Python World!")
print (sys.version)
```

##  Test  Graphic DOT

```{.dot  label=neato-sample app=neato  echo=false}
graph G {
  node [shape=box,style=filled,fillcolor=skyblue,
              color=black,width=0.4,height=0.4];
          n0 -- n1 -- n2 -- n3 -- n0;
}
```

```{.dot label=digraph echo=true }
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