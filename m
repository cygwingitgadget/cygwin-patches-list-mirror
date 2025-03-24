Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 7C3663858423; Mon, 24 Mar 2025 10:57:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7C3663858423
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1742813828;
	bh=rW0rNCRqsAtrh97o2F7Rc3tiqeXkblvCeuC10HMoolE=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=kih3wP6hZZerBN3kPCvYLTzDpK1Ug8fCA8ciYPt7Xez2+BCmo/6kIz/ztIoLnR2Fe
	 rTy/rLeczMnbByKH+tYRuHoFTOnk5oGqcuDoqh2Vyj80voKf8ZH0sqLf1vHC+mGEH0
	 ketBLrPdQO5GQSE+w1+jnYUJI2/OAyKUSV2ULWag=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 4DB34A80B7A; Mon, 24 Mar 2025 11:57:06 +0100 (CET)
Date: Mon, 24 Mar 2025 11:57:06 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: thread: Allow fast_mutex to be acquired multiple
 times.
Message-ID: <Z-E6groYVnQAh-kj@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250324055340.975-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250324055340.975-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Mar 24 14:53, Takashi Yano wrote:
> Previously, the fast_mutex defined in thread.h could not be aquired
> multiple times, i.e., the thread causes deadlock if it attempted to
> acquire a lock already acquired by the thread. For example, a deadlock
> occurs if another pthread_key_create() is called in the destructor
> specified in the previous pthread_key_create(). This is because the
> run_all_destructors() calls the desructor via keys.for_each() where
> both for_each() and pthread_key_create() (that calls List_insert())
> attempt to acquire the lock. With this patch, the fast_mutex can be
> acquired multiple times by the same thread similar to the behaviour
> of a Windows mutex. In this implementation, the mutex is released
> only when the number of unlock() calls matches the number of lock()
> calls.

Doesn't that mean fast_mutex is now the same thing as muto?  The
muto type was recursive from the beginning.  It's kind of weird
to maintain two lock types which are equivalent.

I wonder if we shouldn't drop the keys list structure entirely, and
convert "keys" to a simple sequence number + destructor array, as in
GLibc.  This allows lockless key operations and drop the entire list and
mutex overhead.  The code would become dirt-easy, see
https://sourceware.org/cgit/glibc/tree/nptl/pthread_key_create.c
https://sourceware.org/cgit/glibc/tree/nptl/pthread_key_delete.c

What do you think?

However, for 3.6.1, the below patch should be ok.


Corinna


> 
> Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257705.html
> Fixes: 1a821390d11d ("fix race condition in List_insert")
> Reported-by: Yuyi Wang <Strawberry_Str@hotmail.com>
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/local_includes/thread.h | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/local_includes/thread.h b/winsup/cygwin/local_includes/thread.h
> index b3496281e..025bfa2fc 100644
> --- a/winsup/cygwin/local_includes/thread.h
> +++ b/winsup/cygwin/local_includes/thread.h
> @@ -31,7 +31,7 @@ class fast_mutex
>  {
>  public:
>    fast_mutex () :
> -    lock_counter (0), win32_obj_id (0)
> +    tid (0), counter_self (0), lock_counter (0), win32_obj_id (0)
>    {
>    }
>  
> @@ -55,17 +55,29 @@ public:
>  
>    void lock ()
>    {
> -    if (InterlockedIncrement (&lock_counter) != 1)
> +    if (!locked () && InterlockedIncrement (&lock_counter) != 1)
>        cygwait (win32_obj_id, cw_infinite, cw_sig | cw_sig_restart);
> +    tid = GetCurrentThreadId ();
> +    counter_self++;
>    }
>  
>    void unlock ()
>    {
> +    if (!locked () || --counter_self > 0)
> +      return;
> +    tid = 0;
>      if (InterlockedDecrement (&lock_counter))
>        ::SetEvent (win32_obj_id);
>    }
>  
> +  bool locked ()
> +  {
> +    return tid == GetCurrentThreadId ();
> +  }
> +
>  private:
> +  DWORD tid;
> +  int counter_self;
>    LONG lock_counter;
>    HANDLE win32_obj_id;
>  };
> -- 
> 2.45.1
