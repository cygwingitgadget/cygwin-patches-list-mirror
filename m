From: Brian Keener <bkeener@thesoftwaresource.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] setup.exe changes for Redownload/Reinstall Current version or Sources only - Part 2
Date: Fri, 11 May 2001 12:45:00 -0000
Message-id: <VA.0000076b.006f522f@thesoftwaresource.com>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08EFA8@itdomain002.itdomain.net.au> <20010510005533.A12859@redhat.com> <000701c0d972$7889a680$9332273f@ca.boeing.com> <200105101705.NAA22677@envy.delorie.com> <VA.00000766.003544d4@thesoftwaresource.com> <200105102332.TAA25548@envy.delorie.com> <VA.00000768.00f859ec@thesoftwaresource.com> <200105110242.WAA26871@envy.delorie.com> <VA.00000769.012ce1e7@thesoftwaresource.com> <200105110313.XAA27108@envy.delorie.com>
X-SW-Source: 2001-q2/msg00245.html

DJ Delorie wrote:
> I don't think the user should be limited to only one cygwin install
> per machine.
>

Valid point - now back to my original question about mount points - If I 
can have multiple installs of cygwin and I change the root directory 
should we be doing anything with the files that currently exist within 
the original root directory and or that cygwin versions mount points - I 
don't think so, because now we don't know if they are creating a new 
install of cygwin or moving the old one.

All we should do is look at the root directory and our mount points 
during setup and if the root directory appears to contain a valid cygwin 
install then we simply use the mount points for our install and if a 
directory we need does not exist as a mount point or real directory we 
create it.  If the root directory specified does not appear to contain a 
valid cygwin install then we install as a new install and create the 
mount points for that new install just like we normally would.



