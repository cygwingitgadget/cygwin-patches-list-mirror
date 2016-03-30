Return-Path: <cygwin-patches-return-8515-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 119186 invoked by alias); 30 Mar 2016 19:04:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 119140 invoked by uid 89); 30 Mar 2016 19:04:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.6 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_FAIL autolearn=no version=3.3.2 spammy=H*r:envelope-sender, HTo:U*cygwin-patches, protect
X-HELO: smtpout.aon.at
Received: from smtpout.aon.at (HELO smtpout.aon.at) (195.3.96.117) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Wed, 30 Mar 2016 19:04:02 +0000
Received: (qmail 10422 invoked from network); 30 Mar 2016 19:03:57 -0000
Received: from 194-166-53-240.adsl.highway.telekom.at (HELO fril0034.wamas.com) ([194.166.53.240])          (envelope-sender <michael.haubenwallner@ssi-schaefer.com>)          by smarthub79.res.a1.net (qmail-ldap-1.03) with AES128-SHA encrypted SMTP; 30 Mar 2016 19:03:57 -0000
X-A1Mail-Track-Id: 1459364636:10338:smarthub79:194.166.53.240:1
Subject: Re: [PATCH 0/6] Protect fork() against dll- and exe-updates.
To: cygwin-patches@cygwin.com
References: <1459364024-24891-1-git-send-email-michael.haubenwallner@ssi-schaefer.com> <56FC211E.4030204@dancol.org>
Newsgroups: gmane.os.cygwin.patches
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
X-Enigmail-Draft-Status: N1110
Message-ID: <56FC2318.6060609@ssi-schaefer.com>
Date: Wed, 30 Mar 2016 19:04:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <56FC211E.4030204@dancol.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-SW-Source: 2016-q1/txt/msg00221.txt.bz2

On 03/30/2016 08:55 PM, Daniel Colascione wrote:
> 
> 
> On 03/30/2016 11:53 AM, Michael Haubenwallner wrote:
>> Hi,
>>
>> this is the updated and split series of patches to use hardlinks
>> for creating the child process by fork(), in reply to
>> https://cygwin.com/ml/cygwin-developers/2016-01/msg00002.html
>> https://cygwin.com/ml/cygwin-developers/2016-03/msg00005.html
>> http://thread.gmane.org/gmane.os.cygwin.devel/1378
>>
>> Thanks for review!
>> /haubi/
>>
>>
> 
> Creating a new process now requires a write operation on the filesystem
> hosting the binary? Seriously? I don't think that's worth it no matter
> the other benefits.
> 

Only if the original binaries necessary to create the new child process
by fork() are not available any more - and the /var/run/cygfork/
directory does exist and is on NTFS.  I do prefer a working fork() even
when updating dlls and executables while the parent process is running.

/haubi/
