Return-Path: <cygwin-patches-return-6989-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18721 invoked by alias); 26 Feb 2010 10:50:36 -0000
Received: (qmail 18650 invoked by uid 22791); 26 Feb 2010 10:50:35 -0000
X-SWARE-Spam-Status: No, hits=-2.6 required=5.0 	tests=AWL,BAYES_00
X-Spam-Check-By: sourceware.org
Received: from mail-qy0-f191.google.com (HELO mail-qy0-f191.google.com) (209.85.221.191)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 26 Feb 2010 10:50:31 +0000
Received: by qyk29 with SMTP id 29so1980946qyk.15         for <cygwin-patches@cygwin.com>; Fri, 26 Feb 2010 02:50:29 -0800 (PST)
Received: by 10.224.96.223 with SMTP id i31mr114077qan.183.1267181429601;         Fri, 26 Feb 2010 02:50:29 -0800 (PST)
Received: from ?127.0.0.1? (S010600112f237275.wp.shawcable.net [24.76.241.98])         by mx.google.com with ESMTPS id 21sm1791273qyk.9.2010.02.26.02.50.28         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Fri, 26 Feb 2010 02:50:28 -0800 (PST)
Message-ID: <4B87A77B.2010704@users.sourceforge.net>
Date: Fri, 26 Feb 2010 10:50:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] define SIGPWR
References: <4B875901.6010906@users.sourceforge.net>  <20100226052655.GA22741@ednor.casa.cgf.cx>  <4B87616D.7050602@users.sourceforge.net>  <4B876413.8040800@users.sourceforge.net>  <20100226092035.GB8489@calimero.vinschen.de>  <4B8796E6.5010202@users.sourceforge.net> <20100226100417.GY5683@calimero.vinschen.de>
In-Reply-To: <20100226100417.GY5683@calimero.vinschen.de>
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
X-SW-Source: 2010-q1/txt/msg00105.txt.bz2

On 2010-02-26 04:04, Corinna Vinschen wrote:
> Replace SIGLOST with SIGPWR, add SIGLOST as parenthetical note to SIGPWR,
> add SIGIO an SIGCLD.
>
> No, really, whatever you think is best.  Documentation is hell and
> there can never be enough anyway.

Yeah, I know the feeling.  I went ahead and added all three.


Yaakov
