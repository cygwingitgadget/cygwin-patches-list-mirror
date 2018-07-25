Return-Path: <cygwin-patches-return-9150-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 46718 invoked by alias); 25 Jul 2018 20:06:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 46674 invoked by uid 89); 25 Jul 2018 20:06:51 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_PASS autolearn=no version=3.3.2 spammy=Hx-languages-length:854
X-HELO: mx1.redhat.com
Received: from mx3-rdu2.redhat.com (HELO mx1.redhat.com) (66.187.233.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 25 Jul 2018 20:06:50 +0000
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 7734140216EA	for <cygwin-patches@cygwin.com>; Wed, 25 Jul 2018 20:06:49 +0000 (UTC)
Received: from yselkowitz.redhat.com (ovpn-122-107.rdu2.redhat.com [10.10.122.107])	by smtp.corp.redhat.com (Postfix) with ESMTPS id 377392156701	for <cygwin-patches@cygwin.com>; Wed, 25 Jul 2018 20:06:49 +0000 (UTC)
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/1] Update _PC_ASYNC_IO return value
Date: Wed, 25 Jul 2018 20:06:00 -0000
Message-Id: <20180725200643.10750-1-yselkowi@redhat.com>
X-SW-Source: 2018-q3/txt/msg00045.txt.bz2

From discussion on IRC:

<yselkowitz> corinna, just sent a patch for _POSIX_ASYNCHRONOUS_IO as a
	  follow-up to the AIO feature, but am still wondering about
	  _[POSIX|PC]_ASYNC_IO
[snip]
<corinna> in terms of _PC_ASYNC_IO, the test might be a bit tricky
<corinna> let me check
<corinna> actually, no
<corinna> it's easy
<corinna> Mark implemented the stuff with pread/pwrite only on disk files
<corinna> but otherwise it's device independent in that he implemented a
	  workaround for pipes and stuff
<corinna> so, in theory we can just return 1

I'm not sure how to test this atm, but based on the above I have made
the following patch so this doesn't get lost.

Yaakov Selkowitz (1):
  Cygwin: fpathconf: update _PC_ASYNC_IO return value

 winsup/cygwin/fhandler.cc | 1 +
 1 file changed, 1 insertion(+)

-- 
2.17.1
