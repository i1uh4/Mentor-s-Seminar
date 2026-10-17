
#!/usr/bin/env bash
read -p "Первое число: " a
read -p "Второе число: " b

# допускаем целые и дробные через awk
cmp=$(awk -v x="$a" -v y="$b" 'BEGIN{ if(x+0<y+0) print "<"; else if(x+0>y+0) print ">"; else print "=="}')
case "$cmp" in
  "<") echo "$a < $b" ;;
  ">") echo "$a > $b" ;;
  "==") echo "$a = $b" ;;
esac
