Return-Path: <cygwin-patches-return-6663-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9826 invoked by alias); 30 Sep 2009 15:24:58 -0000
Received: (qmail 9787 invoked by uid 22791); 30 Sep 2009 15:24:53 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-98-110-183-151.bstnma.fios.verizon.net (HELO cgf.cx) (98.110.183.151)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 30 Sep 2009 15:24:48 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 698EE13C002 	for <cygwin-patches@cygwin.com>; Wed, 30 Sep 2009 11:24:38 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 6543C2B352; Wed, 30 Sep 2009 11:24:38 -0400 (EDT)
Date: Wed, 30 Sep 2009 15:24:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: detect . in a/.//
Message-ID: <20090930152438.GA11977@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AC34A01.4070509@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AC34A01.4070509@byu.net>
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
X-SW-Source: 2009-q3/txt/msg00117.txt.bz2

On Wed, Sep 30, 2009 at 06:07:29AM -0600, Eric Blake wrote:
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>My testing on rename found another corner case: we rejected
>rename("dir","a/./") but accepted rename("dir","a/.//").  OK to commit?
>
>For reference, the test I am writing for hammering rename() and renameat()
>corner cases is currently visible here; it will be part of the next
>coreutils release, among other places.  It currently stands at 400+ lines,
>and exposes bugs in NetBSD, Solaris 10, mingw, and cygwin 1.5, but passes
>on cygwin 1.7 (after this patch) and on Linux:
>http://repo.or.cz/w/gnulib/ericb.git?a=blob;f=tests/test-rename.h
>
>2009-09-30  Eric Blake  <ebb9@byu.net>
>
>	* path.cc (has_dot_last_component): Detect "a/.//".

No, I don't think so.  I don't think this function is right.  It
shouldn't be doing a strrchr(dir, '//).  And the formatting is off
slightly.

Is this function supposed to detect just "." or "*/."?

cgf
