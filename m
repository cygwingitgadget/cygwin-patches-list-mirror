Return-Path: <cygwin-patches-return-3002-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18502 invoked by alias); 19 Sep 2002 10:39:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18488 invoked from network); 19 Sep 2002 10:39:33 -0000
X-WM-Posted-At: avacado.atomice.net; Thu, 19 Sep 02 11:39:30 +0100
From: "Chris January" <chris@atomice.net>
To: "Cygwin-Patches@Cygwin.Com" <cygwin-patches@cygwin.com>
Subject: RE: More changes about open on Win95 directories.
Date: Thu, 19 Sep 2002 03:39:00 -0000
Message-ID: <LPEHIHGCJOAIPFLADJAHEECDCNAA.chris@atomice.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
In-Reply-To: <00ed01c25fb7$1f9f6970$0100a8c0@wdg.uk.ibm.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
X-SW-Source: 2002-q3/txt/msg00450.txt.bz2

> > Is '!' invalid? It can easily be confused with '|'.
>
> Maybe ':' ?
>
> > I am bothered that the code uses 0 as an illegal
> > handle value. Is that really the case?
>
> No.
> /usr/include/w32api/winbase.h:232:#define INVALID_HANDLE_VALUE
> (HANDLE)(-1)
It's not quite as simple as that...
Although CreateFile will return INVALID_HANDLE_VALUE when an error occurs,
other Win32 functions will return NULL instead. The only way to tell is to
read the SDK docs.

Chris
