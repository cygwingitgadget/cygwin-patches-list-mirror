Return-Path: <cygwin-patches-return-3561-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22653 invoked by alias); 13 Feb 2003 22:04:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22643 invoked from network); 13 Feb 2003 22:04:56 -0000
Date: Thu, 13 Feb 2003 22:04:00 -0000
From: Vaclav Haisman <V.Haisman@sh.cvut.cz>
To: cygwin-patches@cygwin.com
Subject: Re: Produce beeps using soundcard
In-Reply-To: <20030213204600.GH32279@redhat.com>
Message-ID: <20030213225108.H52833-100000@logout.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: AMaViS at Silicon Hill
X-Spam-Status: No, hits=-0.5 required=5.0
	tests=CARRIAGE_RETURNS,IN_REP_TO,QUOTED_EMAIL_TEXT,
	      SPAM_PHRASE_00_01
	version=2.43
X-Spam-Level: 
X-SW-Source: 2003-q1/txt/msg00210.txt.bz2

> I don't like to introduce lots of unnecessary decision points into a
> product.  It increases support and it increases code complexity.
This patch is literally few lines long. I doubt it adds much complexity.
>
> Once again, how does linux handle this scenario?  You don't do a
> "export LINUX=linbeep" to get linux to use the soundcard.
>
> cgf
>
I know only about one way how to do this in GNU/Linux. It is this
ftp://www.ibiblio.org/pub/Linux/kernel/patches/misc/modreq_beep.tgz kernel
module and user space daemon that gets notified whenever there is a beep
pending. IMHO this is much more complex than my patch. If you don't like using
new CYGWIN option I can make it registry value but I think that that is still
more complex than this patch.

Vaclav Haisman
