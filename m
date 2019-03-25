Return-Path: <cygwin-patches-return-9232-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 52402 invoked by alias); 25 Mar 2019 19:02:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 52386 invoked by uid 89); 25 Mar 2019 19:02:08 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.7 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.1 spammy=advised, HContent-Transfer-Encoding:8bit
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 25 Mar 2019 19:02:07 +0000
Received: from [192.168.1.114] ([24.64.172.44])	by shaw.ca with ESMTP	id 8UrEhpLLMldkP8UrFhtSAS; Mon, 25 Mar 2019 13:02:05 -0600
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH 0/2] default ps -W process start time to boot time when unavailable
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20190324022239.48618-1-Brian.Inglis@SystematicSW.ab.ca> <20190325102701.GG3471@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Openpgp: preference=signencrypt
Message-ID: <70584859-5c2a-ab63-e8c2-691eb4e031c1@SystematicSw.ab.ca>
Date: Mon, 25 Mar 2019 19:02:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190325102701.GG3471@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00042.txt.bz2

On 2019-03-25 04:27, Corinna Vinschen wrote:
> On Mar 23 20:22, Brian Inglis wrote:
>> non-elevated users can not access system startup process start times,
>> defaulting to time_t 0, displaying as Dec 31/Jan 1 depending on time zone,
>> so instead use system boot time, which is within seconds of correct,
>> to avoid WMI overhead getting correct system startup process start time
>> Brian Inglis (2):
>>   default ps -W process start time to system boot time when inaccessible, 0, -1
>>   get and convert boot time once and use as needed
>>  winsup/utils/ps.cc | 20 +++++++++++++++++++-
>>  1 file changed, 19 insertions(+), 1 deletion(-)
>> -- 
>> 2.17.0
> Pushed.

Ta, Cheers!

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
