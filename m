Return-Path: <cygwin-patches-return-3437-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5879 invoked by alias); 21 Jan 2003 16:09:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5850 invoked from network); 21 Jan 2003 16:09:55 -0000
Date: Tue, 21 Jan 2003 16:09:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Races in group/passwd code (was Re: etc_changed, passwd & group)
Message-ID: <20030121161115.GA13536@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030117233612.007ed390@mail.attbi.com> <3.0.5.32.20030120215131.007f9740@h00207811519c.ne.client2.attbi.com> <20030121051325.GA4667@redhat.com> <20030121153538.GA24356@redhat.com> <3E2D6CF9.FF47B7F4@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E2D6CF9.FF47B7F4@ieee.org>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00086.txt.bz2

On Tue, Jan 21, 2003 at 10:53:29AM -0500, Pierre A. Humblet wrote:
>Christopher Faylor wrote:
>This has been there forever, I would not delay the release of 1.3.19

Did I say I was delaying anything?

>By the way, I wrote the internal_get{pw,gr} routines having in mind
>that they could be extended to handle those multiple access issues,

>avoiding to have to set and release locks in routines outside of
>passwd.cc and group.cc (with a few exceptions).

You'd need a per-thread buffer to accomplish that.  I assume that
is what you had in mind.

For the record, the current code isn't even signal safe, AFAICT.
I really should have dealt with this a while ago.  I wonder how
many inexplicable "cygwin hangs" issues this is responsible for.

cgf
