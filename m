From: Brian Keener <bkeener@thesoftwaresource.com>
To: Earnie Boyd <cygwin-patches@cygwin.com>
Subject: Re: [patch] Setup.exe choose.cc selection enhancement based on file  existence
Date: Tue, 06 Mar 2001 14:41:00 -0000
Message-id: <VA.0000068e.017d3abe@thesoftwaresource.com>
References: <3AA553A8.E7A27B1A@yahoo.com>
X-SW-Source: 2001-q1/msg00153.html

Earnie Boyd wrote:
> And as far as I remember that is the way the FULL/PART switch
> should/does work.  If I want to force a package install, whether
> installed already or not it should happen.
>
Are you folks sure we are on the same wavelength here.  If we are then my 
saved copy of setup.exe 2.29 must have a problem.  If I select install 
from Internet the only items which are displayed to me by default are the 
packages which need updating and yes I have the option to download the 
source.

However if I select the Full option - you will see all the packages 
listed, but those that are current will say keep and their source option 
will say n/a.  As far as I can tell (with my saved version) - setup will 
not let me select the same version for install - I can keep, I can 
uninstall and I can install some other version (which does then give me 
the download source option) but I cannot install the same version.  This 
appears to be the way the current web version works and I tried to 
maintain this logic in my changes.

The bulk of my changes was to help prompt the user for what should be 
done - ie if downloading and it already exists - don't show it to them or 
if they are installing from local directory and it doesn't exist - don't 
show it to them.  Really the install from internet option should have 
changed minimally.

Maybe I missed something here and I do agree that we should probably have 
the option to download/install the same package again as well as 
download/install the source even if we didn't do it 10 minutes ago, but I 
don't think either of these were options that were there and are no 
longer because of changes I made.  

