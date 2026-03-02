Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 85BD04BA23C3; Mon,  2 Mar 2026 19:52:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 85BD04BA23C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1772481160;
	bh=vVXegtz79QV/0KJlDO0zG6p9fH0SOEEdm7G5EJlIvPk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=o9J09E7BIK5Lu2OkSps7pkyOv9I2Hk3WLIvgceNLcCxSQre/oV9S6Gk8AoV0ER+dT
	 6dXdsyzhXd4Ccpekc1QYSDuepnOTGGButPv3i0YJfBNMUPSwFYrLPzYFsTpA4ns392
	 6hir7GFkce5brGbQuLblN1MBi6dItYKdu5AuFIJk=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 938E8A80886; Mon, 02 Mar 2026 20:52:38 +0100 (CET)
Date: Mon, 2 Mar 2026 20:52:38 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Igor Podgainoi <Igor.Podgainoi@arm.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>,
	nd <nd@arm.com>
Subject: Re: [PATCH] Cygwin: open: Fix Windows resource leak after fd
 exhaustion
Message-ID: <aaXqhqYCVJcskPMt@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Igor Podgainoi <Igor.Podgainoi@arm.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>,
	nd <nd@arm.com>
References: <aZWJymeR-iwCYR1p@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZWJymeR-iwCYR1p@arm.com>
List-Id: <cygwin-patches.cygwin.com>

On Feb 18 09:43, Igor Podgainoi wrote:
> In a specific rare case when a Cygwin process runs out of available
> file descriptor numbers (errno set to EMFILE), the underlying Windows
> HANDLE is not being closed. This is partly because currently the given
> file is first opened natively before a new Cygwin file descriptor has
> been assigned - the logic overlooks the fact that it is possible for
> the Windows HANDLE to be valid, but not the internal fd.
> 
> Even though the object is explicitly freed from memory later using
> operator delete, the fhandler_disk_file class has no destructor
> defined to mitigate the leak.
> 
> This patch introduces a manual call to fh->close() if the assigned fd
> value returned by the operator int &() function in the cygheap_fdnew
> class is less than 0.
> 
> Test fixed on AArch64 and x86_64:
> winsup.api/ltp/dup03.exe
> 
> Signed-off-by: Igor Podgainoi <Igor.Podgainoi@arm.com>
> ---
>  winsup/cygwin/syscalls.cc | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> index 1b1ff17b0..7a8e5d4fd 100644
> --- a/winsup/cygwin/syscalls.cc
> +++ b/winsup/cygwin/syscalls.cc
> @@ -1576,7 +1576,10 @@ open (const char *unix_path, int flags, ...)
>        cygheap_fdnew fd;
>  
>        if (fd < 0)
> -	__leave;		/* errno already set */
> +	{
> +	  fh->close();
> +	  __leave;		/* errno already set */
> +	}
>  
>        fd = fh;
>        if (fd <= 2)
> -- 
> 2.43.0

Pushed.

Thanks,
Corinna
