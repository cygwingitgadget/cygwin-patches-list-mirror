Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 87DF33858C50; Tue, 22 Oct 2024 14:45:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 87DF33858C50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1729608324;
	bh=/XHDY9Iq3uVmGKHho9uHOCo5dK9WdpabDszfMHomI4o=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=WVuKqLmwynzNHkEXUHqayfNNhA0AgDGoDzFxjR6G9tPEYJr+GXj0PYw4bY4i+tAWF
	 BwlPZXR08HBSCuYJdKQpuYLp8paNPGLp9HhZLM3elnGyVcVtNKxMolnGSgR3VCvcwT
	 zI8EmKFgbBMMeRiN4QiEJKyrPEpefuRCZGZV0NM8=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 7924AA80D05; Tue, 22 Oct 2024 16:45:22 +0200 (CEST)
Date: Tue, 22 Oct 2024 16:45:22 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Mark Geisert <mark@maxrnd.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: Change pthread_sigqueue() to accept thread id
Message-ID: <Zxe6gsvAQp7HaeO7@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Mark Geisert <mark@maxrnd.com>, cygwin-patches@cygwin.com
References: <20240919091331.1534-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240919091331.1534-1-mark@maxrnd.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

Thanks for looking into this.

On Sep 19 02:13, Mark Geisert wrote:
> Change the first parameter of pthread_sigqueue() to be a thread id rather
> than a thread pointer. The change is to match the Linux implementation of
> this function.
> 
> The user-visible function prototype is changed. Simple list iteration is
> added to the threadlist code. A lookup-by-id function is added to class
> pthread. The pthread_sigqueue() function is modified to work with a
> passed-in thread id rather than an indirect thread pointer as before.
> (It was "pthread_t *thread", i.e., class pthread **.) The release note
> for Cygwin 3.6.0 is updated.

Even if the old prototype was wrong, we probably have to keep it for
backward compatibility.  As unlikely as it seems, but there may be
binaries out there actually using the old prototype.

We can discuss this probability, but assuming we want to keep backward
compat at all cost, we would have to

- create a new function like pthread_sigqueue_with_correct_prototype (heh)

- Add this function to cygwin.din as exported symbol

- Add a matching entry to NEW_FUNCTIONS in Makefile.am, e.g.,

    pthread_sigqueue=pthread_sigqueue_with_correct_prototype,

- Implement either pthread_sigqueue_with_correct_prototype calling
  pthread_sigqueue or vice versa, whatever makese more sense.

> Reported-by: Christian Franke <Christian.Franke@t-online.de>
> Addresses: https://cygwin.com/pipermail/cygwin/2024-September/256439.html
> Signed-off-by: Mark Geisert <mark@maxrnd.com>
> Fixes: 2041af1a535a (cygwin.din (pthread_sigqueue): Export.)
> 
> ---
>  winsup/cygwin/include/pthread.h       |  2 +-
>  winsup/cygwin/local_includes/thread.h | 18 ++++++++++++++++++
>  winsup/cygwin/release/3.6.0           |  3 +++
>  winsup/cygwin/thread.cc               | 12 ++++++++++--
>  4 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/winsup/cygwin/include/pthread.h b/winsup/cygwin/include/pthread.h
> index 66d367d62..a0ec32526 100644
> --- a/winsup/cygwin/include/pthread.h
> +++ b/winsup/cygwin/include/pthread.h
> @@ -244,7 +244,7 @@ int pthread_getattr_np (pthread_t, pthread_attr_t *);
>  int pthread_getname_np (pthread_t, char *, size_t) __attribute__((__nonnull__(2)));
>  int pthread_setaffinity_np (pthread_t, size_t, const cpu_set_t *);
>  int pthread_setname_np (pthread_t, const char *) __attribute__((__nonnull__(2)));
> -int pthread_sigqueue (pthread_t *, int, const union sigval);
> +int pthread_sigqueue (pthread_t, int, const union sigval);
>  int pthread_timedjoin_np (pthread_t, void **, const struct timespec *);
>  int pthread_tryjoin_np (pthread_t, void **);
>  #endif
> diff --git a/winsup/cygwin/local_includes/thread.h b/winsup/cygwin/local_includes/thread.h
> index b3496281e..a6e9c9b6b 100644
> --- a/winsup/cygwin/local_includes/thread.h
> +++ b/winsup/cygwin/local_includes/thread.h
> @@ -199,6 +199,16 @@ template <class list_node> class List
>    fast_mutex mx;
>    list_node *head;
>  
> +  list_node *first ()
> +  {
> +    return head;
> +  }
> +
> +  list_node *next (list_node *cur)
> +  {
> +    return cur->next;
> +  }
> +
>  protected:
>    void mx_init ()
>    {
> @@ -439,6 +449,14 @@ public:
>      return t1 == t2;
>    }
>  
> +  static pthread* lookup_by_id (DWORD thread_id)
> +  {
> +    for (pthread *ptr = threads.first (); ptr; ptr = threads.next (ptr))
> +      if (thread_id == ptr->get_thread_id ())
> +        return ptr;
> +    return NULL;
> +  }
> +

This lookup function is not needed.

>    /* List support calls */
>    class pthread *next;
>    static void fixup_after_fork ()
> diff --git a/winsup/cygwin/release/3.6.0 b/winsup/cygwin/release/3.6.0
> index 240550715..8dfa4c385 100644
> --- a/winsup/cygwin/release/3.6.0
> +++ b/winsup/cygwin/release/3.6.0
> @@ -34,3 +34,6 @@ What changed:
>  - Expose //tsclient (Microsoft Terminal Services) shares as well as
>    //wsl$ (Plan 9 Network Provider) shares, i. e., WSL installation
>    root dirs.
> +
> +- Change pthread_sigqueue() to accept a thread id as first parameter
> +  as Linux does.
> diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
> index 0c6f57032..7905935a3 100644
> --- a/winsup/cygwin/thread.cc
> +++ b/winsup/cygwin/thread.cc
> @@ -3301,15 +3301,23 @@ pthread_sigmask (int operation, const sigset_t *set, sigset_t *old_set)
>  }
>  
>  int
> -pthread_sigqueue (pthread_t *thread, int sig, const union sigval value)
> +pthread_sigqueue (pthread_t thread_id, int sig, const union sigval value)
>  {
> -  siginfo_t si = {0};
> +  DWORD tid = (DWORD) (long) thread_id;
> +
> +  //FIXME This convolution is needed for ::is_good_object below
> +  void *tmp = (void *) pthread::lookup_by_id (tid);
> +  pthread_t const *thread = (pthread_t const *) &tmp;
> +  if (!*thread)
> +    return ESRCH;

This should actually be

   pthread_t const *thread = &thread_id;

but in fact you don't have to do even that.  Just make that

  pthread_sigqueue (pthread_t thread, int sig, const union sigval value)

and change all "(*thread)" to just "thread".

> +  //FIXME possibly superfluous sanity checks from older version of function
>    if (!pthread::is_good_object (thread))

And that would be

   if (!pthread::is_good_object (&thread))

Compare with, for instance, pthread_getschedparam() or some other
function taking a pthread_t as parameter.


Thanks,
Corinna
