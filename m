Return-Path: <cygwin-patches-return-4126-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14380 invoked by alias); 20 Aug 2003 01:25:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14367 invoked from network); 20 Aug 2003 01:25:30 -0000
Message-Id: <3.0.5.32.20030819212357.0081eb30@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net
Date: Wed, 20 Aug 2003 01:25:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Signal handling tune up.
In-Reply-To: <20030820005027.GB25456@redhat.com>
References: <20030820004135.GA25456@redhat.com>
 <3.0.5.32.20030819084636.0081c730@incoming.verizon.net>
 <20030819024617.GA6581@redhat.com>
 <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com>
 <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com>
 <3.0.5.32.20030818222927.008114e0@incoming.verizon.net>
 <20030819024617.GA6581@redhat.com>
 <3.0.5.32.20030819084636.0081c730@incoming.verizon.net>
 <3.0.5.32.20030819193152.00817750@incoming.verizon.net>
 <20030820004135.GA25456@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q3/txt/msg00142.txt.bz2

At 08:50 PM 8/19/2003 -0400, Christopher Faylor wrote:
>On Tue, Aug 19, 2003 at 08:41:35PM -0400, Christopher Faylor wrote:
>>However, it has been bothering me for a long time that all of this
>>signal mask stuff is in the pinfo structure.  This is a holdover from
>>early cygwin that doesn't make any sense.  So, sometime soon, I'm
>>going to rip much of the signal handling out of pinfo and put it
>>into local arrays.

OK.

>Actually, just to clarify, you do have to save siga's mask away
>somewhere since there could be a race otherwise.

Good point. But siga = myself->getsig (sig) so it can be calculated
on the fly.
Or do you mean that the program could change the sigaction mask
in midstream? That would be unsafe programming.

Pierre
