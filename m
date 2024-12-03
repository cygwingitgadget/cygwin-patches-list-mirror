Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id B6B6C3858D35; Tue,  3 Dec 2024 10:19:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B6B6C3858D35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1733221159;
	bh=/Ni7zwH5Q6WMAPYbm3K8I/HQ0+Q0Lj7ktF3pyBfNBz4=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=Q6UYfHZibwJ8dT2cnhwro6/SOKfguTYVrfgVHhc1t0iXPGcJXDGWy/a5Bq8T9S577
	 /aj5yRJtRCgZ6yFUZBXWudLIIl3KQo5PkjFfqGCGuH5EdP0BdNGTCgA65oBz/tuSR4
	 6CrcLDB0PsNOHqznMHVPH+CEJZMXsvEpJ4o6gwf4=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 0F1B4A80B66; Tue,  3 Dec 2024 11:19:17 +0100 (CET)
Date: Tue, 3 Dec 2024 11:19:17 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: sched_setscheduler: accept SCHED_OTHER,
 SCHED_FIFO and SCHED_RR
Message-ID: <Z07bJSlTbhnXwhnE@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <eabbcf15-1605-8b77-bf77-ec5fde2d6001@t-online.de>
 <Z03Tik1rbM4sMpKl@calimero.vinschen.de>
 <e79eb78a-c8a1-d2c6-4a8d-9c21415b15e9@t-online.de>
 <8734j6q6qk.fsf@Gerda.invalid>
 <1a3eb3c2-0059-322b-1c1f-321edc79b059@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a3eb3c2-0059-322b-1c1f-321edc79b059@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Dec  2 19:58, Christian Franke wrote:
> ASSI wrote:
> > Christian Franke writes:
> > > +    nice value   sched_priority   Windows priority class
> > > +     12...19      1....6          IDLE_PRIORITY_CLASS
> > > +      4...11      7...12          BELOW_NORMAL_PRIORITY_CLASS
> > > +     -4....3     13...18          NORMAL_PRIORITY_CLASS
> > > +    -12...-5     19...24          ABOVE_NORMAL_PRIORITY_CLASS
> > > +    -13..-19     25...30          HIGH_PRIORITY_CLASS
> > > +         -20     31...32          REALTIME_PRIORITY_CLASS
> > That mapping looks odd… care to explain why the number of nice values
> > and sched_priorities doesn't match up for each priority class?  39
> > possible values for one can't match to 32 for the other of course, but
> > which ones are skipped and why?
> 
> I don't know as I only documented the long standing existing mappings here.

Yeah, call it "history".  The original scheduler priorities as defined
by the original code in commit 6b2a2aa4af1e from 2001 were not overly
POSIX compatible.  So I took a stab at rewriting it, in
450f557feee5 ("Rewrite scheduler functions getting and setting process
and thread priority"), albeit I don't know anymore what triggered this.

For the reasoning, see the commit message of 450f557feee5.

Everybody, feel free to correct this approach if it was ill-advised.


Corinna
