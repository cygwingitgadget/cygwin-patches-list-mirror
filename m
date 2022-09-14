Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	by sourceware.org (Postfix) with ESMTPS id 89D373858407
	for <cygwin-patches@cygwin.com>; Wed, 14 Sep 2022 03:27:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 89D373858407
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=systematicsw.ab.ca
Received: from shw-obgw-4004a.ext.cloudfilter.net ([10.228.9.227])
	by cmsmtp with ESMTP
	id Y9ePog1k3S8WrYJ3eoHwKZ; Wed, 14 Sep 2022 03:27:26 +0000
Received: from [10.0.0.5] ([184.64.124.72])
	by cmsmtp with ESMTP
	id YJ3dob6TUGRNlYJ3eoKYj7; Wed, 14 Sep 2022 03:27:26 +0000
X-Authority-Analysis: v=2.4 cv=Sfrky9du c=1 sm=1 tr=0 ts=63214a1e
 a=oHm12aVswOWz6TMtn9zYKg==:117 a=oHm12aVswOWz6TMtn9zYKg==:17
 a=IkcTkHD0fZMA:10 a=MaTqHXpsqfzHccmfshIA:9 a=QEXdDO2ut3YA:10
Message-ID: <fb1170f1-b58f-b428-fb2e-647930315db4@SystematicSw.ab.ca>
Date: Tue, 13 Sep 2022 21:27:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Content-Language: en-CA
To: Cygwin Patches <cygwin-patches@cygwin.com>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Subject: Cygwin 32 Build Branch
Organization: Systematic Software
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfGCcACv0WGiLEsbgeR9y+UqWrbywU2HvzKp9y8oHBs4HMunoP9GOVt+4F5QxodFl59Jcm6ACWkGaQYQzMsceW5F6tRbAEZyG5WGw9KoqpZGbARAWZ/8U
 xckpKxawIG7hY8tMAIC5tvhG+9KYJJgR3QjIxhayKTZE++sZYR8ilwFi43ig9OcEVMQ0dxcseVtS45B5sXL0tLyfw/36DDJtDf8=
X-Spam-Status: No, score=-1163.7 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_NONE,SPF_NONE,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi folks,

What is the branch to checkout to build Cygwin 32?

Build master fails with:
   CC       libm/math/libm_a-k_standard.o
In file included from .../newlib/libc/include/sys/config.h:238,
                  from .../newlib/libc/include/_ansi.h:11,
                  from .../newlib/libc/include/sys/reent.h:13,
                  from .../newlib/libc/include/math.h:5,
                  from .../newlib/libm/common/fdlibm.h:15,
                  from .../newlib/libm/math/k_standard.c:15:
.../winsup/cygwin/include/cygwin/config.h: In function ‘__getreent’:
.../winsup/cygwin/include/cygwin/config.h:42:2: error: #error 
unimplemented for this target
    42 | #error unimplemented for this target
       |  ^~~~~
make[3]: *** [Makefile:36280: libm/math/libm_a-k_standard.o] Error 1
...

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

[Please Reply All due to ml email issues]
