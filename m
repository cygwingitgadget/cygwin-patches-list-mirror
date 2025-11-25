Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 195A43858039; Tue, 25 Nov 2025 15:14:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 195A43858039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1764083647;
	bh=WMUjaBySArTc4mYw4VKi89AaAwK/m88aR7DODYCtpbI=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=M2OSAhF8Abid64GDNS18+wIX5h5odP1SJItrHUGcIbw+DuA83nlDT3TM+xQ6BB7iQ
	 22zjxxoE+a5nhyomtbH4SP+4+i+NRiL25iH/1sNyGHyCadwxU8uQwX5vzdlzhbLjFp
	 MMzTSCqwONWQo4whJL60r/7ZAWbrrQamadNO6v6A=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 38EB6A80556; Tue, 25 Nov 2025 16:14:05 +0100 (CET)
Date: Tue, 25 Nov 2025 16:14:05 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4] Cygwin: flock: allocate i_all_lf as static array
Message-ID: <aSXHvc1WqAc3KfRG@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20251125144924.2050628-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251125144924.2050628-1-corinna-cygwin@cygwin.com>
List-Id: <cygwin-patches.cygwin.com>

On Nov 25 15:49, Corinna Vinschen wrote:
> @@ -285,7 +288,9 @@ class inode_t
>    public:
>      LIST_ENTRY (inode_t) i_next;
>      lockf_t		*i_lockf;  /* List of locks of this process. */
> -    lockf_t		*i_all_lf; /* Temp list of all locks for this file. */
> +				   /* list of all locks for this file. */
> +    lockf_t		*i_all_lf;
> +    lockf_t		 i_all[MAX_LOCKF_CNT];
>  
>      dev_t		 i_dev;    /* Device ID */
>      ino_t		 i_ino;    /* inode number */

One more change: i_all should be moved to the end of the member list and
be private.  I fixed that locally.


Sorry,
Corinna
