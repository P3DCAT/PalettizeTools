# 3D Props Example #
----

There are two preferable ways to palettize textures with UV maps and anything non-gui related.

I've labeled both variants "static" and "dynamic". Let me go into detail about each one:

* **Static** refers to a texture that won't get overriden from another texture getting palettized. Instead, each of the models textures has its own palette map; with the UVs hooked up and ready.

* **Dynamic** refers to a texture that would more than likely change in the future due to another model sharing the same palette sheet.
There's often a chance in which the elements on a palette would get swapped and shifted around for spacial optimizations.

todo: go into detail for each cli arg