From: "Schaible, Jorg" <Joerg.Schaible@gft.com>
To: CP List <Cygwin-Patches@Cygwin.Com>
Subject: RE: winsup/cinstall/desktop.cc: link to rxvt instead of cygwin.bat
Date: Mon, 24 Sep 2001 06:28:00 -0000
Message-id: <C2D7D58DBFE9D111B0480060086E96350519BD9D@mail_server.gft.com>
X-SW-Source: 2001-q3/msg00188.html

Hi,

>I don't like your choice of values for the rxvt switches.  It doesn't
>matter what you change them to I'll never like your choice of 
>switches. 
>Given that you should modify your patch to create a 
>cygwin-rxvt.bat file
>and use that if rxvt is available.  Then I can modify your choice of
>switches like I'm used to changing other values.  

Personally I would prefer an option to the cygwin.bat like -rxvt. Otherwise
I had to duplicate my settings in both files. Additionally I would not
replace the link in the start menu, but add another one.

>Shortcutting directly
>to the executable doesn't allow me to add environment variables such as
>CYGWIN before starting the process.  Shortcutting to a bat file is a
>common Cygwin occurrence that if it doesn't happen will generate
>hundreds to thousands of list mail.

What I do not like with the current batch file approach is, that it does
only support global settings, not personal ones (nor does it respect my
favorite choice of the shell from /etc/passwd). This is not an issue, if I
am the only  person using the machine.

Jorg
