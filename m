From: Brian Keener <bkeener@thesoftwaresource.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] setup.exe changes for Redownload/Reinstall Current version or Sources only - Part 2
Date: Thu, 10 May 2001 20:12:00 -0000
Message-id: <VA.00000769.012ce1e7@thesoftwaresource.com>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08EFA8@itdomain002.itdomain.net.au> <20010510005533.A12859@redhat.com> <000701c0d972$7889a680$9332273f@ca.boeing.com> <200105101705.NAA22677@envy.delorie.com> <VA.00000766.003544d4@thesoftwaresource.com> <200105102332.TAA25548@envy.delorie.com> <VA.00000768.00f859ec@thesoftwaresource.com> <200105110242.WAA26871@envy.delorie.com>
X-SW-Source: 2001-q2/msg00239.html

DJ Delorie wrote:
> Setup is a cygwin setup program, not a bash setup program.  If you ask
> it to install cygwin in a different place, and don't select anything
> but bash, you get a default cygwin installation with just bash.  That
> includes the mount table configuration.
>
Oh I know :-), I was just pointing out that we are throwing the confusion 
in another direction.  If all I am doing is updating my installation for 
updated packages and setup is changing mount points and I changed the 
root directory for whatever reason - We now have a far bigger mess than 
the fact we might have put files where we shouldn't have. 

I really believe (but I yield to those that know better than I) that the 
root directory input should be disabled and setup attempt to follow the 
mount points if it is found that the root directory appears to contain a 
valid cygwin install.  A full uninstall must be performed to reenable the 
root directory input.  If it appears to be a new install (ie root 
directory doesn't exist, /etc/setup/installed.db doesn't exists, 
whatever) then root directory is allowed to be input and the mount points 
are constructed as they have been.

bk

