From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] settimeofday ... attempt 2
Date: Mon, 26 Feb 2001 16:10:00 -0000
Message-id: <20010226190940.C6209@redhat.com>
References: <20010219093133.F16141@moria.simons-clan.com> <20010219215508.C23483@redhat.com> <20010221021420.G16141@moria.simons-clan.com>
X-SW-Source: 2001-q1/msg00116.html

I applied this, but I have to point out that it didn't compile as is
due to this line:

>+  syscall_printf ("%d = settimeofday (%x, %x)", res, p, z);
						       ^  ^

Neither of these was defined.  I changed this line to use the obvious.

>- diff -up
>
>  nope: sent diff -u.  However, I can see no differnces between the
>  two diffs for this patch.

The man page for diff should help show you what -p does.  It provides
the name of the function being changed in the diff output.  Your previous
patch lacked this.

Thanks for the contribution.  It is much appreciated.

cgf
