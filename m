Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 3543F3858C53; Tue, 22 Oct 2024 16:02:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3543F3858C53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1729612922;
	bh=RIxPl3fZZM6UhNWNkdz8wDqmeJKknNcCZGElp+AWvy4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=qEMRRMLUO14miItilwE4O6U6BH7Te+FO8xC7SmKn4XWHkxYHuxq9On56U7g+DxZpW
	 MOt/PcO8oaePp+3I3wgrgehQEEfvlWwUgM2oLFugR/HE3IIhNma9JGbebnGOkrpNkX
	 18/F2S9diAqlirKceWdNNQ4UiVKaCuGK06RW0oOU=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 1A4C1A80D05; Tue, 22 Oct 2024 18:02:00 +0200 (CEST)
Date: Tue, 22 Oct 2024 18:02:00 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] Cygwin: lockf: Make lockf() return ENOLCK when too
 many locks
Message-ID: <ZxfMeOTgFQHZYTCD@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Takashi Yano <takashi.yano@nifty.ne.jp>,
	cygwin-patches@cygwin.com
References: <20241020092650.835-1-takashi.yano@nifty.ne.jp>
 <20241020092650.835-3-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241020092650.835-3-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Oct 20 18:26, Takashi Yano wrote:
> Previously, lockf() printed a warning message when the number of locks
> per file exceeds the limit (MAX_LOCKF_CNT). This patch makes lockf()
> return ENOLCK in that case rather than printing the warning message.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2024-October/256528.html
> Fixes: 31390e4ca643 ("(inode_t::get_all_locks_list): Use pre-allocated buffer in i_all_lf instead of allocating every lock.  Return pointer to start of linked list of locks.")
> Reported-by: Christian Franke <Christian.Franke@t-online.de>
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/flock.cc | 46 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 38 insertions(+), 8 deletions(-)
> 
> diff --git a/winsup/cygwin/flock.cc b/winsup/cygwin/flock.cc
> index 5550b3a5b..3b8475c18 100644
> --- a/winsup/cygwin/flock.cc
> +++ b/winsup/cygwin/flock.cc
> @@ -297,6 +297,7 @@ class inode_t
>      HANDLE		 i_dir;
>      HANDLE		 i_mtx;
>      uint32_t		 i_cnt;    /* # of threads referencing this instance. */
> +    uint32_t		 i_lock_cnt; /* # of locks for this file */
>  
>    public:
>      inode_t (dev_t dev, ino_t ino);
> @@ -321,6 +322,8 @@ class inode_t
>      void unlock_and_remove_if_unused ();
>  
>      lockf_t *get_all_locks_list ();
> +    uint32_t get_lock_count () /* needs get_all_locks_list() */
> +    { return i_lock_cnt; }
>  
>      bool del_my_locks (long long id, HANDLE fhdl);
>  };
> @@ -503,7 +506,8 @@ inode_t::get (dev_t dev, ino_t ino, bool create_if_missing, bool lock)
>  }
>  
>  inode_t::inode_t (dev_t dev, ino_t ino)
> -: i_lockf (NULL), i_all_lf (NULL), i_dev (dev), i_ino (ino), i_cnt (0L)
> +: i_lockf (NULL), i_all_lf (NULL), i_dev (dev), i_ino (ino), i_cnt (0L),
> +  i_lock_cnt (0)
>  {
>    HANDLE parent_dir;
>    WCHAR name[48];
> @@ -610,17 +614,15 @@ inode_t::get_all_locks_list ()
>  	  dbi->ObjectName.Buffer[LOCK_OBJ_NAME_LEN] = L'\0';
>  	  if (!newlock.from_obj_name (this, &i_all_lf, dbi->ObjectName.Buffer))
>  	    continue;
> -	  if (lock - i_all_lf >= MAX_LOCKF_CNT)
> -	    {
> -	      system_printf ("Warning, can't handle more than %d locks per file.",
> -			     MAX_LOCKF_CNT);
> -	      break;
> -	    }
> +	  if (lock - i_all_lf > MAX_LOCKF_CNT)
> +	    api_fatal ("Can't handle more than %d locks per file.",
> +		       MAX_LOCKF_CNT);

I don't quite get that. The commit message says to return ENOLCK rather
than printing a warning, but here you call api_fatal(), which is even
more extrem?  Did I miss something?


Thanks,
Corinna
