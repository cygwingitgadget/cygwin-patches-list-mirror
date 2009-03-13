Return-Path: <cygwin-patches-return-6440-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7776 invoked by alias); 13 Mar 2009 18:16:50 -0000
Received: (qmail 7766 invoked by uid 22791); 13 Mar 2009 18:16:49 -0000
X-SWARE-Spam-Status: No, hits=-2.2 required=5.0 	tests=AWL,BAYES_00
X-Spam-Check-By: sourceware.org
Received: from etr-usa.com (HELO etr-usa.com) (130.94.180.135)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 13 Mar 2009 18:16:42 +0000
Received: (qmail 13886 invoked by uid 13447); 13 Mar 2009 18:16:40 -0000
Received: from unknown (HELO [172.20.0.42]) ([71.213.157.42])           (envelope-sender <warren@etr-usa.com>)           by 130.94.180.135 (qmail-ldap-1.03) with SMTP           for <cygwin-patches@cygwin.com>; 13 Mar 2009 18:16:40 -0000
Message-ID: <49BAA2F4.1060907@etr-usa.com>
Date: Fri, 13 Mar 2009 18:16:00 -0000
From: Warren Young <warren@etr-usa.com>
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: errno.h: ESTRPIPE
References: <49B8A1F8.1030306@users.sourceforge.net> <20090312085748.GE14431@calimero.vinschen.de> <49B98AC4.1040202@users.sourceforge.net> <20090313103036.GA13010@calimero.vinschen.de> <49BA4D48.1030705@etr-usa.com> <20090313145026.GB11253@ednor.casa.cgf.cx>
In-Reply-To: <20090313145026.GB11253@ednor.casa.cgf.cx>
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
X-SW-Source: 2009-q1/txt/msg00038.txt.bz2

Christopher Faylor wrote:
> Defining a unique value means that, if we do decide at some point to add
> functionality which utilizes that errno the will be no need to recompile
> the application.

If you think Cygwin might at some point learn to send certain errnos, 
they should use low values, as the standard ones do.  The point of using 
9999 is to say "we'll never need this one," perhaps because it just 
doesn't make sense for Cygwin.

I'd be surprised if there were actually errnos used by other *ixes that 
Cygwin currently doesn't use, which are also not understood well enough 
such that you can't predict whether Cygwin will ever need them for more 
than compatibility.  Obviously the future is wide open and holds endless 
surprises, but isn't Cygwin mature enough by now that its wish list is 
mostly populated by obvious things?  Is there really a lot of stuff 
coming in these days where you say, "didn't see that coming!"?
