Return-Path: <cygwin-patches-return-7647-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15757 invoked by alias); 23 Apr 2012 22:17:31 -0000
Received: (qmail 15742 invoked by uid 22791); 23 Apr 2012 22:17:30 -0000
X-SWARE-Spam-Status: No, hits=-4.4 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mail-iy0-f171.google.com (HELO mail-iy0-f171.google.com) (209.85.210.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 23 Apr 2012 22:17:10 +0000
Received: by iadj38 with SMTP id j38so62147iad.2        for <cygwin-patches@cygwin.com>; Mon, 23 Apr 2012 15:17:10 -0700 (PDT)
Received: by 10.50.220.129 with SMTP id pw1mr7958217igc.29.1335219430211;        Mon, 23 Apr 2012 15:17:10 -0700 (PDT)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id en3sm28764487igc.2.2012.04.23.15.17.08        (version=TLSv1/SSLv3 cipher=OTHER);        Mon, 23 Apr 2012 15:17:09 -0700 (PDT)
Message-ID: <4F95D4E6.8010907@users.sourceforge.net>
Date: Mon, 23 Apr 2012 22:17:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Regenerate configures
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
X-SW-Source: 2012-q2/txt/msg00016.txt.bz2

cygwin/doc/configure and cygwin/testsuite/configure are now the only 
configure scripts in the winsup tree which were generated with 
autoconf-2.5x.  Any objections to regenerating them with 2.68?


Yaakov
