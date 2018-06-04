Return-Path: <cygwin-patches-return-9073-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29256 invoked by alias); 4 Jun 2018 20:35:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 27910 invoked by uid 89); 4 Jun 2018 20:35:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-3.6 required=5.0 tests=AWL,BAYES_00,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches
X-HELO: limerock04.mail.cornell.edu
Received: from limerock04.mail.cornell.edu (HELO limerock04.mail.cornell.edu) (128.84.13.244) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 04 Jun 2018 20:35:03 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite3.serverfarm.cornell.edu [10.16.197.8])	by limerock04.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id w54KZ1YP002125	for <cygwin-patches@cygwin.com>; Mon, 4 Jun 2018 16:35:01 -0400
Received: from [192.168.0.4] (mta-68-175-129-7.twcny.rr.com [68.175.129.7] (may be forged))	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id w54KYx09010965	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)	for <cygwin-patches@cygwin.com>; Mon, 4 Jun 2018 16:35:00 -0400
Subject: Re: [PATCH 2/5] Cygwin: Allow the environment pointer to be NULL
To: cygwin-patches@cygwin.com
References: <20180604193607.17088-1-kbrown@cornell.edu> <20180604193607.17088-3-kbrown@cornell.edu>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <1b83c074-0b82-87a0-0ba0-2f253c55f69c@cornell.edu>
Date: Mon, 04 Jun 2018 20:35:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180604193607.17088-3-kbrown@cornell.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Cornell-Gauge: Gauge=XXXXX
X-PMX-CORNELL-AUTH-RESULTS: dkim-out=none;
X-IsSubscribed: yes
X-SW-Source: 2018-q2/txt/msg00030.txt.bz2

On 6/4/2018 3:36 PM, Ken Brown wrote:
> Following glibc, interpret this as meaning the environment is empty.

Sorry, please hold off on reviewing this patch.  I just noticed that I 
missed at least one place (build_env()) where environ==NULL could cause 
a crash.  I need to fix this and try to make sure there are no others.

Ken
