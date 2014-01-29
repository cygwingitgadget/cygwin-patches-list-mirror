Return-Path: <cygwin-patches-return-7956-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18690 invoked by alias); 29 Jan 2014 18:55:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 18678 invoked by uid 89); 29 Jan 2014 18:55:36 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2
X-HELO: mho-01-ewr.mailhop.org
Received: from mho-03-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.66) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Wed, 29 Jan 2014 18:55:36 +0000
Received: from pool-173-76-44-31.bstnma.fios.verizon.net ([173.76.44.31] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf-use-the-mailinglist-please@cygwin.com>)	id 1W8aIQ-000CDj-3H	for cygwin-patches@cygwin.com; Wed, 29 Jan 2014 18:55:34 +0000
Received: from ednor (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with SMTP id 3E1E360108	for <cygwin-patches@cygwin.com>; Wed, 29 Jan 2014 13:55:31 -0500 (EST)
Received: by ednor (sSMTP sendmail emulation); Wed, 29 Jan 2014 13:55:31 -0500
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX19v6i58BdcXCBSPx9uc+0pN
Date: Wed, 29 Jan 2014 18:55:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Snapshot install instructions use bz2, not xz
Message-ID: <20140129185531.GA2303@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20140129164607.GA14239@tastycake.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140129164607.GA14239@tastycake.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SW-Source: 2014-q1/txt/msg00029.txt.bz2

On Wed, Jan 29, 2014 at 04:46:09PM +0000, Adam Dinwoodie wrote:
>I've attached a minor correction to the FAQ entry on installing
>snapshots, to note that snapshots are now .xz archives, rather than
>.bz2.

Thanks for the heads up.  I've made some more general wording changes
in faq-setup.xml.

cgf
