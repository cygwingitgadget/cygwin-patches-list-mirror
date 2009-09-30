Return-Path: <cygwin-patches-return-6659-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24368 invoked by alias); 30 Sep 2009 01:11:17 -0000
Received: (qmail 24355 invoked by uid 22791); 30 Sep 2009 01:11:16 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-qy0-f183.google.com (HELO mail-qy0-f183.google.com) (209.85.221.183)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 30 Sep 2009 01:11:12 +0000
Received: by qyk13 with SMTP id 13so4454665qyk.18         for <cygwin-patches@cygwin.com>; Tue, 29 Sep 2009 18:11:11 -0700 (PDT)
Received: by 10.224.82.149 with SMTP id b21mr4712804qal.323.1254273071122;         Tue, 29 Sep 2009 18:11:11 -0700 (PDT)
Received: from ?192.168.0.101? (S010600112f237275.wp.shawcable.net [24.76.241.98])         by mx.google.com with ESMTPS id 4sm81619qwe.45.2009.09.29.18.11.09         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Tue, 29 Sep 2009 18:11:10 -0700 (PDT)
Message-ID: <4AC2B02E.7010805@users.sourceforge.net>
Date: Wed, 30 Sep 2009 01:11:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.4pre) Gecko/20090915 Thunderbird/3.0b4
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] --std=c89 error in sys/signal.h
References: <4AC2732D.5090304@users.sourceforge.net> <20090929223320.GA8901@ednor.casa.cgf.cx> <4AC2A7B5.3070105@users.sourceforge.net>
In-Reply-To: <4AC2A7B5.3070105@users.sourceforge.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00113.txt.bz2

On 29/09/2009 19:35, Yaakov (Cygwin/X) wrote:
> Anyway, to answer the question, AFAICS in glibc, <signal.h> #include
> <bits/types.h> unconditionally[1]. (<sys/signal.h> is just one line:
> #include <signal.h> [2])
>
> So should I take the first route, patching newlib instead?

OTOH, this comment in the offending hunk of <sys/signal.h> (which is 
only for Cygwin and RTEMS) makes me wonder:

/* The first argument to kill should be pid_t.  Right now
    <sys/types.h> always defines pid_t to be int.  If that ever
    changes, then we will need to do something else, perhaps along the
    lines of <machine/types.h>.  */
int _EXFUN(kill, (int, int));
int _EXFUN(killpg, (pid_t, int));

Is that supposed to mean that we don't want to use pid_t here at all, 
and the intended solution would be to change killpg to (int, int), as 
ugly as that is, leaving only <cygwin/signal.h> needing the #include 
<sys/types.h>?


Yaakov
