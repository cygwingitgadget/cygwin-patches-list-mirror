Return-Path: <cygwin-patches-return-3673-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18308 invoked by alias); 6 Mar 2003 23:43:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18299 invoked from network); 6 Mar 2003 23:43:43 -0000
From: "Chris January" <chris@atomice.net>
To: <cygwin-patches@cygwin.com>
Subject: RE: PATCH: Implements /proc/cpuinfo and /proc/partitions
Date: Thu, 06 Mar 2003 23:43:00 -0000
Message-ID: <LPEHIHGCJOAIPFLADJAHGEFCDGAA.chris@atomice.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <3E67DBA2.2020002@yahoo.com>
Importance: Normal
X-SW-Source: 2003-q1/txt/msg00322.txt.bz2

> Chris January wrote:
> >
> > 2003-03-06  Christopher January  <chris@atomice.net>
> >
> > 	* include/winbase.h (FindFirstVolume): Add declaration.
> > 	(FindNextVolume): Add declaration.
> > 	(FindVolumeClose): Add declaration.
> > 	(GetSystemTimes): Add declaration.
> > 	* include/winnt.h: Add define for PF_XMMI64_INSTRUCTIONS_AVAILABLE.
> >
>
> Do you plan to use these API?  You'll need to supply a corresponding
> patch to the appropriate .def file in the lib directory.

The Cygwin DLL uses autoload.cc to load its functions so it works without
the .def entries. Of the above I only use GetSystemTimes anyway. Do you want
the .def entries for completeness then? I was really providing a patch
against Cygwin, not w32api. I'm not really up to speed on what's necessary
for a w32api patch.

Chris
