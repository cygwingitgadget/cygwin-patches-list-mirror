Return-Path: <cygwin-patches-return-9379-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22413 invoked by alias); 24 Apr 2019 13:08:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 22398 invoked by uid 89); 24 Apr 2019 13:08:29 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.8 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=consequently, feels
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 24 Apr 2019 13:08:28 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 15:08:25 +0200
Received: from [172.28.42.244]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1hJHdR-0000gA-A8; Wed, 24 Apr 2019 15:08:25 +0200
Subject: Re: [rebase PATCH] Introduce --no-rebase flag
References: <990610f4-8ba8-92a1-0ece-5b22c275945a@ssi-schaefer.com> <87bm1axsls.fsf@Rainer.invalid>
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
To: cygwin-patches@cygwin.com
Openpgp: preference=signencrypt
Message-ID: <e6f0850c-d431-0b95-c521-6c5693748435@ssi-schaefer.com>
Date: Wed, 24 Apr 2019 13:08:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87bm1axsls.fsf@Rainer.invalid>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SW-Source: 2019-q2/txt/msg00086.txt.bz2

On 4/13/19 9:38 AM, Achim Gratz wrote:
> Michael Haubenwallner writes:
>> The --no-rebase flag is to update the database for new files, without
>> performing a rebase.  The file names provided should have been rebased
>> using the --oblivious flag just before.
> 
> That name is somewhat strange, how about "--enlist"?

From my point of view, rebase does perform multiple steps,
each being enabled by default, but each to become optional:

1) Perform the "rebase", with flag for disabling to be defined.
2) "Record" (or "enlist") to database, with --oblivious flag for disabling.

While it is fine to have both enabled by default, disabling one step by
explicitly enabling the (already enabled) other step feels confusing...

So, consequently, what about renaming --oblivious to --no-record (or --no-enlist),
to end up with the "rebase" and the "record" (or "enlist") steps both being
disabled by the according --no-<step> flag?

Thanks!
/haubi/
