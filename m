Return-Path: <cygwin-patches-return-7605-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22009 invoked by alias); 24 Feb 2012 16:56:39 -0000
Received: (qmail 21996 invoked by uid 22791); 24 Feb 2012 16:56:37 -0000
X-SWARE-Spam-Status: No, hits=-6.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,SPF_HELO_PASS,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 24 Feb 2012 16:56:24 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q1OGuN1H014012	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)	for <cygwin-patches@cygwin.com>; Fri, 24 Feb 2012 11:56:23 -0500
Received: from [127.0.0.1] (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q1OGuMCh024446	for <cygwin-patches@cygwin.com>; Fri, 24 Feb 2012 11:56:23 -0500
Message-ID: <4F47C136.20805@redhat.com>
Date: Fri, 24 Feb 2012 16:56:00 -0000
From: Pedro Alves <palves@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0) Gecko/20120131 Thunderbird/10.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add pthread_getname_np, pthread_setname_np
References: <1330054695.6828.15.camel@YAAKOV04> <20120224093809.GA20683@calimero.vinschen.de> <1330081241.6260.3.camel@YAAKOV04> <20120224121808.GG17797@calimero.vinschen.de>
In-Reply-To: <20120224121808.GG17797@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8
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
X-SW-Source: 2012-q1/txt/msg00028.txt.bz2

Just FYI,

Windows' way to have the program affect thread names in the
debugger is with SetThreadName, which throws a magic exception
which the debugger can catch.  GDB doesn't know about this though.

 http://msdn.microsoft.com/en-us/library/xcb2z8hs.aspx

Just for completeness...  I don't know if there's a native
method that's closer to pthread_setname_np's semantics.

-- 
Pedro Alves
