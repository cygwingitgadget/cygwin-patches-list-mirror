Return-Path: <cygwin-patches-return-7065-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16026 invoked by alias); 10 Aug 2010 01:23:52 -0000
Received: (qmail 16014 invoked by uid 22791); 10 Aug 2010 01:23:51 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-48-4.bstnma.east.verizon.net (HELO cgf.cx) (173.76.48.4)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 10 Aug 2010 01:23:47 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 17E1B13C061	for <cygwin-patches@cygwin.com>; Mon,  9 Aug 2010 21:23:46 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id 0650A2B352; Mon,  9 Aug 2010 21:23:46 -0400 (EDT)
Date: Tue, 10 Aug 2010 01:23:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] adjust to mingw sysroot
Message-ID: <20100810012345.GA18526@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1281393516.6576.29.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1281393516.6576.29.camel@YAAKOV04>
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
X-SW-Source: 2010-q3/txt/msg00025.txt.bz2

On Mon, Aug 09, 2010 at 05:38:36PM -0500, Yaakov (Cygwin/X) wrote:
>winsup/utils/mingw will break once mingw-* moves into a sysroot.  The
>attached patch allows for the sysroot without (hopefully) breaking
>pre-sysroot installations.
>
>It may be a bit premature to commit this, but this transition will
>otherwise break the Cygwin build so I didn't want any surprises.

This what I planned on doing once things stabilized but if the location
has stabilized then please commit.

Thanks.

cgf
