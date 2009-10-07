Return-Path: <cygwin-patches-return-6735-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14458 invoked by alias); 7 Oct 2009 00:02:16 -0000
Received: (qmail 14362 invoked by uid 22791); 7 Oct 2009 00:02:14 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-48-2.bstnma.east.verizon.net (HELO cgf.cx) (173.76.48.2)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 07 Oct 2009 00:02:09 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id AB3A13B0002 	for <cygwin-patches@cygwin.com>; Tue,  6 Oct 2009 20:01:59 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id A5B9A2B352; Tue,  6 Oct 2009 20:01:59 -0400 (EDT)
Date: Wed, 07 Oct 2009 00:02:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Merge pseudo-reloc-v2 support from mingw/pseudo-reloc.c
Message-ID: <20091007000159.GA12885@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4ACBD892.5040508@cwilson.fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ACBD892.5040508@cwilson.fastmail.fm>
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
X-SW-Source: 2009-q4/txt/msg00066.txt.bz2

On Tue, Oct 06, 2009 at 07:53:54PM -0400, Charles Wilson wrote:
>As discussed on cygwin-developers...
>http://cygwin.com/ml/cygwin-developers/2009-10/msg00052.html
>and thread. Please refer to that thread for the justification of this
>patch, and some of the details of its evolution.
>
>The changelog entry below is somewhat odd (multiple sections) because of
>the licensing differences in the various files. Kai's only contribution
>was to the pseudo-reloc.c code, which is entirely public domain (and he
>placed his contributions to that file into the public domain, as well).
>Similarly, my contributions to pseudo-reloc.c are also public domain.
>
>Bowever, the changes to the other cygwin files are mine and are covered
>by assignment to Red Hat.
>
>Hence, three separate "entries". One question: when it comes time to
>commit this to CVS, should it be done all in one lump, or 1-2-3 very
>quick separate commits (even though the tree would be broken between,
>say, #1 and #2)?

I don't see why you shouldn't check in everything together since it's
all one "change set". It's not like you could just back out Kai's changes
individually and still get a working cygwin, right?

cgf
