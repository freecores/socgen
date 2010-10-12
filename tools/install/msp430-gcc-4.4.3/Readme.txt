MSP430





http://mylightswitch.com/


            A few weeks ago I decided to upgrade my PC from an older 
version of OpenSuse to Kubuntu 10.04. Here are my steps to install on 
Kunbuntu 10.04.     

   I installed following packages via System Settings-&gt;Add and Remove
 Software but I believe it would just as easy to use apt-get on the 
command line.     

      subversion     
      gcc-4.4     
      texinfo     
      patch     
      libncurses5-dev     
      zlibc     
      zlib1g-dev     
      libx11-dev     
      libusb-dev     
      libreadline6-dev     

   With those packages installed I could install mspgcc4 with following steps:     

      check out mspgcc4 from sourceforge via "svn checkout https://mspgcc4.svn.sourceforge.net/svnroot/mspgcc4"     
      change directory into newly created mspgcc4 via "cd mspgcc"     
      run the build script via "sudo sh buildgcc.sh"

     I basicly used all the default answers by pressing ENTER only selecting "Build now" with yes (default there is no)<br>This installed all the tools under /opt/msp430-gcc-4.4.3.     

      Next I added /opt/msp430-gcc-4.4.3/bin to the path in /etc/profiles ("export PATH=${PATH}:/opt/msp430-gcc-4.4.3/bin")     

   Next I downloaded the tar file for mspdebug from sourceforge ( http://mspdebug.sourceforge.net/download.html ).     
   Then I was able to install the mspdebug via:     

      tar xvfz mspdebug-version.tar.gz     
      cd mspdebug-version     
      make     
      sudo make install     

   I can start mspdebug for the ez430F2013 with "mspdebug -u /dev/ttyUSB0" Update:
 in version 0.10 the -u option is not there anymore. Instead I had to 
use "mspdebug -d /dev/ttyUSB0 uif" to connect to my EZ430   


