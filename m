Return-Path: <cygwin-patches-return-1621-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 10597 invoked by alias); 21 Dec 2001 08:00:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10528 invoked from network); 21 Dec 2001 08:00:03 -0000
Message-ID: <20011221080001.90765.qmail@web14506.mail.yahoo.com>
Date: Thu, 08 Nov 2001 15:24:00 -0000
From: =?iso-8859-1?q?Danny=20Smith?= <danny_r_smith_2001@yahoo.co.nz>
Subject: Re: src/winsup/w32api ChangeLog include/wingdi.h
To: cygwin-patches <cygwin-patches@cygwin.com>, rbcollins@cygwin.com
In-Reply-To: <20011221065358.25757.qmail@sources.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SW-Source: 2001-q4/txt/msg00153.txt.bz2

 --- rbcollins@cygwin.com wrote: > CVSROOT:	/cvs/src
> Module name:	src
> Changes by:	rbcollins@sources.redhat.com	2001-12-20 22:53:57
> 
> Modified files:
> 	winsup/w32api  : ChangeLog 
> 	winsup/w32api/include: wingdi.h 
> 
> Log message:
> 	2001-12-21  Robert Collins  <rbtcollins@hotmail.com>
> 	
> 	* include/wingdi.h: Add GetRandomRgn and SYSRGN.
> 
Robert. I know your intentions were good, but please there is no need to
submit to the patch tracker page at mingw SourceForge site as well. That is
for submission of new patches needing review.  Unless you make clear that
you have comitted this patch to winsup CVS, it may lead to someone else
(like myself) checking in your patch to the SourceForge CVS (perhaps
modified) leading to conflicts at merging.

Also, in future, keeping to the general layout of existing w32api headers
(defines, then typedefs, then prototypes) would be good.  This makes it
easier to protect typedefs and prototypes against RC_INVOKED, while leaving
the constants visible to windres.

Thanks

Danny



http://greetings.yahoo.com.au - Yahoo! Greetings
- Send your festive greetings online!
