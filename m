Return-Path: <cygwin-patches-return-9065-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27939 invoked by alias); 1 Jun 2018 12:34:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 27907 invoked by uid 89); 1 Jun 2018 12:34:02 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=cygwin-patches, cygwinpatches, HTo:U*cygwin-patches
X-HELO: limerock03.mail.cornell.edu
Received: from limerock03.mail.cornell.edu (HELO limerock03.mail.cornell.edu) (128.84.13.243) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 01 Jun 2018 12:34:00 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite3.serverfarm.cornell.edu [10.16.197.8])	by limerock03.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id w51CXwdc027721	for <cygwin-patches@cygwin.com>; Fri, 1 Jun 2018 08:33:58 -0400
Received: from [192.168.0.15] (mta-68-175-129-7.twcny.rr.com [68.175.129.7] (may be forged))	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id w51CXu8W025543	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)	for <cygwin-patches@cygwin.com>; Fri, 1 Jun 2018 08:33:57 -0400
Subject: Re: Fix declaration of pthread_rwlock_* functions
To: cygwin-patches@cygwin.com
References: <cfb6a3b0-57f6-8594-0872-db65d371a997@cornell.edu> <20180601101028.GC14289@calimero.vinschen.de>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <eb00138e-d955-1cd6-b105-9d812de06018@cornell.edu>
Date: Fri, 01 Jun 2018 12:34:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180601101028.GC14289@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------360A150E11481E82CA12B042"
X-PMX-Cornell-Gauge: Gauge=XXXXX
X-PMX-CORNELL-AUTH-RESULTS: dkim-out=none;
X-IsSubscribed: yes
X-SW-Source: 2018-q2/txt/msg00022.txt.bz2

This is a multi-part message in MIME format.
--------------360A150E11481E82CA12B042
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1440

On 6/1/2018 6:10 AM, Corinna Vinschen wrote:
> On May 30 16:28, Ken Brown wrote:
>> The attached patch fixes the second problem reported in
>> https://cygwin.com/ml/cygwin/2018-05/msg00316.html, though I'm not sure it's
>> the right fix.
>>
>> Ken
> 
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
>> 2.17.0
>>
> 
> Pushed.  Any text for winsup/cygwin/release/2.10.1, perhaps?

Attached.

Ken


--------------360A150E11481E82CA12B042
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-Add-pthread_rwlock_-fix-to-release-notes.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Cygwin-Add-pthread_rwlock_-fix-to-release-notes.patch"
Content-length: 1078

RnJvbSA2NjFlZGFmZWRlYjA5ZDZlYWQxZDMyNDk3NjNkYzNmYzZkM2RlNDBm
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGti
cm93bkBjb3JuZWxsLmVkdT4KRGF0ZTogRnJpLCAxIEp1biAyMDE4IDA4OjMx
OjQzIC0wNDAwClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBBZGQgcHRocmVh
ZF9yd2xvY2tfKiBmaXggdG8gcmVsZWFzZSBub3RlcwoKLS0tCiB3aW5zdXAv
Y3lnd2luL3JlbGVhc2UvMi4xMC4xIHwgMyArKysKIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2lu
L3JlbGVhc2UvMi4xMC4xIGIvd2luc3VwL2N5Z3dpbi9yZWxlYXNlLzIuMTAu
MQppbmRleCBjMTMzMTI0YWUuLjQyZDlkMTExMCAxMDA2NDQKLS0tIGEvd2lu
c3VwL2N5Z3dpbi9yZWxlYXNlLzIuMTAuMQorKysgYi93aW5zdXAvY3lnd2lu
L3JlbGVhc2UvMi4xMC4xCkBAIC0yOSwzICsyOSw2IEBAIEJ1ZyBGaXhlcwog
LSBGaXggYSBzdGFjayBhbGlnbm1lbnQgcHJvYmxlbSB3aGljaCBtYXkgbGVh
ZCB0byBzcHVyaW91cyBjcmFzaGVzIGFmdGVyCiAgIGZvcmsuCiAgIEFkZHJl
c3NlczogaHR0cHM6Ly9jeWd3aW4uY29tL21sL2N5Z3dpbi1wYXRjaGVzLzIw
MTgtcTIvbXNnMDAwMTYuaHRtbAorCistIEZpeCBhIGcrKyBjb21waWxhdGlv
biBwcm9ibGVtIHdpdGggLXN0ZD1jKysxNCBvciAtc3RkPWMrKzE3LgorICBB
ZGRyZXNzZXM6IGh0dHBzOi8vY3lnd2luLmNvbS9tbC9jeWd3aW4vMjAxOC0w
NS9tc2cwMDMxNi5odG1sCi0tIAoyLjE3LjAKCg==

--------------360A150E11481E82CA12B042--
