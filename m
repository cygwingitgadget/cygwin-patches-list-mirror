From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Console codepage
Date: Sun, 08 Apr 2001 17:47:00 -0000
Message-id: <20010408204737.B23313@redhat.com>
References: <u7l3fv26h.fsf@mail.epost.de> <20010128154852.A20701@redhat.com> <m3hezz8o0c.fsf@benny-ppc.crocodial.de> <20010408144157.A30790@redhat.com>
X-SW-Source: 2001-q2/msg00016.html

On Sun, Apr 08, 2001 at 02:41:58PM -0400, Christopher Faylor wrote:
>On Sun, Apr 08, 2001 at 04:28:03PM +0200, Benjamin Riefenstahl wrote:
>>Christopher Faylor <cgf@redhat.com> writes:
>>> [...] If you could send an assignment form, too, that would help
>>> make sure that the legalities are covered.
>>
>>I got the reply to the assignment form last week.  Thanks for the
>>T-shirt, I didn't expect that ;-)
>>
>>
>>I checked the CVS source and noticed that my patch did not get applied
>>yet.  Did it just fall between the cracks or are there still problems
>>with it?
>
>The patch doesn't get installed until I hear that the assignment has
>gone through.  I'll look at this now.

I've installed a variation of this patch.  I eliminated the method
call in favor of just directly using str_to_con.

I also did a fair amount of coding style cleanup on this and reformatted
the ChangeLog, as previously indicated.

I made enough changes that this needs to be retested.  I'd appreciated
it if everyone who gave this thumbs up before (Kazuhiro and Egor?) would
test this again.

Thanks,
cgf
