Return-Path: <cygwin-patches-return-4112-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24492 invoked by alias); 19 Aug 2003 02:51:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24482 invoked from network); 19 Aug 2003 02:51:07 -0000
Message-Id: <3.0.5.32.20030818225010.0080e4c0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net
Date: Tue, 19 Aug 2003 02:51:00 -0000
To: cygwin-patches@cygwin.com,cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Signal handling tune up.
In-Reply-To: <20030819010531.GD4303@redhat.com>
References: <20030819005832.GB4303@redhat.com>
 <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com>
 <20030819005832.GB4303@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q3/txt/msg00128.txt.bz2

At 09:05 PM 8/18/2003 -0400, Christopher Faylor wrote:
>Nevermind.  It doesn't work the way I remembered.  The while loop which
>decrements sigtodo only executes once when it encounters a normal UNIX
>signal (it probably should just be recoded as an if).  So, this should
>be a non-issue.  In fact, I don't see how multiple signals coming in at
>the same time would have the effect you mentioned either.
>
I don't understand. The sigtodo of a signal is decremented once
but the code immediately continues in the for loop for the next signal.
Two signals can be processed during a cycle of the outside for (;;) and
they will have the same rc.

Pierre

