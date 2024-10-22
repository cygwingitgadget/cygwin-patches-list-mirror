Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 1ACE33858D20; Tue, 22 Oct 2024 14:47:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1ACE33858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1729608466;
	bh=a4Vk4b9gS22tNVNtT6olrL3WvsPS+lQafylZx+cCvpM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=sMTDu/9mfox8clBVF+6wQWSACVkqbgRILMWuLiHWyWAUr0Db3pVxOKz978C6wZ1OL
	 XueKXRVb02CiraULUxhwgdaUGSI/dCWrO+8iEdWQNRn7NV2frdQBN1nLx4JeuXKoS5
	 /UzEHiqhwz3++uzHuOv5CmdTaFGOHDPk7fL13QZI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id EF4DAA80420; Tue, 22 Oct 2024 16:47:43 +0200 (CEST)
Date: Tue, 22 Oct 2024 16:47:43 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Christian Franke <Christian.Franke@t-online.de>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin: pread/pwrite: prevent EBADF error after fork()
Message-ID: <Zxe7D_8yo05dgxZ2@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Christian Franke <Christian.Franke@t-online.de>,
	cygwin-patches@cygwin.com
References: <9ef0c0ee-23fd-e74e-a925-2d7f973151b2@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9ef0c0ee-23fd-e74e-a925-2d7f973151b2@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

Hi Christian,

On Sep 24 12:09, Christian Franke wrote:
> This addresses:
> https://sourceware.org/pipermail/cygwin/2024-September/256468.html
> 
> -- 
> Regards,
> Christian
> 

Cool. Can you please add a matching entry to release/3.5.5?

Thanks,
Corinna


> From a688e962eb493140010a75dc24b6b49b34b7d558 Mon Sep 17 00:00:00 2001
> From: Christian Franke <christian.franke@t-online.de>
> Date: Tue, 24 Sep 2024 11:56:43 +0200
> Subject: [PATCH] cygwin: pread/pwrite: prevent EBADF error after fork()
> 
> If the parent process has already used pread() or pwrite(), these
> functions fail with EBADF if used on the inherited fd.  Ensure that
> fix_after_fork() is called to invalidate the prw_handle. This issue
> has been detected by 'stress-ng --pseek 1'.
> 
> Signed-off-by: Christian Franke <christian.franke@t-online.de>
> ---
>  winsup/cygwin/fhandler/disk_file.cc | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/winsup/cygwin/fhandler/disk_file.cc b/winsup/cygwin/fhandler/disk_file.cc
> index f4c21d3b7..2008fb61b 100644
> --- a/winsup/cygwin/fhandler/disk_file.cc
> +++ b/winsup/cygwin/fhandler/disk_file.cc
> @@ -1803,6 +1803,9 @@ fhandler_disk_file::prw_open (bool write, void *aio)
>        return -1;
>      }
>  
> +  /* prw_handle is invalid after fork. */
> +  need_fork_fixup (true);
> +
>    /* record prw_handle's asyncness for subsequent pread/pwrite operations */
>    prw_handle_isasync = !!aio;
>    return 0;
> -- 
> 2.45.1
> 

