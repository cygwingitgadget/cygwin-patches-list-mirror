Return-Path: <cygwin-patches-return-9402-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 77580 invoked by alias); 4 May 2019 14:34:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 77571 invoked by uid 89); 4 May 2019 14:34:02 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.3 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.1 spammy=English, acknowledge, quoted, WAS
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.137) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 04 May 2019 14:34:01 +0000
Received: from [192.168.1.114] ([24.64.172.44])	by shaw.ca with ESMTP	id MvjihpOA7o7SQMvjjhv5ZW; Sat, 04 May 2019 08:33:59 -0600
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [rebase PATCH] Introduce --recognize flag (WAS: Introduce --no-rebase flag)
To: cygwin-patches@cygwin.com
References: <20190412180302.GF4248@calimero.vinschen.de> <319c9949-6e00-2c18-f1d0-a88a7f02fdab@ssi-schaefer.com>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Openpgp: preference=signencrypt
Message-ID: <ae7bce9f-b1d6-440b-f6d6-fdca1040d56f@SystematicSw.ab.ca>
Date: Sat, 04 May 2019 14:34:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <319c9949-6e00-2c18-f1d0-a88a7f02fdab@ssi-schaefer.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00109.txt.bz2

On 2019-05-03 09:32, Michael Haubenwallner wrote:
> On 4/12/19 8:03 PM, Corinna Vinschen wrote:
>> On Apr 12 15:52, Michael Haubenwallner wrote:
>>> The --no-rebase flag is to update the database for new files, without
>> Wouldn't something like --merge-files be more descriptive?
> What about --recognize ?

"The --recognize flag is to update the database for new files, without
performing a rebase.  The file names provided should have been rebased
using the --oblivious flag just before."

Recognize does not mean record or update in English but see, identify, or
acknowledge.

Your earlier suggestion of --record, the verb used in the comment quoted above
--update, or CV's suggestion --merge-files would make sense and be more
descriptive.
I use such brief comments or descriptions as a guide to pick the most obvious
names for functions, options, etc: if the comment or description then reads as
if redundant, the choice is good.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
