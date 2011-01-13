Return-Path: <cygwin-patches-return-7155-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13821 invoked by alias); 13 Jan 2011 15:39:41 -0000
Received: (qmail 12257 invoked by uid 22791); 13 Jan 2011 15:39:26 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-72-93-220-155.bstnma.fios.verizon.net (HELO cgf.cx) (72.93.220.155)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 13 Jan 2011 15:39:22 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id F062F13C0C9	for <cygwin-patches@cygwin.com>; Thu, 13 Jan 2011 10:39:19 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id D392D2B352; Thu, 13 Jan 2011 10:39:19 -0500 (EST)
Date: Thu, 13 Jan 2011 15:39:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygcheck -s should not imply -d
Message-ID: <20110113153919.GD10806@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4D24CB9A.2030906@dronecode.org.uk> <20110110125102.GA14789@calimero.vinschen.de> <20110110175244.GC10806@ednor.casa.cgf.cx> <20110111081043.GB8899@calimero.vinschen.de> <4D2C688E.9080204@dronecode.org.uk> <20110113123336.GA25033@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110113123336.GA25033@calimero.vinschen.de>
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
X-SW-Source: 2011-q1/txt/msg00010.txt.bz2

On Thu, Jan 13, 2011 at 01:33:36PM +0100, Corinna Vinschen wrote:
>On Jan 11 14:26, Jon TURNEY wrote:
>> On 11/01/2011 08:10, Corinna Vinschen wrote:
>> > I wasn't quite sure either, but while running cygcheck with Jon's patch
>> > it started to make more sense.  We can also change the docs to ask for
>> > `cygcheck -svrd' output, but I guess we should just wait and see.
>> 
>> FWIW (I don't have all packages installed), mutt is the only package I have
>> installed for which cygcheck -c falsely reports a problem.
>> 
>> $ cygcheck -c | grep -v OK
>> Cygwin Package Information
>> Package                        Version                  Status
>> mutt                           1.5.20-1                 Incomplete
>
>Do you happen to know why?

I know why.  It just isn't high on my list of things to fix.

cgf
