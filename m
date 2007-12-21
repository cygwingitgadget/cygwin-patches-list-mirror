Return-Path: <cygwin-patches-return-6204-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26468 invoked by alias); 21 Dec 2007 03:35:20 -0000
Received: (qmail 26457 invoked by uid 22791); 21 Dec 2007 03:35:20 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 21 Dec 2007 03:35:16 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1J5YfK-0007re-Kf 	for cygwin-patches@cygwin.com; Fri, 21 Dec 2007 03:35:14 +0000
Message-ID: <476B3472.17126868@dessent.net>
Date: Fri, 21 Dec 2007 03:35:00 -0000
From: Brian Dessent <brian@dessent.net>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] un-NT-ify cygcheck (was: cygwin 1.5.25-7: cygcheck 	does   not   work?)
References: <836045.82708.qm@web33207.mail.mud.yahoo.com> <476A726D.50100@byu.net> <476A78EF.2322FB0A@dessent.net> <476A8729.5C05B169@dessent.net> <20071220211130.GA28771@ednor.casa.cgf.cx> <047a01c84375$2f2cf810$2e08a8c0@CAM.ARTIMI.COM> <20071221030715.GB28930@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00056.txt.bz2

Christopher Faylor wrote:

> Unless Corinna says differently, I think she wants to be in control of
> what goes into the branch so I don't want to suggest that you should
> check it in there too.

Okay, I'll let her take care of the branch since she's been handling all
the releases from it.

> The problem in this case would be "Hey!  Look at what cygcheck is saying!
> You are using Windows 9x!  You can't do that!"

In a sense it already does this:

    case VER_PLATFORM_WIN32_WINDOWS:
      switch (osversion.dwMinorVersion)
	{
	case 0:
	  osname = "95 (not supported)";
	  break;
	case 10:
	  osname = "98 (not supported)";
	  break;
	case 90:
	  osname = "ME (not supported)";
	  break;
	default:
	  osname = "9X (not supported)";
	  break;
	}
      break;

Brian
