Return-Path: <SRS0=doSl=B3=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by sourceware.org (Postfix) with ESMTPS id BB3D94BA2E18
	for <cygwin-patches@cygwin.com>; Fri, 27 Mar 2026 15:02:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BB3D94BA2E18
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BB3D94BA2E18
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774623744; cv=none;
	b=aXJ78eX2WiaFzuwjiLgIkc+4iadnSD0HA7sFIiQ/98rALHxWFrA+dC7W9JyR4gIi6m62HbuwdXgnovvc5E197Gf8p92Nd07DttnUTWOJGPVRjc0EuTGpvj6Y/nYFS/kXuJ5CoKoGnZgzH7KoBWIcz3FWsAyg72hOxGj7yG7jmOI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774623744; c=relaxed/simple;
	bh=fbwu9PTladOehO5xU2gNSO4PizIq6WYCbhHGzpF5n0w=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=qe0WVaxrngsDCG0QfI+Lcl0Qvs6LgW17dGbGeZtss9smsUF6aa0Kk7lteaMgF7IStv8MWyusq93mO8DwClhO9V0Y59aiVRLh5rm/eEoWgD5wMFFv1QR6cCqIm3zzkNZaUyiVrmSAv4l2pks3VM31qEE9JpqCe8dMTEnJ6rcBcQg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BB3D94BA2E18
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=tI8UE3pR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1774623742; x=1775228542;
	i=johannes.schindelin@gmx.de;
	bh=G9i8XppWyCsT43tw5wK2IaWkwelju8EAdG5rd8TFNxA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tI8UE3pRQ05TpG2AHdUb9RKikveeCtf7ETa7WDusgnYvPIjkllbtzgX9VFE/j9QT
	 fZBGaIOcuycBYqPq/LK83+2nn6jeZB+RA5IpRvMD26VWgm4KWsLj9CxOJEWeOqWuV
	 UBxrUcPtSZUS7MoKAqz3vu1RA4r1vg13MAYsWghUQThcKvtsi5OmD4+8d+ls1cSPt
	 9MdAf75JrrV065/uuU7pVWfHTzMMCP/RikNNd7VnvZbeiBr4pfa5L3HwsWWgUl2yl
	 DoXqFvZQeimsxmdcTh/KL6KFr+eA2tUWc6gIxk/viPbVh9fOuij0NoaDt7xq1DbSH
	 v/u3Snd61RlzX2ngJA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8ygY-1w8sFk22sA-00EjVG; Fri, 27
 Mar 2026 16:02:22 +0100
Date: Fri, 27 Mar 2026 16:02:20 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v7 5/7] Cygwin: pty: Guard get_winpid_to_hand_over() with
 attach_mutex
In-Reply-To: <20260325130453.62246-6-takashi.yano@nifty.ne.jp>
Message-ID: <b2d504c3-899b-0449-bb89-9f3e857bf898@gmx.de>
References: <20260321113613.9443-1-takashi.yano@nifty.ne.jp> <20260325130453.62246-1-takashi.yano@nifty.ne.jp> <20260325130453.62246-6-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/Msu/27aDOynm+TYkdpEAJEydzOpUhGDjxIs3QqLVAsJ+t/lWB+
 tD3+eNEDcdGkvyLbGJkfUMX8LsxafEHvfrzAbCKmM4wu1LRVLk2WRGPmu+hNXH2rZkvKW02
 moLKoMNV76eqUP18a9oCPya+oMReRA+2ihkBMqVBi3GeXP2RpCPMemSsTiUP7AQ3/dr+sfE
 WLLO/BLBfnBIPcmUBMfqQ==
UI-OutboundReport: notjunk:1;M01:P0:GT/qIDVVw28=;n373e3S1iNJQzLov7a5W/AwdmEp
 +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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

This patch is correct and minimal. I have two observations, one about the
commit message and one about the exec path.

On Wed, 25 Mar 2026, Takashi Yano wrote:

> Currently, attach_mutex is shared only in the same process. As a
> result, if the master process of pty attaches to pseudo console
> temporarily, get_winpid_to_hand_over() may wrongly find the master
> process to hand over the pseudo console. make attach_mutex shared
> within the PTY and guard get_winpid_to_hand_over() with it.

The commit message would benefit from a bit more context. As it stands, a
future reader has to guess _why_ the master temporarily attaches and _what=
_
makes `get_winpid_to_hand_over()` sensitive to that attachment.

Concretely: the master process (e.g. mintty) temporarily attaches to the
pseudo console's conhost in `transfer_input()` (the `to_cyg` path) so it
can read INPUT_RECORDs via `ReadConsoleInputA()`. During that brief window=
,
`get_console_process_id()` inside `get_winpid_to_hand_over()` calls
`GetConsoleProcessList()`, which now sees the master among the console's
attached processes and may select it as the handover target. That is wrong
because the master will detach immediately after the read.

Making `attach_mutex` a cross-process named mutex lets
`get_winpid_to_hand_over()` in the slave serialize with the master's
temporary attachment, so the `GetConsoleProcessList()` enumeration never
observes the master while it is temporarily attached.

I think spelling that out in the commit message (even briefly) would make
the patch much easier to revisit later.

Also, minor: "make attach_mutex shared" at the start of a new sentence
should be capitalized ("Make attach_mutex shared").

Something like this maybe?

    The master process (e.g. mintty) temporarily attaches to the pseudo
    console's conhost in `transfer_input()` so it can read
    INPUT_RECORDs via `ReadConsoleInputA()`. During that brief window,
    `get_console_process_id()` inside `get_winpid_to_hand_over()` calls
    `GetConsoleProcessList()`, which sees the master among the console's
    attached processes and may select it as the handover target. That is
    wrong because the master will detach immediately after the read.

    Until now, `attach_mutex` was a process-local unnamed mutex, so
    the slave's `get_winpid_to_hand_over()` could not serialize with
    the master's temporary attachment. Make `attach_mutex` a
    cross-process named mutex (`ATTACH_MUTEX`) shared within the PTY,
    and acquire it around the `get_console_process_id()` calls in
    `get_winpid_to_hand_over()`. This ensures the console process list
    enumeration never observes the master while it is temporarily
    attached.

>=20
> Fixes: 1e6c51d74136 ("Cygwin: pty: Reorganize the code path of setting u=
p and closing pcon.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/fhandler/pty.cc      | 14 ++++++++++++--
>  winsup/cygwin/local_includes/tty.h |  1 +
>  2 files changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index 2a0e0d2f7..0de6ec007 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -774,6 +774,12 @@ fhandler_pty_slave::open (int flags, mode_t)
>        errmsg =3D "open pipe switch mutex failed, %E";
>        goto err;
>      }
> +  if (!(attach_mutex
> +	=3D get_ttyp ()->open_mutex (ATTACH_MUTEX, MAXIMUM_ALLOWED)))
> +    {
> +      errmsg =3D "open attach mutex failed, %E";
> +      goto err;
> +    }
>    shared_name (buf, INPUT_AVAILABLE_EVENT, get_minor ());
>    if (!(input_available_event =3D OpenEvent (MAXIMUM_ALLOWED, TRUE, buf=
)))
>      {
> @@ -2533,6 +2539,7 @@ void
>  fhandler_pty_slave::fixup_after_fork (HANDLE parent)
>  {
>    create_invisible_console ();
> +  attach_mutex =3D get_ttyp ()->open_mutex (ATTACH_MUTEX, MAXIMUM_ALLOW=
ED);

The patch opens `attach_mutex` in `open()` and `fixup_after_fork()` but
not in `fixup_after_exec()`. Since `fixup_after_exec()` calls
`fixup_after_fork()`, the mutex _is_ reopened after exec as well, so this
is fine. The dependency is implicit, though. A one-line comment in
`fixup_after_fork()` noting that this also covers the exec path (or a note
in the commit message) would save the next reader a detour.

The code change itself is sound. The named mutex correctly serializes the
cross-process operation, and the critical section is kept tight around the
`get_console_process_id()` calls.

Thanks,
Johannes

> =20
>    // fork_fixup (parent, inuse, "inuse");
>    // fhandler_pty_common::fixup_after_fork (parent);
> @@ -3164,8 +3171,9 @@ fhandler_pty_master::setup ()
>    if (!(pipe_sw_mutex =3D CreateMutex (&sa, FALSE, buf)))
>      goto err;
> =20
> -  if (!attach_mutex)
> -    attach_mutex =3D CreateMutex (&sec_none_nih, FALSE, NULL);
> +  errstr =3D shared_name (buf, ATTACH_MUTEX, unit);
> +  if (!(attach_mutex =3D CreateMutex (&sa, FALSE, buf)))
> +    goto err;
> =20
>    /* Create master control pipe which allows the master to duplicate
>       the pty pipe handles to processes which deserve it. */
> @@ -3725,6 +3733,7 @@ fhandler_pty_slave::get_winpid_to_hand_over (tty *=
ttyp,
>        DWORD current_pid =3D myself->exec_dwProcessId ?: myself->dwProce=
ssId;
>        if (ttyp->nat_pipe_owner_pid =3D=3D GetCurrentProcessId ())
>  	current_pid =3D GetCurrentProcessId ();
> +      acquire_attach_mutex (mutex_timeout);
>        switch_to =3D get_console_process_id (current_pid,
>  					  false, true, true, true);
>        if (!switch_to)
> @@ -3733,6 +3742,7 @@ fhandler_pty_slave::get_winpid_to_hand_over (tty *=
ttyp,
>        if (!switch_to && ttyp->pcon_activated)
>  	switch_to =3D get_console_process_id (current_pid,
>  					    false, false, false, false);
> +      release_attach_mutex ();
>      }
>    return switch_to;
>  }
> diff --git a/winsup/cygwin/local_includes/tty.h b/winsup/cygwin/local_in=
cludes/tty.h
> index cd1e202f1..962697782 100644
> --- a/winsup/cygwin/local_includes/tty.h
> +++ b/winsup/cygwin/local_includes/tty.h
> @@ -22,6 +22,7 @@ details. */
>  #define OUTPUT_MUTEX		"cygtty.output.mutex"
>  #define INPUT_MUTEX		"cygtty.input.mutex"
>  #define PIPE_SW_MUTEX		"cygtty.pipe_sw.mutex"
> +#define ATTACH_MUTEX		"cygtty.attach.mutex"
>  #define TTY_SLAVE_ALIVE		"cygtty.slave_alive"
>  #define TTY_SLAVE_READING	"cygtty.slave_reading"
> =20
> --=20
> 2.51.0
>=20
>=20
