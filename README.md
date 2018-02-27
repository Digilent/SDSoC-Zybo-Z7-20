# Zybo Z7-20 SDSoC Platform
Created for SDx 2017.4, Vivado 2017.4, and Petalinux 2017.4

## Downloading and Using the Platform

Please click on the releases tab in github to download the latest release for 
your version of SDx. A README.txt is included with the release that describes 
how to use the SDSoC platform.

## Platform Sources

This repository is used by Digilent to version control all the sources used to 
create the platform. It contains the Vivado IPI project, an SDx platform 
generator project and a Petalinux project. The SDSoC platform generator project 
also contains the a submodule with a port of the standard Xilinx samples. These 
parts all come together to form a SDSoC Platform.

Advanced users who wish to make modifications to this platform or use it as a
reference are welcome to. This may be a challenging task for beginners, If you 
need help please feel free to reach out on https://forum.digilentinc.com.

## Included Documentation

This document contains a procedure for building all the sources and generating 
the output platform, however there are several other useful documents in this 
repo.
       
##### petalinux_notes.txt
   
   This document describes the modifications that needed to be made to the 
   standard Petalinux project for this board in order to work with SDSoC.

##### linux/README.md
   
   The standard README that ships with Digilent Petalinux projects. It contains 
   useful information for using and building the included Petalinux project.

##### sdsoc/README.txt
   
   The README.txt that is included with the platfrom release. It contains
   instructions for how to use the built platform in SDx to design SDx 
   applications. It should be referred to by those interested in only using the
   platform.
  
## Known Issues

1. In the Vivado block diagram, typically the processing system IP core will 
   infer a BUFG on the FCLK signals. For some reason, this is occuring for 
   FCLK0 only. FCLK2 seems to be getting a BUFG added during implementation, so 
   it doesn't cause any issues for that net, but FCLK 1 was being
   routed as a normal signal (not on the global clock network). This caused 
   insanely long build times and failure to meet timing. The current work around
   is to manually insert a BUFG on FCLK1 using a util_ds_buf IP core.

2. Audio is not functional


3. The included vivado project has several critical warnings that complain about
   negative values in the DDR parameters. These can be safely ignored. The 
   warnings look similar to:

```
PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_* has negative value...
```

4. Board files and IP repo are forked and locally included with the Vivado 
   project. It should be possible to reduce redundancy by including them both as
   submodules.


# Building the Platform

        WARNING*** You must have obtained this package using "git clone --recursive 
        https://github.com/Digilent/SDSoC-Zybo-Z7-20.git" or else these instructions 
        will not work.

## Prerequisites

1. Host computer running Ubuntu 16.04.3 LTS 

2. Xilinx SDx 2017.4 installed to /opt/Xilinx/SDx/

3. Petalinux 2017.4 installed to /opt/pkg/petalinux/

4. Package must have been obtained using 
   "git clone --recursive https://github.com/Digilent/SDSoC-Zybo-Z7-20.git" or 
   else these instructions will not work.

        NOTE*** This procedure assumes some basic experience with Vivado IP Integrator 
        and PetaLinux.

## Procedure     

1. If you have built the Vivado IPI project at least once and it has not changed
   since the last build you can skip this step. Otherwise do the following:
    
    1. Open a terminal and run "source /opt/Xilinx/SDx/2017.4/settings64.sh"

    2. cd into the vivado/zybo_z7_20/ folder

    3. Run "./cleanup.sh" at the terminal if you have pulled remote changes 
       since the last time you have built the project. If you have not pulled 
       any changes to the vivado project from git or it is your first time 
       building the project then you do not need to run the script.

    4. run "vivado" at the terminal to open Vivado. 

    5. Click Open Block Design in the flow navigator. You can modify the design 
       if you like at this point. 
  
    6. Generate the bitstream, relaunching synthesis and implementation.
    
    7. Open the Implemented Design and then click File->Export->Hardware. 
       Include the bitstream and save it to the hw_handoff folder. Overwrite
       the existing file.

    8. At the tcl console in vivado, run "source ./create_dsa.tcl". Ignore 
       warnings that say that the design has changed since last build.
   
    9. Close Vivado and the terminal. You can save the block diagram if asked.

2. If changes have been made to the petalinux project or it has not been built 
   yet since cloning this repo, the following must be done:

    1. Open a new terminal and run "source /opt/pkg/petalinux/settings.sh".

    2. cd into the linux/Zybo-Z7-20/ directory of this repo. Run 
       "petalinux-config --get-hw-description=../../hw_handoff" and exit the
       menu that opens.
   
    3. Additional changes to the petalinux project can be made at this time, as 
       needed.

    4. Build the project using petalinux-build.

    5. Close the terminal 

           NOTE*** In the rare case that the memory map has been modified, for example if 
           block ram was added to an AXI GP port, then Xilinx SDK should be launched from 
           the vivado project (prior to closing Vivado). The hw_handoff folder should be 
           used as the exported hardware location and the sdk folder should be used as the
           workspace. Then hello world applications will need to be generated with the same
           names as those already found in that folder, one for standalone and one for 
           freeRTOS. This is solely to generate the lscript.ld files. Finally, open the 
           lscript.ld files in each of the hello world projects and change the heap size to
           0x10000000 and the stack size to 0x40000. Save the files, then Xilinx SDK and 
           Vivado can be closed.

4. Open a terminal and cd into the sdsoc/zybo_z7_20/resources/ folder.

5. Run "./copy_files.sh". If errors are reported that files do not exist, then 
   step 1 or 2 likely needs to be rerun.

6. cd to your home directory and run 
   "source /opt/Xilinx/SDx/2017.4/settings64.sh"

7. run "sdx" to open SDx

8. Choose the sdsoc folder of this repo as your workspace.

9. Click Import Project on the Welcome screen. In the window that opens, select
   the sdsoc folder as the root directory and click finish to import the 
   zybo_z7_20 platform project.

10. In the Project Explorer pane, double click platform.spr in the zybo_z7_20
   project. Changes, such as adding library and include paths, can be made to
   the platform at this point. See UG1146 from Xilinx for information on using
   this tool to define the SDSoC platform.

11. Click the hammer in the zybo_z7_20 pane to generate the platform. The 
    platform is now ready to use!
   
12. If you will be moving directly onto application development, add the 
    newly generated platform platform to custom repo path by clicking the 
    "4. Add to Custom Repositories" button at the bottom of the zybo_z7_20 pane.
    You can now create new SDx projects in this workspace that target the custom
    platform that was just built. See sdsoc/README.txt for further information
    on using the platform.
    
## Platform Release Procedure  

The following procedure describes how to push your modifications back to the 
Digilent github (or a fork hosted elsewhere) and generate a release package.

1. cd to the root folder of this repo (SDSoC-Zybo-Z7-20). Run git status to
   see if any changes have been made to the project. If it appears generated 
   files, logs, or other unneeded files are seen in the git status output,
   then .gitignore should be modified to exclude them. Do not check in 
   unneeded files. 

2. Use "git add ." and "git commit" to commit the changes

3. Run git status again. If it reports that the linux submodule has changes
   then run the following:
       
        cd linux
        git checkout -b sdsoc <skip this step if already done since cloning the repo>
        git status <check to make sure that only needed files will be commited, change .gitignore if not>
        git add . 
        git commit <write a commit message for the Petalinux submodule>
        git push -u origin sdsoc
        cd ..
        git add linux
        git commit <write commit message that indicates "updated linux submodule">

4. If git status indicates there are changes to another submodule, then 
   rerun step 3. for it to push the changes. It is likely that the branch
   name in the checkout and push steps will need to change, probably to 
   master.

5. Copy sdsoc/README.txt to sdsoc/zybo_z7_20/export/zybo_z7_20/

6. Open the Ubuntu file browser and browse to the sdsoc/zybo_z7_20/export/
   folder.

7. right click the zybo_z7_20 folder and click Compress... to compress it as
   a Zip file. Name the Zip file as follows:

        SDSoC-Zybo-Z7-20-v20XX.X-Y
    
   Where 20XX.X is the SDx version and Y is the release number. 
   
8. Back at the terminal, ensure that all changes are commited, and push the
   commits to github.

9. Create a github release that targets the most recent commit, and attach 
   the platform Zip file to it.


