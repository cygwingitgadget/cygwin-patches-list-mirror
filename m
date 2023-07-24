Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id D44853858C5E; Mon, 24 Jul 2023 15:21:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D44853858C5E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1690212086;
	bh=hdyeeY6TWN9yzypSrWcT9ehxg6z0WrUHBaiGntohFRk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=bTLV0bCEt9VfUEYmkWCENgIM73vTEYeavoybxVJKE837l9ve4QaMmV4xFoS7njluT
	 P1o7PewuVzbEtmDUMuxrdxUq6bIgX4Z5G7+sF2aC9weEeWR2v/Jf48anPgsJ1sGWjw
	 ktzEBBZke7EQftLoJ4jp2xQxPDJziJ4B2RCX8o5g=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 2ED19A80D4E; Mon, 24 Jul 2023 17:21:24 +0200 (CEST)
Date: Mon, 24 Jul 2023 17:21:24 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/5] Fix AT_EMPTY_PATH handling
Message-ID: <ZL6W9M4TXFv3Igcy@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Johannes Schindelin <johannes.schindelin@gmx.de>,
	cygwin-patches@cygwin.com
References: <20230712120804.2992142-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230712120804.2992142-1-corinna-cygwin@cygwin.com>
List-Id: <cygwin-patches.cygwin.com>

Johannes? Ping?

On Jul 12 14:07, Corinna Vinschen wrote:
> From: Corinna Vinschen <corinna@vinschen.de>
> 
> The GLIBC extension AT_EMPTY_PATH allows the functions fchownat
> and fstatat to operate on dirfd alone, if the given pathname is an
> empty string.  This also allows to operate on any file type, not
> only directories.
> 
> Commit fa84aa4dd2fb4 broke this.  It only allows dirfd to be a
> directory in calls to these two functions.
> 
> Fix that by handling AT_EMPTY_PATH right in gen_full_path_at.
> A valid dirfd and an empty pathname is now a valid combination
> and, noticably, this returns a valid path in path_ret.  That
> in turn allows to remove the additional path generation code
> from the callers.
> 
> Fixes: fa84aa4dd2fb ("Cygwin: fix errno values set by readlinkat")
> Reported-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
> 
> Corinna Vinschen (5):
>   Cygwin: gen_full_path_at: drop never reached code
>   Define _AT_NULL_PATHNAME_ALLOWED
>   Cygwin: use new _AT_NULL_PATHNAME_ALLOWED flag
>   Cygwin: Fix and streamline AT_EMPTY_PATH handling
>   Cygwin: add AT_EMPTY_PATH fix to release message
> 
>  newlib/libc/include/sys/_default_fcntl.h | 11 +++--
>  winsup/cygwin/release/3.4.8              |  4 ++
>  winsup/cygwin/syscalls.cc                | 61 ++++++------------------
>  3 files changed, 25 insertions(+), 51 deletions(-)
> 
> -- 
> 2.40.1
