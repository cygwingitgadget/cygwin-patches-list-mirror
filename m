Return-Path: <cygwin-patches-return-4115-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29187 invoked by alias); 19 Aug 2003 04:22:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29171 invoked from network); 19 Aug 2003 04:22:21 -0000
Date: Tue, 19 Aug 2003 04:22:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Signal handling tune up.
Message-ID: <20030819042216.GB9022@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030819005832.GB4303@redhat.com> <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com> <20030819005832.GB4303@redhat.com> <3.0.5.32.20030818225010.0080e4c0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030818225010.0080e4c0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00131.txt.bz2

On Mon, Aug 18, 2003 at 10:50:10PM -0400, Pierre A. Humblet wrote:
>At 09:05 PM 8/18/2003 -0400, Christopher Faylor wrote:
>>Nevermind.  It doesn't work the way I remembered.  The while loop which
>>decrements sigtodo only executes once when it encounters a normal UNIX
>>signal (it probably should just be recoded as an if).  So, this should
>>be a non-issue.  In fact, I don't see how multiple signals coming in at
>>the same time would have the effect you mentioned either.
>>
>I don't understand. The sigtodo of a signal is decremented once
>but the code immediately continues in the for loop for the next signal.
>Two signals can be processed during a cycle of the outside for (;;) and
>they will have the same rc.

Oh, right.  I was remembering a time when the inner while used to
exhaust the InterlockedDecrement.  It doesn't do that anymore but that
hardly matters because, as you say, it is possible to the current code
to be confused by "simultaneous" signals coming from the outside and
from the current process.

The only way I can think of around that is to add another an internal
sigtodo array to every process just for signals sent to myself and scan
that and the sigtodo process table.  I guess I'll implement that in the
next couple of days.

So, yes, this could be responsible for some strange signal hangs.

cgf
