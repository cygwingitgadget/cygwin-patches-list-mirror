Return-Path: <cygwin-patches-return-6829-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11166 invoked by alias); 11 Nov 2009 10:22:55 -0000
Received: (qmail 11155 invoked by uid 22791); 11 Nov 2009 10:22:54 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from qw-out-1920.google.com (HELO qw-out-1920.google.com) (74.125.92.147)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 11 Nov 2009 10:22:50 +0000
Received: by qw-out-1920.google.com with SMTP id 4so139540qwk.20         for <cygwin-patches@cygwin.com>; Wed, 11 Nov 2009 02:22:48 -0800 (PST)
Received: by 10.224.87.204 with SMTP id x12mr685156qal.378.1257934968221;         Wed, 11 Nov 2009 02:22:48 -0800 (PST)
Received: from ?192.168.0.101? (S010600112f237275.wp.shawcable.net [24.76.241.98])         by mx.google.com with ESMTPS id 20sm1223198qyk.9.2009.11.11.02.22.46         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Wed, 11 Nov 2009 02:22:46 -0800 (PST)
Message-ID: <4AFA907E.1050408@users.sourceforge.net>
Date: Wed, 11 Nov 2009 10:22:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.4pre) Gecko/20090915 Thunderbird/3.0b4
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] add get_nprocs, get_nprocs_conf
References: <4AFA6675.6070408@users.sourceforge.net> <20091111094119.GA3564@calimero.vinschen.de>
In-Reply-To: <20091111094119.GA3564@calimero.vinschen.de>
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
X-SW-Source: 2009-q4/txt/msg00160.txt.bz2

On 11/11/2009 03:41, Corinna Vinschen wrote:
> Thanks, but, wouldn't it be simpler to implement them as macros in
> sys/sysinfo.h?

Implementing them as macros won't help an autoconf AC_CHECK_FUNC or 
cmake CHECK_FUNCTION_EXISTS test.


Yaakov
