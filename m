Return-Path: <cygwin-patches-return-7995-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30898 invoked by alias); 26 May 2014 23:54:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 30882 invoked by uid 89); 26 May 2014 23:54:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2
X-HELO: mho-01-ewr.mailhop.org
Received: from mho-03-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.66) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Mon, 26 May 2014 23:54:12 +0000
Received: from pool-98-110-183-166.bstnma.fios.verizon.net ([98.110.183.166] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf-use-the-mailinglist-please@cygwin.com>)	id 1Wp4iY-000H69-98	for cygwin-patches@cygwin.com; Mon, 26 May 2014 23:54:10 +0000
Received: from ednor (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with SMTP id A9ED0600E3	for <cygwin-patches@cygwin.com>; Mon, 26 May 2014 19:54:08 -0400 (EDT)
Received: by ednor (sSMTP sendmail emulation); Mon, 26 May 2014 19:54:08 -0400
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/BMW/8PG4jjJkTQhg5JpJy
Date: Mon, 26 May 2014 23:54:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin_rexec() returns pointer to deallocated memory
Message-ID: <20140526235408.GA2716@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <53811668.5010208@tiscali.co.uk> <5382E760.7@lysator.liu.se> <538312E4.1040201@tiscali.co.uk> <5383434B.8070508@lysator.liu.se> <53835D4E.9040603@tiscali.co.uk> <20140526163505.GA7018@ednor.casa.cgf.cx> <5383A667.9070407@lysator.liu.se> <20140526214049.GB4754@ednor.casa.cgf.cx> <20140526214610.GA6786@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140526214610.GA6786@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SW-Source: 2014-q2/txt/msg00018.txt.bz2

On Mon, May 26, 2014 at 05:46:10PM -0400, Christopher Faylor wrote:
>Btw, the latest version of freebsd can't have this particular problem
>since ahostbuf is now gone.  We probably should pull in the latest version
>into Cygwin's tree.

...and that's apparently because Corinna added the code in question...

cgf
