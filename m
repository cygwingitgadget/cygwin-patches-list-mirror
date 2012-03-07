Return-Path: <cygwin-patches-return-7614-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18200 invoked by alias); 7 Mar 2012 10:04:27 -0000
Received: (qmail 17945 invoked by uid 22791); 7 Mar 2012 10:04:02 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 07 Mar 2012 10:03:46 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 0B5692C006E; Wed,  7 Mar 2012 11:03:44 +0100 (CET)
Date: Wed, 07 Mar 2012 10:04:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Changing MAXPATHLEN in glob.cc back to 16384
Message-ID: <20120307100343.GA12279@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <49D44181BE9446429E0DA767E6813C54F320@SJEXCHMB05.corp.ad.broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <49D44181BE9446429E0DA767E6813C54F320@SJEXCHMB05.corp.ad.broadcom.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q1/txt/msg00037.txt.bz2

On Mar  6 17:06, Piotr Foltyn wrote:
> Hi,
> 
> Revision 1.7 of src/winsup/cygwin/glob.cc reduced maximum allowed path length from 16384 to 4096 characters. This is unfortunate because some paths used in my build system can reach 6k characters in length. Attached patch reinstates 16384 characters limit.

MAXPATHLEN == PATH_MAX == 4096.  While the OS allows 32K char paths,
we don't support any longer paths than PATH_MAX.  There are other
restrictions in Cygwin based on PATH_MAX.

The problems with the size of MAXPATHLEN in glob.cc are:

- The buffer type is Char, which is defined as uint_fast64_t, which
  is 8 byte.

- The temporary buffers are allocated on the stack.  Each of them takes
  8 * MAXPATHLEN bytes,  32K vs. 128K.  3 of them are always needed,
  plus one MAXPATHLEN bytes buffer.  Additional MAXPATHLEN bytes buffers
  can be created via recursion.
  
- So the stack pressure just by calling glob and the glob internal
  functions it at least 400K if MAXPATHLEN is 16384.  That's quite a
  lot, given the default stacksizes of 2 Megs for the main thread and 1
  Meg for other threads.

Having said that, I'm willing to try with setting MAXPATHLEN to 8192.
I change that in CVS.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
