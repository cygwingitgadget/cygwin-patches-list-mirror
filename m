From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
Subject: Re: Cygwin half of pthread update
Date: Wed, 11 Apr 2001 21:06:00 -0000
Message-id: <05df01c0c305$d4bef0f0$0200a8c0@lifelesswks>
References: <03f001c0c2ed$3b89acd0$0200a8c0@lifelesswks> <20010411232520.C32524@redhat.com>
X-SW-Source: 2001-q2/msg00037.html

----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>
To: <cygwin-patches@cygwin.com>
Sent: Thursday, April 12, 2001 1:25 PM
Subject: Re: Cygwin half of pthread update


> On Thu, Apr 12, 2001 at 11:09:31AM +1000, Robert Collins wrote:
> >Ok, this is a bug one. I really really really hope I've got the
> >ChangeLog correct!
> >
> >The standard GPL warning applies to this contrib:
> >no warranty.
> >All care no responsibility :]
>
> The ChangeLog is a little off.  You don't have to document every
export.
> Just do something like:
>
> * cygwin.din: Remove @PTH_ALLOW@ prefixes to pthread functions.  Add
> new pthread exports.
>
> The pthread.cc, sched.cc, thread.cc, thread.h, include/* entries are
all
> missing the leading '* ' prior to the filenames.
>
> Also don't mention that you ran indent.  IMO, that's irrelevant.
>
> Once you fix up these issues in the ChangeLog, go ahead and "cvs
commit"
> this.  I just checked and you should already have permission to do
this.
>
> I didn't look closely at the patch, but I realized, as I was heading
off
> to bead, that you were 12 hours out of sync with me, so I should take
a
> look at what you'd done or we'd lose a day.
>
> If there are issues we can fine tune them tomorrow.
>
> Thanks,
> cgf
>

Committed.

Thanks,
Rob
