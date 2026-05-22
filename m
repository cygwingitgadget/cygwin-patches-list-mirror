Return-Path: <SRS0=Q8d+=DT=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo003.btinternet.com (btprdrgo003.btinternet.com [65.20.50.48])
	by sourceware.org (Postfix) with ESMTP id AC4EE4B9208E
	for <cygwin-patches@cygwin.com>; Fri, 22 May 2026 10:19:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AC4EE4B9208E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AC4EE4B9208E
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.48
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1779445169; cv=none;
	b=rzwgi11+Zo0xcazOytrT/dV/36sLhH6Ocx6b9HGL6pvjBw92ia1XUPZTorHBXPh0ax7GHws73aXRV8I8niyvj18nZuXlt4NkSptzcqohxVNOdDvPlWtUgVl6vIqfYBsZFHjteZrqI6AER+HJgnu2zyr+aDSBU76paFcxFmG4G54=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1779445169; c=relaxed/simple;
	bh=NejSOfYff6ZyAkQw49lobQKVNzPAuY0H82hL2AdO5/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=x2NV5oX1g83OodJnZa2ZqMWLMlqrnkJMHR7xj9YTjiz52/wH/iukCLBN+1cI5dBupCllQyHzr2rCVVSX73QKflELMGUqJ48P0miS3rNsbT4M2oULJfjS++QsiqxzYLEtSuxnFCIGXzjiWgVLG6BFL8qvtUCNK4bB1m3rlROAY68=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AC4EE4B9208E
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A02527800DA7B15
X-Originating-IP: [83.105.142.8]
X-OWM-Source-IP: 83.105.142.8
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTEvMmWeayvTTa7Dq5Zwz6/dua3K1fNIWpHu1Zf9YO/uTT5fdLt1IIEHL8ovidC5A5TUHcLTRNSxeGVi+T4V+K1+nEsZMgoFS/4OdLzDZh0ApeZDEq1tHYuHntk8kV0xSkSJ63syTZhiG5LyQrGR4kXF7eCWxO4Rec1SFUeqmgb1nsYBfSN7QBBxSM/f99vbjtsW14ILBXCxmldjuLT49HjtcepGXDDyD0Tm+ihwzSrKlcvCa/W4ffvE01eBr6lt1r1CAOUn6EKiwt9SvULh8ZXx0B9R0wDRR56D/9C6GXMB8GftNCPAN2s3+bOci5h7UZkuQ65LKaccZQdQsfmG1k3Pk5zd7+6WC48/A6/1VJvkokkkKZat8zwFYuTafb/6sEBBHU3C3yZZGYEzYqPwLwHy8eEur7UiERUgYW8cky2EiA0Doct4pwwZ0SibHglJD5T5wj0rNcIBEqEN8cPV1N9TW40G1K0f5NA70NkLj5Lq5OPbAMLIpeL8e1xpRFToFJhh5KMLUCu4t/csOa0msoFxqolgncryXltg/J5tHBWAWv/WlZIIeopdGzfQmw+NpgB/bIdyNK/C8InkfaWdp+TUFJ/wsbv2YZWaEsw9k3/JVid8euD1XyTHZ1Ou1fvuMhcQer+q+v9wAWNJ0LYbdxw9U2bcdNBEPgEZsMMae1iY9w
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (83.105.142.8) by btprdrgo003.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A02527800DA7B15; Fri, 22 May 2026 11:19:17 +0100
Message-ID: <e5a59828-cdab-4d8a-980c-14b52a5c0d32@dronecode.org.uk>
Date: Fri, 22 May 2026 11:19:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: Implement 'reserved' marker in fdtable entries
To: Mark Geisert <mark@maxrnd.com>
References: <https://cygwin.com/pipermail/cygwin-patches/2026q2/014989.html>
 <20260522072913.574-1-mark@maxrnd.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20260522072913.574-1-mark@maxrnd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 22/05/2026 08:28, Mark Geisert wrote:
> The existing logic for open() assumes an entry is always available in
> the fdtable for a newly-created file.  The fdtable is extended if needed
> up to OPEN_MAX in size.  Stress testing has found a situation where, if
> there is no fdtable entry available, the file is created (by Windows)
> but cannot be referenced by a Cygwin fd.
> 
> Investigation found the fdtable entry was not obtained until after low-
> level operations had been done.  If the fdtable was full, the problem
> situation occurs.  The solution is to obtain the fd earlier in open().
> 
> Then it was realized that there is no multi-thread protection of the
> fdtable entries.  The fdtable itself can be locked and unlocked, but
> the fdtable entries are either NULL (unused) or non-NULL (pointer to
> fhandler_base structure associated with that fd).
> 
> With the planned update to open(), there was now a larger timing window
> between obtaining the fdtable entry then associating the fhandler_base.
> There is no protection against another thread obtaining the same fdtable
> entry during that time.  This is true for any users of cygheap_fdnew;
> open() is just one of the syscalls that have a possibly problematic
> timing window.
> 
> This patch implements a 'reserved' marker for fdtable entries.  That
> marker is an integer value equal to the fdtable entry index.  This leads
> to localized changes in dtable.h and cygheap.h as laid out below.
> 
> The notion is that an fdtable entry provided by cygheap_fdnew is marked
> so that another thread can't obtain it.  Care is taken to reset the
> marker when the entry is no longer needed.  Actually, in the usual case
> the marker is overwritten with a pointer to an fhandler_base structure,
> by the reserving thread, as the syscall completes.
> 
> Reported-by: Christian Franke <Christian.Franke@t-online.de>
> Addresses: https://cygwin.com/pipermail/cygwin/2026-May/259664.html
> Signed-off-by: Mark Geisert <mark@maxrnd.com>
> Fixes: e859706578ba (* autoload.cc (NtCreateFile): Add.)

Thanks!

This all seems fine and reasonable, but I have a couple of small comments.

> 
> ---
>   winsup/cygwin/local_includes/cygheap.h | 31 +++++++++++++++++++++-----
>   winsup/cygwin/local_includes/dtable.h  |  4 +++-
>   winsup/cygwin/syscalls.cc              | 14 +++++-------
>   3 files changed, 35 insertions(+), 14 deletions(-)
> 
> diff --git a/winsup/cygwin/local_includes/cygheap.h b/winsup/cygwin/local_includes/cygheap.h
> index 74cfff652..1eccf6d36 100644
> --- a/winsup/cygwin/local_includes/cygheap.h
> +++ b/winsup/cygwin/local_includes/cygheap.h
> @@ -576,9 +576,13 @@ class cygheap_fdmanip
>     fhandler_base *operator -> () const {return cygheap->fdtab[fd];}
>     bool isopen () const
>     {
> -    if (cygheap->fdtab[fd])
> +    /* check fdtab entry present (i.e. non-NULL) and not a "reserved" marker */
> +    if (cygheap->fdtab[fd] && cygheap->fdtab[fd] != (fhandler_base *)(int64_t) fd)
>         return true;
> -    set_errno (EBADF);
> +    /* check fdtab entry is not present */
> +    if (cygheap->fdtab[fd] == NULL)
> +      set_errno (EBADF);
> +    /* remaining case is fdtab entry present and is a "reserved" marker */
>       return false;

Hmm.. we end up here without setting errno.  That doesn't seem right.

>     }
>   };
> @@ -595,7 +599,11 @@ class cygheap_fdnew : public cygheap_fdmanip
>       else
>         fd = cygheap->fdtab.find_unused_handle (seed_fd + 1);
>       if (fd >= 0)
> -      locked = lockit;
> +      {
> +        locked = lockit;
> +        /* mark as "reserved" for open(), or other syscall, in progress */
> +        cygheap->fdtab[fd] = (fhandler_base *)(int64_t) fd;

So, we're already relying on "a small integer cast to pointer can't 
collide with an actual pointer value we might get" (which is fine).

But then there's no reason why we can't use a distinct constant (like 1 
or -1), to indicate a reserved slow throughout, which would make this 
easier to understand?

> +      }
>       else
>         {
>   	/* errno set by find_unused_handle */
> @@ -607,7 +615,18 @@ class cygheap_fdnew : public cygheap_fdmanip
>     ~cygheap_fdnew ()
>     {
>       if (cygheap->fdtab[fd])
> -      cygheap->fdtab[fd]->inc_refcnt ();
> +      {
> +        /* check if fdtab entry is a "reserved" marker */
> +        if (cygheap->fdtab[fd] == (fhandler_base *)(int64_t) fd)
> +          {
> +            /* remove "reserved" marker */
> +            cygheap->fdtab.lock ();
> +            cygheap->fdtab[fd] = NULL;
> +            cygheap->fdtab.unlock ();
> +          }
> +        else
> +          cygheap->fdtab[fd]->inc_refcnt ();
> +      }
>     }
>     void operator = (fhandler_base *fh) {cygheap->fdtab[fd] = fh;}
>   };
> @@ -620,7 +639,9 @@ public:
>     {
>       if (lockit)
>         cygheap->fdtab.lock ();
> -    if (fd >= 0 && fd < (int) cygheap->fdtab.size && cygheap->fdtab[fd] != NULL)
> +    /* this is similar to ::isopen() above, but doesn't set_errno() on fail */
> +    if (fd >= 0 && fd < (int) cygheap->fdtab.size && cygheap->fdtab[fd] &&
> +	cygheap->fdtab[fd] != (fhandler_base *)(int64_t) fd)
>         {
>   	this->fd = fd;
>   	locked = lockit;
> diff --git a/winsup/cygwin/local_includes/dtable.h b/winsup/cygwin/local_includes/dtable.h
> index 7803fae1b..a434554fb 100644
> --- a/winsup/cygwin/local_includes/dtable.h
> +++ b/winsup/cygwin/local_includes/dtable.h
> @@ -51,7 +51,9 @@ public:
>     inline int not_open (int fd)
>     {
>       lock ();
> -    int res = fd < 0 || fd >= (int) size || fds[fd] == NULL;
> +    /* treat fds entry marked "reserved" same as not present fds entry */
> +    int res = fd < 0 || fd >= (int) size ||
> +              fds[fd] == NULL || fds[fd] == (fhandler_base *)(int64_t) fd;
>       unlock ();
>       return res;
>     }
> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> index 7a8e5d4fd..e42771c18 100644
> --- a/winsup/cygwin/syscalls.cc
> +++ b/winsup/cygwin/syscalls.cc
> @@ -1460,6 +1460,12 @@ open (const char *unix_path, int flags, ...)
>   
>     __try
>       {
> +      /* try to reserve a new fd now rather than later in this block */

Uh, this comment could say that why we do this. I guess because that's 
because we're going to fail here if we've already hit the OPEN_MAX limit?

> +      cygheap_fdnew fd;
> +
> +      if (fd < 0)
> +        __leave;		/* errno already set */
> +
>         syscall_printf ("open(%s, %y)", unix_path, flags);
>         if (!*unix_path)
>   	{
> @@ -1573,14 +1579,6 @@ open (const char *unix_path, int flags, ...)
>   	try_to_bin (fh->pc, fh->get_handle (), DELETE,
>   		    FILE_OPEN_FOR_BACKUP_INTENT);
>   
> -      cygheap_fdnew fd;
> -
> -      if (fd < 0)
> -	{
> -	  fh->close();
> -	  __leave;		/* errno already set */
> -	}
> -
>         fd = fh;
>         if (fd <= 2)
>   	set_std_handle (fd);



