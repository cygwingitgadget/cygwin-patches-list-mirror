From: Vadim Egorov <egorovv@mailandnews.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: Re: [egorovv@mailandnews.com: inet_network]
Date: Wed, 19 Apr 2000 12:49:00 -0000
Message-id: <itygkq3z.fsf@mailandnews.com>
References: <20000419134603.A15867@cygnus.com> <200004191752.NAA03943@envy.delorie.com> <20000419135549.D15867@cygnus.com> <200004191757.NAA03992@envy.delorie.com>
X-SW-Source: 2000-q2/msg00014.html

DJ Delorie <dj@delorie.com> writes:

> > LoadDLLFunc should actually abort the process if it can't load the function.
> 
> Then we shouldn't use it for an undocumented function, which may not
> be available in all versions of winsock.

First, I'll try to check as much as possible wsock32.dll versions as possible 
-- especially the earliest one --  to see if any of them are missing this entry. 

Next, it's certanly possible to use raw LoadLibrary/GetProcAddress API to achieve
the same thing plus gracefuuly handling the worst case.

One more way is to borow it -- glibc contains quite compact and independent one -- 
though I'm not quite sure about cygwin policy in this respect. 


-----
Regards,
Vadim

