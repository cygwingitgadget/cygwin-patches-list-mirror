From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] setup.exe: Stop NetIO_HTTP from treating entire stream as a  header
Date: Tue, 27 Nov 2001 15:09:00 -0000
Message-ID: <20011127230925.GA5830@redhat.com>
References: <3C035977.BF151D0A@syntrex.com> <000601c17772$7c5ecfd0$2101a8c0@d8rc020b> <20011127184223.GA24028@redhat.com> <1006899141.2048.2.camel@lifelesswks>
X-SW-Source: 2001-q4/msg00260.html
Message-ID: <20011127150900.8FQscBBjs4Xg-jYM7ltt5fUI3kNCphPjbIxxw64opjo@z>

On Wed, Nov 28, 2001 at 09:12:20AM +1100, Robert Collins wrote:
>On Wed, 2001-11-28 at 05:42, Christopher Faylor wrote:
>
>> >Ah, better yet.  Jeez you guys are clever ;-).  But how about we make it:
>> >
>> >	while (((l = s->gets ()) != 0) && (*l != '\0'))
>> >
>> >in the interest of making it a bit more self-documenting?
>> 
>> Actually, how about not using != 0.  Use NULL in this context.
>> 
>> I don't think that *l is hard to understand, fwiw.
>
>I think *l is ok. As for 0 vs NULL, in C++ NULL is deprecated, 0 is the
>correct test for an invalid pointer.

References?  A simple google search for 'NULL C++ deprecated' didn't
unearth this information.

Regardless, I strenuously disagree with this.  It certainly is not
deprecated in the Cygwin DLL.

cgf
