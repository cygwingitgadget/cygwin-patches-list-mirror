From: Chris Faylor <cgf@cygnus.com>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: [PATCH]: uinfo.cc or "all commands start soooooow slow"
Date: Wed, 21 Jun 2000 20:38:00 -0000
Message-id: <20000621233805.C26676@cygnus.com>
References: <20000622030046.25151.qmail@web124.yahoomail.com>
X-SW-Source: 2000-q2/msg00111.html

On Wed, Jun 21, 2000 at 08:00:46PM -0700, Earnie Boyd wrote:
>--- Corinna Vinschen <corinna@vinschen.de> wrote:
>> I have found that on NT/W2K systems that functions are called,
>> regardless of the ntsec setting. My patch fixes that.
>> 
>
>Yep, sure did.  Thanks for the patch.  I've just tested this with my laptop
>unplugged from the domain controller.  Much improved.  Do I hear a cygwin-1.1.3
>in the near future?

Corinna has asked me for this too.  Except for this one problem things have been
so nice and quiet I'm really loath to release it, but I guess it does make
sense.

It looks like the version will have to be 1.1.4 since Cygnus has released
a version 1.1.3 to a customer and I'd rather not cause any confusion like
this.

cgf
