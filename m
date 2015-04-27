Return-Path: <cygwin-patches-return-8134-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 51993 invoked by alias); 27 Apr 2015 08:46:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 51979 invoked by uid 89); 27 Apr 2015 08:46:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.4 required=5.0 tests=BAYES_00,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mail-qk0-f181.google.com
Received: from mail-qk0-f181.google.com (HELO mail-qk0-f181.google.com) (209.85.220.181) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Mon, 27 Apr 2015 08:46:31 +0000
Received: by qkgx75 with SMTP id x75so58640973qkg.1        for <cygwin-patches@cygwin.com>; Mon, 27 Apr 2015 01:46:29 -0700 (PDT)
X-Received: by 10.55.23.16 with SMTP id i16mr11197184qkh.14.1430124389320;        Mon, 27 Apr 2015 01:46:29 -0700 (PDT)
Received: from executor.depaulo.org (pool-96-245-198-248.phlapa.fios.verizon.net. [96.245.198.248])        by mx.google.com with ESMTPSA id n83sm11176232qkh.31.2015.04.27.01.46.28        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);        Mon, 27 Apr 2015 01:46:28 -0700 (PDT)
From: Mike DePaulo <mikedep333@gmail.com>
To: cygwin-patches@cygwin.com
Cc: Mike DePaulo <mikedep333@gmail.com>
Subject: [PATCH] cygserver.xml: Add new section. How to install Cygserver.
Date: Mon, 27 Apr 2015 08:46:00 -0000
Message-Id: <1430124378-16484-1-git-send-email-mikedep333@gmail.com>
X-IsSubscribed: yes
X-SW-Source: 2015-q2/txt/msg00035.txt.bz2

I recently wasted time at work because I did not know how to install Cygserver.
It looks like other people had this problem too:
http://superuser.com/questions/738105/how-to-install-cygserver

So I wrote a patch for the documentation, which people are likely to find via
Google/DDG.

Also, this is my 1st time using git-send-email.


Mike DePaulo (1):
  * cygserver.xml: Add new section. How to install Cygserver.

 winsup/doc/cygserver.xml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

-- 
2.1.4
