Return-Path: <cygwin-patches-return-6612-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2251 invoked by alias); 3 Sep 2009 19:17:36 -0000
Received: (qmail 2240 invoked by uid 22791); 3 Sep 2009 19:17:35 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-54-238.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.54.238)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 03 Sep 2009 19:17:27 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 95F5A13C0C4 	for <cygwin-patches@cygwin.com>; Thu,  3 Sep 2009 15:17:17 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 4B4EB2B352; Thu,  3 Sep 2009 15:17:17 -0400 (EDT)
Date: Thu, 03 Sep 2009 19:17:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: fcntl bug
Message-ID: <20090903191717.GA3998@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4A8F0944.5020004@byu.net>  <4A8F1819.9060209@sipxx.com>  <4A8F19DC.8060104@byu.net>  <20090822001027.GB8375@ednor.casa.cgf.cx>  <loom.20090824T170139-863@post.gmane.org>  <4A9B1A3B.9070600@byu.net>  <20090831005538.GH2068@ednor.casa.cgf.cx>  <4AA013D2.5060702@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AA013D2.5060702@byu.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00066.txt.bz2

On Thu, Sep 03, 2009 at 01:06:58PM -0600, Eric Blake wrote:
>> If it is important to you then please provide a patch.
>
>2009-09-03  Eric Blake  <ebb9@byu.net>
>
>	* dtable.h (OPEN_MAX_MAX): New macro.
>	* resource.cc (getrlimit) [RLIMIT_NOFILE]: Use it.
>	* dtable.cc (dtable::extend): Likewise.
>	* fcntl.cc (fcntl64): Obey POSIX rules.
>	* syscalls.cc (dup2): Likewise.

Thanks for the patch.  Go ahead and check this in.

In particular, thanks for turning (100 * NOFILE_INCR) into a #define.

cgf
