Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id CC8923858D34; Mon,  9 Dec 2024 12:28:04 +0000 (GMT)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C5B97A8093F; Mon,  9 Dec 2024 13:28:02 +0100 (CET)
Date: Mon, 9 Dec 2024 13:28:02 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: sched_setscheduler: accept SCHED_BATCH
Message-ID: <Z1biUqJeeCbOZMcQ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3a052da3-f60e-1d7a-f741-956926af23da@t-online.de>
 <Z1bEgYIYR43Jn45A@calimero.vinschen.de>
 <9362a9a5-2ec9-0c89-9d2a-5b5f357857ad@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9362a9a5-2ec9-0c89-9d2a-5b5f357857ad@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Dec  9 11:52, Christian Franke wrote:
> Corinna Vinschen wrote:
> > I would prefer that SCHED_BATCH gets its own, single value.
> > There's no good reason to add another ifdef for that.  Why
> > not just #define SCHED_BATCH 6?
> 
> The idea was to keep the non-Cygwin value in sync with Linux.
> https://github.com/torvalds/linux/blob/fac04ef/include/uapi/linux/sched.h#L111
> Of course we could drop this idea and use 6.

I see, but I wonder if Linux binary compatibility for flag values is
really important.  From the readability POV it's bad enough that we have
two different values for SCHED_OTHER.  And SCHED_SPORADIC is already
breaking Linux binary compat since it clashes with SCHED_ISO (which,
funny enough, isn't documented in sched(7), afaics).

Maybe you'd like to ask on the newlib ML if somebody prefers Linux
binary compat for SCHED_BATCH?


Corinna
