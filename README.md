Egg Palletization Tools
--------------
This repository is aimed as a guide to using specific Panda3D tools.

## Components ##

### Panda3D Binaries ###

We will primarily be using three of Panda's tools with their usages defined below:

>
> **egg-palettize**
>
> ``egg-palettize [opts] file.egg [file.egg ...]``
>
> egg-palettize attempts to pack several texture maps from various models
> together into one or more palette images, for improved rendering
> performance and ease of texture management.  It can also resize textures
> and convert them to another image file format, whether or not they are
> actually placed on a palette, and can manage some simple texture
> properties, like mipmapping and rendering format.
>
> egg-palettize reads a texture attributes file, usually named
> textures.txa, which contains instructions from the user about resizing
> particular textures.  Type egg-palettize -H [in the command line] for an introduction to the
> syntax of this file.
>
> The palettization information from previous runs is recorded in a file
> named textures.boo (assuming the attributes file is named textures.txa);
> a complete record of every egg file and every texture that has been
> referenced is kept here.  This allows the program to intelligently
> manage the multiple egg files that may reference the textures in
> question.

>
> **egg-texture-cards**
>
>``egg-texture-cards [opts] texture [texture ...] output.egg``
>
> egg-texture-cards generates an egg file consisting of several square
> polygons, one for each texture name that appears on the command line.
>
> This is a handy thing to have for importing texture images through
> egg-palettize, even when those textures do not appear on any real
> geometry; it can also be used for creating a lot of simple polygons for
> rendering click buttons and similar interfaces.

>
> **egg-trans**
>
>``egg-trans [opts] -o output.egg input.egg``
>
> egg-trans reads an egg file and writes an essentially equivalent egg
> file to the standard output, or to the file specified with -o.  Some
> simple operations on the egg file are supported.

### Texture Attributes (txa) ###

## Palletization Process ##

### 2D Assets ###

The typical pipeline for palettizing 2D assets, such as GUI and simple
2d images, utilize Panda's **egg-texture-cards** tool. This is
crucial for the input egg file required by **egg-palettize**.

### 3D Assets ###



