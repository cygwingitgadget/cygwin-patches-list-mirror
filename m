From: Chris Faylor <cgf@cygnus.com>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: Files with system bit set.
Date: Mon, 08 May 2000 15:33:00 -0000
Message-id: <20000508183356.A2616@cygnus.com>
References: <3917298E.821F9CE5@vinschen.de> <20000508171856.A1920@cygnus.com> <39173153.D5468099@vinschen.de>
X-SW-Source: 2000-q2/msg00045.html

On Mon, May 08, 2000 at 11:27:47PM +0200, Corinna Vinschen wrote:
>Chris Faylor wrote:
>> 
>> Doesn't this always set errno to EINVAL?  How is that better?
>
>It's better because it's the expected behaviour for ordinary
>files. Excerpt from path_conv::check():

Ah.  Ok.  In that case, of course your patch makes sense.  I
could have figured that out for myself if I had spent another
twenty seconds looking at the code.

Please check it in.

cgf
