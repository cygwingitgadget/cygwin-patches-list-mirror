Return-Path: <cygwin-patches-return-8768-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 58041 invoked by alias); 13 May 2017 04:26:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 57205 invoked by uid 89); 13 May 2017 04:25:40 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.0 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=no version=3.3.2 spammy=andrey, Repin, repin, Andrey
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.137) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 13 May 2017 04:25:21 +0000
Received: from [192.168.1.100] ([174.0.238.184])	by shaw.ca with SMTP	id 9OcHdikbTyd2D9OcIdEByK; Fri, 12 May 2017 22:25:18 -0600
X-Authority-Analysis: v=2.2 cv=F5wnTupN c=1 sm=1 tr=0 a=WqCeCkldcEjBO3QZneQsCg==:117 a=WqCeCkldcEjBO3QZneQsCg==:17 a=IkcTkHD0fZMA:10 a=w_pzkKWiAAAA:8 a=GeDdQGIk3sC7dlQFBMAA:9 a=QEXdDO2ut3YA:10 a=nQ-Hu-D2FK4A:10 a=YcSCMB9dSN0A:10 a=l4lHiSdNQNsA:10 a=sRI3_1zDfAgwuvI8zelB:22
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Subject: Re: [PATCH] Avoid decimal point localization in /proc/loadavg
References: <20170408125537.15728-1-jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
In-Reply-To: <20170408125537.15728-1-jon.turney@dronecode.org.uk>
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Message-ID: <ba5b7dfb-686b-7791-b6a6-17eb91527359@SystematicSw.ab.ca>
Date: Sat, 13 May 2017 04:26:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfH7Mlb3kx38ZK6FPZuqHRZn5wvzLQ43BLDWKgVE5or8+vYyfvabCUHdfibNUCjk5XmJE96V+ZE767cEyoFqZNQhRZPM91ojJTkW4wypS53+Zgoz3LssZ xxYRiya+Pwe+P7rEwTr6nywEz/SvnmtGAiZMklaYBS7yCvy7kqyfBogBMKdTaI3i+yWAUP60fOSwLxmPJD46efBsMfjXsebKuAY=
X-SW-Source: 2017-q2/txt/msg00039.txt.bz2

Also affects uptime - and anything else using /proc/loadavg

https://cygwin.com/ml/cygwin/2017-05/msg00190.html

Subject: $ uptime: bad data in /proc/loadavg
On 2017-05-12 20:44, Andrey Repin wrote:
> Greetings, All!
> Just a few days ago it worked, but now
> $ uptime
> bad data in /proc/loadavg
> $ cat /proc/loadavg
> 0,00 0,00 0,00 1/3
> It reporting approx the same from under elevated shell.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada
