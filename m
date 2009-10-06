Return-Path: <cygwin-patches-return-6726-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19811 invoked by alias); 6 Oct 2009 20:29:29 -0000
Received: (qmail 19799 invoked by uid 22791); 6 Oct 2009 20:29:29 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-48-2.bstnma.east.verizon.net (HELO cgf.cx) (173.76.48.2)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 06 Oct 2009 20:29:25 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id C076B3B0002 	for <cygwin-patches@cygwin.com>; Tue,  6 Oct 2009 16:29:15 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id BCCBE2B352; Tue,  6 Oct 2009 16:29:15 -0400 (EDT)
Date: Tue, 06 Oct 2009 20:29:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add wrappers for ExitProcess, TerminateProcess
Message-ID: <20091006202915.GA18969@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4ACA5BC7.6090908@cwilson.fastmail.fm>  <20091006034229.GA12172@ednor.casa.cgf.cx>  <4ACAC079.2020105@cwilson.fastmail.fm>  <20091006074620.GA13712@calimero.vinschen.de>  <4ACB56D5.4060606@cwilson.fastmail.fm>  <4ACB670F.2070209@cwilson.fastmail.fm>  <20091006182221.GD18135@ednor.casa.cgf.cx>  <4ACB9042.3070104@cwilson.fastmail.fm>  <20091006193502.GA18384@ednor.casa.cgf.cx>  <4ACB9FBE.5080700@cwilson.fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ACB9FBE.5080700@cwilson.fastmail.fm>
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
X-SW-Source: 2009-q4/txt/msg00057.txt.bz2

On Tue, Oct 06, 2009 at 03:51:26PM -0400, Charles Wilson wrote:
>Having said all that, I really don't care one way or the other. We have
>three possibilities:
>
>1) current iteration (BOOL in cygwin_internal coerced to bool for static
>function exit_process)
>2) use bool throughout exceptions.cc, and expect caller to use C++ bool,
>C99 bool, or stdbool.h bool.

Since, as you say, we use DWORD in other places, I'm going to opt for
what I originally proposed.  Change BOOL to bool since there is no reason
to use the Windows API BOOL type.  Do that everywhere in your change that
it makes sense.  Leave the UINT alone.

cgf
