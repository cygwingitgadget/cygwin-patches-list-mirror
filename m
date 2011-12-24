Return-Path: <cygwin-patches-return-7572-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12323 invoked by alias); 24 Dec 2011 01:52:10 -0000
Received: (qmail 12312 invoked by uid 22791); 24 Dec 2011 01:52:09 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE
X-Spam-Check-By: sourceware.org
Received: from mho-02-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.72)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 24 Dec 2011 01:51:55 +0000
Received: from pool-173-76-42-41.bstnma.fios.verizon.net ([173.76.42.41] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1ReGmB-0006Cz-72	for cygwin-patches@cygwin.com; Sat, 24 Dec 2011 01:51:55 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id E819913C0CD	for <cygwin-patches@cygwin.com>; Fri, 23 Dec 2011 20:51:54 -0500 (EST)
X-Mail-Handler: MailHop Outbound by DynDNS
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/oK7Dvd668ffxtVz74cnd9
Date: Sat, 24 Dec 2011 01:52:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add support for creating native windows symlinks
Message-ID: <20111224015154.GB11770@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAL-4N9uVjoqNTXPQGvsjnT+q=KJx9_QNzT-m8U_K=46+zOyheQ@mail.gmail.com> <20111205101715.GA13067@calimero.vinschen.de> <CAL-4N9sx=asy0r3fcD65=WfvW0VHByv-Hn0CAJgaAFK3C8Vw_Q@mail.gmail.com> <CAL-4N9v8QU-mZfE-4gtpjtybD8A1BYt8QJNGAHOOHv25fkF0Mg@mail.gmail.com> <20111219155948.GA7148@calimero.vinschen.de> <CAL-4N9tALgoad1K+BKH3UoC4_viooeyt9KNHAxm1kwHWw8KcEw@mail.gmail.com> <20111220153404.GF23547@calimero.vinschen.de> <CAL-4N9tGWAK7nnGqcRMOgS8CTJoh7-nmrbinGndwxUEy5L-q2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL-4N9tGWAK7nnGqcRMOgS8CTJoh7-nmrbinGndwxUEy5L-q2Q@mail.gmail.com>
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
X-SW-Source: 2011-q4/txt/msg00062.txt.bz2

On Fri, Dec 23, 2011 at 01:38:07PM -0800, Russell Davis wrote:
>Sigh... I've already addressed all of these ponts (there are simple
>ways to handle to all of them). I'm done fighting this battle.

Actually, I don't think you did answer all of them.  But, regardless, to
summarize, what you were proposing was adding functionality to Cygwin
which would allow you to create and manipulate "native" symlinks on
systems >= Vista which would could only be guaranteed to work reliably
within Cygwin itself.  It would be possible, if you know the rules, to
create symlinks which would be usuable outside of Cygwin also.

Since the only benefit that I can see over the current symlinks is that
they could be usable under Windows, I, personally, don't think the
drawbacks to using this approach is worth the cost of further
complicating Cygwin's already labyrinthian path handling capabilities
especially since it seems like adding support to Cygwin would guarantee
end-user confusion.

cgf
