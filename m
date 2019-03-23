Return-Path: <cygwin-patches-return-9222-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 98693 invoked by alias); 23 Mar 2019 20:37:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 98684 invoked by uid 89); 23 Mar 2019 20:37:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.1 required=5.0 tests=AWL,BAYES_00,KAM_NUMSUBJECT,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.1 spammy=HX-Languages-Length:948, advised
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.138) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 23 Mar 2019 20:37:43 +0000
Received: from [192.168.1.114] ([24.64.172.44])	by shaw.ca with ESMTP	id 7nOehqP9cGusj7nOfhsiAz; Sat, 23 Mar 2019 14:37:41 -0600
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH] default ps -W process start time to system boot time when inaccessible, 0, -1
To: cygwin-patches@cygwin.com
References: <20190323034522.9688-1-Brian.Inglis@SystematicSW.ab.ca> <87d0mh5x3u.fsf@Rainer.invalid> <20190323183653.GB3471@calimero.vinschen.de> <874l7tbfh6.fsf@Rainer.invalid>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Openpgp: preference=signencrypt
Message-ID: <4dfdfce1-245d-98fe-0c49-890ba8ec8dd4@SystematicSw.ab.ca>
Date: Sat, 23 Mar 2019 20:37:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <874l7tbfh6.fsf@Rainer.invalid>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00032.txt.bz2

On 2019-03-23 12:41, Achim Gratz wrote:
> Corinna Vinschen writes:
>>> replacing one lie with another that is less easy to spot doesn't sound
>>> the right thing to do.  How about ps if reported "N/A" or something to
>>> that effect instead?
>> 1 Jan 1970 may also be a good hint...
> Well, that was the point: I can deduce just from that date that ps
> didn't actually get data for the start time.  If it starts replacing
> this with the start time of the system instead, it might take a while
> for me to see what is going on.

Are there non-startup system processes for which boot time is misleading?
If you need the truth use wmic, procexp64, or run ps in an elevated shell.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
