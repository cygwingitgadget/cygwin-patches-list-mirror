Return-Path: <SRS0=iF8p=I5=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo012.btinternet.com (btprdrgo012.btinternet.com [65.20.50.227])
	by sourceware.org (Postfix) with ESMTP id 8280B4BA2E14
	for <cygwin-patches@cygwin.com>; Sun,  8 Nov 2026 16:40:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8280B4BA2E14
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8280B4BA2E14
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.227
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1794156000; cv=none;
	b=paoPOCxut26GqLuOpDwnTitgJp0FbKx8Ef0uUksPnfyvQXvPo24Hh9wUOTQr6v9OuwhXrHGW+mKULezvSOi0SWU4gyGTOlwFA6otB3i4xxubdL0fruiUZo6qoN1c9tEW7y8hzVYxxJuX4v4Za8NT5bGRAdqQN+soueVZoCMxzHA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1794156000; c=relaxed/simple;
	bh=owu4Rtw4XnfUpUEyD4XK4x9ziZ9p2SNpwZPYHQhefhs=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=ZShDsr/OBDZaLF714OdRZmXNNiQs/oOyYQYC9IHvarMhcJcPdZHOf6GNUthRwlfQiUFmWxCb8nPftU9HJoVxWxwYLSDwPdC12lVPbhAaHutadM2/Bz8fCTvAi7TFoqd34/V4G5sU7X1VJKyjdP7pfry3s7ftDf696OlfIS575ts=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8280B4BA2E14
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A7161CE147484EF
X-Originating-IP: [80.176.81.8]
X-OWM-Source-IP: 80.176.81.8
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTGFtkjce0k8Gy6Ai6DxeM3yCeVF5SwSR/bf4wCAiAGJQnSt7bzC9U8y9JdoW2i5S23B7a2br3MxKmBzs6qgovAaCzRNZiG8NULPhk0nXk8qPTmYdQCu/V54nfbG1v2I89c6A1XoiItGOBuxJpXZmoER0lNsJxi+WC5aS2Ay0K+mleW13IbWAmwQbZODZWCXu9J+BH09we0LTWHP1QYX0LIyOdz0BITPLJ9q0DKNcWqe3w6z4Vc/kVf38o8pNWaWo85x4rCKrUDtyJtgkXiN1IuTSW5S11qZn2LVHU9Hgn/mfV+WlRhYTHmLuE3kheUY9p20Gw/l+Q5+M7FPAo2DzSNVJvc6QoKWFxLs1JUP6SbO0vInQhcziEy9j/aGFPYdVvowDfRvm+VljXYbDDojmZp18HzXGAwBNfngm7tkcXynZHQDTbsFa7d25CzxrTxNSHEqfP69Y2Z21DQCFy7fiYqGT1r9SzOlsTgyhv6Xomid/7IXh46fJpBawpBT6x1MYlpk4EoEKkWPqolw9+J6/Q6jjV7eyodwcWahWnDNiZSh0efoNWoP2rQgjnBkqHSQxzajP7TSg4Ba5BX+uUi76WkIIwGW9RktYq+ofLywXotL9eCzD1Gi1sp2HXRDR/UP2GA2Inok0UUzEsmkCTkQ8nmLmRKt88FGKwaEOvPnQLzf6A
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (80.176.81.8) by btprdrgo012.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A7161CE147484EF; Sun, 8 Nov 2026 16:39:58 +0000
Message-ID: <f5b464c0-09dc-41c8-a0a2-c85588a645e0@dronecode.org.uk>
Date: Sun, 8 Nov 2026 16:39:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] Cygwin: serialize user shared initialization with
 a named mutex
References: <CO1PR17MB5321BE63472EAC7A500BCCA0AA9B2@CO1PR17MB5321.namprd17.prod.outlook.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com, Phil Cahoon <pcahoon@leafsoftwaresolutions.com>
In-Reply-To: <CO1PR17MB5321BE63472EAC7A500BCCA0AA9B2@CO1PR17MB5321.namprd17.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 16/10/2026 12:41, Phil Cahoon via Cygwin-patches wrote:
> Resending because the attachment on my first post was archived as
> binary and scrubbed. The patch is attached as plain text this time;
> nothing in it has changed.
> 
> 
> 0001-Cygwin-serialize-user-shared-initialization-with-a-named- 
> mutex.patch.txt
> 
>  From 2cfe69e107a15ad2b4106bda3bebb5efe5a6ee43 Mon Sep 17 00:00:00 2001
> From: Phil Cahoon<pcahoon@leafsoftwaresolutions.com>
> Date: Thu, 15 Oct 2026 08:45:20 -0400
> Subject: [PATCH] Cygwin: serialize user shared initialization with a named
>   mutex
> 
> user_info::initialize guards the build of the per-user mount table with
> a spinlock that gives up after 15 seconds and lets the waiter initialize
> anyway.  The waiter cannot tell a slow initializer (a slow account
> lookup, a suspended or starved process) from one that died part way
> through.  In both cases it re-runs mount_info::init on a table that
> already holds "/", create_root_entry fails with EPERM, and the process
> dies with
> 
>    add_item ("\??\C:\cygwin64", "/", ...) failed, errno 1
> 
> The timed-out waiter never resets the lock, so while other processes
> keep the section mapped, every new process waits 15 seconds and dies the
> same way.  Tools that start a shell every second keep the section mapped
> indefinitely.
> 
> Use a named mutex next to the section instead.  A live initializer is
> simply waited for, so the table is never built twice.  An initializer
> that died is reported as WAIT_ABANDONED, and the waiter clears the
> half-built section and rebuilds it.  Already initialized sections still
> take the lock-free fast path.
> 
> This patch was written by Claude Opus 5.5 (Anthropic) using Claude
> Code, at the submitter's direction.
> 
> Addresses:https://github.com/git-for-windows/git/issues/6368
> Signed-off-by: Phil Cahoon<pcahoon@leafsoftwaresolutions.com>

Yes, this looks like a real problem, so thanks for investigating and 
producing a patch. I apologize for the delay in reviewing it.

Firstly, a statement on the licensing of the patch, as per [1], would be 
welcome.

[1] https://cygwin.com/contrib/dll.html#before_starting_legal

This all seems reasonable, but I have a couple of small questions:

> --- a/winsup/cygwin/mm/shared.cc
> +++ b/winsup/cygwin/mm/shared.cc
> @@ -190,30 +190,62 @@ open_shared (const WCHAR *name, int n, HANDLE& shared_h, DWORD size,
>  void
>  user_info::initialize ()
>  {
> -  /* Wait for initialization of the Cygwin per-user shared, if necessary */
> -  spinlock sversion (version, CURR_USER_MAGIC);
> -  if (!sversion)
> +  if ((ULONG) version != CURR_USER_MAGIC)

Hmmm... yeah, after a bit of head scratching, this seems OK outside the 
mutex, because we've done all the initialization by the time the value 
is set.

>      {
> -      cb = sizeof (*user_shared);
> -      /* Initialize mount table from system fstab prior to calling
> -         internal_getpwsid.  This allows to convert pw_dir and pw_shell
> -	 paths given in DOS notation to valid POSIX paths.  */
> -      mountinfo.init (false);
> -      cygpsid sid (cygheap->user.sid ());
> -      struct passwd *pw = internal_getpwsid (sid);
> -      /* Correct the user name with what's defined in /etc/passwd before
> -	 loading the user fstab file. */
> -      if (pw)
> -	cygheap->user.set_name (pw->pw_name);
> -      /* After fetching the user infos, add mount entries from user's fstab. */
> -      mountinfo.init (true);
> +      WCHAR name[UNLEN + 1];
> +      WCHAR mutex_name[UNLEN + 32];
> +      cygheap->user.get_windows_id (name);
> +      __small_swprintf (mutex_name, L"%W.%d.init", name, USER_VERSION);

There's probably room for some commentary here that mutex and file 
mappings exist in the same namespace, so the '.init' suffix serves to 
separate them.

(I'm kind of surprised that the mutex name doesn't also include the 
installation key, but it's not in the shared memory file mapping's name 
either, maybe I'm misunderstanding how that applies here)

> +      HANDLE init_mutex = CreateMutexW (&sec_none_nih, FALSE, mutex_name);
> +      if (!init_mutex)
> +	api_fatal ("CreateMutex %W, %E.  Terminating.", mutex_name);
> +      DWORD wait = WaitForSingleObject (init_mutex, INFINITE);
> +      if (wait != WAIT_OBJECT_0 && wait != WAIT_ABANDONED)
> +	api_fatal ("WaitForSingleObject %W returned %u, %E.  Terminating.",
> +		   mutex_name, wait);
> +
> +      if ((ULONG) version == CURR_USER_MAGIC)
> +	/* Initialized while we waited. */;
> +      else if (version == 0 || version == -1 || wait == WAIT_ABANDONED)

Uh, what these special values of 0 and -1 correspond to is a mystery to 
me. I dug around a bit, but couldn't immediately find anything.

A comment explaining that would be nice.

> +	{
> +	  /* An abandoned mutex means the previous initializer died part way
> +	     through.  Discard what it left and start over. */
> +	  if (wait == WAIT_ABANDONED)
> +	    {
> +	      debug_printf ("user shared initializer died, rebuilding");
> +	      memset ((void *) this, 0, sizeof (*this));
> +	    }
> +	  cb = sizeof (*user_shared);
> +	  /* Initialize mount table from system fstab prior to calling
> +	     internal_getpwsid.  This allows to convert pw_dir and pw_shell
> +	     paths given in DOS notation to valid POSIX paths.  */
> +	  mountinfo.init (false);
> +	  cygpsid sid (cygheap->user.sid ());
> +	  struct passwd *pw = internal_getpwsid (sid);
> +	  /* Correct the user name with what's defined in /etc/passwd before
> +	     loading the user fstab file. */
> +	  if (pw)
> +	    cygheap->user.set_name (pw->pw_name);
> +	  /* After fetching the user infos, add mount entries from user's
> +	     fstab. */
> +	  mountinfo.init (true);
> +	  InterlockedExchange (&version, (LONG) CURR_USER_MAGIC);

Reason for using InterlockedExchange here?

> +	}
> +      else
> +	{
> +	  LONG found = version;
> +	  ReleaseMutex (init_mutex);
> +	  CloseHandle (init_mutex);
> +	  multiple_cygwin_problem ("user shared memory version", found,
> +				   CURR_USER_MAGIC);
> +	  return;
> +	}
> +      ReleaseMutex (init_mutex);
> +      CloseHandle (init_mutex);
>      }
> -  else if (sversion != CURR_USER_MAGIC)
> -    sversion.multiple_cygwin_problem ("user shared memory version", version,
> -				      sversion);
> -  else if (user_shared->cb != sizeof (*user_shared))
> -    sversion.multiple_cygwin_problem ("user shared memory size", cb,
> -				      sizeof (*user_shared));
> +  if (cb != sizeof (*user_shared))
> +    multiple_cygwin_problem ("user shared memory size", cb,
> +			     sizeof (*user_shared));
>  }

