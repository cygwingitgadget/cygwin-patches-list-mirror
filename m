Return-Path: <cygwin-patches-return-4768-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5097 invoked by alias); 16 May 2004 04:25:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5085 invoked from network); 16 May 2004 04:25:27 -0000
Date: Sun, 16 May 2004 04:25:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fix gethwnd race
Message-ID: <20040516042527.GA30387@coe.bosbc.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0405061902370.636@fordpc.vss.fsi.com> <20040507032703.GA950@coe.bosbc.com> <Pine.CYG.4.58.0405131444340.3944@fordpc.vss.fsi.com> <20040513200801.GA8666@coe.bosbc.com> <Pine.CYG.4.58.0405131519060.3944@fordpc.vss.fsi.com> <20040513210306.GD11731@coe.bosbc.com> <Pine.CYG.4.58.0405131614030.3944@fordpc.vss.fsi.com> <20040514042403.GA20769@coe.bosbc.com> <Pine.CYG.4.58.0405141004020.3944@fordpc.vss.fsi.com> <20040514162017.GA21214@coe.bosbc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040514162017.GA21214@coe.bosbc.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00120.txt.bz2

On Fri, May 14, 2004 at 12:20:18PM -0400, Christopher Faylor wrote:
>I need to do a little debugging on what I have but it does try to clean
>up the windows code slightly.  I even eliminated the thread event
>synchronization entirely.

This is now checked in.  In the end, I implemented a new method for
passing off an acquired muto to another thread.  This avoids the need
for allocating another event.  I can use this technique elsewhere, too.

So, I revamped window.cc and did a minor revamp and cleanup on mutos.
This is not something I would have expected anyone else to do.

Thanks again for putting the effort into producing a patch.  In the end,
I just decided to go with my original observation that this code needed
some major work.  And, I'm not done yet...

cgf
