Return-Path: <cygwin-patches-return-9063-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 47432 invoked by alias); 31 May 2018 09:19:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 47412 invoked by uid 89); 31 May 2018 09:19:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-23.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*M:cygwin, Hx-languages-length:1250, HTo:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx3-rdu2.redhat.com (HELO mx1.redhat.com) (66.187.233.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 31 May 2018 09:19:33 +0000
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 0E273818BAF2	for <cygwin-patches@cygwin.com>; Thu, 31 May 2018 09:19:32 +0000 (UTC)
Received: from [10.10.125.159] (ovpn-125-159.rdu2.redhat.com [10.10.125.159])	by smtp.corp.redhat.com (Postfix) with ESMTPS id D92BF6352A	for <cygwin-patches@cygwin.com>; Thu, 31 May 2018 09:19:31 +0000 (UTC)
Subject: Re: Fix declaration of pthread_rwlock_* functions
To: cygwin-patches@cygwin.com
References: <cfb6a3b0-57f6-8594-0872-db65d371a997@cornell.edu> <20180531080609.GA15191@calimero.vinschen.de>
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
Message-ID: <d7592aab-90e2-a902-8cde-5dcc5106a2d0@cygwin.com>
Date: Thu, 31 May 2018 09:19:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180531080609.GA15191@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2018-q2/txt/msg00020.txt.bz2

On 2018-05-31 03:06, Corinna Vinschen wrote:
>>  From 4940baac08cd9339d771d9db90a880c61610ae4c Mon Sep 17 00:00:00 2001
>> From: Ken Brown <kbrown@cornell.edu>
>> Date: Wed, 30 May 2018 16:19:01 -0400
>> Subject: [PATCH] Declare the pthread_rwlock_* functions if __cplusplus >=
>>   201402L
>>
>> Some of these functions are used in the <shared_mutex> C++ header.
>> ---
>>   winsup/cygwin/include/pthread.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/winsup/cygwin/include/pthread.h b/winsup/cygwin/include/pthread.h
>> index 3dfc2bc80..fed616532 100644
>> --- a/winsup/cygwin/include/pthread.h
>> +++ b/winsup/cygwin/include/pthread.h
>> @@ -187,7 +187,7 @@ int pthread_spin_unlock (pthread_spinlock_t *);
>>   #endif
>>   
>>   /* RW Locks */
>> -#if __XSI_VISIBLE >= 500 || __POSIX_VISIBLE >= 200112
>> +#if __XSI_VISIBLE >= 500 || __POSIX_VISIBLE >= 200112 || __cplusplus >= 201402L
>>   int pthread_rwlock_destroy (pthread_rwlock_t *rwlock);
>>   int pthread_rwlock_init (pthread_rwlock_t *rwlock, const pthread_rwlockattr_t *attr);
>>   int pthread_rwlock_rdlock (pthread_rwlock_t *rwlock);
>> -- 
> 
> LGTM but the guards are Yaakov's domain.  Yaakov, any input?

LGTM.

-- 
Yaakov
