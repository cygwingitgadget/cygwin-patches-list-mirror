Return-Path: <cygwin-patches-return-4877-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25319 invoked by alias); 24 Jul 2004 16:07:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25310 invoked from network); 24 Jul 2004 16:07:46 -0000
Message-Id: <3.0.5.32.20040724120400.00808b80@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sat, 24 Jul 2004 16:07:00 -0000
To: "Gerd.Spalink@t-online.de" <Gerd.Spalink@t-online.de>,
 cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: RE: Fix dup for /dev/dsp
In-Reply-To: <01C47174.AD674DB0.Gerd.Spalink@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q3/txt/msg00029.txt.bz2

At 11:52 AM 7/24/2004 +0200, Gerd Spalink wrote:
>After reading the discussion, I agree to give archetypes a try to fix dup.
>I'll keep a copy of the linked list solution as a reference.

Gert, 

I have the feeling that the main reason dup doesn't work is that
audioin_/out_ are not "new'ed" in the dup call. That means that when
the original handle is closed, the storage will go away even though
the child stills point to it.
Using an archetype will fix that, but it can probably also be fixed 
very simply without that. I was going to try that today, but I won't
if you implement the archetype. 
What the archetype buys you is that duped handles can share 
format/bits/freq/channels info. Is that used by any application?

I am wondering if format/bits/freq/channels should be kept separately
for "in" and "out". The reason is that the "out" values can be modified
on the fly by the wave header, and this shouldn't affect the "in" 
values.
Also, doing a wave{in/Out}Open (or query) in ::open isn't that useful,
because 1) the device isn't really reserved and 2) the format can change
later, by ioctl or wave header.

>Regarding the sharing/dup stuff, there are three different things to
>consider:
>
>1. Independent processes
>
>They should be able to open as many /dev/dsp devices as the hardware
>supplies. On my hardware (AC97 on-board sound),
>I have an arbitrary number of playback devices.

Not on mines (2 systems tried). I can only open one output and one
input device.

>All output is converted to a common sampling rate and added somewhere
>inside the win32 mmsystem. It ends up on the same set of speakers.
>I only have a single recording device.
>All these devices should have different memory areas for their state.

>This case also applies to one process calling open several times.

The archetype won't do that right (allow calling open several times),
at least without minor device numbers. The settings of one "open"
will influence those of another "open".
But my idea of using ID as a minor won't work for several reasons,
- waveOutGetID returns -1 when the device was open with WAVE_MAPPER
- when the open is RW we would need two ID's.
- it may work differently on diff platforms

However I don't think it matters because from what I have read, on Linux
/dev/dsp can only be opened once. So no existing application will open
it several times :)
If the archetype already exists, I would simply have open return EBUSY,
and not try to have minor numbers.
 
>2. Different processes related as parent/child
>
>If the parent has opened the device before the fork, child and parent
>should share the same device. Unfortunately, Win32 seems not to allow
>DuplicateHandle for wave devices, so as a work around the current
>implementation does not open the handle in the open call but later
>in read/write. This solution works for the players/recorders I tried.
>But it has the following faults:
>1. The open does not really reserve the device. The device reservation
>   only works for devices that have already started to read/write.
>2. Currently, state changes in the child are not affecting
>   the device state in the parent, neither the other way around.
>Some shared memory between these processes would improve things.
>But a child process could not stop a ongoing recording if the parent has
>started it and vice versa because the win32 device is still not shared.
>IMHO the only way to really share a wave device in this case
>is to have a common process that calls all the Win32 wave functions.

I agree.
But the current code seems to assume a shared memory. Otherwise setting
the "owner" to the current PID is completely useless (except perhaps
if a fork occurs while the device is playing. Doing that would be 
an interesting test!) My 2 cents are that I would try to remove owner.
While doing so we would see if (and why) it's helpful after all. 

>Does anyone know how to duplicate a win32 wave device handle between
>processes?

I looked at that a little. waveOutOpen does not set a "real" handle.
It is not shown by sysinternals. To the contrary sysinternals shows
other sound related handles that are not accessible by waveXXX calls.
Those hidden handles are not inheritable.
So I don't think there is a way, using the waveXXX interface.

>Otherwise, I think a real fix needs a separate dispatcher process,
>which is really heavyweight.
>
>3. Duped devices in the same process
>
>Here I can implement a real sharing of the same device. Archetypes
>seem the way to go forward.

I agree.

>Regarding the test suite on Win98/ME, I never ran it on this system.
>I can only test in Win2k. I would appreciate any hints on the cause of
>the failure on Win98/ME. strace?

I will retry it after changes are made.

Pierre
