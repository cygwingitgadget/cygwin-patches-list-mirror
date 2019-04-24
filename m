Return-Path: <cygwin-patches-return-9378-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 66578 invoked by alias); 24 Apr 2019 12:33:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 66290 invoked by uid 89); 24 Apr 2019 12:33:43 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-9.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Envelope-From:sk:michael, newest, Pushed
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 24 Apr 2019 12:33:42 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 14:33:38 +0200
Received: from [172.28.42.244]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1hJH5m-0008Dn-4q; Wed, 24 Apr 2019 14:33:38 +0200
Subject: Re: [PATCH] Cygwin: use win pid+threadid for forkables dirname
References: <869d6cb0-9c14-d1f6-fdf2-f87ff815029b@ssi-schaefer.com> <20190412180140.GE4248@calimero.vinschen.de> <87ftqmxsok.fsf@Rainer.invalid>
To: cygwin-patches@cygwin.com
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Openpgp: preference=signencrypt
Message-ID: <5f9962f4-ce0c-a046-edcf-2003fc03eff9@ssi-schaefer.com>
Date: Wed, 24 Apr 2019 12:33:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87ftqmxsok.fsf@Rainer.invalid>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SW-Source: 2019-q2/txt/msg00085.txt.bz2

On 4/13/19 9:36 AM, Achim Gratz wrote:
> Corinna Vinschen writes:
>> On Apr 12 15:32, Michael Haubenwallner wrote:
>>> Rather than newest last write time of all dlls loaded, use the forking
>>> process' windows pid and windows thread id as directory name to create
>>> the forkable hardlinks into.  While this may create hardlinks more
>>> often, it does avoid conflicts between dlls not having the newest last
>>> write time.
>>> ---
>>>  winsup/cygwin/forkable.cc | 26 +++++++-------------------
>>>  1 file changed, 7 insertions(+), 19 deletions(-)
>>
>> Pushed.
> 
> Hmm. Is it safe to use such easily predictable names?

Not sure about potential threats here, as each hardlink is (re)created
right before the child process is created.

/haubi/
