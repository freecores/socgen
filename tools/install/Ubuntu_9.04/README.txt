================================================================
Install recipe for ubuntu 9.04 on asus M2N68-AM SE2 with 22" lcd
================================================================

Install ubuntu 9.04 


System --> Administration  --> Hardware Drivers
  activate recomended nvidia driver

This set up the usb for urjtag
  sudo cp -r etc /


cp files in socgen/bin to your local ~/bin directory.

add to .profile:

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi



Reboot



System --> Administration  --> Software Sources
  Download from << find a local source for files>>

System    --> Administration  --> update Manager
   update


cd socgen/tools/install/ubuntu_9.04

make install



External tools that must be obtained from the net and installed


icarus verilog              verilog-0.9.1.tar.gz

Verilog preprocessor        Verilog-Perl-3.223.tar.gz

xilinx web pack             version 11.1 



