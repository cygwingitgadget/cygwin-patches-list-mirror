Return-Path: <cygwin-patches-return-8916-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 103036 invoked by alias); 12 Nov 2017 19:07:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 102056 invoked by uid 89); 12 Nov 2017 19:07:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-3.1 required=5.0 tests=AWL,BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=UD:xml, H*Ad:U*kbrown, HTo:U*cygwin-patches
X-HELO: limerock02.mail.cornell.edu
Received: from limerock02.mail.cornell.edu (HELO limerock02.mail.cornell.edu) (128.84.13.242) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 12 Nov 2017 19:07:05 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite4.serverfarm.cornell.edu [10.16.197.9])	by limerock02.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id vACJ72os028212	for <cygwin-patches@cygwin.com>; Sun, 12 Nov 2017 14:07:03 -0500
Received: from [192.168.0.15] (mta-68-175-129-7.twcny.rr.com [68.175.129.7] (may be forged))	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id vACJ71Zi013888	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)	for <cygwin-patches@cygwin.com>; Sun, 12 Nov 2017 14:07:02 -0500
Subject: Re: [PATCH] Add FAQ 4.46 How do I fix find_fast_cwd warnings?
To: cygwin-patches@cygwin.com
References: <ac78412d-748f-ed22-473e-9d101f7bde2f@SystematicSw.ab.ca>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <0cf17d74-23a4-f08d-fd67-afed0bd3be9d@cornell.edu>
Date: Sun, 12 Nov 2017 19:07:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <ac78412d-748f-ed22-473e-9d101f7bde2f@SystematicSw.ab.ca>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Cornell-Gauge: Gauge=XXXXX
X-PMX-CORNELL-AUTH-RESULTS: dkim-out=none;
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00046.txt.bz2

On 11/12/2017 1:39 PM, Brian Inglis wrote:
> Having responded to some of these posts and being prompted by the suggestion in
> a reply to one by "Cyg simple", I attach an offering, in the off chance that
> anyone affected might actually check the FAQ or find it in a search. ;^>

Even if they don't find it, we can refer them to the FAQ rather than 
re-writing variations on the same answer each time.  But your patch 
should be to winsup/doc/faq-using.xml.

Ken
