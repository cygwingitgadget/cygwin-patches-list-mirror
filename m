Return-Path: <cygwin-patches-return-3567-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17675 invoked by alias); 13 Feb 2003 23:45:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17646 invoked from network); 13 Feb 2003 23:45:57 -0000
Message-ID: <02d101c2d3ba$0bd76b00$78d96f83@pomello>
From: "Max Bowsher" <maxb@ukf.net>
To: "Gary R Van Sickle" <tiberius@braemarinc.com>,
	<cygwin-patches@cygwin.com>
References: <000b01c2d3b9$41b49780$2101a8c0@BRAEMARINC.COM>
Subject: Re: Produce beeps using soundcard
Date: Thu, 13 Feb 2003 23:45:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-SW-Source: 2003-q1/txt/msg00216.txt.bz2

Gary R Van Sickle wrote:
> What am I missing here?  Beep (412, 100) ==> MessageBeep
> ((unsigned)-1) and we're done, right?  No need for any CYGWIN=
> hoobajoob or another static BOOL or anything.

Checking MSDN....
"If the sound card is not available, the sound is generated using the
speaker."

So that should be fine! Thanks for reminding me of the obvious!


Max.
