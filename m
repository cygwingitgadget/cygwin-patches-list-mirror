Return-Path: <cygwin-patches-return-2906-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24445 invoked by alias); 1 Sep 2002 13:25:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24426 invoked from network); 1 Sep 2002 13:25:55 -0000
X-WM-Posted-At: avacado.atomice.net; Sun, 1 Sep 02 14:09:52 +0100
From: "Chris January" <chris@atomice.net>
To: "Ville Herva" <vherva@niksula.hut.fi>
Cc: "Cygwin-Patches@Cygwin.Com" <cygwin-patches@cygwin.com>
Subject: RE: Unicode filename patch
Date: Sun, 01 Sep 2002 06:25:00 -0000
Message-ID: <LPEHIHGCJOAIPFLADJAHEEFHCLAA.chris@atomice.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
In-Reply-To: <20020901082424.GN3568@niksula.cs.hut.fi>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
X-SW-Source: 2002-q3/txt/msg00354.txt.bz2

> Hi,
>
> I haven't been able to follow cygwin ml for a while (too busy at
> work ;( ),
> but did Christopher Faylor ever consider merging the unicode
> filename patch
> you created? I followed CVS for a while, but it didn't appear there (I
> haven't checked lately, though.)
Ask on cygwin-patches what Chris wants to do with it. It's best discussed
there.

BTW, the patch is not complete; certain functions don't work. It's main
purpose was to allow reading and writing files with Unicode filenames -
something that wasn't possible at all before.

Saying that, it did work quite well with UTF8 aware shell tools and a UTF8
terminal.

Chris
