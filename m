Return-Path: <cygwin-patches-return-8393-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 46537 invoked by alias); 12 Mar 2016 06:25:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 46525 invoked by uid 89); 12 Mar 2016 06:25:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.1 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2 spammy=H*r:8.12.11, H*r:sk:daemon@, HTo:U*cygwin-patches, HContent-Transfer-Encoding:8bit
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Sat, 12 Mar 2016 06:25:45 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id u2C6PC3R044592	for <cygwin-patches@cygwin.com>; Fri, 11 Mar 2016 22:25:12 -0800 (PST)	(envelope-from mark@maxrnd.com)
Received: from 76-217-5-154.lightspeed.irvnca.sbcglobal.net(76.217.5.154), claiming to be "[192.168.1.100]" via SMTP by m0.truegem.net, id smtpdXAE50x; Fri Mar 11 22:25:11 2016
Subject: Re: Fwd: [PATCH] spinlock spin with pause instruction
To: cygwin-patches@cygwin.com
References: <CAKw7uVgrjqZVznRMoCbsjyz4YXast5YtAAmpWQorOw7YXqbOhw@mail.gmail.com> <CAKw7uVg78t2V8KKLYfPyhb97XjU+aUb4KV-poz7i_wwDeJ6b=g@mail.gmail.com>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <56E3B674.7020702@maxrnd.com>
Date: Sat, 12 Mar 2016 06:25:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:42.0) Gecko/20100101 Firefox/42.0 SeaMonkey/2.39
MIME-Version: 1.0
In-Reply-To: <CAKw7uVg78t2V8KKLYfPyhb97XjU+aUb4KV-poz7i_wwDeJ6b=g@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00099.txt.bz2

Václav Haisman wrote:
> Hi.
>
> I have noticed that Cygwin's spinlock goes into heavy sleeping code
> for each spin. It seems it would be a good idea to actually try to
> spin a bit first. There is this 'pause' instruction which let's the
> CPU make such busy loops be less busy. Here is a patch to do this.

I wanted to try out this patch but compilation is failing on the "unlikely" 
call.  Is that a macro that needs defining or something else?
Thanks,

..mark
