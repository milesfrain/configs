set history save on
set history size 10000
set history filename ~/.gdb_history
# Can reduce duplicate search count to improve performance
# Note that this does not deduplicate across launches.
set history remove-duplicates 10000
