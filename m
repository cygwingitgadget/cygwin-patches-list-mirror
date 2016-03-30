Return-Path: <cygwin-patches-return-8516-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3352 invoked by alias); 30 Mar 2016 19:12:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 3342 invoked by uid 89); 30 Mar 2016 19:12:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.1 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_FAIL autolearn=no version=3.3.2 spammy=Hx-languages-length:1002, wherever, implications, H*r:envelope-sender
X-HELO: smtpout.aon.at
Received: from smtpout.aon.at (HELO smtpout.aon.at) (195.3.96.112) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Wed, 30 Mar 2016 19:12:04 +0000
Received: (qmail 22684 invoked from network); 30 Mar 2016 19:12:01 -0000
Received: from 194-166-53-240.adsl.highway.telekom.at (HELO fril0034.wamas.com) ([194.166.53.240])          (envelope-sender <michael.haubenwallner@ssi-schaefer.com>)          by smarthub77.res.a1.net (qmail-ldap-1.03) with AES128-SHA encrypted SMTP; 30 Mar 2016 19:12:01 -0000
X-A1Mail-Track-Id: 1459365120:22637:smarthub77:194.166.53.240:1
Subject: Re: [PATCH 4/6] forkables: Protect fork against dll-, exe-updates.
To: cygwin-patches@cygwin.com
References: <1459364024-24891-1-git-send-email-michael.haubenwallner@ssi-schaefer.com> <1459364024-24891-5-git-send-email-michael.haubenwallner@ssi-schaefer.com> <56FC232D.4090006@cygwin.com>
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Message-ID: <56FC2500.4080909@ssi-schaefer.com>
Date: Wed, 30 Mar 2016 19:12:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <56FC232D.4090006@cygwin.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-SW-Source: 2016-q1/txt/msg00222.txt.bz2

On 03/30/2016 09:04 PM, Yaakov Selkowitz wrote:
> On 2016-03-30 13:53, Michael Haubenwallner wrote:
>> To support in-cygwin package managers, the fork() implementation must
>> not rely on .exe and .dll files to stay in their original location, as
>> the package manager's job is to replace these files.  Instead, we use
>> the hardlinks to the original binaries in /var/run/cygfork/ to create
>> the child process during fork, and let the main.exe.local file enable
>> the "DotLocal Dll Redirection" feature for dlls.
>>
>> The (probably few) users that need an update-safe fork manually have to
>> create the /var/run/cygfork/ directory for now, using:
>> mkdir --mode=a=rwxt /var/run/cygfork
> 
> Have the security implications of this been considered?

Which security implications do you think of?

Removed but in-use binaries are available in the recycle bin anyway,
and can manually be hardlinked to wherever one likes...

/haubi/
