Return-Path: <cygwin-patches-return-6731-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27943 invoked by alias); 6 Oct 2009 21:24:29 -0000
Received: (qmail 27932 invoked by uid 22791); 6 Oct 2009 21:24:28 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-48-2.bstnma.east.verizon.net (HELO cgf.cx) (173.76.48.2)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 06 Oct 2009 21:24:24 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 9F8073B0002 	for <cygwin-patches@cygwin.com>; Tue,  6 Oct 2009 17:24:14 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 973F42B352; Tue,  6 Oct 2009 17:24:14 -0400 (EDT)
Date: Tue, 06 Oct 2009 21:24:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add wrappers for ExitProcess, TerminateProcess
Message-ID: <20091006212414.GA12340@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4ACB670F.2070209@cwilson.fastmail.fm>  <20091006182221.GD18135@ednor.casa.cgf.cx>  <4ACB9042.3070104@cwilson.fastmail.fm>  <20091006193502.GA18384@ednor.casa.cgf.cx>  <4ACB9FBE.5080700@cwilson.fastmail.fm>  <20091006202915.GA18969@ednor.casa.cgf.cx>  <4ACBB03A.6030009@cwilson.fastmail.fm>  <20091006210906.GB18969@ednor.casa.cgf.cx>  <4ACBB350.1090302@cwilson.fastmail.fm>  <4ACBB447.5070908@cwilson.fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ACBB447.5070908@cwilson.fastmail.fm>
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
X-SW-Source: 2009-q4/txt/msg00062.txt.bz2

On Tue, Oct 06, 2009 at 05:19:03PM -0400, Charles Wilson wrote:
>Charles Wilson wrote:
>
>> Oh, ok. I'm sorry; I misread that.  Sure, int is fine. I'll do that,
>> check that it actually builds and works (!), and check it in.  Thanks.
>
>Do I need to increment the minor version when adding a new
>cygwin_internal call?  It seems so:
>
>2009-01-09  Christopher Faylor
>
>        * include/sys/cygwin.h (CW_SETERRNO): Define.
>        * external.cc (CW_SETERRNO): Implement.
>        * include/cygwin/version.h: Bump CYGWIN_VERSION_API_MINOR to 192 to
>        reflect the above change.

Yes.  Thanks for catching that.

cgf
