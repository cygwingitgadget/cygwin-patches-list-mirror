Return-Path: <cygwin-patches-return-3442-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22049 invoked by alias); 21 Jan 2003 17:57:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22040 invoked from network); 21 Jan 2003 17:57:33 -0000
Date: Tue, 21 Jan 2003 17:57:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Races in group/passwd code (was Re: etc_changed, passwd & group)
Message-ID: <20030121175854.GA15711@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030117233612.007ed390@mail.attbi.com> <3.0.5.32.20030120215131.007f9740@h00207811519c.ne.client2.attbi.com> <20030121051325.GA4667@redhat.com> <20030121153538.GA24356@redhat.com> <3E2D6CF9.FF47B7F4@ieee.org> <20030121161115.GA13536@redhat.com> <3E2D79A7.DCC9AF74@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E2D79A7.DCC9AF74@ieee.org>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00091.txt.bz2

On Tue, Jan 21, 2003 at 11:47:35AM -0500, Pierre A. Humblet wrote:
>Christopher Faylor wrote:
>
>> You'd need a per-thread buffer to accomplish that.  I assume that
>> is what you had in mind.
>
>If you look at them, most internal_get{pw,gr} calls from outside
>of passwd.cc and grp.cc only want the {u,g}id, the sid or the name,
>but never the other fields. 

getpwuid_r32

>I wanted to avoid copying the entire line, at least in the first
>two cases.

Not copying is a good goal.  I guess there is no reason why the lock
couldn't be exported to everyone.

Except for the problem with locks and signals, this isn't a big issue,
as you know.  However, since I was in the process of cleaning some of
this up, I thought I'd try to at least close the window a little.

>> I wonder how many inexplicable "cygwin hangs" issues this is
>> responsible for.
>
>Problems only happen when updating passwd/group while a program
>is running. At least in case of the recent BSOD, users were
>very good correlating the two events.

There is a potential for essentially causing a deadlock due to
the fact that pthread locks are not recognized by the signal code.
If a signal handler is called in the middle of a passwd or group
read, then there is a potential for a hang.  It's easy enough to
fix by using mutos and I will do that in the next couple of days.

cgf
