From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] setup.exe changes for Redownload/Reinstall Current version or Sources only - Part 2
Date: Fri, 11 May 2001 13:05:00 -0000
Message-id: <20010511160353.B26223@redhat.com>
References: <000701c0d972$7889a680$9332273f@ca.boeing.com> <200105101705.NAA22677@envy.delorie.com> <VA.00000766.003544d4@thesoftwaresource.com> <200105102332.TAA25548@envy.delorie.com> <VA.00000768.00f859ec@thesoftwaresource.com> <200105110242.WAA26871@envy.delorie.com> <VA.00000769.012ce1e7@thesoftwaresource.com> <200105110313.XAA27108@envy.delorie.com> <VA.0000076b.006f522f@thesoftwaresource.com>
X-SW-Source: 2001-q2/msg00247.html

On Fri, May 11, 2001 at 03:45:21PM -0400, Brian Keener wrote:
>DJ Delorie wrote:
>> I don't think the user should be limited to only one cygwin install
>> per machine.
>
>Valid point - now back to my original question about mount points - If I 
>can have multiple installs of cygwin and I change the root directory 
>should we be doing anything with the files that currently exist within 
>the original root directory and or that cygwin versions mount points - I 
>don't think so, because now we don't know if they are creating a new 
>install of cygwin or moving the old one.
>
>All we should do is look at the root directory and our mount points 
>during setup and if the root directory appears to contain a valid cygwin 
>install then we simply use the mount points for our install and if a 
>directory we need does not exist as a mount point or real directory we 
>create it.  If the root directory specified does not appear to contain a 
>valid cygwin install then we install as a new install and create the 
>mount points for that new install just like we normally would.

I have modified setup.exe to honor existing mount points.

If there are no mount points then setup.exe will use the same procedure
as previously.

There is no need to run a heuristic analysis on the root directory to
see if there is a "valid" installation there.  The user can install as
much or as little as they want.  They can have no root mount but a
/usr/lib mount.  In that case, we'll create a new root but install
/usr/lib files where the mount points.  We just honor whatever they are
using.

cgf
