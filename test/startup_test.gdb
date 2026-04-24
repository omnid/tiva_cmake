target remote :1234
break test_over
continue

set $result = *test_result
quit $result