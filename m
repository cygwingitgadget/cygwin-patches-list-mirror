Return-Path: <cygwin-patches-return-6695-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27896 invoked by alias); 5 Oct 2009 14:18:51 -0000
Received: (qmail 27879 invoked by uid 22791); 5 Oct 2009 14:18:49 -0000
X-SWARE-Spam-Status: No, hits=-2.6 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from qw-out-1920.google.com (HELO qw-out-1920.google.com) (74.125.92.149)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 05 Oct 2009 14:18:46 +0000
Received: by qw-out-1920.google.com with SMTP id 4so846786qwk.20         for <cygwin-patches@cygwin.com>; Mon, 05 Oct 2009 07:18:45 -0700 (PDT)
Received: by 10.224.52.94 with SMTP id h30mr52110qag.348.1254752324789;         Mon, 05 Oct 2009 07:18:44 -0700 (PDT)
Received: from ?192.168.0.101? (S010600112f237275.wp.shawcable.net [24.76.241.98])         by mx.google.com with ESMTPS id 4sm2364qwe.18.2009.10.05.07.18.41         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Mon, 05 Oct 2009 07:18:42 -0700 (PDT)
Message-ID: <4ACA0043.6070504@users.sourceforge.net>
Date: Mon, 05 Oct 2009 14:18:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.4pre) Gecko/20090915 Thunderbird/3.0b4
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] --std=c89 error in sys/signal.h
References: <4AC2732D.5090304@users.sourceforge.net> <20090929223320.GA8901@ednor.casa.cgf.cx> <4AC2A7B5.3070105@users.sourceforge.net> <4AC2B02E.7010805@users.sourceforge.net> <4AC94F6F.60308@users.sourceforge.net> <20091005083759.GA12170@calimero.vinschen.de>
In-Reply-To: <20091005083759.GA12170@calimero.vinschen.de>
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
X-SW-Source: 2009-q4/txt/msg00026.txt.bz2

On 05/10/2009 03:37, Corinna Vinschen wrote:
> Newlib, methinks.

OK, I'll send a patch there.

> I think the newlib kill declaration should be changed to pid_t, since
> that's simply correct per POSIX.
>
> I can;t believe the RTEMS people have a problem with that.

Did you forget about the ESTRPIPE episode already?


Yaakov
