Return-Path: <cygwin-patches-return-4729-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12372 invoked by alias); 7 May 2004 14:51:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12308 invoked from network); 7 May 2004 14:51:45 -0000
Message-ID: <409BA27E.379C0E06@hot.pl>
Date: Fri, 07 May 2004 14:51:00 -0000
From: Jacek Trzmiel <sc0rp@hot.pl>
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fix gethwnd race
References: <Pine.CYG.4.58.0405061902370.636@fordpc.vss.fsi.com> <20040507032703.GA950@coe.bosbc.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q2/txt/msg00081.txt.bz2


> On Thu, May 06, 2004 at 07:18:39PM -0500, Brian Ford wrote:
> >Although not the complete rewrite you may have been hoping for, the
> >attached patch does appear to fix the:
> >Winmain: Cannot register window class, Win32 error 1410
> >portion of this bug:
> >http://www.cygwin.com/ml/cygwin/2004-05/msg00232.html

Christopher Faylor wrote:
> Thanks, but, I see that you're using busy loops.  I use those in places
> where I have no choice but to do so or when the potential for a race is
> unlikely.
> 
> I don't think that this is really a situation that qualifies for either.
> It seems like a muto is a cleaner choice here.

I can change it to use critical section.  I just have one question -
where would be good place to put InitializeCriticalSection call?

Best regards,
Jacek.
