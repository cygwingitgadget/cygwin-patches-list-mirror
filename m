Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id F27C43942014
 for <cygwin-patches@cygwin.com>; Fri, 12 Feb 2021 09:20:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org F27C43942014
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MQ5aw-1lWRJo0UWO-00M509 for <cygwin-patches@cygwin.com>; Fri, 12 Feb 2021
 10:20:24 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id AD097A80D37; Fri, 12 Feb 2021 10:20:23 +0100 (CET)
Date: Fri, 12 Feb 2021 10:20:23 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: Have tmpfile(3) use O_TMPFILE
Message-ID: <20210212092023.GH4251@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210211065306.457-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210211065306.457-1-mark@maxrnd.com>
X-Provags-ID: V03:K1:I1yVSkKHHagK8i9iDpQ4PoC3uV103CaWKuOVx1dEOm3Et+hF5kq
 7/OJ4SFWDN0JkaZFzEzjEMh7/jiZcOM0qJf6OuwSLaYkfm5GbnT/0z4XjAC4s+NAq/59T17
 rJOxdgdTzU68nz7Q5uFdBmgfwjQOUoZ2ihTybyVw7OthmuxKHbRBi5JjsJj+MS7Z2bx2VeC
 mpbwhPaDmTprrGc/HlXAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ze61/rn0tl0=:KiT54RqqFwHu32HqjrDSc6
 t0v6JH/M87TBI2xN1/5EhYxFb8z/l5vBTLF4d/LOP9bnccnkUzkh8QD08Nqndzvyo9xcoWGy7
 i3PbaX/2SB6ww3OD3vVo5adX0lF1w1nkiFi2CD8U3hWISdu1HFkaL3ruad4m1pOp20Yb3NFAE
 nRm+/kdnL4KEvZP9nm8H7MzKjtszvbqfgy6GsGQzZu9nRIkMsJFwF/sl8PUwLbYdpxQOlvQVl
 bVn1cifaXdsrzwbahynjZIGtwhcIdj8wxGm8UPaHqUqvzCb782Xom0DkfAYM73oVFfAfy01+w
 hQZdFZe5sXwdtEGpf2iIr2AA52rPomfh3YcSuZrK17rIk+FmmkmciJWM6Y7YgIKeoXI+VIQ4o
 9bmhTKbWbdsUsp+sf2pufAVluq1PlJbIejXPgvKpqXs1F+y0QJGGlMaRKGUfkR0of/k5A9cPV
 g7yQKJov1Q==
X-Spam-Status: No, score=-107.3 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Fri, 12 Feb 2021 09:20:27 -0000

On Feb 10 22:53, Mark Geisert wrote:
> Per discussion on cygwin-developers, a Cygwin tmpfile(3) implementation
> has been added to syscalls.cc.  This overrides the one supplied by
> newlib.  Then the open(2) flag O_TMPFILE was added to the open call that
> tmpfile internally makes.
> 
> This v2 patch removes O_CREAT from open() call as O_TMPFILE obviates it.
> Note that open() takes a directory's path but returns an fd to a file.
> ---
>  winsup/cygwin/release/3.2.0 |  4 ++++
>  winsup/cygwin/syscalls.cc   | 17 +++++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/winsup/cygwin/release/3.2.0 b/winsup/cygwin/release/3.2.0
> index f748a9bc8..d02d16863 100644
> --- a/winsup/cygwin/release/3.2.0
> +++ b/winsup/cygwin/release/3.2.0
> @@ -19,6 +19,10 @@ What changed:
>  
>  - A few FAQ updates.
>  
> +- Have tmpfile(3) make use of Win32 FILE_ATTRIBUTE_TEMPORARY via open(2)
> +  flag O_TMPFILE.
> +  Addresses: https://cygwin.com/pipermail/cygwin/2021-January/247304.html
> +
>  
>  Bug Fixes
>  ---------
> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> index 52a020f07..4cda69033 100644
> --- a/winsup/cygwin/syscalls.cc
> +++ b/winsup/cygwin/syscalls.cc
> @@ -5225,3 +5225,20 @@ pipe2 (int filedes[2], int mode)
>    syscall_printf ("%R = pipe2([%d, %d], %y)", res, read, write, mode);
>    return res;
>  }
> +
> +extern "C" FILE *
> +tmpfile (void)
> +{
> +  char *dir = getenv ("TMPDIR");
> +  if (!dir)
> +    dir = P_tmpdir;
> +  int fd = open (dir, O_RDWR | O_BINARY | O_TMPFILE, S_IRUSR | S_IWUSR);
> +  if (fd < 0)
> +    return NULL;
> +  FILE *fp = fdopen (fd, "wb+");
> +  int e = errno;
> +  if (!fp)
> +    close (fd); // ..will remove tmp file
> +  set_errno (e);
> +  return fp;
> +}

The patch was missing the EXPORT_ALIAS for tmpfile64, as outlined in
https://cygwin.com/pipermail/cygwin-developers/2021-February/012039.html
I added this to the patch and pushed it.

Thanks,
Corinna
