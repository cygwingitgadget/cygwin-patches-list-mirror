Return-Path: <cygwin-patches-return-3003-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 6984 invoked by alias); 19 Sep 2002 12:46:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6969 invoked from network); 19 Sep 2002 12:46:25 -0000
Message-ID: <3D89C74A.83D2CE15@yahoo.com>
Date: Thu, 19 Sep 2002 05:46:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
Reply-To: cygwin-patches@cygwin.com
X-Accept-Language: en
MIME-Version: 1.0
To: Chris January <chris@atomice.net>
CC: "Cygwin-Patches@Cygwin.Com" <cygwin-patches@cygwin.com>
Subject: Re: More changes about open on Win95 directories.
References: <LPEHIHGCJOAIPFLADJAHEECDCNAA.chris@atomice.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00451.txt.bz2

Chris January wrote:
> 
> > > Is '!' invalid? It can easily be confused with '|'.
> >
> > Maybe ':' ?
> >
> > > I am bothered that the code uses 0 as an illegal
> > > handle value. Is that really the case?
> >
> > No.
> > /usr/include/w32api/winbase.h:232:#define INVALID_HANDLE_VALUE
> > (HANDLE)(-1)
> It's not quite as simple as that...
> Although CreateFile will return INVALID_HANDLE_VALUE when an error occurs,
> other Win32 functions will return NULL instead. The only way to tell is to
> read the SDK docs.
> 

So, it's the standard consistency of inconsistency. :)

Earnie.

- I seem to at times have CRS (Cranial Retention Syndrome)
						- me -
