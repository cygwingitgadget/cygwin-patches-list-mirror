From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Corinna Vinschen" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Re: pthread -- Corinna?
Date: Tue, 17 Apr 2001 05:10:00 -0000
Message-id: <00f501c0c737$54ccf1e0$0200a8c0@lifelesswks>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF79C0@itdomain002.itdomain.net.au> <20010417005137.A26463@redhat.com> <20010417122126.A12559@cygbert.vinschen.de> <009d01c0c729$68fe0b80$0200a8c0@lifelesswks> <20010417140502.F12559@cygbert.vinschen.de>
X-SW-Source: 2001-q2/msg00096.html

----- Original Message -----
From: "Corinna Vinschen" <cygwin-patches@cygwin.com>
To: "cygpat" <cygwin-patches@cygwin.com>; <cygwin-xfree@cygwin.com>
Sent: Tuesday, April 17, 2001 10:05 PM
Subject: Re: [PATCH] Re: pthread -- Corinna?


> On Tue, Apr 17, 2001 at 08:30:11PM +1000, Robert Collins wrote:
> > From: "Corinna Vinschen" <cygwin-patches@cygwin.com>
> When I changed the code in passwd.cc and grp.cc once, I was annoyed
> about the usage of fopen in these internal functions. However, I
> didn't change it due to the usage of fgets(). I'm pretty sure
> it would be better to use CreateFile/ReadFile/CloseHandle in
> read_etc_...() than high-level libc functions. This would drop the
> need for the ..._sem variables once and for all. No open(), no
> ntsec, no recursion. It only would have to care for line endings
> by itself.
>

Sounds good to me. I'll bow out of this, my main goal was to get a
thread safe _r set of functions, and as the recursion issue is
separate...

Rob
