Return-Path: <cygwin-patches-return-4870-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6951 invoked by alias); 22 Jul 2004 03:29:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6941 invoked from network); 22 Jul 2004 03:29:02 -0000
Message-Id: <3.0.5.32.20040721232519.00810350@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Thu, 22 Jul 2004 03:29:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: Fix dup for /dev/dsp
In-Reply-To: <20040721170015.GC22390@trixie.casa.cgf.cx>
References: <40FE87D6.3C89AE1F@phumblet.no-ip.org>
 <40FE87D6.3C89AE1F@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q3/txt/msg00022.txt.bz2

At 01:00 PM 7/21/2004 -0400, Christopher Faylor wrote:
>On Wed, Jul 21, 2004 at 11:12:22AM -0400, Pierre A. Humblet wrote:
>>Here is another idea.
>>As noted in your comments, the children cannot change any of the
>>parameters (because they don't have access to the parent).  To fix that
>>I am wondering if it wouldn't be better to use a FileMapping that can
>>be shared between parent and children, instead of an archetype.
>>Apparently that's what fhandler_tape does.  See mtinfo_init () in
>>fhandler_tape.cc Perhaps that share can be created on demand when the
>>dsp is opened, instead of creating it for every process as tape does.
>>My understanding is very superficial, I apologize in advance if I
>>mislead you.
>
>If this is all that's required, you could use an __attribute__((shared))
>option to share the state among all processes.

That would work too, I think, although it's not secure.
But there is a complication. Apparently a PC can have several input and
output audio devices and I don't see why several of them couldn't be opened
at the same time, in the same or in different processes. There would need
to be a shared area per such device (or an area large enough for all
together).

Related to that, the archetype is identified by the device, i.e. /dev/dsp
But there can be several "real" devices, each needing its own archetype.
That leads to having to define minor device numbers for /dev/dsp...
(e.g. based on in/out + device ID, it the ID is determined when /dev/dsp is
opened, and not when it starts playing)
So it gets to be complex, although not that different from ttys.

Is it worth to delay 1.5.11 until those issues are sorted out? 

Pierre
