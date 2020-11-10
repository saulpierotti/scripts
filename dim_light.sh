#!/bin/sh

sleep_time=0.5
decrease_by=0.1
i=3

light -O

while [ $i -gt 0 ]; do
    i=$(($i - 1))
    light -T $decrease_by
    sleep $sleep_time
    light -I
    sleep $sleep_time
done
