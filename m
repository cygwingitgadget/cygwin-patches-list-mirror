Return-Path: <cygwin-patches-return-4119-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 456 invoked by alias); 19 Aug 2003 20:46:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 437 invoked from network); 19 Aug 2003 20:46:39 -0000
Date: Tue, 19 Aug 2003 20:46:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Signal handling tune up.
Message-ID: <20030819204639.GA22125@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030819024617.GA6581@redhat.com> <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com> <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com> <3.0.5.32.20030818222927.008114e0@incoming.verizon.net> <20030819024617.GA6581@redhat.com> <3.0.5.32.20030819084636.0081c730@incoming.verizon.net> <20030819143305.GA17431@redhat.com> <3F4288CE.C5133419@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F4288CE.C5133419@ieee.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00135.txt.bz2

On Tue, Aug 19, 2003 at 04:30:06PM -0400, Pierre A. Humblet wrote:
>Christopher Faylor wrote:
>
>> >Don't we have the same problem today?
>> >
>> >Handler is running with current mask M1, old mask M0
>> >New signal occurs, sigthread prepares sigsave with new mask M2, old mask M1
>> > but is preempted before setting sigsave.sig
>> >Handler terminates, restores M0
>> >sigthread resumes and starts new handler. It runs with M2 and restores
>> >M1 (instead of M0) at end.
>> 
>> Is this any different from UNIX?  Some races in signal handling are
>> inavoidable, IMO.  I guess you could make things slightly more
>> determinstic by setting a lock.  Probably UNIX has the luxury of being
>> able to tell the process handling a signal to stop working for a second
>> while it fiddles with masks.  We don't have any reliable way of doing
>> that.
>
>Here is a safe way.
>
>1) change sigsave to contain the incremental mask bits, set by sigthread
>   (instead of old mask and new mask) 

And while you are in the process of saving the incremental bits, they
are in the process of being changed == race.  I don't see why this adds
anything.  I'm also not sure that this is posix-sanctioned behavior.

cgf
