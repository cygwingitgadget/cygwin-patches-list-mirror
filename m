Return-Path: <cygwin-patches-return-8193-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 40361 invoked by alias); 17 Jun 2015 20:57:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 40340 invoked by uid 89); 17 Jun 2015 20:57:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.0 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_PASS autolearn=no version=3.3.2
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Wed, 17 Jun 2015 20:57:30 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])	by mx1.redhat.com (Postfix) with ESMTPS id 4F2D92EBD1A	for <cygwin-patches@cygwin.com>; Wed, 17 Jun 2015 20:57:29 +0000 (UTC)
Received: from YAAKOV04.redhat.com ([10.10.116.16])	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t5HKvRIm007542	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)	for <cygwin-patches@cygwin.com>; Wed, 17 Jun 2015 16:57:28 -0400
Message-ID: <1434574654.11212.4.camel@cygwin.com>
Subject: Re: [PATCH] Hide sethostname() in unistd.h
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
To: cygwin-patches@cygwin.com
Date: Wed, 17 Jun 2015 20:57:00 -0000
In-Reply-To: <5581D7C4.1000207@t-online.de>
References: <55804E7D.3060504@t-online.de>	 <20150616174551.GF31537@calimero.vinschen.de>	 <558107F2.3030809@t-online.de>	 <20150617084626.GI31537@calimero.vinschen.de>	 <5581D7C4.1000207@t-online.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2015-q2/txt/msg00094.txt.bz2

On Wed, 2015-06-17 at 22:25 +0200, Christian Franke wrote:
> Busybox does not use autoconf or similar. It requires manual platform 
> specific configuration which does not yet support a missing 
> sethostname(). After adding HAVE_SETHOSTNAME manually and some other 
> minor additions, busybox (which many commands enabled) compiles and 
> works reasonably.
> Would ITP make sense ?

TBH I'm not sure.  Presuming you're discussing the single-executable
build (so as not to clobber coreutils etc.), there is still the question
of (not) matching the heavily-patched coreutils wrt .exe handling etc.
What do you think the use case would be?

--
Yaakov


