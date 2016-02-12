Return-Path: <cygwin-patches-return-8304-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 52180 invoked by alias); 12 Feb 2016 16:53:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 52143 invoked by uid 89); 12 Feb 2016 16:53:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_PASS autolearn=no version=3.3.2 spammy=H*M:cygwin, Hx-languages-length:409, HTo:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Fri, 12 Feb 2016 16:53:29 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])	by mx1.redhat.com (Postfix) with ESMTPS id 6639432D3C7	for <cygwin-patches@cygwin.com>; Fri, 12 Feb 2016 16:53:28 +0000 (UTC)
Received: from [10.10.116.17] (ovpn-116-17.rdu2.redhat.com [10.10.116.17])	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u1CGrRF6022299	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)	for <cygwin-patches@cygwin.com>; Fri, 12 Feb 2016 11:53:28 -0500
Subject: Re: [PATCH] cygwin: update child info magic
To: cygwin-patches@cygwin.com
References: <1455244717-12688-1-git-send-email-yselkowi@redhat.com> <20160212093359.GC19968@calimero.vinschen.de>
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
Message-ID: <56BE0DFC.7000702@cygwin.com>
Date: Fri, 12 Feb 2016 16:53:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20160212093359.GC19968@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00010.txt.bz2

On 2016-02-12 03:33, Corinna Vinschen wrote:
> On Feb 11 20:38, Yaakov Selkowitz wrote:
>> 	winsup/cygwin/
>> 	* child_info.h (CURR_CHILD_INFO_MAGIC): Update.
>
> This needs an explanation.  CHILD_INFO_MAGIC is still 0x30ea98f6U
> for me.

Hmmm, in that case it's either one of the patches I just sent or it's 
gcc-5.  How would either of those affect this?

-- 
Yaakov
