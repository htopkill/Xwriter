
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
