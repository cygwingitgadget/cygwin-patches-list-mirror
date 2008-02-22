Return-Path: <cygwin-patches-return-6248-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32542 invoked by alias); 22 Feb 2008 05:00:47 -0000
Received: (qmail 32529 invoked by uid 22791); 22 Feb 2008 05:00:46 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-72-74-94-250.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (72.74.94.250)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 22 Feb 2008 05:00:23 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 7A86862D2D7; Fri, 22 Feb 2008 00:00:21 -0500 (EST)
Date: Fri, 22 Feb 2008 05:00:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: PATCH: avoid system shared memory version mismatch detected by 	versioning shared memory name
Message-ID: <20080222050020.GA17196@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <674fdff20802211641p19f7b3a1pb3f843ba262dfde6@mail.gmail.com> <674fdff20802211701u1a866d2fw2bb21047ecc5e8ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <674fdff20802211701u1a866d2fw2bb21047ecc5e8ea@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00022.txt.bz2

On Thu, Feb 21, 2008 at 05:01:20PM -0800, Noel Burton-Krahn wrote:
>This is a patch to avoid the "system shared memory version mismatch
>detected" problem when two applications use different versions of
>Cygwin.  My solution is to append the Cygwin version number to the
>name of the shared memory segment, so only Cygwin with the same
>version share a memory space.
>
>ChangeLog
>2008-02-21  Noel Burton-Krahn  <noel@burton-krahn.com>
>
>    * shared.cc (shared_name): always add USER_VERSION_MAGIC to the
>    shared memory space name so multiple versions of Cygwin keep their
>     own shared memory space.  No more "system shared memory version
>    mismatch detected"  errors.

Thanks for the patch but the whole reason for this detection and others
in the DLL is to disallow multiple copies of cygwin1.dll from running at
the same time.  This isn't a bug, it's a feature.  That's why we have
the detection in the first place.

As you can see from other checks in the dll, the shared memory region
is just one of the things that are checked for.  If you need to have
two copies of the DLL for debugging then there are ways to do that.
But, in general, it is not a good idea to use two versions of the DLL
unless you really know what you are doing, so we are not going to
be making it trivially possible for everyone to do that.

cgf
