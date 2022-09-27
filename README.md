Clothing machines
==============================================

Add simple machines usable to making clothing.

Crafting
--------

[clothing_machines:spinning_machine]
+------+--------+------+
| wood |  wood  | wood |
+------+--------+------+
| wood | string | wood |
+------+--------+------+
| wood |  wood  | wood |
+------+--------+------+

[clothing_machines:loom]
+-------+----------+----------+
| stick | pinewood |  stick   |
+-------+----------+----------+
| stick | pinewood |  stick   |
+-------+----------+----------+
| stick | pinewood | pinewood |
+-------+----------+----------+

[clothing_machines:sewing_table]
+-------+--------+-------+
| wood  |  wood  | wood  |
+-------+--------+-------+
| stick | needle | stick |
+-------+--------+-------+
| stick | needle | stick |
+-------+--------+-------+

[clothing_machines:dya_machine_empty]
+------+-------+------+
| wood | stick | wood |
+------+-------+------+
| wood | stick | wood |
+------+-------+------+
| wood | wood  | wood |
+------+-------+------+

[clothing_machines:needle]
+--------+
| needle |
+--------+
| needle |
+--------+

[clothing:yarn_spool_empty]
+-------+
| stick |
+-------+
| wood  |
+-------+

Spinning
  wool -> yarn_spool
  cotton -> yarn_spool
  hemp fibre -> yarn_spool

Weaving
  +------------+------------+
  | yarn_spool | yarn_spool |
  +------------+------------+ -> fabric
  | yarn_spool | yarn_spool |
  +------------+------------+
  
  +-----------------+-----------------+
  | yarn_spool_col1 | yarn_spool_col2 |
  +-----------------+-----------------+ -> dual color fabric
  | yarn_spool_col2 | yarn_spool_col1 |
  +-----------------+-----------------+

Dyeing
  - colorize white yarn, fabric or wool

Sewing
  - use same color of fabric and yarn  
  
Configuration
-------------


