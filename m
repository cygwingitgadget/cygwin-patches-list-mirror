Return-Path: <cygwin-patches-return-6728-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22019 invoked by alias); 6 Oct 2009 21:09:20 -0000
Received: (qmail 22009 invoked by uid 22791); 6 Oct 2009 21:09:19 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-48-2.bstnma.east.verizon.net (HELO cgf.cx) (173.76.48.2)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 06 Oct 2009 21:09:16 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 5F71E3B0002 	for <cygwin-patches@cygwin.com>; Tue,  6 Oct 2009 17:09:06 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 570402B352; Tue,  6 Oct 2009 17:09:06 -0400 (EDT)
Date: Tue, 06 Oct 2009 21:09:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add wrappers for ExitProcess, TerminateProcess
Message-ID: <20091006210906.GB18969@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4ACAC079.2020105@cwilson.fastmail.fm>  <20091006074620.GA13712@calimero.vinschen.de>  <4ACB56D5.4060606@cwilson.fastmail.fm>  <4ACB670F.2070209@cwilson.fastmail.fm>  <20091006182221.GD18135@ednor.casa.cgf.cx>  <4ACB9042.3070104@cwilson.fastmail.fm>  <20091006193502.GA18384@ednor.casa.cgf.cx>  <4ACB9FBE.5080700@cwilson.fastmail.fm>  <20091006202915.GA18969@ednor.casa.cgf.cx>  <4ACBB03A.6030009@cwilson.fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ACBB03A.6030009@cwilson.fastmail.fm>
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
X-SW-Source: 2009-q4/txt/msg00059.txt.bz2

On Tue, Oct 06, 2009 at 05:01:46PM -0400, Charles Wilson wrote:
>So, to avoid requiring #include <windows.h>, I guess the next best thing
>is option #3, right?
>
>> 3) use bool in static function exit_process, use unsigned long in
>> cygwin_internal and callers.

Actually, I'd just use int for the external "bool" field and bool
internally.  I was proposing unsigned long for the UINT field but I've
given up on that.

(I can't believe that I'm having an anal bool discussion in a cygwin list
after heroically avoiding it at my real job for months)

cgf
