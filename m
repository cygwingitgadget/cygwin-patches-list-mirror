Return-Path: <cygwin-patches-return-7883-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28756 invoked by alias); 11 May 2013 00:16:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 28744 invoked by uid 89); 11 May 2013 00:16:49 -0000
X-Spam-SWARE-Status: No, score=-1.7 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE autolearn=ham version=3.3.1
Received: from mho-02-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.72)    by sourceware.org (qpsmtpd/0.84/v0.84-167-ge50287c) with ESMTP; Sat, 11 May 2013 00:16:48 +0000
Received: from pool-98-110-186-170.bstnma.fios.verizon.net ([98.110.186.170] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1UaxUU-0003dS-Oe	for cygwin-patches@cygwin.com; Sat, 11 May 2013 00:16:46 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 2989360125	for <cygwin-patches@cygwin.com>; Fri, 10 May 2013 20:16:46 -0400 (EDT)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/+G+Ulb47iwmgKKewKChOn
Date: Sat, 11 May 2013 00:16:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: May I remove setup.xml and cygwin-ug.xml?
Message-ID: <20130511001646.GA894@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <518D3A45.7000109@etr-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <518D3A45.7000109@etr-usa.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SW-Source: 2013-q2/txt/msg00021.txt.bz2

On Fri, May 10, 2013 at 12:19:49PM -0600, Warren Young wrote:
>These files in winsup/doc appear to have been replaced by setup-net.xml 
>and cygwin-ug-net.xml.  The Makefile doesn't use either of these as 
>input to any of its outputs, and they're not referenced by any of the 
>other input files.

Sounds like they should go.  Removing them is not a permanent thing so
there is no harm in doing a 'cvs delete'.  They can always be resurrected
if needed.

cgf
