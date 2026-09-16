Return-Path: <SRS0=cqtw=HI=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id CDDC14BA2E3F
	for <cygwin-patches@cygwin.com>; Wed, 16 Sep 2026 13:41:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CDDC14BA2E3F
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CDDC14BA2E3F
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789566078; cv=none;
	b=qVi6xr4gLUZRA29JFC5MSJXH9rVyF1X9Mjl7nhNmeCvFnHCw2tXXxff8uiIQD4SPVCBCqFxsGdhugCvhdKmQgd90ah10lxlO4T+TjzFe6MGGXGh5j8TX2CqWAdUzx1l1qjN+7YTpoPC0CaGgE2llGJ3gvSIJx/Fc9x50nEijBVE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789566078; c=relaxed/simple;
	bh=zu8CxnZhpDR8i3brCbY75jAqpTBCGNOfwqWToXCZP9M=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=lrK/wlpwRkZ5FcqcGLNBL2yglDNppLkXhhtLC7vPhy7TkxFQsKX3xo2g8PCVNrqZzFld2r5ZYXNv0Npba5jMMe8ejcmoeOiE9fsl/2nS8cTkZrF+puCiYt2plj3r7PFQMh6qiD9KOTNb1xhU3hkJBxAb22hp/XjjrvP6mVWwnsw=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=X5gePfkR
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CDDC14BA2E3F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=X5gePfkR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789566070; x=1790170870;
	i=johannes.schindelin@gmx.de;
	bh=4wpfVFLzlkR26MWS6nwLyAVIFZX199s6j8HMJpyd91A=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=X5gePfkRl4244rJoEwWdqhDFUiWHTCyG4C/ai/7gp7gbKpP1WyxqTwd2NvngHoQk
	 oVZN0VxA9B/YtmmwCxcazko8e16E883a067MRRqLpf7aFieYp5yktFFaUyEmu2RZH
	 bW+d3Vpsd1Vu8ORoS7HjSCOg0mIwara2txF7yRUilkP/+E9OqtB8VgwfqrlxHXQcg
	 uyIUeDAIVRDXFNOlEN5WEmPibuUjWPAFLSb9Rs2uzJcXf+aE87u2nwm6IpSNWt8g9
	 0Pr7GVStLdrD9LWonlKR3zgKdLGbzazcQ64Vx3eHOeWvwfUhyeCvCzOpikTWLCGVG
	 gkDd+IfSjMuUOY3LLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiaY9-1wchvN0nih-00hxLg; Wed, 16
 Sep 2026 15:41:10 +0200
Date: Wed, 16 Sep 2026 15:41:10 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v16] Cygwin: console: Fix undesired mode change at exit
 of non-cygwin apps
In-Reply-To: <20260915075713.726-1-takashi.yano@nifty.ne.jp>
Message-ID: <b5cc7615-8db1-6f65-cd2b-88095d491667@gmx.de>
References: <20260915075713.726-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:LDZvLCaPXRMHh6En1vZFqMQnxGhx9B53v2RTgvtVzsx/UgTar5p
 wfvgZwP1PR8MWH+ABMne3Bt5uH8lbTMXhKxGrSWxh6Y9VUppML+Ly0fLRlX6QSfTdWZ9yaU
 zCM7BGzcw5N29Kh8pIIXtSL2eKJBGK83XwW+PSLrnka2L2UFtep7UYwsr6+LDK0KHaAVjJC
 l767conswgyYqJ6rffGuQ==
UI-OutboundReport: notjunk:1;M01:P0:URVgLPuLbuI=;0RKPefBDiRb92DMp7HOVR+njRwy
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Tue, 15 Sep 2026, Takashi Yano wrote:

> Previously, if two non-cygwin apps are started and one of them
> exits first, the other one lost appropriate console mode, since
> the first one restored it to tty::cygwin. This patch counts the
> active console process whose pgid is pgid of the tty and if the
> result is zero (means the last non-cygwin foreground process),
> restore console mode. To avoid race issue between apps modifying
> console mode simultaneously, this patch also introduce a mutex
> named `cons_mode_mutex`.
>=20
> Known limitation:
> In the case of non-overlayed spawn, there still exists a small
> window in which another non-cygwin process may restore tty::cygwin
> mode even though new non-cygwin app is about to start.
>=20
> Fixes: 48285aa36c2c ("Cygwin: console: Fix handling of Ctrl-S in Win7.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
> v2: Stop counting up/down the counter by itself.
>     Use num_active_non_cygwin_apps() instead.
> v3: Guard setup_for_non_cygwin_app() by cons_mode_mutex as well.
> v4: Guard all mode changes in console by cons_mode_mutex.
> v5: Fix the issue of mutex acquisition order.
>     Fix the race window around the process creation.
>     Improve latency of checking existence of non-cygwin apps.
>     Handle errors in checking existence of non-cygwin apps.
> v6: Match the conditions for incrementing and decrementing the counter.
> v7: Decrement the counter only if it was incremented by myself.
> v8: Symlify the conditions for incrementing and decrementing the counter
>     a bit.
> v9: Minimize the argument of set_non_cygwin_app_setup_ongoing().
> v10: Set process_state before calling spawn_worker::setup() rather than
>      using the counter. In addition, resume non-cygwin app before
> 	 modifying process table. These make things much simpler.
>      Narrowing the period of acquiring input_mutex in peek_console()
>      in select.cc.
> v11: Release output_mutex before calling bg_check() in ioctl().
>      Suppress unecessary console-mode change attempts.
> v12: Change handling of disabling master thread in the case of win32
>      input mode.
>      Wait for console attaching only when the spawned app is a console
>      app. In addition, a timeout is introduced to this wait loop for
>      safety.
> v13: Do not perform cleanup for non-cygwin apps on the error in
>      active_non_cygwin_apps_exist().
>      Handle WAIT_ABANDONED in CSI?9001h/l handling.
>      Fix ABBA deadlock about echo code path.
>      Set need_win32_input_mode_fix before set_disable_master_thread()
>      in CSI?9001h/l handling.
>      Setting and checking for need_win32_input_mode_fix inside the
>      input_mutex.
>      Fix the problem that the flag need_win32_input_mode_fix is set,
>      but disable_master_thread does not set if another thread holds
>      cons_mode_mutex.
> v14: Re-design echo code path. (Introduce raw_write() for doecho())
>      Re-design the handling of need_win32_input_mode_fix from scratch.
> v15: Fix possible deadlock with input_mutex regarding doecho()
> v16: Avoid to overwrite ENABLE_PROCESS_INPUT in tty::native mode.
>      Call fix_input_mode_if_necessary in TIMEOUT case as well.

Unfortunately, v16 still does not quite address the hangs. See for example
https://github.com/msys2/msys2-runtime/issues/351, with whose reproducer
at https://github.com/mrev11/msys2-bugreport (which still hangs with a
backported v16) I was able to come up with a fixup for the backported v15,
https://github.com/msys2/msys2-runtime/pull/364/commits/dbc070a9d472021d0a=
ecf771ea1d5280a6a48031:

=2D- snip --
Avoid the cleanup/startup deadlock: cleanup can hold `cons_mode_mutex`
while waiting for a console master that a new owner cannot start until
acquiring that mutex. Startup must precede the mode-mutex wait without
changing the handshake or mode serialization.

Also avoid waiting forever for an owner that exited without clearing
ownership. A confirmed exit permits ending the wait only while the
captured owner is still recorded, excluding the -1 normal-retirement
sentinel. Preserve the published request for a replacement worker;
a missing worker is not an acknowledgement.

Assisted-by: GPT-6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 winsup/cygwin/fhandler/console.cc | 47 +++++++++++++++++++------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/co=
nsole.cc
index 1c30d5f981..c499ae491f 100644
=2D-- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -2086,6 +2086,26 @@ fhandler_console::open (int flags, mode_t)
   if (in_is_console)
     CloseHandle (h_in);
=20
+  /* Another process may hold cons_mode_mutex while waiting for the
+     master thread to acknowledge a state change. */
+  if (GetCurrentProcessId () =3D=3D con.owner)
+    {
+      if (GetModuleHandle ("ConEmuHk64.dll"))
+	hook_conemu_cygwin_connector ();
+      char name[MAX_PATH];
+      shared_name (name, CONS_THREAD_SYNC, get_minor ());
+      thread_sync_event =3D CreateEvent(NULL, FALSE, FALSE, name);
+      if (thread_sync_event)
+	{
+	  new cygthread (::cons_master_thread, this, "consm");
+	  WaitForSingleObject (thread_sync_event, INFINITE);
+	  CloseHandle (thread_sync_event);
+	}
+      else
+	debug_printf ("Failed to create thread_sync_event %08x",
+		      GetLastError ());
+    }
+
   WaitForSingleObject (cons_mode_mutex, mutex_timeout);
   if (in_is_console && con.curr_input_mode !=3D tty::cygwin)
     {
@@ -2104,23 +2124,6 @@ fhandler_console::open (int flags, mode_t)
   debug_printf ("opened conin$ %p, conout$ %p", get_handle (),
 		get_output_handle ());
=20
-  if (GetCurrentProcessId () =3D=3D con.owner)
-    {
-      if (GetModuleHandle ("ConEmuHk64.dll"))
-	hook_conemu_cygwin_connector ();
-      char name[MAX_PATH];
-      shared_name (name, CONS_THREAD_SYNC, get_minor ());
-      thread_sync_event =3D CreateEvent(NULL, FALSE, FALSE, name);
-      if (thread_sync_event)
-	{
-	  new cygthread (::cons_master_thread, this, "consm");
-	  WaitForSingleObject (thread_sync_event, INFINITE);
-	  CloseHandle (thread_sync_event);
-	}
-      else
-	debug_printf ("Failed to create thread_sync_event %08x",
-		      GetLastError ());
-    }
   return 1;
 }
=20
@@ -4938,7 +4941,15 @@ fhandler_console::set_disable_master_thread (bool x=
, fhandler_console *cons)
   con.disable_master_thread =3D x;
   cons->release_input_mutex ();
   while (con.master_thread_suspended !=3D x)
-    Sleep (1);
+    {
+      DWORD owner =3D con.owner;
+      /* Keep the request for a replacement worker, but do not wait for a
+	 dead owner.  -1 denotes an owner completing normal retirement. */
+      if (owner !=3D (DWORD) -1 && !process_alive (owner)
+	  && con.owner =3D=3D owner)
+	break;
+      Sleep (1);
+    }
 }
=20
 int
=2D- snap --

Note: I am _not_ claiming that this should be the final fix. I'm just
observing that it addresses the reported hangs reliably.

The reason is a startup deadlock. The reproducer launches Bash and native
children from concurrent native threads. In my tests, already its first of
five passes hung: one started, zero completed. Cleanup process A holds
`cons_mode_mutex` in `cleanup_for_non_cygwin_app()` and calls
`set_disable_master_thread(false)`, waiting for resume acknowledgement.
Live owner B waits in `open()` for the same mutex _before creating the
worker_ that must acknowledge A. Process A cannot release the mutex until
B's worker runs; B cannot start it until A releases the mutex. The
captures show a `false` request, `true` acknowledgement, no started worker
and `need_win32_input_mode_fix=3Dfalse`: this failure does not involve
Win32-input suppression.

The fixup I came up with moves worker startup before the mode-lock wait
and adds an owner-liveness escape preserving the request. Startup
reordering alone still hung on a dead, nonzero owner. The combined
v15-backport fix completed five uninstrumented reproducer runs (495 jobs,
no child-command failures); GitHub user `@lhmouse` reported in
https://github.com/msys2/MSYS2-packages/pull/6445#issuecomment-5677483786
that their own hang was _also_ resolved by this v15+fixup.

>=20
>  winsup/cygwin/fhandler/console.cc       | 207 +++++++++++++++++++++---
>  winsup/cygwin/fhandler/termios.cc       |  40 +++--
>  winsup/cygwin/local_includes/fhandler.h |  10 +-
>  winsup/cygwin/select.cc                 |  16 +-
>  winsup/cygwin/spawn.cc                  |  44 ++---
>  5 files changed, 257 insertions(+), 60 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/=
console.cc
> index be41bf3a2..5de74a6a6 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -443,6 +443,11 @@ fhandler_console::cons_master_thread (handle_set_t =
*p, tty *ttyp)
>  	  cygwait (40);
>  	  continue;
>  	}
> +      if (con.need_win32_input_mode_fix)
> +	{
> +	  cygwait (40);
> +	  continue;
> +	}

An already-started worker can still fail to acknowledge resume. The 40msec
window covers setting acknowledgement `true` for pause. While
`need_win32_input_mode_fix` remains `true`, the worker sleeps and
continues before clearing that acknowledgement. A caller requesting
`false` can therefore wait indefinitely despite periodic wakes. This
unchanged source-level concern is distinct from the captured startup
deadlock; the experimental startup/death safeguards do not fix it.

> =20
>        acquire_attach_mutex (mutex_timeout);
>        GetNumberOfConsoleInputEvents (p->input_handle, &total_read);
> @@ -841,6 +846,8 @@ fhandler_console::setup ()
>        con.num_processed =3D 0;
>        con.curr_input_mode =3D tty::restore;
>        con.curr_output_mode =3D tty::restore;
> +      con.need_win32_input_mode_fix =3D false;
> +      con.is_processed_input =3D false;
>      }
>  }
> =20
> [... snipping ...]
> @@ -1248,6 +1378,7 @@ wait_retry:
>  	case WAIT_TIMEOUT:
>  	  if (copied_chars)
>  	    {
> +	      fix_input_mode_if_necessary (); /* for win32_input_mode */
>  	      buflen =3D copied_chars;
>  	      return;
>  	    }

This timeout fix still misses canonical echo (a blocking canonical read
uses `INFINITE`). If it echoes a mode-switch sequence without receiving a
newline, input processing can return `input_processing`, release
`input_mutex`, and loop back to waiting. It reaches neither this timeout
branch nor the normal finishing fix-up. Thus this hunk addresses the
specific partial-timeout example, but not that canonical-echo path.

I do like the native guard and timeout improvement, but also think that
worker startup/retirement, `false` acknowledgement and deferred
reconciliation before approval need addressing.

I.e. the code needs to finish processing the current input under
`input_mutex`, release that lock, then apply any mode change recorded
during echo, _before_ waiting for more input or returning to the
application. The order should be something along the lines of:

	case input_processing:
	  release_input_mutex ();
	  fix_input_mode_if_necessary ();
	  continue;

v16 currently goes straight from `release_input_mutex()` to `continue`,
potentially waiting indefinitely for more input before applying the echoed
mode change. Early returns after input processing need the same
consideration.

So why release input first? The helper acquires `cons_mode_mutex` and
then, when an update is needed, `input_mutex`. Calling it while the caller
still holds `input_mutex` would introduce the reverse ordering:

	echoing reader:		holds INPUT -> waits for MODE
	mode changer:		holds MODE -> waits for INPUT

That's the deadlock we need to remove.

At least that's how I interpret the observed hangs in that reproducer.

Ciao,
Johannes
