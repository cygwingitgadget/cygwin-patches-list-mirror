Return-Path: <cygwin-patches-return-4875-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18381 invoked by alias); 24 Jul 2004 09:52:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18371 invoked from network); 24 Jul 2004 09:52:24 -0000
Message-ID: <01C47174.AD674DB0.Gerd.Spalink@t-online.de>
From: Gerd.Spalink@t-online.de (Gerd Spalink)
Reply-To: "Gerd.Spalink@t-online.de" <Gerd.Spalink@t-online.de>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: RE: Fix dup for /dev/dsp
Date: Sat, 24 Jul 2004 09:52:00 -0000
Organization: privat
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ID: r1cVUrZEoeNkJBWPrAD9spSIVNMjOmlnsPNmzeUD+-ZZm5PEP-hTQx
X-SW-Source: 2004-q3/txt/msg00027.txt.bz2

After reading the discussion, I agree to give archetypes a try to fix dup.
I'll keep a copy of the linked list solution as a reference.

Regarding the sharing/dup stuff, there are three different things to
consider:

1. Independent processes

They should be able to open as many /dev/dsp devices as the hardware
supplies. On my hardware (AC97 on-board sound),
I have an arbitrary number of playback devices.
All output is converted to a common sampling rate and added somewhere
inside the win32 mmsystem. It ends up on the same set of speakers.
I only have a single recording device.
All these devices should have different memory areas for their state.
This case also applies to one process calling open several times.

2. Different processes related as parent/child

If the parent has opened the device before the fork, child and parent
should share the same device. Unfortunately, Win32 seems not to allow
DuplicateHandle for wave devices, so as a work around the current
implementation does not open the handle in the open call but later
in read/write. This solution works for the players/recorders I tried.
But it has the following faults:
1. The open does not really reserve the device. The device reservation
   only works for devices that have already started to read/write.
2. Currently, state changes in the child are not affecting
   the device state in the parent, neither the other way around.
Some shared memory between these processes would improve things.
But a child process could not stop a ongoing recording if the parent has
started it and vice versa because the win32 device is still not shared.
IMHO the only way to really share a wave device in this case
is to have a common process that calls all the Win32 wave functions.

Does anyone know how to duplicate a win32 wave device handle between
processes?

Otherwise, I think a real fix needs a separate dispatcher process,
which is really heavyweight.

3. Duped devices in the same process

Here I can implement a real sharing of the same device. Archetypes
seem the way to go forward.


Regarding the test suite on Win98/ME, I never ran it on this system.
I can only test in Win2k. I would appreciate any hints on the cause of
the failure on Win98/ME. strace?

Gerd

On Thursday, July 22, 2004 5:15 PM, Christopher Faylor [SMTP:cgf-no-personal-reply-please@cygwin.com] wrote:
> On Thu, Jul 22, 2004 at 10:58:00AM -0400, Pierre A. Humblet wrote:
> >Igor Pechtchanski wrote:
> >> On Thu, 22 Jul 2004, Christopher Faylor wrote:
> >>>On Wed, Jul 21, 2004 at 11:25:19PM -0400, Pierre A.  Humblet wrote:
> >>>>Is it worth to delay 1.5.11 until those issues are sorted out?
> >>>
> >>>No, I don't think so.
> >>>
> >>>We do have people reporting problems with MapViewOfFileEx and with
> >>>threads in perl, now, though.  So, 1.5.11 is not quite cooked.
> >>
> >>Unfortunately, the problems with MapViewOfFileEx are elusive and hard
> >>to reproduce, even for some of those people reporting them (i.e., me
> >>:-}).  Since they aren't critical for me (I can just re-run the command
> >>if I get one of those), I personally don't mind if 1.5.11 is released
> >>without a fix (unless there's something I can do to help track them
> >>down sooner).  I don't speak for Volker, though.
> >
> >I share Igor's opinion.  1.5.11 as it is solves a fair number of
> >annoying issues.  Regarding /dev/dsp, I would apply Gert's latest
> >patches.  It's progress, and not an impediment to making more progress
> >later.
> 
> Sorry but I disagree on both counts.  1) I don't want to release cygwin
> with a known regression and 2) I don't want to apply a patch that I
> don't entirely agree with in the hopes that someone will "do it the
> right way" at some nebulous point in the future.
> 
> I could possibly be convinced about 1 but I'm rather adamant about 2.
