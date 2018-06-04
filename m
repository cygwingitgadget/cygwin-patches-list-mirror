Return-Path: <cygwin-patches-return-9074-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 56898 invoked by alias); 4 Jun 2018 23:16:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 35474 invoked by uid 89); 4 Jun 2018 23:15:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_PASS,TIME_LIMIT_EXCEEDED autolearn=unavailable version=3.3.2 spammy=Hx-languages-length:461, HTo:U*cygwin-patches, our
X-HELO: mx1.redhat.com
Received: from mx3-rdu2.redhat.com (HELO mx1.redhat.com) (66.187.233.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 04 Jun 2018 23:15:20 +0000
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id CC591401EF0F	for <cygwin-patches@cygwin.com>; Mon,  4 Jun 2018 23:15:12 +0000 (UTC)
Received: from [10.10.120.98] (ovpn-120-98.rdu2.redhat.com [10.10.120.98])	by smtp.corp.redhat.com (Postfix) with ESMTPS id A0B9C63F2F	for <cygwin-patches@cygwin.com>; Mon,  4 Jun 2018 23:15:12 +0000 (UTC)
Subject: Re: [PATCH 0/5] Implement clearenv
To: cygwin-patches@cygwin.com
References: <20180604193607.17088-1-kbrown@cornell.edu>
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
Message-ID: <6e1cc41e-7bf0-227f-98d4-44884eb560be@cygwin.com>
Date: Mon, 04 Jun 2018 23:16:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180604193607.17088-1-kbrown@cornell.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2018-q2/txt/msg00031.txt.bz2

On 2018-06-04 14:36, Ken Brown wrote:
> 2. I guarded the declaration of clearenv() with __GNU_VISIBLE, but
>     again I'm not sure about this.  On the one hand, clearenv() is a
>     GNU extension, so __GNU_VISIBLE would seem to be the right guard.
>     On the other hand, glibc declares clearenv() if _DEFAULT_SOURCE is
>     defined, so maybe the guard should be relaxed if our goal is to
>     emulate Linux.

Use __MISC_VISIBLE.

-- 
Yaakov
