Return-Path: <cygwin-patches-return-4441-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5870 invoked by alias); 26 Nov 2003 03:13:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5861 invoked from network); 26 Nov 2003 03:13:24 -0000
Message-Id: <3.0.5.32.20031125221219.0082f690@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Wed, 26 Nov 2003 03:13:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: Create Global Privilege
In-Reply-To: <20031126024744.GA28857@redhat.com>
References: <20031126021312.GD24422@redhat.com>
 <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net>
 <20031126021312.GD24422@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q4/txt/msg00160.txt.bz2

At 09:47 PM 11/25/2003 -0500, you wrote:
>On Tue, Nov 25, 2003 at 09:13:12PM -0500, Christopher Faylor wrote:
>>Other than that minor point, this looks ok.
>
>Sorry.  On rereading this this sounded rather lukewarm.  I'm very happy
>that you are fixing this problem.  I should probably let Corinna have
>the final word on this, though.
>
>Thanks.

OK, I will be out of town for a few days, so it would be nice if Corinna 
could apply it as well.

Regarding your remark, I had thought of putting prefix on the cygheap,
but that looked like overkill (could be done some day, together with 
cygwin_user_h and a few others).

With a few exceptions (e.g. utmp/wtmp handling in login/logout), shared_name
is only called when the map handle is NULL, e.g. when starting cygwin 
(thus relatively rarely).
It's also called for the title_mutex, but that's only needed for old systems 
that don't have GetConsoleWindow, so a better optimization would be to only
call it when needed. That mutex is a great DOS source. Fixing that is on
my todo list, as a side effect of more important stuff.

Pierre
