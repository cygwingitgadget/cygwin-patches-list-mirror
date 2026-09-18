Return-Path: <SRS0=MpZY=HK=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id E9CC34BA7998
	for <cygwin-patches@cygwin.com>; Fri, 18 Sep 2026 15:51:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E9CC34BA7998
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E9CC34BA7998
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789746663; cv=none;
	b=QM4liIdO0yRJFbGPVGazNLIhIEXkSlMdw02MQiIR0C7kBUQmpt4kzB+r+mtsg+LQraFVqsFxiUY624Up8CScLm3uN6jf5B7B7yIhWpRGcNZmnQyS6UziB8DFvdOppnXQ7uP92O5s/ZtUVjJEhDm28ER/uNRHKdeFES8aHlAtA64=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789746663; c=relaxed/simple;
	bh=E0jXozMy49dPxZFGpKlI9bxUG5HFj2C95nULRQiGqxk=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=GUo9bBPvn3twHrcNWpM4lEJUdZdBeIHjaXUjtA5Wlz0wvhtE3Vw1il3yQCZGykP9nvOSbDZsk36/Doodfb58ebz3dexmZPfsAVsZWfnUTIl/lkeEYcBT5ADDMGsAdYzQRl4rIMGiU/lPCxl6rOceQJPfcK4BtvEg2BqxSH9Fx9s=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=LI+AC/mP
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E9CC34BA7998
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=LI+AC/mP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789746656; x=1790351456;
	i=johannes.schindelin@gmx.de;
	bh=W1A5WOiuzYQkglphNAz6uRgMEV35dhL9FutgZ8xy2MQ=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LI+AC/mPCKayw6E7NMyEUFz+vwBX2WRo2kK4UcpfF6scDY8x3kjK4mf4HVyR8YzE
	 w8PGohYU8xc1F0l65UqUvxUjzcoElsRRaHe88CULW9f5NqH417gTjY0JIQdD9kmwy
	 cbvmZ9xWampfwuxwM3/+0JVwSJmC8lG72pZgnf9WR+jRrq2VFKpaY3PZRHog480QW
	 5An53F1O2ePBGnHfU6tCEhC/E+fXHPGHHOV8hvWLrmuOM6q5PdjY3bOQzSl5buOev
	 JqLV7ymwdfjM7K73+LEW8OkpdrfhGP9sUlqhz+B1o7X2TxWJVTCYd/HKMMEesDGD6
	 mO6PCOib2cfO4T8s3g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mnpru-1wSUgX32mg-00eWLy; Fri, 18
 Sep 2026 17:50:55 +0200
Date: Fri, 18 Sep 2026 17:50:54 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com, Jay Libove Alzina <libove@felines.org>
Subject: Re: [PATCH v3] Cygwin: console: Abort setting disable_master_thread
 when no con.owner
In-Reply-To: <20260917054209.7682-1-takashi.yano@nifty.ne.jp>
Message-ID: <f6e4cbb2-302e-910d-35f5-2a403d604322@gmx.de>
References: <20260917054209.7682-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:QJw+EoUTvzNXqMBkuQC/JxjK1CNxSs0L1FfDmDP5I1QGZ117/8E
 ABf4VIZbz1JzEYaznwQFLDsn51CpaojzWaGaEARlKs0rAIgSglLkwm/7TLQyGw9WRS+/MaE
 PY16CfDQjKtzRwQJqV5+h8HJVzMl8A3z8GDIgKBqndDGYlZlb2GXg9armc7KcNe41kjngng
 4qMdvDVtIYmlg0egyAP6Q==
UI-OutboundReport: notjunk:1;M01:P0:vH29ONZCAvc=;tcQMPemTcLXdRoqWDuH0C866e8/
 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
 sozoGXuWSaKasDznDyrNYjptOV/dU8Pfgcw==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Thu, 17 Sep 2026, Takashi Yano wrote:

> With the commit 733d5a953fa9 ("Cygwin: console: Ensure the master
> thread runs only when it is supposed to"), the process which calls
> set_disable_master_thread() hangs if the con.owner already exited,
> because set_disable_master_thread() waits for cons_master_thread
> accepting the status change and reflecting the current status to
> master_thread_suspended. With this patch, set_disable_master_thread()
> is aborted if the owner process no longer exists to avoid this
> hang.
>=20
> Addresses: https://cygwin.com/pipermail/cygwin/2026-September/260037.htm=
l
> Fixes: 733d5a953fa9 ("Cygwin: console: Ensure the master thread runs onl=
y when it is supposed to")
> Reported-by: Jay Libove Alzina <libove@felines.org>
> Co-authored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
> v2: Treat the absence of the master thread the same as suspension.
> v3: Handle the crash of owner process.

Thank you!

There's one more concern I have: An owner query failure does not
necessarily mean the process exited, and observing exit is not a worker
acknowledgement.

I think we need to allow an owner-exit escape only on observed exit or
absence, with con.owner still matching the captured owner. We need to
leave the acknowledgement untouched and preserve -1 as normal retirement,
and log inconclusive query or wait failures once per newly observed
failing owner and keep waiting.

More concretely, I am worried about this scenario: An old owner's absence
can overwrite a replacement's acknowledgement. Non-owner cleanup A holds
`cons_mode_mutex` and requests resume, while acknowledgement remains true.
Process A captures a dead owner's PID or zero and selects the escape
branch before reacquiring `input_mutex`. Meanwhile, process B can claim
ownership in `open()` and start its worker before obtaining the mode
mutex, as v17 deliberately permits. Process B's worker sees the retained
false request and acknowledges resume. Process A then obtains the input
lock but rechecks neither owner nor acknowledgement before writing true.
The shared record now calls process B suspended despite its
acknowledgement. Later mode decisions use that record when selecting
`ENABLE_PROCESSED_INPUT`. Holding the mode mutex does not exclude the new
startup path, and taking the input lock does not validate the earlier
owner observation.

A related concern: Retiring is not the same as retired. `close()` sets
owner to `-1`, waits for the worker's completion event, then publishes
zero. V3 treats that intermediate value as absence.

Another note: `process_alive()` also returns false when opening or
querying a process fails. A failed query is not verified process exit.
This distinction needs deliberate error handling, not an unconditional
assertion that the worker no longer exists.

I'd like to offer this as a discussion starter:

=2D- snip --
diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/co=
nsole.cc
index 16c3e5270a..39352ddda1 100644
=2D-- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -4950,16 +4950,40 @@ fhandler_console::set_disable_master_thread (bool =
x, fhandler_console *cons)
   cons->acquire_input_mutex (mutex_timeout);
   con.disable_master_thread =3D x;
   cons->release_input_mutex ();
+  DWORD reported_owner =3D 0;
   while (con.master_thread_suspended !=3D x)
-    { /* Wait for the responce from the cons_master_thread. */
+    {
       DWORD owner =3D con.owner;
-      if (owner =3D=3D 0 || owner =3D=3D (DWORD) -1 || !process_alive (ow=
ner))
-	{ /* The process that runs cons_master_thread no longer exists. */
-	  cons->acquire_input_mutex (mutex_timeout);
-	  /* Treat the absence of the master_thread the same as suspension. */
-	  con.master_thread_suspended =3D true;
-	  cons->release_input_mutex ();
-	  return; /* Abort */
+      if (owner !=3D (DWORD) -1)
+	{
+	  bool exited =3D owner =3D=3D 0;
+	  DWORD error =3D ERROR_SUCCESS;
+	  if (owner)
+	    {
+	      HANDLE process =3D OpenProcess (SYNCHRONIZE, FALSE, owner);
+	      if (process)
+		{
+		  DWORD res =3D WaitForSingleObject (process, 0);
+		  if (res =3D=3D WAIT_FAILED)
+		    error =3D GetLastError ();
+		  exited =3D res =3D=3D WAIT_OBJECT_0;
+		  CloseHandle (process);
+		}
+	      else
+		{
+		  error =3D GetLastError ();
+		  exited =3D error =3D=3D ERROR_INVALID_PARAMETER;
+		}
+	    }
+	  /* Keep the request, but never invent a worker acknowledgement. */
+	  if (exited && con.owner =3D=3D owner)
+	    return;
+	  if (error && !exited && reported_owner !=3D owner)
+	    {
+	      system_printf ("Cannot query console owner %u, error %u",
+			     owner, error);
+	      reported_owner =3D owner;
+	    }
 	}
       Sleep (1);
     }
=2D- snap --

I haven't been able to fully wrap my head around these issues, and need to
unwind this weekend. Hopefully you can turn this into a correct and
complete fix.

Thank you,
Johannes

>=20
>  winsup/cygwin/fhandler/console.cc | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/=
console.cc
> index a877fce0b..0b9e205e6 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -5025,7 +5025,18 @@ fhandler_console::set_disable_master_thread (bool=
 x, fhandler_console *cons)
>    con.disable_master_thread =3D x;
>    cons->release_input_mutex ();
>    while (con.master_thread_suspended !=3D x)
> -    Sleep (1);
> +    { /* Wait for the responce from the cons_master_thread. */
> +      DWORD owner =3D con.owner;
> +      if (owner =3D=3D 0 || owner =3D=3D (DWORD) -1 || !process_alive (=
owner))
> +	{ /* The process that runs cons_master_thread no longer exists. */
> +	  cons->acquire_input_mutex (mutex_timeout);
> +	  /* Treat the absence of the master_thread the same as suspension. */
> +	  con.master_thread_suspended =3D true;
> +	  cons->release_input_mutex ();
> +	  return; /* Abort */
> +	}
> +      Sleep (1);
> +    }
>  }
> =20
>  int
> --=20
> 2.51.0
>=20
>=20
