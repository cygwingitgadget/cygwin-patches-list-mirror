From: Christopher Faylor <cgf@redhat.com>
To: Christopher Faylor <cygwin-patches@cygwin.com>
Subject: Re: SYSTEMROOT, SYSTEMDRIVE
Date: Thu, 10 May 2001 20:31:00 -0000
Message-id: <20010510232935.A23432@redhat.com>
References: <20010508001319.A16059@redhat.com> <8111460809.20010508190550@logos-m.ru> <12720489682.20010509223903@logos-m.ru> <20010509162006.C2089@redhat.com> <8973604858.20010510132418@logos-m.ru>
X-SW-Source: 2001-q2/msg00241.html

On Thu, May 10, 2001 at 01:24:18PM +0400, egor duda wrote:
>you're right. always calling GetEnvironmentVariable is a waste of
>time. i've changed my patch to 
>
>- avoid repeated scanning of forced env vars list.
>- look into native environment only when needed.
>- don't truncate forced vars values to MAX_PATH symbols.

This still wasn't quite what I had envisioned.  I checked in a patch
that combines your code with my conception of what needed to be done.

My patch is probably slower than yours but it is quite a bit more
compact.

Thanks.
cgf
