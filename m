Return-Path: <cygwin-patches-return-6668-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18267 invoked by alias); 30 Sep 2009 19:31:30 -0000
Received: (qmail 18252 invoked by uid 22791); 30 Sep 2009 19:31:28 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-98-110-183-151.bstnma.fios.verizon.net (HELO cgf.cx) (98.110.183.151)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 30 Sep 2009 19:31:22 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 1021813C002 	for <cygwin-patches@cygwin.com>; Wed, 30 Sep 2009 15:31:13 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 0F6282B352; Wed, 30 Sep 2009 15:31:13 -0400 (EDT)
Date: Wed, 30 Sep 2009 19:31:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: detect . in a/.//
Message-ID: <20090930193112.GA15083@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AC34A01.4070509@byu.net>  <20090930152438.GA11977@ednor.casa.cgf.cx>  <20090930153451.GA12182@ednor.casa.cgf.cx>  <4AC3ABA4.9090905@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AC3ABA4.9090905@byu.net>
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
X-SW-Source: 2009-q3/txt/msg00122.txt.bz2

On Wed, Sep 30, 2009 at 01:04:04PM -0600, Eric Blake wrote:
>According to Christopher Faylor on 9/30/2009 9:34 AM:
>>> Is this function supposed to detect just "." or "*/."?
>
>Both.
>
>>   /* SUSv3: . and .. are not allowed as last components in various system
>>      calls.  Don't test for backslash path separator since that's a Win32
>>      path following Win32 rules. */
>>   const char *last_comp = strrchr (dir, '\0');
>
>Looked like a decent rewrite to me, except why did you use strrchr instead
>of strchr to find the end of the string?

Oops.  That was an oversight.  I'll change it to strchr and check it in.
Thanks for catching that.

Btw, I've only confirmed that this compiles.  I haven't actually tested it.

cgf
