Texture Attributes Keywords
--------------
*As denoted from ``egg-palettize -H``*


## Usage ##
Our attributes file (commonly referred to as ``textures.txa``) consists mostly of lines describing desired sizes of
texture maps.

In general, each line consists of one or more filenames (and can contain
shell globbing characters like ``*`` or ``?``), and a colon followed by a
size request.  For each texture appearing in an egg file, the input list
is scanned from the beginning and the first line that matches the
filename defines the size of the texture, as well as other properties
associated with the texture.

## Syntax ##
We define our configuration attributes with a ``:`` prefix. Generic filenames are not required to start with a ``:`` prefix, but use such to define specific attributes for a group or a texture.

Comments are denoted from a ``#`` prefix. It's best to use comments when defining different texture sectors.

Example:
> ```
> :imagetype png
> textureName.png : 16 16
> ```
> Defines the overall palette to use a PNG file format, while additionally defining the resolution for the known input texture.

## Keywords ##

### Special Keywords ###
####  **:palette** *xsize ysize*  ####       
This specifies the size of the palette images to be created. The default is 512 by 512.

####  **:margin** *msize*  ####       
This specifies the amount of default margin to apply to all
textures that are placed within a palette image.  The margin
is a number of additional pixels that are written around the
texture image to help prevent color bleeding between
neighboring images within the same palette.  The default is 2.  

####  **:background** *r g b a* ####        
Specifies the background color of the generated palette
images.  Normally, this is black, and it doesn't matter much
since the background color is, by definition, the color of the
palette images where nothing is used.

####  **:coverage** *area* ####       
The 'coverage' of a texture refers to the fraction of the area
in the texture image that is actually used, according to the
UV's that appear in the various egg files.  If a texture's
coverage is less than 1, only some of the texture image is
used (and only this part will be written to the palette).  
If the coverage is greater than 1, the texture repeats that  
number of times.  A repeating texture may still be palettized
by writing the required number of copies into the palette
image, according to the coverage area.   
 * This command specifies the maximum coverage to allow for any
          texture before rejecting it from the palette.  It may be any
          floating-point number greater than zero.  Set this to 1 to
          avoid palettizing repeating textures altogether.  This may
          also be overridden for a particular texture using the
          'coverage' keyword on the texture line.    
  
####   **:powertwo** *flag* ####      
>          Specifies whether textures should be forced to a power of two
>          size when they are not placed within a palette.  Use 1 for
>          true, to force textures to a power of two; or 0 to leave them
>          exactly the size they are specified.  The default is true.

####    **:round** *fraction fuzz* ####         
>          When the coverage area is computed, it may optionally be
>          rounded up to the next sizeable unit before placing the
>          texture within the palette.  This helps reduce constant
>          repalettization caused by slight differences in coverage
>          between egg files.  For instance, say file a.egg references a
>          texture with a coverage of 0.91, and then later file b.egg is
>          discovered to reference the same texture with a coverage of
>          0.92.  If the texture was already palettized with the original
>          coverage of 0.91, it must now be moved in the palette.
> * Rounding the coverage area up to some fixed unit reduces this
>          problem.  For instance, if you specified a value 0.5 for
>          fraction in the above command, it would round both of these
>          values up to the next half-unit, or 1.0.
> *  The second number is a fuzz factor, and should be a small
>          number; if the coverage area is just slightly larger than the
>          last unit (within the fuzz factor), it is rounded down instead
>          of up.  This is intended to prevent UV coordinates that are
>          just slightly out of the range [0, 1] (which happens fairly
>          often) from forcing the palettization area all the way up to
>          the next stop.
> * The default if this is unspecified is 0.1 0.01.  That is,
>          round up to the next tenth, unless within a hundredth of the
>          last tenth.  To disable rounding, specify ':round no'.
>          Rounding is implicitly disabled when you run with the -opt
>          command line option.

>  **:remap** (*never* | *group* | *poly*)    
>          Sometimes two different parts of an egg file may reference
>          different regions of a repeating texture.  For instance, group
>          A may reference UV coordinate values ranging from (0,5) to
>          (1,6), for a coverage of 1.0, while group B references values
>          ranging from (0,2) to (1,4), for a coverage of 2.0.  The
>          maximum coverage used is only 2.0, and thus the texture only
>          needs to appear in the palette twice, but the total range of
>          UV's is from (0,2) to (1,6), causing an apparent coverage of
>          4.0.
> * It's possible for egg-palettize to reduce this kind of mistake
>          by remapping both groups of UV's so that they overlap.  This
>          parameter specifies how this operation should be done.  If the
>          option is 'never', remapping will not be performed; if
>          'group', entire groups will be remapped as a unit, if 'poly',
>          individual polygons within a group may be remapped.  This last
>          option provides the greatest minimization of UV coverage, but
>          possibly at the expense of triangle strips in the resulting
>          model (since some vertices can no longer be shared).
> * Sometimes, it may be necessary to be more restrictive on
>          character geometry than on non-character geometry, because the
>          cost of adding additional vertices on characters is greater.
>          You can specify a different kind of remapping for characters
>          only, by using the keyword 'char' on the same line, e.g.
>          ':remap group char never'.
> * The default remap mode for all geometry, character or
>          otherwise, if no remap mode is specified is 'poly'.

>  **:imagetype** *type[,alpha_type]*      
>          This specifies the default type of image file that should be
>          generated for each palette image and for each unplaced texture
>          copied into the install directory.  This may be overridden for
>          a particular texture by specifying the image type on the
>          texture line.                      
> * If two image type names separate by a comma are given, it
>          means to generate a second file of the second type for the
>          alpha channel, for images that require an alpha channel.  This
>          allows support for image file formats that do not support
>          alpha (for instance, JPEG).

>  **:shadowtype** *type[,alpha_type]*         
>          When generating palette images, egg-palettize sometimes has to
>          read and write the same palette image repeatedly.  If the
>          palette image is stored in a lossy file format (like JPEG, see
>          :imagetype), this can eventually lead to degradation of the
>          palette images.  As a workaround, egg-palettize can store its
>          working copies of the palette images in lossless shadow
>          images.  Specify this to enable this feature; give it the name
>          of a lossless image file format.  The shadow images will be
>          written to the directory specified by -ds on the command line.

>  **:group** *groupname [dir dirname] [on group1 group2 ...] [includes group1 group2 ...]*     
>          This defines a palette group, a logical division of textures.
>          Each texture is assigned to one or more palette groups before
>          being placed in any palette image; the palette images are tied
>          to the groups.
> * The optional parameter 'dir' specifies a directory name to
>          associate with this group.  This name is substituted in for
>          the string '%g' when it appears in the map directory name
>          specified on the command line with -dm; this may be used to
>          install textures and palettes into different directories based
>          on the groups they are assigned to.
> * Palette groups can also be hierarchically related.  The
>          keyword 'on' specifies any number of groups that this palette
>          group depends on; if a texture has already been assigned to
>          one of this group's dependent groups, it will not need to be
>          assigned to this group.  This also implicitly specifies a dir
>          if one has not already been specified.
> *  The keyword 'includes' names one or more groups that depend on
>          this group.

>  **:textureswap** *groupname texturename0 texturename1 [texturename2 ...]*        
>          This option builds a set of matching, interchangeable palette
>          images. All palette images in the set share the same internal
>          texture layout. The intention is to be able to swap palette
>          images out at runtime, to replace entire sets of textures on a
>          model in one operation. The textures named by this option
>          indicate the texture images which are similar to each other,
>          and which all should be assigned to the same placement on the
>          different palette images: texturename0 will be assigned to
>          palette image 0, texturename1 to the same position on palette
>          image 1, texturename2 to the same position on palette image 2,
>          and so on. To define a complete palette image, you must repeat
>          this option several times to associate all of the similar
>          texture images.


### Texture Keywords ###

There are several valid keywords that may be specified on the same line with the texture.  

>**omit**    
>          This indicates that the texture should not be placed on any
>          palette image.  It may still be resized, and it will in any
>          case be copied into the install directory.        

>**margin** *i*     
>          This specifies the number of pixels that should be written
>          around the border of the texture when it is placed in a
>          palette image; *i* is the integer number of pixels.  The use of
>          a margin helps cut down on color bleed from neighboring
>          images.  If the texture does not end up placed in a palette
>          image, the margin is not used.  If not specified, the default
>          margin is used, which is specified by the :margin command (see
>          below).    

>**coverage** *f*     
>          This parameter specifies the maximum coverage to allow for
>          this particular texture before rejecting it from the palette.
>          If not specified, the default is specified by the :coverage
>          command (see below).

>**nearest**, **linear**, **mipmap**      
>          One of these options may be used to force the texture to use a
>          particular minfilter/magfilter sampling mode.  If this is not
>          specified, the sampling mode specified in the egg file is
>          used.  Textures that use different sampling modes cannot be
>          placed together on the same palette images.

>**rgba**    
>          This specifies format 'rgba' should be in effect for this
>          particular texture.  Any valid egg texture format, such as
>          rgba, rgba12, rgba8, rgb5, luminance, etc. may be specified.
>          If nothing is specified, the format specified in the egg file
>          is used.  The format will automatically be downgraded to match
>          the number of channels in the texture image; e.g. rgba will
>          automatically be converted to rgb for a three-channel image.
>          As with the filter modes above, textures that use different
>          formats cannot be placed together on the same palette images.

>**force-rgba**  
>          This specifies a particular format, as above, that should be
>          in effect for this texture, but it will not be downgraded to
>          match the number of channels.  As above, any valid egg texture
>          format may be used, e.g. force-rgba12, force-rgb5, etc.

>**keep-format**   
>          This specifies that the image format requested by an egg file
>          should be exactly preserved, without attempting to optimize it
>          by, for instance, automatically downgrading.

>**generic**      
>          Specifies that any image format requested by an egg file that
>          requests a particular bitdepth should be replaced by its
>          generic equivalent, e.g. rgba8 should become rgba.

>***(alpha mode)***     
>          A particular alpha mode may be applied to a texture by naming
>          the alpha mode.  This may be any valid egg alpha mode, e.g.
>          blend, binary, ms, or dual.

>**repeat_u**, **repeat_v**, **clamp_u**, **clamp_v**    
>          Explcitly specify whether the source texture should repeat or
>          clamp in each direction.  Although palette images are always
>          clamped, this will affect the pixels that are painted into the
>          palette image.

>***(image type)***   
>          A texture may be converted to a particular image type, for
>          instance jpg or rgb, by naming the type.  If present, this
>          overrides the :imagetype command, described below.  As with
>          :imagetype, you may also specify two type names separated by a
>          comma, to indicate that a different file should be written for
>          the color and alpha components.

>***(group name)***     
>          A texture may also be assigned to a specific group by naming
>          the group.  The groups are defined using the :group command
>          (see below).  Normally, textures are not assigned directly to
>          groups; instead, it is more useful to assign the egg files
>          they are referenced in to groups; see below.

>**cont**    
>          Normally, a texture file (or egg file) scans the lines in the
>          attributes file from the top, and stops on the first line that
>          matches its name.  If the keyword 'cont' is included on the
>          line, however, the texture will apply the properties given on
>          the line, and then continue scanning.  This trick may be used
>          to specify general parameters for all files while still
>          allowing the texture to match a more specific line below.



## References ##
http://www.etc.cmu.edu/projects/panda3d/PandaDox/Panda/html/classEggTexture.html#EggTextures40

