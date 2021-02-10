Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id A83BE3857C7B
 for <cygwin-patches@cygwin.com>; Wed, 10 Feb 2021 09:07:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A83BE3857C7B
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=mark@maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 11A97ZOw059121
 for <cygwin-patches@cygwin.com>; Wed, 10 Feb 2021 01:07:35 -0800 (PST)
 (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "[192.168.1.100]"
 via SMTP by m0.truegem.net, id smtpd2IcfIv; Wed Feb 10 01:07:30 2021
Subject: Re: [PATCH] Cygwin: Have tmpfile(3) use O_TMPFILE
To: cygwin-patches@cygwin.com
References: <20210209105000.26544-1-mark@maxrnd.com>
 <20210209152510.GV4251@calimero.vinschen.de>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <69e6c815-eafe-1b9e-948c-fd64c977ae88@maxrnd.com>
Date: Wed, 10 Feb 2021 01:07:30 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <20210209152510.GV4251@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, KAM_SHORT, NICE_REPLY_A,
 SPF_HELO_NONE, SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 10 Feb 2021 09:07:40 -0000

Hi Corinna,

Corinna Vinschen via Cygwin-patches wrote:
> Hi Mark,
> 
> On Feb  9 02:50, Mark Geisert wrote:
>> Per discussion on cygwin-developers, a Cygwin tmpfile(3) implementation
>> has been added to syscalls.cc.  This overrides the one supplied by
>> newlib.  Then the open(2) flag O_TMPFILE was added to the open call that
>> tmpfile internally makes.
>> ---
>>   winsup/cygwin/release/3.2.0 |  4 ++++
>>   winsup/cygwin/syscalls.cc   | 20 ++++++++++++++++++++
>>   2 files changed, 24 insertions(+)
>>
>> diff --git a/winsup/cygwin/release/3.2.0 b/winsup/cygwin/release/3.2.0
>> index f748a9bc8..d02d16863 100644
>> --- a/winsup/cygwin/release/3.2.0
>> +++ b/winsup/cygwin/release/3.2.0
>> @@ -19,6 +19,10 @@ What changed:
>>   
>>   - A few FAQ updates.
>>   
>> +- Have tmpfile(3) make use of Win32 FILE_ATTRIBUTE_TEMPORARY via open(2)
>> +  flag O_TMPFILE.
>> +  Addresses: https://cygwin.com/pipermail/cygwin/2021-January/247304.html
>> +
>>   
>>   Bug Fixes
>>   ---------
>> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
>> index 52a020f07..b79c1c7cd 100644
>> --- a/winsup/cygwin/syscalls.cc
>> +++ b/winsup/cygwin/syscalls.cc
>> @@ -5225,3 +5225,23 @@ pipe2 (int filedes[2], int mode)
>>     syscall_printf ("%R = pipe2([%d, %d], %y)", res, read, write, mode);
>>     return res;
>>   }
>> +
>> +extern "C" FILE *
>> +tmpfile (void)
>> +{
>> +  char *dir = getenv ("TMPDIR");
> 
> This isn't what Linux tmpfile does.  Per the man page, it tries to
> create the file in P_tmpdir first, and if that fails, it tries
> "/tmp".

Oops, I was following newlib's code here.  I'll adjust this.

>> +  if (!dir)
>> +    dir = P_tmpdir;
>> +  int fd = open (dir, O_RDWR | O_CREAT | O_BINARY | O_TMPFILE,
> 
> You have to specify O_EXCL here.  The idea is that this file cannot be
> made permanent, and missing the O_EXCL flag allows exactly that.  See
> https://man7.org/linux/man-pages/man2/open.2.html, the lengthy
> description in terms of O_TMPFILE.

I started out with O_EXCL as you suggested, but found syscalls.cc:1504 reporting 
EEXIST.  Is there some clash there between fh->exists() and O_TMPFILE?  Hmm.

..mark
