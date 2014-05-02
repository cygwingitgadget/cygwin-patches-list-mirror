Return-Path: <cygwin-patches-return-7980-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 923 invoked by alias); 2 May 2014 14:30:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 909 invoked by uid 89); 2 May 2014 14:30:49 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.7 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_SEMBACKSCATTER autolearn=no version=3.3.2
X-HELO: mho-02-ewr.mailhop.org
Received: from mho-02-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Fri, 02 May 2014 14:30:48 +0000
Received: from pool-98-110-183-166.bstnma.fios.verizon.net ([98.110.183.166] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf-use-the-mailinglist-please@cygwin.com>)	id 1WgEUA-000DBY-D9	for cygwin-patches@cygwin.com; Fri, 02 May 2014 14:30:46 +0000
Received: from ednor (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with SMTP id 63D04600D0	for <cygwin-patches@cygwin.com>; Fri,  2 May 2014 10:30:44 -0400 (EDT)
Received: by ednor (sSMTP sendmail emulation); Fri, 02 May 2014 10:30:44 -0400
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX18Spl8eJw4lV7Xlc/lMkG1N
Date: Fri, 02 May 2014 14:30:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: stdio.h patches for g++ -std=c++11
Message-ID: <20140502143044.GA6122@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <5363A041.50704@orange.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5363A041.50704@orange.fr>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SW-Source: 2014-q2/txt/msg00003.txt.bz2

On Fri, May 02, 2014 at 03:40:17PM +0200, zosrothko wrote:
>This is a patch for exposing the new stdio functions added by the c++11 
>standard. Without this patch the snprintf for example is not exposed as

Patches for newlib should go to the newlib mailing list at sourceware.org.
