From: Earnie Boyd <earnie_boyd@yahoo.com>
To: Michael Hoffman <grouse@mail.utexas.edu>
Cc: cygwin-patches@cygwin.com
Subject: Re: winsup/cinstall/desktop.cc: link to rxvt instead of cygwin.bat
Date: Mon, 24 Sep 2001 04:32:00 -0000
Message-id: <3BAF19AE.30B2394D@yahoo.com>
References: <Pine.WNT.4.40.0109231820080.800-100000@barbecueworld>
X-SW-Source: 2001-q3/msg00187.html

Michael Hoffman wrote:
> 
> This is a patch to change setup so desktop and Start Menu shortcuts will
> link to rxvt instead of cygwin.bat, only if rxvt is installed.
> Otherwise, it will link to bash --login -i. It still creates cygwin.bat
> and doesn't rewrite existing shortcuts, in case people still want to use
> the batch file. Changing from cygwin.bat to bash --login -i was
> suggested more than a year ago and DJ said "Patches welcome," so here is
> the patch. :-)
> 
> http://sources.redhat.com/ml/cygwin/2000-08/msg00514.html
> 
> Since the shortcuts no longer link to a batch file, I don't think the
> code in make_link that constructs a command line for Win9X should be
> necessary. But I don't have a Win9X system to test on, so I left it
> alone.
> 
> Please let me know if you have any thoughts about this.
> 

I don't like your choice of values for the rxvt switches.  It doesn't
matter what you change them to I'll never like your choice of switches. 
Given that you should modify your patch to create a cygwin-rxvt.bat file
and use that if rxvt is available.  Then I can modify your choice of
switches like I'm used to changing other values.  Shortcutting directly
to the executable doesn't allow me to add environment variables such as
CYGWIN before starting the process.  Shortcutting to a bat file is a
common Cygwin occurrence that if it doesn't happen will generate
hundreds to thousands of list mail.

Earnie.

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

