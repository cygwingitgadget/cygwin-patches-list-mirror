From: "Norman Vine" <nhv@cape.com>
To: "'Jason Tishler'" <Jason.Tishler@dothill.com>, "'Robert Collins'" <robert.collins@itdomain.com.au>
Cc: "'Greg Smith'" <gsmith@nc.rr.com>, <cygwin-patches@cygwin.com>
Subject: RE: Deadly embrace between pthread_cond_wait and pthread_cond_signal
Date: Tue, 26 Jun 2001 07:42:00 -0000
Message-id: <005001c0fe4c$2e2acb60$a300a8c0@nhv>
References: <20010626101032.O296@dothill.com>
X-SW-Source: 2001-q2/msg00339.html

Jason Tishler writes:
>
>Rob,
>
>On Thu, Jun 21, 2001 at 04:02:46PM -0400, Jason Tishler wrote:
>> Norman,
>> 
>
>Unfortunately I was swayed by Norman's exuberance and responded without
>actually testing myself.  I now see that Python hangs when trying to
>build the standard extension modules during the build (which uses the
>newly built python executable).  I will try to supply useful details as
>soon as I get a chance.
>
>In off-list email with Norman, it was ascertained that he is not using a
>stock Python 2.1 source tree.  Norman, feel free to supply your findings
>-- it may be helpful for Rob to track down some of the remain problems.

Hi all

Since my last correspondance with Jason I have tested this with
the 'stock'  Python-2.1 tarball and all seems to be OK

I am experiencing an occasional 'hang' in the make process
this is on WIn2k sp2 and the 'very latest' Cygwin files.
Usually a 'ctrl-C' will abort the make and a subsequent make
will  run to completion.  This make behaviour is not isolated to the
Python build but I have not been able to find a situation that will
reliably reproduce it.

Cheers

Norman
