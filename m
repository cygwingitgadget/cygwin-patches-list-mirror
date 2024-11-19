Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 331FF3858401; Tue, 19 Nov 2024 21:37:36 +0000 (GMT)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id EC6E9A80D6C; Tue, 19 Nov 2024 22:33:59 +0100 (CET)
Date: Tue, 19 Nov 2024 22:33:59 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] cygthread: suspend thread before terminating.
Message-ID: <Zz0ER77IqtBDV_EU@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <45e536e2-e894-2548-e9d0-5937ff96b0b5@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <45e536e2-e894-2548-e9d0-5937ff96b0b5@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Nov 19 11:06, Jeremy Drake via Cygwin-patches wrote:
> (I searched for other callers of terminate_thread after this, and the only
> one left without CancelSynchronousIo is in ldap.cc and I'm pretty sure
> that's a "can't happen" case.)

I'm inclined to push your patch, but I'm not quite sure here...

Yes, terminate_thread called from ldap.cc is an unlikely last resort kind
of thing.  And there are more places calling terminate_thread().  But none
of them are terminating the wait_thread, so they shouldn't matter in this
scenario.  I think?

Assuming they do matter, CancelSynchronousIo() only makes sense
if the thread hangs in synchronous IO.  Other internal threads use WFMO,
and I don't see that you can avoid a TerminateThread in these cases.
But those are covered by the neat SuspendThread/GetThreadContext trick,
right?


Thanks,
Corinna
