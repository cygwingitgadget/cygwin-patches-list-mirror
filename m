Return-Path: <cygwin-patches-return-4876-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22005 invoked by alias); 24 Jul 2004 10:56:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21981 invoked from network); 24 Jul 2004 10:56:26 -0000
Date: Sat, 24 Jul 2004 10:56:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: Re: Fix dup for /dev/dsp
Message-ID: <20040724105631.GN5441@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
References: <01C47174.AD674DB0.Gerd.Spalink@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01C47174.AD674DB0.Gerd.Spalink@t-online.de>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q3/txt/msg00028.txt.bz2

On Jul 24 11:52, Gerd Spalink wrote:
> After reading the discussion, I agree to give archetypes a try to fix dup.
> I'll keep a copy of the linked list solution as a reference.
> 
> Regarding the sharing/dup stuff, there are three different things to
> consider:
> 
> 1. Independent processes
> 
> They should be able to open as many /dev/dsp devices as the hardware
> supplies. On my hardware (AC97 on-board sound),
> I have an arbitrary number of playback devices.
> All output is converted to a common sampling rate and added somewhere
> inside the win32 mmsystem. It ends up on the same set of speakers.
> I only have a single recording device.
> All these devices should have different memory areas for their state.
> This case also applies to one process calling open several times.
> 
> 2. Different processes related as parent/child
> 
> If the parent has opened the device before the fork, child and parent
> should share the same device. Unfortunately, Win32 seems not to allow
> DuplicateHandle for wave devices, so as a work around the current
> implementation does not open the handle in the open call but later
> in read/write. This solution works for the players/recorders I tried.
> But it has the following faults:
> 1. The open does not really reserve the device. The device reservation
>    only works for devices that have already started to read/write.
> 2. Currently, state changes in the child are not affecting
>    the device state in the parent, neither the other way around.
> Some shared memory between these processes would improve things.
> But a child process could not stop a ongoing recording if the parent has
> started it and vice versa because the win32 device is still not shared.
> IMHO the only way to really share a wave device in this case
> is to have a common process that calls all the Win32 wave functions.
> 
> Does anyone know how to duplicate a win32 wave device handle between
> processes?

I'm probably an computer audio device ignorant (I love my "real" HiFi
devices, though) but... what's different with the win32 wave device
that the usual DuplicateHandle shouldn't work?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Co-Project Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
