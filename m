From: Brian Keener <bkeener@thesoftwaresource.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] setup.exe changes for Redownload/Reinstall Current version or Sources only - Part 2
Date: Thu, 10 May 2001 15:41:00 -0000
Message-id: <VA.00000766.003544d4@thesoftwaresource.com>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08EFA8@itdomain002.itdomain.net.au> <20010510005533.A12859@redhat.com> <000701c0d972$7889a680$9332273f@ca.boeing.com> <200105101705.NAA22677@envy.delorie.com>
X-SW-Source: 2001-q2/msg00232.html

DJ Delorie wrote:
> > Unless setup.exe is (re)building the mount table, I'd prefer to see
> > setup.exe honor the Cygwin mount points.
> 
> Me too, but *someone* has to write the code to do so.  Will you?
>

Let me get this straight - because of setup doing installs and updates 
and operators sometimes moving files around and not leaving them where 
setup put them ;-)  means that setup should be modified to work as 
follows:

1) new install - its current operation is exactly what it should do.

2) update to an existing installation - setup should look at the mount 
table for directories like /usr/src, /usr/lib, and /usr/bin and any 
others that might exist.  
   A) If none of these are actually part of the mount points then  
current setup operation is correct.  
   B) If they do exist as mount points then setup should install to    
the actual directory and not try to use the cygwin root plus    /usr/src 
or whatever.
   
Is this a correct assessment - I wanted to try to look at it (I think it 
may be over my head but.. ) but I wanted to make sure I understood what 
we were looking for.


