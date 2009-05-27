Return-Path: <cygwin-patches-return-6524-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11483 invoked by alias); 27 May 2009 21:14:56 -0000
Received: (qmail 11472 invoked by uid 22791); 27 May 2009 21:14:55 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-126-240-136.bstnma.fios.verizon.net (HELO cgf.cx) (71.126.240.136)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 27 May 2009 21:14:51 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id A6D5E13C0C3 	for <cygwin-patches@cygwin.com>; Wed, 27 May 2009 17:14:41 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 990FA6BB96A; Wed, 27 May 2009 17:14:41 -0400 (EDT)
Date: Wed, 27 May 2009 21:14:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Re: [1.5] ls -l on /cygdrive/d doesn't work
Message-ID: <20090527211441.GA11382@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4A1BC73F.5090300@sysgo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A1BC73F.5090300@sysgo.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q2/txt/msg00066.txt.bz2

On Tue, May 26, 2009 at 12:41:03PM +0200, David Engraf wrote:
>I have fixed the error in ntea.cc handling the return value of 
>NTQueryEaFile. This patch is only needed for the 1.5 release. Maybe this 
>error should be considered as critical due to uninitialized stack usage 
>of the variable fea when the function returned an error.
>
>
>2009-05-26 David Engraf <david.engraf@sysgo.com>
>
>	* ntea.cc (read_ea): Fix error handling and avoid using
>	uninitialized stack.

Thanks for the patch but this will have to be a known limitation of
1.5.x.  We don't plan on making any new releases before 1.7 is rolled
out.

cgf
