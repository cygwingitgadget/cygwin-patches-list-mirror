Return-Path: <cygwin-patches-return-7976-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30133 invoked by alias); 20 Mar 2014 22:15:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 30118 invoked by uid 89); 20 Mar 2014 22:15:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2
X-HELO: mho-01-ewr.mailhop.org
Received: from mho-03-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.66) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Thu, 20 Mar 2014 22:15:55 +0000
Received: from pool-173-76-43-57.bstnma.fios.verizon.net ([173.76.43.57] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf-use-the-mailinglist-please@cygwin.com>)	id 1WQlFh-000AC9-7Z	for cygwin-patches@cygwin.com; Thu, 20 Mar 2014 22:15:53 +0000
Received: from ednor (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with SMTP id 88A95600EE	for <cygwin-patches@cygwin.com>; Thu, 20 Mar 2014 18:15:51 -0400 (EDT)
Received: by ednor (sSMTP sendmail emulation); Thu, 20 Mar 2014 18:15:51 -0400
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX181jJjuN5hny6rDc/HItXGK
Date: Thu, 20 Mar 2014 22:15:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: patch for command line containing equals sign
Message-ID: <20140320221551.GA2366@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <d67f6d61ce414f719b5c26c3d71f301b@AM3PR02MB113.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d67f6d61ce414f719b5c26c3d71f301b@AM3PR02MB113.eurprd02.prod.outlook.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SW-Source: 2014-q1/txt/msg00049.txt.bz2

On Thu, Mar 20, 2014 at 09:10:05PM +0000, Weber, Mark wrote:
>
>See
>http://cygwin.com/ml/cygwin-patches/2014-q1/msg00017.html
>and related.
>
>Thanks for posting how the new behavior is different from the old.
>I am having a related issue, with C++ code that parses the command line.
>
>The command line we support is something like -
>  program_name   arg1  -option1=val1  -option2=val2  ...
>
>You get the idea.
>
>Now, with the above mentioned Cygwin patch, we are seeing the input arguments
>
>arg1  "-option1=val1"   "-option2=val2"  ...
>
>If this were the extent of the issue, it would be no big deal to strip off the quotes. However, the user may have put quotes on the command line himself, which Cygwin now moves around.
>Such as:
>  program_name  arg1  -option1="file name with spaces in it"
>
>Is there any way to reliably tell what the user entered on the command line?

Sorry but this mailing list is for patches, not questions or bug reports.

I'm unsubscribing you from this list.  Please resubscribe if you have an actual
patch to submit.
