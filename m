Return-Path: <cygwin-patches-return-8833-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 92700 invoked by alias); 23 Aug 2017 18:52:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 92653 invoked by uid 89); 23 Aug 2017 18:51:59 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2 spammy=H*R:D*ca, D*ca, Attached, H*F:D*ca
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.138) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 23 Aug 2017 18:51:57 +0000
Received: from [192.168.1.100] ([24.64.240.204])	by shaw.ca with SMTP	id kaksd2wvKDJTWkaktdmtoJ; Wed, 23 Aug 2017 12:51:56 -0600
X-Authority-Analysis: v=2.2 cv=B4DJ6KlM c=1 sm=1 tr=0 a=MVEHjbUiAHxQW0jfcDq5EA==:117 a=MVEHjbUiAHxQW0jfcDq5EA==:17 a=r77TgQKjGQsHNAKrUKIA:9 a=Y9RzA-PAWJbZsLeMOg8A:9 a=QEXdDO2ut3YA:10 a=7vT8eNxyAAAA:8 a=xp7C-Ao4kqvRuE73rngA:9 a=CdiWusdWvyIA:10 a=Mzmg39azMnTNyelF985k:22
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: [PATCH] winsup/cygwin/libc/strptime.cc(__strptime) add strptime %s
References: <BY1PR09MB0343663DE41D927E67CF0CCEA5BB0@BY1PR09MB0343.namprd09.prod.outlook.com> <acc19ec5-055b-1bd4-997d-a247755163bf@SystematicSw.ab.ca>
To: cygwin-patches@cygwin.com
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Message-ID: <92da937f-f770-f29c-651e-000f92cbf358@SystematicSw.ab.ca>
Date: Thu, 24 Aug 2017 09:33:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <acc19ec5-055b-1bd4-997d-a247755163bf@SystematicSw.ab.ca>
Content-Type: multipart/mixed; boundary="------------2392733ADB0970CF9A761D2D"
X-CMAE-Envelope: MS4wfAAebtOWP9nPOjQr/TGi5wG1xN7jVs2Mf1HWpUjdF4d5H1UsuSFGXThGmP3+16BzVNt6cnZGQ4EIksBeHJpWdzY4zUG4G6GM04zE6TUKg9iB0KTtYnvw KZtiUUix0/eGqinldHkl5OJG2Cnj6eSbd2KY7Cf4qbBsCCvHALSU9CcnMKyBKfdNxKxmWQ0PmsBoTp/xMu2aNWLA2KRF7GcvYhY=
X-IsSubscribed: yes
X-SW-Source: 2017-q3/txt/msg00035.txt.bz2

This is a multi-part message in MIME format.
--------------2392733ADB0970CF9A761D2D
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-length: 1425

On 2017-07-23 22:07, Brian Inglis wrote:
> On 2017-07-23 20:09, Lavrentiev, Anton (NIH/NLM/NCBI) [C] wrote:
>>> But that's just scanning a decimal integer to time_t.
>> It's not a question of whether I can or can't convert a string into an 
>> integer, rather it's a question about portability of code that uses %s for
>> both functions and expects it to work unchanged in the Cygwin environment.
>> Also, strptime() was designed to be a reversal to strftime() (from the
>> man-pages: the strptime() function is the converse function to strftime(3))
>> so both are supposed to "understand" the same basic set of formats. Because
>> of Cygwin's strptime() missing "%s", the following also does not work even
>> from command line:
>> $ date +"%s" | strptime "%s"
> Attached diff for proposed strptime %s and %F support.
> Let me know if you would prefer a different approach before I submit a git 
> format-patch.

Attached patch to support %s in Cygwin winsup libc strptime.cc __strptime().

This also enables support for %s in dateutils package strptime(1).

In case the issue comes up, if the user wants to support %s as in date(1) with a
preceding @ flag, they just have to include that verbatim before the format as
in "@%s".

Testing revealed a separate issue with %F format which I will follow up on in a
different thread.

Similar patch coming for newlib.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

--------------2392733ADB0970CF9A761D2D
Content-Type: text/plain; charset=UTF-8;
 name="0001-winsup-cygwin-libc-strptime.cc-__strptime-add-strpti.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-winsup-cygwin-libc-strptime.cc-__strptime-add-strpti.pa";
 filename*1="tch"
Content-length: 1737

RnJvbSAxMWY5NTA1OTdlN2Y2NjEzMmEyY2U2YzgxMjBmNzE5OWJhMDIzMTZm
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBCcmlhbiBJbmdsaXMg
PEJyaWFuLkluZ2xpc0BTeXN0ZW1hdGljU1cuYWIuY2E+CkRhdGU6IFR1ZSwg
MjIgQXVnIDIwMTcgMTU6MTA6MjcgLTA2MDAKU3ViamVjdDogW1BBVENIXSB3
aW5zdXAvY3lnd2luL2xpYmMvc3RycHRpbWUuY2MoX19zdHJwdGltZSkgYWRk
IHN0cnB0aW1lICVzCgotLS0KIHdpbnN1cC9jeWd3aW4vbGliYy9zdHJwdGlt
ZS5jYyB8IDIzICsrKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hh
bmdlZCwgMjMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9j
eWd3aW4vbGliYy9zdHJwdGltZS5jYyBiL3dpbnN1cC9jeWd3aW4vbGliYy9z
dHJwdGltZS5jYwppbmRleCA2MmRjYTZlNWUuLmE3ZmVmNDk4NSAxMDA2NDQK
LS0tIGEvd2luc3VwL2N5Z3dpbi9saWJjL3N0cnB0aW1lLmNjCisrKyBiL3dp
bnN1cC9jeWd3aW4vbGliYy9zdHJwdGltZS5jYwpAQCAtNTczLDYgKzU3Mywy
OSBAQCBsaXRlcmFsOgogCQkJYnAgPSBjb252X251bShicCwgJnRtLT50bV9z
ZWMsIDAsIDYxLCBBTFRfRElHSVRTKTsKIAkJCWNvbnRpbnVlOwogCisJCWNh
c2UgJ3MnIDoJLyogVGhlIHNlY29uZHMgc2luY2UgVW5peCBlcG9jaCAtIEdO
VSBleHRlbnNpb24gKi8KKwkJICAgIHsKKwkJCWxvbmcgbG9uZyBzZWM7CisJ
CQl0aW1lX3QgdDsKKwkJCWludCBlcnJub19zYXZlOworCQkJY2hhciAqZW5k
OworCisJCQlMRUdBTF9BTFQoMCk7CisJCQllcnJub19zYXZlID0gZXJybm87
CisJCQllcnJubyA9IDA7CisJCQlzZWMgPSBzdHJ0b2xsX2wgKChjaGFyICop
YnAsICZlbmQsIDEwLCBsb2NhbGUpOworCQkJdCA9IHNlYzsKKwkJCWlmIChl
bmQgPT0gKGNoYXIgKilicAorCQkJICAgIHx8IGVycm5vICE9IDAKKwkJCSAg
ICB8fCB0ICE9IHNlYworCQkJICAgIHx8IGxvY2FsdGltZV9yICgmdCwgdG0p
ICE9IHRtKQorCQkJICAgIHJldHVybiBOVUxMOworCQkJZXJybm8gPSBlcnJu
b19zYXZlOworCQkJYnAgPSAoY29uc3QgdW5zaWduZWQgY2hhciAqKWVuZDsK
KwkJCXltZCB8PSBTRVRfWURBWSB8IFNFVF9XREFZIHwgU0VUX1lNRDsKKwkJ
CWJyZWFrOworCQkgICAgfQorCiAJCWNhc2UgJ1UnOgkvKiBUaGUgd2VlayBv
ZiB5ZWFyLCBiZWdpbm5pbmcgb24gc3VuZGF5LiAqLwogCQljYXNlICdXJzoJ
LyogVGhlIHdlZWsgb2YgeWVhciwgYmVnaW5uaW5nIG9uIG1vbmRheS4gKi8K
IAkJCS8qCi0tIAoyLjE0LjAKCg==

--------------2392733ADB0970CF9A761D2D--
