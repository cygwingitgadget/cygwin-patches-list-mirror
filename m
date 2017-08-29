Return-Path: <cygwin-patches-return-8840-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 90909 invoked by alias); 24 Aug 2017 20:01:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 90554 invoked by uid 89); 24 Aug 2017 20:00:40 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2 spammy=Attached, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.12) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 24 Aug 2017 20:00:39 +0000
Received: from [192.168.1.100] ([24.64.240.204])	by shaw.ca with SMTP	id kyIudrYpjM9gtkyIvd08Ny; Thu, 24 Aug 2017 14:00:37 -0600
X-Authority-Analysis: v=2.2 cv=a+JAzQaF c=1 sm=1 tr=0 a=MVEHjbUiAHxQW0jfcDq5EA==:117 a=MVEHjbUiAHxQW0jfcDq5EA==:17 a=r77TgQKjGQsHNAKrUKIA:9 a=xdBemK8hOofEOvEkRpEA:9 a=QEXdDO2ut3YA:10 a=7vT8eNxyAAAA:8 a=jNeH2KA-qBnYL5l4uxIA:9 a=CdiWusdWvyIA:10 a=Mzmg39azMnTNyelF985k:22
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Subject: Re: [PATCH] winsup/cygwin/libc/strptime.cc(__strptime) add strptime %s
Reply-To: Brian.Inglis@SystematicSw.ab.ca
To: cygwin-patches@cygwin.com
References: <BY1PR09MB0343663DE41D927E67CF0CCEA5BB0@BY1PR09MB0343.namprd09.prod.outlook.com> <acc19ec5-055b-1bd4-997d-a247755163bf@SystematicSw.ab.ca> <92da937f-f770-f29c-651e-000f92cbf358@SystematicSw.ab.ca> <20170824092535.GH7469@calimero.vinschen.de>
Message-ID: <3d046e98-13f6-8cd6-97e7-2ce611946350@SystematicSw.ab.ca>
Date: Tue, 29 Aug 2017 17:57:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170824092535.GH7469@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------61E456A3570C36FAEA67A188"
X-CMAE-Envelope: MS4wfImndcmbSjN6wYYju9EMEr1RdnkRK4wXQ2WIlCadfh2n+TAaiWrHfk80PZqqoICSGjdy+tc5els0tXNNPe1ij8nRSvK4wbr0RYgPsXr/G0rkJ7qrgEpK fB+DnE+vWfcPcZgU44UdR0lvN4HLQJkrE/QQX0InOmX+Zsf3u8jsqSzqq0eTuGMgwpYyOKqAEvVOyOwjAoqFFNLenmmUApmuklI=
X-IsSubscribed: yes
X-SW-Source: 2017-q3/txt/msg00042.txt.bz2

This is a multi-part message in MIME format.
--------------61E456A3570C36FAEA67A188
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-length: 1053

On 2017-08-24 03:25, Corinna Vinschen wrote:
> On Aug 23 12:51, Brian Inglis wrote:
>> Attached patch to support %s in Cygwin winsup libc strptime.cc __strptime().
>> This also enables support for %s in dateutils package strptime(1).
>> In case the issue comes up, if the user wants to support %s as in date(1) with a
>> preceding @ flag, they just have to include that verbatim before the format as
>> in "@%s".
>> Testing revealed a separate issue with %F format which I will follow up on in a
>> different thread.
>> Similar patch coming for newlib.
> Funny enough, in other places in Cygwin we call this temp variable
> "save_errno" :)
> Alternatively, since you're in C++ code, you can use the save_errno
> class, like this:
>   {
>     save_errno save;
> 
>     [do your thing]
>   }
> The destructor of save_errno will restore errno.
> Since the code as such is fine, it's your choice if you want to stick
> to it or use one of the above.  Just give the word.

Changed to use that.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada


--------------61E456A3570C36FAEA67A188
Content-Type: text/plain; charset=UTF-8;
 name="0001-winsup-cygwin-libc-strptime.cc-__strptime-add-s-supp.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-winsup-cygwin-libc-strptime.cc-__strptime-add-s-supp.pa";
 filename*1="tch"
Content-length: 1664

RnJvbSAxNjg1NWUyZTI0MTY3M2U1Y2I5ODM2OGE2OTYxMTRlMzhmNjJhNGRj
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBCcmlhbiBJbmdsaXMg
PEJyaWFuLkluZ2xpc0BTeXN0ZW1hdGljU1cuYWIuY2E+CkRhdGU6IFRodSwg
MjQgQXVnIDIwMTcgMTM6MjQ6MjggLTA2MDAKU3ViamVjdDogW1BBVENIXSB3
aW5zdXAvY3lnd2luL2xpYmMvc3RycHRpbWUuY2MoX19zdHJwdGltZSkgYWRk
ICVzIHN1cHBvcnQgdG8KIHN0cnB0aW1lCgotLS0KIHdpbnN1cC9jeWd3aW4v
bGliYy9zdHJwdGltZS5jYyB8IDIwICsrKysrKysrKysrKysrKysrKysrCiAx
IGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBh
L3dpbnN1cC9jeWd3aW4vbGliYy9zdHJwdGltZS5jYyBiL3dpbnN1cC9jeWd3
aW4vbGliYy9zdHJwdGltZS5jYwppbmRleCA2MmRjYTZlNWUuLjdjNmNjMjAy
NCAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9saWJjL3N0cnB0aW1lLmNj
CisrKyBiL3dpbnN1cC9jeWd3aW4vbGliYy9zdHJwdGltZS5jYwpAQCAtNTcz
LDYgKzU3MywyNiBAQCBsaXRlcmFsOgogCQkJYnAgPSBjb252X251bShicCwg
JnRtLT50bV9zZWMsIDAsIDYxLCBBTFRfRElHSVRTKTsKIAkJCWNvbnRpbnVl
OwogCisJCWNhc2UgJ3MnIDoJLyogVGhlIHNlY29uZHMgc2luY2UgVW5peCBl
cG9jaCAtIEdOVSBleHRlbnNpb24gKi8KKwkJICAgIHsKKwkJCWxvbmcgbG9u
ZyBzZWM7CisJCQl0aW1lX3QgdDsKKwkJCWNoYXIgKmVuZDsKKwkJCXNhdmVf
ZXJybm8gc2F2ZTsKKworCQkJTEVHQUxfQUxUKDApOworCQkJc2VjID0gc3Ry
dG9sbF9sICgoY2hhciAqKWJwLCAmZW5kLCAxMCwgbG9jYWxlKTsKKwkJCXQg
PSBzZWM7CisJCQlpZiAoZW5kID09IChjaGFyICopYnAKKwkJCSAgICB8fCBl
cnJubyAhPSAwCisJCQkgICAgfHwgdCAhPSBzZWMKKwkJCSAgICB8fCBsb2Nh
bHRpbWVfciAoJnQsIHRtKSAhPSB0bSkKKwkJCSAgICByZXR1cm4gTlVMTDsK
KwkJCWJwID0gKGNvbnN0IHVuc2lnbmVkIGNoYXIgKillbmQ7CisJCQl5bWQg
fD0gU0VUX1lEQVkgfCBTRVRfV0RBWSB8IFNFVF9ZTUQ7CisJCQlicmVhazsK
KwkJICAgIH0KKwogCQljYXNlICdVJzoJLyogVGhlIHdlZWsgb2YgeWVhciwg
YmVnaW5uaW5nIG9uIHN1bmRheS4gKi8KIAkJY2FzZSAnVyc6CS8qIFRoZSB3
ZWVrIG9mIHllYXIsIGJlZ2lubmluZyBvbiBtb25kYXkuICovCiAJCQkvKgot
LSAKMi4xNC4xCgo=

--------------61E456A3570C36FAEA67A188--
