Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id ECE393858433; Wed, 23 Jul 2025 08:38:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org ECE393858433
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1753259881;
	bh=n2fIUJW+A1vxGHFRA9LH1tuyPz4f0rustue3IJ2q8zk=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=Zzkrfdd6g+fMU+DxQhWMAyoKyLbiSr3JyojnBqdnP8En6XIL2BXmGJMfynhLCRSqO
	 g0jOry8pwPKS6Qc7VyQAaLEhb5KNmnKhejDCLjk9e38IQAA0wMBkznw9n/SjbxycSC
	 JdMw1V2K5siMRw9muexTd8hzdo8CfeBHQjUkPPC4=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 2DFF8A80CF9; Wed, 23 Jul 2025 10:38:00 +0200 (CEST)
Date: Wed, 23 Jul 2025 10:38:00 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v7 0/3] Make system() thread-safe
Message-ID: <aICfaJhv1HO5iMjv@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250722121032.4755-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722121032.4755-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Jul 22 21:10, Takashi Yano wrote:
> v2: Introduce init_cygheap::lock/unlock
> v3: Separate init_cygheap::lock/unlock patch and spawn patch
> v4: Inline init_cygheap::lock/unlock
> v5: Lock cygheap only when iscygwin() case
> v6: Introduce spawn_cygheap_lock/unlock
>     Call another child_info_spawn constructor for local ch_spawn
> v7: Instead of v5, move close_all_files() to outside of locked region
> 
> Takashi Yano (3):
>   Cygwin: cygheap: Add lock()/unlock() method
>   Cygwin: spawn: Lock cygheap from refresh_cygheap() until child_copy()
>   Cygwin: spawn: Make system() thread-safe
> 
>  winsup/cygwin/local_includes/cygheap.h |  5 +++++
>  winsup/cygwin/mm/cygheap.cc            | 12 ++++++------
>  winsup/cygwin/spawn.cc                 | 15 +++++++++------
>  winsup/cygwin/syscalls.cc              |  5 +++--
>  4 files changed, 23 insertions(+), 14 deletions(-)
> 
> -- 
> 2.45.1

LGTM

Thanks,
Corinna
