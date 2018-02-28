
=========================
Zybo Z7-20 SDSoC Platform
-------------------------
copyright 2017 Digilent
=========================

=========================
Pre-requisites
=========================

* SDx 2017.4 Installed on either a Windows or supported Linux host. 
* microSD card (First or only partition must be FAT formatted)

============================
How to Use the Platform
============================

To install this platform and run the sample programs, do the following:

1. Open SDx 2017.4 and point to an empty directory to use as a workspace
2. In the top menu bar, click "Xilinx->Add Custom Platform..."
3. In the new window, click "Add Custom Platform..." and select the folder with
   the extracted platform (the folder this document is found in).
4. Click OK.
5. Now, in the top menu bar, click "File->New->SDx Project...".
6. Select Application Project and then press Next.
7. Name the project and press Next.
8. Select zybo_z7_20 and click Next.
9. Select the desired target OS from the System Configuration drop-down. Linux,
   FreeRTOS, and standalone (bare-metal) are supported.
10. Click Next, no other options should need to be changed on this page.
11. Select a sample application to run, or create an empty project, and click 
    finish to create the project.
12. If you created a sample project, click the hammer button to build the 
    project. This can take between 5-30 min on typical host machines.
13. After the build completes, look for the Debug->sd_card folder under your 
    project in the Project Explorer pane. Copy the entire contents of that 
    folder to the microSD.
14. Eject the microSD card from the host and insert it into the Digilent board.
15. Attach the USB UART port of the board to the computer.
16. Attach a suitable external power supply to power the board's barrel jack, 
    and select it with the onboard power jumper. 
17. Switch the board on.
18. Open a terminal program on the host computer and attach to the COM port or 
    tty device at 115200 baud, no flow control, no parity. 
19. Press the red PS-SRST button to reset the board, and watch the output of the
    terminal. If running FreeRTOS or standalone, then the demo should 
    automatically run. If running Linux, run the following commands at the 
    terminal to launch the demo:

    mount /dev/mmcblk0p1 /mnt/
    cd /mnt
    ./<project name>.elf

===========================
Further Information
===========================

For a complete list of this platform's features and known issues, as well as 
access to all sources used to create it, please see:

	https://reference.digilentinc.com/reference/software/sdsoc/start

For more information on using this platform and the SDSoC toolset, please refer 
to Xilinx's SDSoC documentation:

	https://www.xilinx.com/products/design-tools/software-zone/sdsoc.html#documentation

When creating accelerated programs in SDSoC, they are compiled using Vivado HLS.
It is useful to refer to the HLS documenation as well in order to learn how to 
write properly accelerated algorithms. HLS documentation can be found here:

	https://www.xilinx.com/products/design-tools/vivado/integration/esl-design.html#documentation


