Return-Path: <cygwin-patches-return-6438-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6780 invoked by alias); 13 Mar 2009 12:11:44 -0000
Received: (qmail 6756 invoked by uid 22791); 13 Mar 2009 12:11:43 -0000
X-SWARE-Spam-Status: No, hits=-2.1 required=5.0 	tests=AWL,BAYES_00
X-Spam-Check-By: sourceware.org
Received: from etr-usa.com (HELO etr-usa.com) (130.94.180.135)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 13 Mar 2009 12:11:08 +0000
Received: (qmail 78521 invoked by uid 13447); 13 Mar 2009 12:11:06 -0000
Received: from unknown (HELO [172.20.0.42]) ([71.213.157.42])           (envelope-sender <warren@etr-usa.com>)           by 130.94.180.135 (qmail-ldap-1.03) with SMTP           for <cygwin-patches@cygwin.com>; 13 Mar 2009 12:11:06 -0000
Message-ID: <49BA4D48.1030705@etr-usa.com>
Date: Fri, 13 Mar 2009 12:11:00 -0000
From: Warren Young <warren@etr-usa.com>
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: errno.h: ESTRPIPE
References: <49B8A1F8.1030306@users.sourceforge.net> <20090312085748.GE14431@calimero.vinschen.de> <49B98AC4.1040202@users.sourceforge.net> <20090313103036.GA13010@calimero.vinschen.de>
In-Reply-To: <20090313103036.GA13010@calimero.vinschen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q1/txt/msg00036.txt.bz2

Corinna Vinschen wrote:
> This is very Linux device specific and this never occurs on Cygwin.
> What about just defining this error code to some arbitrary value like
> 
>   #ifdef __CYGWIN__
>   #define ESTRPIPE 9999
>   #endif

I like it.  If there are any other errno constants supported by Linux 
but not Cygwin, you could also define them with the same value.  It 
would effectively be the "this never happens" value.
