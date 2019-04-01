Return-Path: <cygwin-patches-return-9297-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 59200 invoked by alias); 1 Apr 2019 20:46:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 59103 invoked by uid 89); 1 Apr 2019 20:46:02 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.5 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.1 spammy=Apart, discretion, advised
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.138) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 01 Apr 2019 20:46:00 +0000
Received: from [192.168.1.114] ([24.64.172.44])	by shaw.ca with ESMTP	id B3oahk6Azo7SQB3obh8NQt; Mon, 01 Apr 2019 14:45:58 -0600
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
To: cygwin-patches@cygwin.com
References: <20190326182824.GB4096@calimero.vinschen.de> <c52ec077-d1e6-f61a-df9c-fe9ede1ba1ff@ssi-schaefer.com> <20190327091640.GE4096@calimero.vinschen.de> <b22069db-a300-56f7-33dd-30a1adbc0c93@ssi-schaefer.com> <678d8ec4-f6c2-1538-aafd-dbb9cfc5dea5@ssi-schaefer.com> <20190328095818.GP4096@calimero.vinschen.de> <fd7b9ab3-ca07-0c80-04da-4f6b2f20d49e@ssi-schaefer.com> <20190328203056.GB4096@calimero.vinschen.de> <fe627231-6717-c702-b97b-d66cdc9409a3@ssi-schaefer.com> <20190401145658.GA6331@calimero.vinschen.de> <20190401155636.GN3337@calimero.vinschen.de> <c1e5901f-ae3e-2c22-46cd-895adadae358@ssi-schaefer.com>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Openpgp: preference=signencrypt
Message-ID: <2ef6e42d-43d7-ffa1-05f6-0601282aa17a@SystematicSw.ab.ca>
Date: Mon, 01 Apr 2019 20:46:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c1e5901f-ae3e-2c22-46cd-895adadae358@ssi-schaefer.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00004.txt.bz2

On 2019-04-01 10:31, Michael Haubenwallner wrote:
> 
> On 4/1/19 5:56 PM, Corinna Vinschen wrote:
>> On Apr  1 16:56, Corinna Vinschen wrote:
>>> On Apr  1 16:28, Michael Haubenwallner wrote:
>>>> On 3/28/19 9:30 PM, Corinna Vinschen wrote:
>>>>> can you please collect the base addresses of all DLLs generated during
>>>>> the build, plus their size and make a sorted list?  It would be
>>>>> interesting to know if the hash algorithm in ld is actually as bad
>>>>> as I conjecture.
>>>>
>>>> Please find attached the output of rebase -i for the dlls after bootstrap
>>>> on Cygwin 3.0.4, each built with ld from binutils-2.31.1.
>>
>> Oh, wait.  That's not what I was looking for.  The addresses are ok, but
>> the paths *must* be the ones at the time the DLLs have been created,
>> because that's what ld uses when creating the image base addresses.
> 
> Maybe I can provide that one as well.
> 
>> The
>> addresses combined with the installation paths don't make sense anymore.
>>
>> Apart from that, since you seem to be installing the DLLs anyway, can't
>> you combine every crucial point during installation with a rebase?
> 
> This is what I'm after now, but I may need to introduce something like
> additional readonly databases plus some --unregister option to rebase.

Check my questions and Achim's answers in the other subthread for existing ways
to deal with your issues that are only semi-documented.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
