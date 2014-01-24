Return-Path: <cygwin-patches-return-7951-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27235 invoked by alias); 24 Jan 2014 20:34:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 27189 invoked by uid 89); 24 Jan 2014 20:34:21 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.7 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2
X-HELO: mho-02-ewr.mailhop.org
Received: from mho-02-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Fri, 24 Jan 2014 20:34:19 +0000
Received: from pool-108-49-99-58.bstnma.fios.verizon.net ([108.49.99.58] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf-use-the-mailinglist-please@cygwin.com>)	id 1W6nSD-000Pe6-5P	for cygwin-patches@cygwin.com; Fri, 24 Jan 2014 20:34:17 +0000
Received: from ednor (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with SMTP id 59048600DD	for <cygwin-patches@cygwin.com>; Fri, 24 Jan 2014 15:34:15 -0500 (EST)
Received: by ednor (sSMTP sendmail emulation); Fri, 24 Jan 2014 15:34:15 -0500
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX18jQaQ70R4fpHkByXxAT5+A
Date: Fri, 24 Jan 2014 20:34:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix parameter passing containing quote/equal to Windows batch command
Message-ID: <20140124203415.GA6857@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CABDpyCh3VMDmd4Rb64Fz-cb2HzUwtZ0cY9T3xWUC8_O-eqKO6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABDpyCh3VMDmd4Rb64Fz-cb2HzUwtZ0cY9T3xWUC8_O-eqKO6Q@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SW-Source: 2014-q1/txt/msg00024.txt.bz2

On Sun, Jan 19, 2014 at 10:02:56PM -0800, Daniel Dai wrote:
>We notice one issue when running a Windows batch command inside
>cygwin. Here is one example.
>
>Simple batch file:
>a.bat:
>echo %1
>
>Run it under cygwin:
>./a.bat a=b
>a
>
>./a.bat "a=b"
>a
>
>If we pass additional \"
>./a.bat "\"a=b\""
>"\"a
>
>There seems no way to pass a=b into bat.
>
>Attach quote.patch contains a fix. It does two things:
>1. If the parameter contains a equal sign, automatically add quote
>(similar to space, tab, new line, quote cygwin already do)
>2. If the parameter is already quoted, don't quote again

I don't understand the 2) part of the patch.  If the parameter contains
a quote then the quote needs to be transmitted to the subprocess.
That's what is happening right now.  That allows:

"\"foo bar\""

to be seen by the subprocess as "foo bar", quotes and all.

I'm going to add '=' to the list of special characters but I don't
see the need for the rest of that patch.

(Sorry for the delay in responding.  A hard drive failure wiped out
my cygwin cross-compil stuff.  Amazingly enough, I have recent
backups)

cgf
