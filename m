Return-Path: <cygwin-patches-return-9075-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 104388 invoked by alias); 4 Jun 2018 23:17:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 104378 invoked by uid 89); 4 Jun 2018 23:17:52 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-9.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx3-rdu2.redhat.com (HELO mx1.redhat.com) (66.187.233.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 04 Jun 2018 23:17:51 +0000
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 122337C6A9	for <cygwin-patches@cygwin.com>; Mon,  4 Jun 2018 23:17:50 +0000 (UTC)
Received: from [10.10.120.98] (ovpn-120-98.rdu2.redhat.com [10.10.120.98])	by smtp.corp.redhat.com (Postfix) with ESMTPS id D9DC7111AF09	for <cygwin-patches@cygwin.com>; Mon,  4 Jun 2018 23:17:49 +0000 (UTC)
Subject: Re: [PATCH 3/5] Cygwin: Implement the GNU extension clearenv
To: cygwin-patches@cygwin.com
References: <20180604193607.17088-1-kbrown@cornell.edu> <20180604193607.17088-4-kbrown@cornell.edu>
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
Message-ID: <ba9f4444-8e25-e749-432c-d06663ffa5d9@cygwin.com>
Date: Mon, 04 Jun 2018 23:17:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180604193607.17088-4-kbrown@cornell.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2018-q2/txt/msg00032.txt.bz2

On 2018-06-04 14:36, Ken Brown wrote:
> --- a/winsup/cygwin/include/cygwin/stdlib.h
> +++ b/winsup/cygwin/include/cygwin/stdlib.h
> @@ -22,6 +22,7 @@ void	setprogname (const char *);
>   
>   #if __GNU_VISIBLE
>   char *canonicalize_file_name (const char *);
> +int clearenv ();
>   #endif

This should be in a __MISC_VISIBLE conditional, and the (void) parameter 
is missing.

-- 
Yaakov
