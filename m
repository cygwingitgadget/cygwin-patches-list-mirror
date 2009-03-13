Return-Path: <cygwin-patches-return-6443-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27114 invoked by alias); 13 Mar 2009 21:14:22 -0000
Received: (qmail 27104 invoked by uid 22791); 13 Mar 2009 21:14:22 -0000
X-SWARE-Spam-Status: No, hits=-2.2 required=5.0 	tests=AWL,BAYES_00
X-Spam-Check-By: sourceware.org
Received: from etr-usa.com (HELO etr-usa.com) (130.94.180.135)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 13 Mar 2009 21:14:17 +0000
Received: (qmail 45857 invoked by uid 13447); 13 Mar 2009 21:14:16 -0000
Received: from unknown (HELO [172.20.0.42]) ([71.213.157.42])           (envelope-sender <warren@etr-usa.com>)           by 130.94.180.135 (qmail-ldap-1.03) with SMTP           for <cygwin-patches@cygwin.com>; 13 Mar 2009 21:14:16 -0000
Message-ID: <49BACC94.9040801@etr-usa.com>
Date: Fri, 13 Mar 2009 21:14:00 -0000
From: Warren Young <warren@etr-usa.com>
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
MIME-Version: 1.0
To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: errno.h: ESTRPIPE
References: <49B8A1F8.1030306@users.sourceforge.net> <20090312085748.GE14431@calimero.vinschen.de> <49B98AC4.1040202@users.sourceforge.net> <20090313103036.GA13010@calimero.vinschen.de> <49BA4D48.1030705@etr-usa.com> <BF8A7E40A996804A81035E1D83DD64FF34F79E@saxon.Axentiatech.local>
In-Reply-To: <BF8A7E40A996804A81035E1D83DD64FF34F79E@saxon.Axentiatech.local>
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
X-SW-Source: 2009-q1/txt/msg00041.txt.bz2

Peter Rosin wrote:
> Consider code like this:
> 
> switch (errno) {
> case -ESTRPIPE:
> 	capers();
> 	break;
> case -EFOOBAR:
> 	cucumber();
> 	break;
> }

The core assumption is that neither can happen.  Not now, not ever.

If that's true, the worst you can say against it is that gcc will bitch 
about the duplicate switch case.  If it's not true, that kicks the legs 
out from under the recommendation, so of course it shouldn't be done 
that way.

It would also be fine with me if the first "can't happen" value were 
9999, then the next 9998, etc.  I do like starting below 10000, as an 
old Winsock hand.  Yes, I know, errno and WSAGetLastError() don't 
overlap, but somehow it appeals to me to behave as if they could.
