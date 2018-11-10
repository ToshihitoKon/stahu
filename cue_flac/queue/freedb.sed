/TITLE ".*"$/N
s/TITLE "\(.*\) \/ \(.*\)"\nPERFORMER ".*"/TITLE "\2"\nPERFORMER "\1"/g
