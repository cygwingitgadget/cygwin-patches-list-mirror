Return-Path: <SRS0=r81+=EB=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo002.btinternet.com (btprdrgo002.btinternet.com [65.20.50.70])
	by sourceware.org (Postfix) with ESMTP id A549B4BA5436
	for <cygwin-patches@cygwin.com>; Fri,  5 Jun 2026 11:55:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A549B4BA5436
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A549B4BA5436
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.70
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1780660512; cv=none;
	b=g5pByog1RTSD2oquJl/zOp9OJdOUTQPNF5aRlRmDnNXteb1Tv+k4Pi0vFBkpI3iGhagDDGhSjRAH1zQepCU9dWdthbnwlmnctDj2YBkv/wfsPbxoLuVCY6r6+Yln/xsH4jnz8o7sEWVwBnZapAkFbvhqDYMtGUqtPobNOc846s0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1780660512; c=relaxed/simple;
	bh=rkFpdYtSA30lHjl3HQHRP3BTjEn/1tn+ewk9sFg5DOk=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=RRFId9wfxG0FRzENOVXzHievhXCbn0/dvQwnAvhuYYiQIe6oO//zRzxtXrQB2Kg8oixHMx3RQvY3ropjcDuvxnK6IFFre+oL9SV+kbns4fZeYIu8jUr1sJtCrTMCehqa5tzUa0tRPJaDHEWI5dxsVMZkgq85YrghOdsOG8SrKGg=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A549B4BA5436
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A08C1FD019B8C59
X-Originating-IP: [83.105.142.8]
X-OWM-Source-IP: 83.105.142.8
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=30/300, class=clean
X-RazorGate-Vade: dmFkZTESsBPoSEpWGDgu8OHUr/7N+B+Y0WbmVGJu0IPEF/z2XzyuQ1pU14/GufRlITq5RCP9z9vVg/mVktBJHpAeuwV4P9leLUD8e9Xpb7F/a8BFCK5XgLg2YvuwwEy9SncnpfdbHzeXKhomkgaqULzgs89xcjiDpIOeVZaOQJzehCRbxydZ5xKVi7xygr2lohRsiT0oi9KQNLYbmtpWUsJ1G3O/wG+JySZoTbeBa/Hhfu1FNjii1ZgpJ1X/ruBB+vi7Ry570LqZCgfrMGu15p9HMhmDwdO92gYWl0ynuMmVMdWXzS5LAEhLF+bUd8Zbt6aAzffJ1MZjCwJLvbutktldoni1BQfHIhN64JLwz2KVFd6hQ56WQAJUo1uVngDMr3Au7ktcm9NpddCVFqR3hkGLjGLR7dkUT8D7iD1nibVoQEQ0YiEvKmuoaizG3ueEEguzVzZTWFAVyw2k43BO3qahofy73X2WFm9zHrkpYRx4GwrWtLHKSRv4ev9MomWxgbJJb1EKg5Kv8g3nxZUficqEQ4t/YMzMt3AN17dFA0kj6sV3etiA+X5MtQb4WH7Z5/4ImzNHnF+IT48q+Vef2LdwydO9ipx7EzjbKetLZckxk9c1NHpudAJfvcAKoYKvsM9R1gEH/4uiyTbZj2KATSj3HcftM0UAOuGQiAl5zwe8EQdEyw
X-RazorGate-Vade-Verdict: clean 30
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (83.105.142.8) by btprdrgo002.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A08C1FD019B8C59 for cygwin-patches@cygwin.com; Fri, 5 Jun 2026 12:55:09 +0100
Message-ID: <f4fb7ca1-0593-4f07-97ac-b3851e82d1e2@dronecode.org.uk>
Date: Fri, 5 Jun 2026 12:55:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: cygcheck: fix a new warning with gcc 16
References: <20260602112007.1279-1-jon.turney@dronecode.org.uk>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20260602112007.1279-1-jon.turney@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,KAM_NUMSUBJECT,MISSING_HEADERS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 02/06/2026 12:20, Jon Turney wrote:
> The mingW-targetted gcc available in Fedora is now gcc 16.
> 
>> ../../../../../winsup/utils/mingw/cygcheck.cc: In function 'void dump_sysinfo()':
>> ../../../../../winsup/utils/mingw/cygcheck.cc:1716:11: error: variable 'count_path_items' set but not used [-Werror=unused-but-set-variable=]
> 
> As far as I can tell, the value of count_path_items we compute has never
> been used.
Pushed.

