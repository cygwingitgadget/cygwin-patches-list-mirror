Return-Path: <cygwin-patches-return-9221-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 94119 invoked by alias); 23 Mar 2019 20:32:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 94110 invoked by uid 89); 23 Mar 2019 20:32:41 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.1 required=5.0 tests=AWL,BAYES_00,KAM_NUMSUBJECT,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.1 spammy=advised
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.137) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 23 Mar 2019 20:32:40 +0000
Received: from [192.168.1.114] ([24.64.172.44])	by shaw.ca with ESMTP	id 7nJlhqNESGusj7nJmhshPt; Sat, 23 Mar 2019 14:32:38 -0600
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH] default ps -W process start time to system boot time when inaccessible, 0, -1
To: cygwin-patches@cygwin.com
References: <20190323034522.9688-1-Brian.Inglis@SystematicSW.ab.ca> <87d0mh5x3u.fsf@Rainer.invalid> <20190323183653.GB3471@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Openpgp: preference=signencrypt
Message-ID: <8e8f788c-83c8-1260-011f-055b19001c44@SystematicSw.ab.ca>
Date: Sat, 23 Mar 2019 20:32:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190323183653.GB3471@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00031.txt.bz2

On 2019-03-23 12:36, Corinna Vinschen wrote:
> On Mar 23 18:17, Achim Gratz wrote:
>> replacing one lie with another that is less easy to spot doesn't sound
>> the right thing to do.  How about ps if reported "N/A" or something to
>> that effect instead?
> 1 Jan 1970 may also be a good hint...

Except it's shifted to local time so always inconsistent unless we fudged with
_TM_GMTOFF and string shuffling or format %b %Y?

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
