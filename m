Return-Path: <cygwin-patches-return-8410-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 77148 invoked by alias); 15 Mar 2016 15:23:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 77121 invoked by uid 89); 15 Mar 2016 15:23:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_PASS autolearn=no version=3.3.2 spammy=H*M:cygwin, H*Ad:U*yselkowitz, HTo:U*cygwin-patches, HContent-Transfer-Encoding:8bit
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Tue, 15 Mar 2016 15:23:32 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])	by mx1.redhat.com (Postfix) with ESMTPS id 62C6C46267	for <cygwin-patches@cygwin.com>; Tue, 15 Mar 2016 15:23:31 +0000 (UTC)
Received: from [10.10.116.22] (ovpn-116-22.rdu2.redhat.com [10.10.116.22])	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u2FFNUn3029381	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)	for <cygwin-patches@cygwin.com>; Tue, 15 Mar 2016 11:23:31 -0400
Subject: Re: [PATCH] Cygwin: define byteswap.h inlines as macros
To: cygwin-patches@cygwin.com
References: <1458011636-8548-1-git-send-email-yselkowi@redhat.com> <CAKw7uVg7QZyVJCO0miU1HXwn6PF-8yxSwzMn7s_t6CkUb2ts5w@mail.gmail.com> <20160315114617.GC7819@calimero.vinschen.de>
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
Message-ID: <56E828F2.2010708@cygwin.com>
Date: Tue, 15 Mar 2016 15:23:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20160315114617.GC7819@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00116.txt.bz2

On 2016-03-15 06:46, Corinna Vinschen wrote:
> On Mar 15 11:55, VÃ¡clav Haisman wrote:
>> Would it not be better to leave the original functions as they were
>> and simply use these defines?
>>
>> #define bswap_16 bswap_16
>> #define bswap_32 bswap_32
>> #define bswap_64 bswap_64
>>
>> I believe this is valid C and C++. Untested.

Already tried that, it leads to compiling issues at least with the 
package that triggered this patch in the first place.

-- 
Yaakov
