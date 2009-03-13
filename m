Return-Path: <cygwin-patches-return-6439-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5465 invoked by alias); 13 Mar 2009 14:51:16 -0000
Received: (qmail 5455 invoked by uid 22791); 13 Mar 2009 14:51:15 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-42-111.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.42.111)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 13 Mar 2009 14:50:37 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id BB7AA13C022 	for <cygwin-patches@cygwin.com>; Fri, 13 Mar 2009 10:50:26 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id AC4D92B385; Fri, 13 Mar 2009 10:50:26 -0400 (EDT)
Date: Fri, 13 Mar 2009 14:51:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: errno.h: ESTRPIPE
Message-ID: <20090313145026.GB11253@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <49B8A1F8.1030306@users.sourceforge.net> <20090312085748.GE14431@calimero.vinschen.de> <49B98AC4.1040202@users.sourceforge.net> <20090313103036.GA13010@calimero.vinschen.de> <49BA4D48.1030705@etr-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49BA4D48.1030705@etr-usa.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q1/txt/msg00037.txt.bz2

On Fri, Mar 13, 2009 at 06:10:48AM -0600, Warren Young wrote:
> Corinna Vinschen wrote:
>> This is very Linux device specific and this never occurs on Cygwin.
>> What about just defining this error code to some arbitrary value like
>>   #ifdef __CYGWIN__
>>   #define ESTRPIPE 9999
>>   #endif
>
> I like it.  If there are any other errno constants supported by Linux but 
> not Cygwin, you could also define them with the same value.  It would 
> effectively be the "this never happens" value.

I'm not sure that you got this but I think Corinna was suggesting that
this should be defined in the code in question rather than in Cygwin
itself.

I don't have a problem defining unique errnos that currently never
happen if it makes Cygwin more compatible with Linux.  I just think that
the value should be marked as

/* Linux compatibility: this currently can never happen */

Yaakov's intent was to reduce the amount of special casing required when
porting to Cygwin to remove the need to do #ifdef __CYGWIN__'s.  I think
he knows that he could have ifdef'ed this since I suspect that he's had
to do that many times in the past.

Defining a unique value means that, if we do decide at some point to add
functionality which utilizes that errno the will be no need to recompile
the application.

cgf
