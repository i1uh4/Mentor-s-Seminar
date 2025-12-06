
#!/usr/bin/env bash
threshold=80
# взять строку с корневым разделом (или все)
df -hP | awk 'NR>1 {print $5 " " $6}' | while read perc mount; do
  pnum=${perc%\%}
  if [ "$pnum" -ge "$threshold" ]; then
    echo "Внимание: использование диска на $mount = $perc"
  fi
done
