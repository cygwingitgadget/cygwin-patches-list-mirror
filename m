Return-Path: <cygwin-patches-return-3675-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19506 invoked by alias); 7 Mar 2003 00:53:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19124 invoked from network); 7 Mar 2003 00:53:25 -0000
Message-ID: <20030307005324.84954.qmail@web21413.mail.yahoo.com>
Date: Fri, 07 Mar 2003 00:53:00 -0000
From: =?iso-8859-1?q?Danny=20Smith?= <danny_r_smith_2001@yahoo.co.nz>
Subject: RE: PATCH: Implements /proc/cpuinfo and /proc/partitions
To: Chris January <chris@atomice.net>, cygwin-patches@cygwin.com
In-Reply-To: <LPEHIHGCJOAIPFLADJAHGEFCDGAA.chris@atomice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SW-Source: 2003-q1/txt/msg00324.txt.bz2

 --- Chris January <chris@atomice.net> wrote: > > Chris January wrote:
> > >
> > > 2003-03-06  Christopher January  <chris@atomice.net>
> > >
> > > 	* include/winbase.h (FindFirstVolume): Add declaration.
> > > 	(FindNextVolume): Add declaration.
> > > 	(FindVolumeClose): Add declaration.
> > > 	(GetSystemTimes): Add declaration.
> > > 	* include/winnt.h: Add define for PF_XMMI64_INSTRUCTIONS_AVAILABLE.
> > >
> >

Thanks Chris, I've committed to w32api CVS.

Also added GetSystemTimes@12 to kernel32.def. The rest were already there.

Danny



http://mobile.yahoo.com.au - Yahoo! Mobile
- Check & compose your email via SMS on your Telstra or Vodafone mobile.
