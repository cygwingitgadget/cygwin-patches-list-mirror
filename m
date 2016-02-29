Return-Path: <cygwin-patches-return-8361-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28409 invoked by alias); 29 Feb 2016 12:21:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 28396 invoked by uid 89); 29 Feb 2016 12:21:02 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.0 required=5.0 tests=BAYES_40,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2 spammy=H*F:U*mail, 12,7, cxx, invocation
X-HELO: vae.croxnet.de
Received: from vae.croxnet.de (HELO vae.croxnet.de) (136.243.225.97) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Mon, 29 Feb 2016 12:21:00 +0000
Received: from localhost (localhost [127.0.0.1])	by vae.croxnet.de (Postfix) with ESMTP id 8314B1B03CF5	for <cygwin-patches@cygwin.com>; Mon, 29 Feb 2016 13:19:44 +0100 (CET)
Received: from vae.croxnet.de ([127.0.0.1])	by localhost (vae.croxnet.de [127.0.0.1]) (amavisd-new, port 10024)	with ESMTP id YFlzgLJZHLBp for <cygwin-patches@cygwin.com>;	Mon, 29 Feb 2016 13:19:44 +0100 (CET)
Received: from mail.croxnet.de (localhost [127.0.0.1])	by vae.croxnet.de (Postfix) with ESMTPSA id 26D931B03CF4	for <cygwin-patches@cygwin.com>; Mon, 29 Feb 2016 13:19:43 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 29 Feb 2016 12:21:00 -0000
From: mail@patrick-bendorf.de
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] ccwrap: fix build with non-english locale set
In-Reply-To: <20160229103339.GB3525@calimero.vinschen.de>
References: <56D3EF72.20504@patrick-bendorf.de> <20160229103339.GB3525@calimero.vinschen.de>
Message-ID: <b818ad6d60ddfd3557c3d9e21efc6344@patrick-bendorf.de>
X-Sender: mail@patrick-bendorf.de
User-Agent: Roundcube Webmail
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00067.txt.bz2

Hi Corinna,

Am 2016-02-29 11:33, schrieb Corinna Vinschen:
> Hi Patrick,
> 
> On Feb 29 08:12, Patrick Bendorf wrote:
>> /winsup/
>> * ccwrap: fix build with non-english locale set
> 
> First of all, why fix it?  Without at least a short explanation what 
> you
> observe without this patch, this change seems arbitrary.
> 
short explanation: after setting up cygwin on my systems the default 
locale is set to "de_DE.UTF-8". this leads to ccwrap not picking up 
certain "-isystem" arguments, which in turn leads to "stddef.h: no such 
file or directory". this breaks the build process for systems having non 
english locale.

consider the following two pastebins from a system with an english 
locale and mine. a whole bunch of "-isystem" can not be found on my 
system using german locale.
http://pastebin.com/ip5L7dZY
http://pastebin.com/wZBc2cqr

ccwrap scans the output of the first compiler invocation (line 21) for 
some specific english output on and around line 43.
output of first invocation on german locale system:
http://pastebin.com/ZZzVGReh

>> ---
>>  winsup/ccwrap | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/winsup/ccwrap b/winsup/ccwrap
>> index 7580e7a..ef83085 100755
>> --- a/winsup/ccwrap
>> +++ b/winsup/ccwrap
>> @@ -12,6 +12,7 @@ if ($ARGV[0] ne '++') {
>>      $cxx = 1;
>>  }
>>  die "$0: $ccorcxx environment variable does not exist\n" unless 
>> exists
>> $ENV{$ccorcxx};
>> +$ENV{'LANG'} = 'C.UTF-8';
>>  my @compiler = split ' ', $ENV{$ccorcxx};
>>  if ("@ARGV" !~ / -nostdinc/o) {
>>      my $fd;
>> --
>> 2.7.0
> 
> That won't work nicely for non-Cygwin build systems.  When cross
> building Cygwin on, e.g., Linux, "C.UTF-8" is an unrecognized locale.
> Ideally the above would test for the current build system being Cygwin
> and use "C.UTF-8" on Cygwin, "C" otherwise.
> 
thanks for pointing that out.
i changed the patch to check uname -o for cygwin string and set the 
locale to either C or C.UTF-8

---
  winsup/ccwrap | 1 +
  1 file changed, 1 insertion(+)

diff --git a/winsup/ccwrap b/winsup/ccwrap
index 7580e7a..ef83085 100755
--- a/winsup/ccwrap
+++ b/winsup/ccwrap
@@ -12,6 +12,11 @@ if ($ARGV[0] ne '++') {
      $cxx = 1;
  }
  die "$0: $ccorcxx environment variable does not exist\n" unless exists 
$ENV{$ccorcxx};
+if (`uname -o` =~ /cygwin/i) {
+    $ENV{'LANG'} = 'C.UTF-8';
+} else {
+    $ENV{'LANG'} = 'C';
+}
  my @compiler = split ' ', $ENV{$ccorcxx};
  if ("@ARGV" !~ / -nostdinc/o) {
      my $fd;
--
2.7.0

> 
> Thanks,
> Corinna
