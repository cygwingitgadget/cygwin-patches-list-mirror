From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com, cygwin-apps@cygwin.com
Subject: Re: setup streams work..
Date: Sun, 11 Nov 2001 15:30:00 -0000
Message-ID: <20011111233034.GA24210@redhat.com>
References: <019d01c16a7f$ab3ee060$0200a8c0@lifelesswks>
X-SW-Source: 2001-q4/msg00197.html
Message-ID: <20011111153000.1cnAosEWgzXiiNvaKYywwsuz3iIioYev_zPYdBYbT3M@z>

On Sun, Nov 11, 2001 at 06:08:29PM +1100, Robert Collins wrote:
>So given that the class layout works, and somethings are already
>becoming easier to do, I plan to commit this to HEAD.
>
>Any objections?

It looks fine to me.

It was a little hard to tell what was changing given that you seem
to have run the sources through indent and there was some whitespace
changes.

I actually think that indent is doing the wrong thing for c++ in some
cases.

I like the idea of the io_stream a lot.  I also like the "cygfile:"
"URL".

I say go for it.

cgf
