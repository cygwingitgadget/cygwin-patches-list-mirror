Return-Path: <cygwin-patches-return-8369-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 77791 invoked by alias); 29 Feb 2016 16:56:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 77778 invoked by uid 89); 29 Feb 2016 16:56:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.2 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2 spammy=H*F:U*mail, overcome, reliably, 29022016
X-HELO: vae.croxnet.de
Received: from vae.croxnet.de (HELO vae.croxnet.de) (136.243.225.97) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Mon, 29 Feb 2016 16:56:11 +0000
Received: from localhost (localhost [127.0.0.1])	by vae.croxnet.de (Postfix) with ESMTP id C1AAB1B03CFA	for <cygwin-patches@cygwin.com>; Mon, 29 Feb 2016 17:54:54 +0100 (CET)
Received: from vae.croxnet.de ([127.0.0.1])	by localhost (vae.croxnet.de [127.0.0.1]) (amavisd-new, port 10024)	with ESMTP id 8HJZfdccrvpJ for <cygwin-patches@cygwin.com>;	Mon, 29 Feb 2016 17:54:54 +0100 (CET)
Received: from [192.168.177.24] (ip4d159a2d.dynamic.kabel-deutschland.de [77.21.154.45])	by vae.croxnet.de (Postfix) with ESMTPSA id 301021B03CF9	for <cygwin-patches@cygwin.com>; Mon, 29 Feb 2016 17:54:53 +0100 (CET)
From: Patrick Bendorf <mail@patrick-bendorf.de>
Subject: Re: [PATCH] ccwrap: fix build with non-english locale set
To: cygwin-patches@cygwin.com
References: <56D3EF72.20504@patrick-bendorf.de> <20160229103339.GB3525@calimero.vinschen.de> <b818ad6d60ddfd3557c3d9e21efc6344@patrick-bendorf.de> <56D43D9B.5020602@dronecode.org.uk> <20160229125813.GE3525@calimero.vinschen.de> <3ecc67c4a2351cf32f28927eea91fc01@patrick-bendorf.de> <56D466A6.1000003@redhat.com>
Message-ID: <56D47828.1090208@patrick-bendorf.de>
Date: Mon, 29 Feb 2016 16:56:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <56D466A6.1000003@redhat.com>
Content-Type: multipart/mixed; boundary="------------020709000106010005060109"
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00075.txt.bz2

This is a multi-part message in MIME format.
--------------020709000106010005060109
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1221

thanks eric.
just changed and tested it.
hopefully the last patch for this matter.

@corinna: as attachment to overcome previous problems.

patrick

Am 29.02.2016 um 16:41 schrieb Eric Blake:
> On 02/29/2016 06:19 AM, patrick bendorf wrote:
>> after some discussion on irc and the list i'm resubmitting a simpler
>> version of the patch.
>> setting the locale on cygwin to 'C.UTF-8' is not needed, so i'm always
>> setting it to 'C' which is sufficient for the build process and the most
>> simple fix.
>>
>> /winsup/
>> * ccwrap: change locale to 'C' as ccwrap searches for literal strings
>> "search starts here" and "End of search list" which may be localized.
>> ---
>>   winsup/ccwrap | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/winsup/ccwrap b/winsup/ccwrap
>> index 7580e7a..0c6a170 100755
>> --- a/winsup/ccwrap
>> +++ b/winsup/ccwrap
>> @@ -12,6 +12,7 @@ if ($ARGV[0] ne '++') {
>>       $cxx = 1;
>>   }
>>   die "$0: $ccorcxx environment variable does not exist\n" unless exists
>> $ENV{$ccorcxx};
>> +$ENV{'LANG'} = 'C';
> This won't work if I have LC_ALL set in my environment.  If you want to
> force the locale, you want to set LC_ALL (highest priority), not LANG
> (lowest priority).
>



--------------020709000106010005060109
Content-Type: text/plain; charset=UTF-8;
 name="0001-winsup.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-winsup.patch"
Content-length: 997

RnJvbSA4MjZmZDAxNTE4NzYwMjc5YWVjOGM4ZTQ5NGE1ZDVkN2ZkZTI4ZjBi
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBwYXRyaWNrIGJlbmRv
cmYgPG1haWxAcGF0cmljay1iZW5kb3JmLmRlPgpEYXRlOiBNb24sIDI5IEZl
YiAyMDE2IDE3OjIxOjIwICswMTAwClN1YmplY3Q6IFtQQVRDSF0gL3dpbnN1
cC8gKiBjY3dyYXA6IHNldCBMQ19BTEwgaW5zdGVhZCBvZiBMQU5HIHRvICdD
JyB0byBmb3JjZQogbG9jYWxlIHJlbGlhYmx5CgotLS0KIHdpbnN1cC9jY3dy
YXAgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvY2N3cmFwIGIvd2lu
c3VwL2Njd3JhcAppbmRleCAwYzZhMTcwLi5hN2QyZGQxIDEwMDc1NQotLS0g
YS93aW5zdXAvY2N3cmFwCisrKyBiL3dpbnN1cC9jY3dyYXAKQEAgLTEyLDcg
KzEyLDcgQEAgaWYgKCRBUkdWWzBdIG5lICcrKycpIHsKICAgICAkY3h4ID0g
MTsKIH0KIGRpZSAiJDA6ICRjY29yY3h4IGVudmlyb25tZW50IHZhcmlhYmxl
IGRvZXMgbm90IGV4aXN0XG4iIHVubGVzcyBleGlzdHMgJEVOVnskY2NvcmN4
eH07Ci0kRU5WeydMQU5HJ30gPSAnQyc7CiskRU5WeydMQ19BTEwnfSA9ICdD
JzsKIG15IEBjb21waWxlciA9IHNwbGl0ICcgJywgJEVOVnskY2NvcmN4eH07
CiBpZiAoIkBBUkdWIiAhfiAvIC1ub3N0ZGluYy9vKSB7CiAgICAgbXkgJGZk
OwotLSAKMi43LjAKCg==

--------------020709000106010005060109--
