Return-Path: <cygwin-patches-return-7978-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26717 invoked by alias); 21 Apr 2014 17:39:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 26704 invoked by uid 89); 21 Apr 2014 17:39:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2
X-HELO: mho-01-ewr.mailhop.org
Received: from mho-03-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.66) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Mon, 21 Apr 2014 17:39:33 +0000
Received: from pool-173-76-43-57.bstnma.fios.verizon.net ([173.76.43.57] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf-use-the-mailinglist-please@cygwin.com>)	id 1WcIBm-000Lt5-WC	for cygwin-patches@cygwin.com; Mon, 21 Apr 2014 17:39:31 +0000
Received: from ednor (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with SMTP id 9E6C4600D0	for <cygwin-patches@cygwin.com>; Mon, 21 Apr 2014 13:39:26 -0400 (EDT)
Received: by ednor (sSMTP sendmail emulation); Mon, 21 Apr 2014 13:39:26 -0400
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX18kiTBXBg5e8CSigdYyK8v8
Date: Mon, 21 Apr 2014 17:39:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] minidumper patches
Message-ID: <20140421173926.GA1281@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <53554F1B.4060408@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53554F1B.4060408@dronecode.org.uk>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SW-Source: 2014-q2/txt/msg00001.txt.bz2

On Mon, Apr 21, 2014 at 06:02:19PM +0100, Jon TURNEY wrote:
>
>Attached are a couple of patches for the minidumper utility which could
>probably use some review.

This is your utility so, as far as I'm concerned, you have carte blanche
to check things in, i.e., you don't need any approval.  I didn't see anything
worth commenting on other than a few GNU coding issues, i.e., spaces
before parentheses for functions.

cgf
