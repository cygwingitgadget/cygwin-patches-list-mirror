Return-Path: <cygwin-patches-return-7933-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31240 invoked by alias); 8 Jan 2014 05:43:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 31227 invoked by uid 89); 8 Jan 2014 05:43:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.7 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,USER_IN_WHITELIST autolearn=ham version=3.3.2
X-HELO: mho-01-ewr.mailhop.org
Received: from mho-03-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.66) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Wed, 08 Jan 2014 05:43:23 +0000
Received: from pool-108-49-99-58.bstnma.fios.verizon.net ([108.49.99.58] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf-use-the-mailinglist-please@cygwin.com>)	id 1W0lvF-0003Ro-8L	for cygwin-patches@cygwin.com; Wed, 08 Jan 2014 05:43:21 +0000
Received: from ednor (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with SMTP id D876B60125	for <cygwin-patches@cygwin.com>; Wed,  8 Jan 2014 00:43:19 -0500 (EST)
Received: by ednor (sSMTP sendmail emulation); Wed, 08 Jan 2014 00:43:19 -0500
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/CFPF4kLZa9NDbHC9+a0XY
Resent-From: Christopher Faylor <me@cgf.cx>
Resent-Date: Wed, 8 Jan 2014 00:43:19 -0500
Resent-Message-ID: <20140108054319.GB861@ednor.casa.cgf.cx>
Resent-To: cygwin-patches@cygwin.com
Date: Wed, 08 Jan 2014 05:43:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to optionally disable overlapped pipes
Message-ID: <20131225041237.GA6930@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <037b01cf00fc$11014c10$3303e430$@motionview3d.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <037b01cf00fc$11014c10$3303e430$@motionview3d.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SW-Source: 2014-q1/txt/msg00006.txt.bz2

On Tue, Dec 24, 2013 at 11:01:21PM -0000, James Johnston wrote:
>Hi,
>
>As I have recently mentioned on the main Cygwin mailing list, Cygwin by
>default creates FILE_FLAG_OVERLAPPED named pipes for the standard file
>handles (stdin/stdout/stderr).  These overlapped pipes require all programs
>using ReadFile/WriteFile to use overlapped I/O when using the pipes.

Thanks for the patch but Cygwin has been using overlapped I/O with pipes
for many years.  They are a requirement for proper operation with
signals.  We try to be very sparing when adding new options and we're
not going to add an option to make things work less reliably.

cgf
