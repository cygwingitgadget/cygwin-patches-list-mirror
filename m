From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sources.redhat.com
Subject: Re: memory leaks in cygheap
Date: Wed, 13 Sep 2000 12:59:00 -0000
Message-id: <20000913155809.A26505@cygnus.com>
References: <19119861671.20000913214625@logos-m.ru>
X-SW-Source: 2000-q3/msg00087.html

On Wed, Sep 13, 2000 at 09:46:25PM +0400, Egor Duda wrote:
>  running  "gcc -c *.c" in dir with lots of *.c files causes
>api_fatal ("couldn't commit memory for cygwin heap")
>
>looks  like  not  all  memory allocated on cygheap got freed. attached
>patch fixes this.

Thanks.  I've checked in your changes.

I've also made some modifications to the 'av' class since I didn't like
the fact that calloced needed to be manipulated by people using the
method.

cgf
