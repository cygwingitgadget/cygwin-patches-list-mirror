Return-Path: <cygwin-patches-return-8366-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 86255 invoked by alias); 29 Feb 2016 13:34:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 86244 invoked by uid 89); 29 Feb 2016 13:34:13 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.7 required=5.0 tests=AWL,BAYES_40,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2 spammy=H*F:U*mail, 12,7, searches, 29022016
X-HELO: vae.croxnet.de
Received: from vae.croxnet.de (HELO vae.croxnet.de) (136.243.225.97) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Mon, 29 Feb 2016 13:34:12 +0000
Received: from localhost (localhost [127.0.0.1])	by vae.croxnet.de (Postfix) with ESMTP id F0C001B03CF7	for <cygwin-patches@cygwin.com>; Mon, 29 Feb 2016 14:32:55 +0100 (CET)
Received: from vae.croxnet.de ([127.0.0.1])	by localhost (vae.croxnet.de [127.0.0.1]) (amavisd-new, port 10024)	with ESMTP id IPFo7lQ81K4F for <cygwin-patches@cygwin.com>;	Mon, 29 Feb 2016 14:32:55 +0100 (CET)
Received: from [192.168.177.24] (ip4d159a2d.dynamic.kabel-deutschland.de [77.21.154.45])	by vae.croxnet.de (Postfix) with ESMTPSA id 81D921B03CF5	for <cygwin-patches@cygwin.com>; Mon, 29 Feb 2016 14:32:54 +0100 (CET)
Subject: Re: [PATCH] ccwrap: fix build with non-english locale set
To: cygwin-patches@cygwin.com
References: <56D3EF72.20504@patrick-bendorf.de> <20160229103339.GB3525@calimero.vinschen.de> <b818ad6d60ddfd3557c3d9e21efc6344@patrick-bendorf.de> <56D43D9B.5020602@dronecode.org.uk> <20160229125813.GE3525@calimero.vinschen.de> <3ecc67c4a2351cf32f28927eea91fc01@patrick-bendorf.de>
From: Patrick Bendorf <mail@patrick-bendorf.de>
Message-ID: <56D448D1.2040700@patrick-bendorf.de>
Date: Mon, 29 Feb 2016 13:34:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <3ecc67c4a2351cf32f28927eea91fc01@patrick-bendorf.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00072.txt.bz2

sorry, now it's based on current git head. and hopefully without 
formatting issues.

/winsup/
* ccwrap: change locale to 'C' as ccwrap searches for literal strings 
"search starts here" and "End of search list" which may be localized.

---
  winsup/ccwrap | 6 +-----
  1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/winsup/ccwrap b/winsup/ccwrap
index 2f1fd3a..0c6a170 100755
--- a/winsup/ccwrap
+++ b/winsup/ccwrap
@@ -12,11 +12,7 @@ if ($ARGV[0] ne '++') {
      $cxx = 1;
  }
  die "$0: $ccorcxx environment variable does not exist\n" unless exists 
$ENV{$ccorcxx};
-if (`uname -o` =~ /cygwin/i) {
-    $ENV{'LANG'} = 'C.UTF-8';
-} else {
-    $ENV{'LANG'} = 'C';
-}
+$ENV{'LANG'} = 'C';
  my @compiler = split ' ', $ENV{$ccorcxx};
  if ("@ARGV" !~ / -nostdinc/o) {
      my $fd;
--
2.7.0

Am 29.02.2016 um 14:19 schrieb patrick bendorf:
> after some discussion on irc and the list i'm resubmitting a simpler 
> version of the patch.
> setting the locale on cygwin to 'C.UTF-8' is not needed, so i'm always 
> setting it to 'C' which is sufficient for the build process and the 
> most simple fix.
>
> /winsup/
> * ccwrap: change locale to 'C' as ccwrap searches for literal strings 
> "search starts here" and "End of search list" which may be localized.
> ---
>  winsup/ccwrap | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/winsup/ccwrap b/winsup/ccwrap
> index 7580e7a..0c6a170 100755
> --- a/winsup/ccwrap
> +++ b/winsup/ccwrap
> @@ -12,6 +12,7 @@ if ($ARGV[0] ne '++') {
>      $cxx = 1;
>  }
>  die "$0: $ccorcxx environment variable does not exist\n" unless 
> exists $ENV{$ccorcxx};
> +$ENV{'LANG'} = 'C';
>  my @compiler = split ' ', $ENV{$ccorcxx};
>  if ("@ARGV" !~ / -nostdinc/o) {
>      my $fd;
> -- 
> 2.7.0
>
> patrick
>
> Am 2016-02-29 13:58, schrieb Corinna Vinschen:
>> On Feb 29 12:46, Jon Turney wrote:
>>> On 29/02/2016 12:19, mail@patrick-bendorf.de wrote:
>>> >+if (`uname -o` =~ /cygwin/i) {
>>> >+    $ENV{'LANG'} = 'C.UTF-8';
>>> >+} else {
>>> >+    $ENV{'LANG'} = 'C';
>>>
>>> This can just say "$ENV{'LANG'} = 'C';" right? As that has to work
>>> everywhere?
>>
>> Uh, I missed that.  Yes, of course that should work, too.
>>
>>
>> Corinna
