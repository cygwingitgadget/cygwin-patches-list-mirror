Return-Path: <cygwin-patches-return-4878-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14633 invoked by alias); 24 Jul 2004 16:51:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14618 invoked from network); 24 Jul 2004 16:51:06 -0000
Message-Id: <3.0.5.32.20040724124722.0080ba90@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sat, 24 Jul 2004 16:51:00 -0000
To: "Gerd.Spalink@t-online.de" <Gerd.Spalink@t-online.de>,
 <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: RE: Fix dup for /dev/dsp
In-Reply-To: <01C47174.AD674DB0.Gerd.Spalink@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q3/txt/msg00030.txt.bz2

Gert,

One reason why "cat xxx.wav > /dev/dsp" doesn't work is that
the /dev/dsp driver sets close on exec. It shouldn't.
But it should have a "fixup_after_exec".
One problem is that "new" calls calloc, and that won't be
preserved through execs. You need to use the cygheap
(ccalloc). 
But is it necessary to allocate audio_in/_out at open time, 
rather than when playing start? The flags passed to open are
stored somewhere, so they can be used to determine how the
device was opened.

Also won't hurt to call "nohandle (true)".

One interesting aspect is that /dev/dsp does not have a Windows
handle. But when  fd is < 2, Cygwin will still call SetStdHandle.
Not sure what will happen.

Pierre
