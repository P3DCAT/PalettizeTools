Texture Attributes Keywords
--------------

### Usage ###
Our ``textures.txa`` file is intended to be a general configuration framework for textures. It is a vital aspect of a typical resources pipeline in Panda3D.

### Syntax ###
We define our configuration attributes with a ``:`` prefix. Generic filenames are not required to start with a ``:`` prefix, but use such to define specific attributes for a group or a texture.

Comments are denoted from a ``#`` prefix. It's best to use comments when defining different texture sectors.

Example:
> ```
> :imagetype png
> textureName.png : 16 16
> ```
> Defines the overall palette to use a PNG file format, while additionally defining the resolution for the known input texture.

### Keywords ###

The following documentation was attributed from the 'Spotify' release along with the Panda3D C++ palletizer documentation.

It goes into detail about different configuration parameters:

#### Static Keywords ####
:imagetype

:shadowtype

:palette

:coverage

:powertwo

:margin

:round

:remap

:cutout

:textureswap

#### Abstract Keywords ####

:group


### References ###
http://www.etc.cmu.edu/projects/panda3d/PandaDox/Panda/html/classEggTexture.html#EggTextures40

