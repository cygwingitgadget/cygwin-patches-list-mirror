Return-Path: <cygwin-patches-return-8885-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24549 invoked by alias); 25 Oct 2017 13:40:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 24505 invoked by uid 89); 25 Oct 2017 13:40:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-25.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RP_MATCHES_RCVD,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=D*cornell.edu, sk:kbrown, Anyway, HTo:U*cygwin-patches
X-HELO: limerock01.mail.cornell.edu
Received: from limerock01.mail.cornell.edu (HELO limerock01.mail.cornell.edu) (128.84.13.241) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 25 Oct 2017 13:40:24 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite3.serverfarm.cornell.edu [10.16.197.8])	by limerock01.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id v9PDeLlL001952	for <cygwin-patches@cygwin.com>; Wed, 25 Oct 2017 09:40:22 -0400
Received: from [10.13.22.3] (50-192-26-108-static.hfc.comcastbusiness.net [50.192.26.108])	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id v9PDeKXq003259	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)	for <cygwin-patches@cygwin.com>; Wed, 25 Oct 2017 09:40:21 -0400
Subject: Re: [PATCH] cygcheck: Fix parsing of file names containing colons
To: cygwin-patches@cygwin.com
References: <20171025112316.13004-1-kbrown@cornell.edu> <20171025121138.GF22429@calimero.vinschen.de> <20171025121912.GG22429@calimero.vinschen.de>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <b995c1b4-81cc-8d6b-91da-a44018393499@cornell.edu>
Date: Wed, 25 Oct 2017 13:40:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171025121912.GG22429@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------F82434C40DFFCFBD98717DE0"
X-PMX-Cornell-Gauge: Gauge=X
X-PMX-CORNELL-AUTH-RESULTS: dkim-out=none;
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00015.txt.bz2

This is a multi-part message in MIME format.
--------------F82434C40DFFCFBD98717DE0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1568

On 10/25/2017 8:19 AM, Corinna Vinschen wrote:
> On Oct 25 14:11, Corinna Vinschen wrote:
>> Hi Ken,
>>
>> On Oct 25 07:23, Ken Brown wrote:
>>> Up to now the function winsup/utils/dump_setup.cc:base skips past
>>> colons when parsing file names.  As a result, a line like
>>>
>>>    foo foo-1:2.3-4.tar.bz2 1
>>>
>>> in /etc/setup/installed.db would cause 'cygcheck -cd foo' to report 4
>>> as the installed version of foo insted of 1:2.3-4.  This is not an
>>> issue now, but it will become an issue when version numbers are
>>> allowed to contain epochs.
>>> ---
>>>   winsup/utils/dump_setup.cc | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/winsup/utils/dump_setup.cc b/winsup/utils/dump_setup.cc
>>> index 320d69fab..3922b18f8 100644
>>> --- a/winsup/utils/dump_setup.cc
>>> +++ b/winsup/utils/dump_setup.cc
>>> @@ -56,7 +56,7 @@ base (const char *s)
>>>     const char *rv = s;
>>>     while (*s)
>>>       {
>>> -      if ((*s == '/' || *s == ':' || *s == '\\') && s[1])
>>> +      if ((*s == '/' || *s == '\\') && s[1])
>>
>> I think this is a simplified way to test for the colon in paths like
>> C:/foo/bar.  Nothing else makes sense in this context.
>>
>> I'm not sure how much we care, but maybe we shoulkd fix the test to
>> ignore the colon only if it's the second character in the incoming
>> string?
> 
> Not "ignore", but "use as a delimiter" only as 2nd char in the input.

I'm not sure the distinction matters in this case, since the function is 
just trying to get the base name.  Anyway, how's the attached?

Ken

--------------F82434C40DFFCFBD98717DE0
Content-Type: text/plain; charset=UTF-8;
 name="0001-cygcheck-Fix-parsing-of-file-names-containing-colons.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-cygcheck-Fix-parsing-of-file-names-containing-colons.pa";
 filename*1="tch"
Content-length: 1591

RnJvbSAxMzU0ZTY3ZTEyODE5NTE5ZjlhNTQ0MGYxMmVmODkzZTRlMGJmN2E1
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGti
cm93bkBjb3JuZWxsLmVkdT4KRGF0ZTogVHVlLCAyNCBPY3QgMjAxNyAxODoy
MTo1MyAtMDQwMApTdWJqZWN0OiBbUEFUQ0hdIGN5Z2NoZWNrOiBGaXggcGFy
c2luZyBvZiBmaWxlIG5hbWVzIGNvbnRhaW5pbmcgY29sb25zCgpVcCB0byBu
b3cgdGhlIGZ1bmN0aW9uIHdpbnN1cC91dGlscy9kdW1wX3NldHVwLmNjOmJh
c2Ugc2tpcHMgcGFzdApjb2xvbnMgd2hlbiBwYXJzaW5nIGZpbGUgbmFtZXMu
ICBBcyBhIHJlc3VsdCwgYSBsaW5lIGxpa2UKCiAgZm9vIGZvby0xOjIuMy00
LnRhci5iejIgMQoKaW4gL2V0Yy9zZXR1cC9pbnN0YWxsZWQuZGIgd291bGQg
Y2F1c2UgJ2N5Z2NoZWNrIC1jZCBmb28nIHRvIHJlcG9ydCA0CmFzIHRoZSBp
bnN0YWxsZWQgdmVyc2lvbiBvZiBmb28gaW5zdGVkIG9mIDE6Mi4zLTQuICBU
aGlzIGlzIG5vdCBhbgppc3N1ZSBub3csIGJ1dCBpdCB3aWxsIGJlY29tZSBh
biBpc3N1ZSB3aGVuIHZlcnNpb24gbnVtYmVycyBhcmUKYWxsb3dlZCB0byBj
b250YWluIGVwb2Nocy4KLS0tCiB3aW5zdXAvdXRpbHMvZHVtcF9zZXR1cC5j
YyB8IDQgKysrLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC91dGlscy9kdW1w
X3NldHVwLmNjIGIvd2luc3VwL3V0aWxzL2R1bXBfc2V0dXAuY2MKaW5kZXgg
MzIwZDY5ZmFiLi5kMDU4MTcyMzkgMTAwNjQ0Ci0tLSBhL3dpbnN1cC91dGls
cy9kdW1wX3NldHVwLmNjCisrKyBiL3dpbnN1cC91dGlscy9kdW1wX3NldHVw
LmNjCkBAIC01MywxMCArNTMsMTIgQEAgYmFzZSAoY29uc3QgY2hhciAqcykK
IHsKICAgaWYgKCFzKQogICAgIHJldHVybiAwOworICBpZiAoaXNhbHBoYSAo
KnMpICYmIHNbMV0gPT0gJzonKQorICAgIHMgKz0gMjsKICAgY29uc3QgY2hh
ciAqcnYgPSBzOwogICB3aGlsZSAoKnMpCiAgICAgewotICAgICAgaWYgKCgq
cyA9PSAnLycgfHwgKnMgPT0gJzonIHx8ICpzID09ICdcXCcpICYmIHNbMV0p
CisgICAgICBpZiAoKCpzID09ICcvJyB8fCAqcyA9PSAnXFwnKSAmJiBzWzFd
KQogCXJ2ID0gcyArIDE7CiAgICAgICBzKys7CiAgICAgfQotLSAKMi4xNC4y
Cgo=

--------------F82434C40DFFCFBD98717DE0--
