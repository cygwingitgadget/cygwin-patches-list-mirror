From: Brian Keener <bkeener@thesoftwaresource.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] setup.exe changes for Redownload/Reinstall Current version or Sources only - Part 2
Date: Thu, 10 May 2001 19:14:00 -0000
Message-id: <VA.00000768.00f859ec@thesoftwaresource.com>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08EFA8@itdomain002.itdomain.net.au> <20010510005533.A12859@redhat.com> <000701c0d972$7889a680$9332273f@ca.boeing.com> <200105101705.NAA22677@envy.delorie.com> <VA.00000766.003544d4@thesoftwaresource.com> <200105102332.TAA25548@envy.delorie.com>
X-SW-Source: 2001-q2/msg00237.html

DJ Delorie wrote:
> /  c:/cygwin
>  /usr/src c:/cygwin/src
> 
> Now, if we install cygwin in d:/cygwin, what do we do with the
> existing /usr/src mount?  I claim we should replace it with
> d:/cygwin/src because it pointed to the old root.  However, consider:
>
Okay, I didn't think of that scenario but now lets really compound this - 
I am only updating my installation of bash and yet it asks me for the 
root directory and I change it from as you said c:/cygwin to d:/cygwin - 
are we saying that at this point that setup is going to go and move the 
entire installation of cygwin from the c drive to the d drive.  I think 
that this is way beyond the bounds of what setup should be expected to do 
and comes back to a little common sense on the part of the user.


