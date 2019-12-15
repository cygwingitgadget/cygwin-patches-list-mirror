Return-Path: <cygwin-patches-return-9866-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 57669 invoked by alias); 15 Dec 2019 20:04:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 57658 invoked by uid 89); 15 Dec 2019 20:04:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.1 spammy=spread, dos, letters, H*f:sk:6db5773
X-HELO: vsmx009.vodafonemail.xion.oxcs.net
Received: from vsmx009.vodafonemail.xion.oxcs.net (HELO vsmx009.vodafonemail.xion.oxcs.net) (153.92.174.87) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 15 Dec 2019 20:04:42 +0000
Received: from vsmx001.vodafonemail.xion.oxcs.net (unknown [192.168.75.191])	by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTP id B530E159CBE0	for <cygwin-patches@cygwin.com>; Sun, 15 Dec 2019 20:04:39 +0000 (UTC)
Received: from Gertrud (unknown [91.47.60.226])	by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 88A51159D241	for <cygwin-patches@cygwin.com>; Sun, 15 Dec 2019 20:04:37 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Provide more COM devices
References: <87mudvwnrl.fsf@Rainer.invalid>	<20191021081844.GH16240@calimero.vinschen.de>	<87pniq7yvm.fsf@Rainer.invalid>	<20191022071622.GM16240@calimero.vinschen.de>	<87sgn4ai3n.fsf@Rainer.invalid> <871rt6rbvb.fsf@Rainer.invalid>	<6db57733-0b63-54fc-3b2f-ff2c87b9dcd1@SystematicSw.ab.ca>
Date: Sun, 15 Dec 2019 20:04:00 -0000
In-Reply-To: <6db57733-0b63-54fc-3b2f-ff2c87b9dcd1@SystematicSw.ab.ca> (Brian	Inglis's message of "Sun, 15 Dec 2019 11:50:23 -0700")
Message-ID: <8736dlicdp.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SW-Source: 2019-q4/txt/msg00137.txt.bz2

Brian Inglis writes:
> On 2019-12-14 11:38, Achim Gratz wrote:
>
> [Sorry, thought I'd sent this, it was backgrounded!]
>
> What are the distinctions between /dev/sd[a-c][a-z], /dev/sdd[a-z], and
> /dev/sd[a-z] appearing in parts of devices.cc?

/dev/sd is the base name for disks, letters denote distinct units (a..dx
for a total of 128 units) and numbers the partitions (starting from 1,
with no number addressing the whole device), just like Linux.

The first 16 partitions of each drive have a fixed device major number
(out of 8) and mangle the drive / partition into the lower nibbles of
the minor.  Any drive with higher partition numbers gets mapped into 25
higher device numbers where the bits for the unit number spread across
major/minor and the remaining 48 partitions make up the lower part of
the minor.  I'd rather had kept the original numbering scheme and packed
each set of 16 extra partitions into one more major number for a total
of 24 extra, but that's what we have now.

> There are 127 each cons,nst,pty,ptym,st,ttyS entries allocated for potential
> devices, which will not exist on most systems.

You'll proably won't find a system with so many tapes, not.  But the way
Windows deals with USB devices means that you can easily have several
dozen of (virtual) COM ports, since it creates a distinct number for
each device / USB port combination you've ever used.  The limit is
probably even higher than the 128 ports Cygwin tries to support.

> Note that GPT supports 128 partitions per device.

But Cygwin only supports 64.

> Are there systems using more than 32 of any supported device?

I have systems that are way past COM64 and I seem to remember having
seen one with a COM port past 127.

> Are there documented Windows I/O device addressing limits?

You could have 256 since Win98 (not for DOS applications, though), but
that IIRC was always a limitation of the control panel, not the
underlying platform.  Not sure if Win10 changed something in that
regard, but probably not.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

SD adaptations for Waldorf Q V3.00R3 and Q+ V3.54R2:
http://Synth.Stromeko.net/Downloads.html#WaldorfSDada
