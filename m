From: Brian Keener <bkeener@thesoftwaresource.com>
To: Trevor Forbes <cygwin-patches@cygwin.com>
Subject: Re: [patch] Setup.exe choose.cc selection enhancement based on file  existence
Date: Wed, 07 Mar 2001 11:27:00 -0000
Message-id: <VA.00000696.0015413c@thesoftwaresource.com>
References: <018501c0a6e8$0b17da70$0200a8c0@voyager>
X-SW-Source: 2001-q1/msg00156.html

Trevor Forbes wrote:
> >From my own build of setup 2.38, it would not let me select any source at
> all.   And when I selected experimental, I was not able to see a package
> that was visible/available in current.

Which download option did you select:  Download, Install from Internet or 
Install from local directory.  The modifications I made will cause the choose 
screen to only show packages for which the Prev,Curr, and Test buttons apply 
(ie the package has that particular version available) and then also their 
display is based on whether you have selected full/part.  I package might show 
with partial selected in current because it has a current version but will not 
show under test because it does not have a test version.  But if you select 
Full all packages should show but the options you can click (ie Keep, 
uninstall, install a version ) will vary depending if you have prev, current, 
test selected.

Also as I previously said the install from internet should work much the same 
as it always did whereas the Download option will only present you with files 
in Partial or full which do not already exist on your hard drive and will not 
provide for a forced download of one that exists.  An install from local 
directory will only provide you with a list of applications which are 
installed and/or their tarball exists on you hard drive.  It too does not 
provide for a forced install of a package which is currently installed.

> IMHO this behaviour is different from setup 2.37 and 2.29, but then again, I
> only had quick look when updating ghostscript..........
>

I am sure there is a difference in the behavior because that was what the 
changes were meant to cause but I think the basic core behavior remained the 
same.

bk

