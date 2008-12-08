Return-Path: <cygwin-patches-return-6377-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6322 invoked by alias); 8 Dec 2008 11:53:24 -0000
Received: (qmail 6311 invoked by uid 22791); 8 Dec 2008 11:53:24 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 08 Dec 2008 11:52:49 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 5036C6D4356; Mon,  8 Dec 2008 12:54:33 +0100 (CET)
Date: Mon, 08 Dec 2008 11:53:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Avoid duplicate names in /proc/registry (which may 	crash   find)
Message-ID: <20081208115433.GX12905@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <49384250.7080707@t-online.de> <20081205095742.GP12905@calimero.vinschen.de> <4939A9F7.1000400@t-online.de> <20081207171802.GV12905@calimero.vinschen.de> <493C1DF7.6090905@t-online.de> <20081208114800.GW12905@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20081208114800.GW12905@calimero.vinschen.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00021.txt.bz2

On Dec  8 12:48, Corinna Vinschen wrote:
> On Dec  7 20:03, Christian Franke wrote:
> > Corinna Vinschen wrote:
> >> ...
> >>> With the attached patch, a duplicate name "foo" is handled as follows:
> >>>
> >>> - readdir() returns the key as "foo" and the value as "foo%val".
> >>> - If the name is "foo%val", stat() and open() consider only the value 
> >>> "foo".
> >>[...]
> >> Cool.  Can you please send a ChangeLog entry as well?
> >
> > Of course:
> 
> Thanks!  Patch applied.

Oh, btw.

I was wondering if you would be not too disgusted by the idea to add
some documentation about this change to the Cygwin User's Guide.
There's already some blurb in pathnames.sgml about the /proc/registry
access.  Currently it lacks a description of the entire % handling.
Maybe it would be helpful to break out an entire (small) section for the
/proc/registry access...


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
