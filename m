Return-Path: <cygwin-patches-return-8642-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8319 invoked by alias); 20 Oct 2016 19:54:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 8306 invoked by uid 89); 20 Oct 2016 19:54:47 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.2 required=5.0 tests=AWL,BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=D*cornell.edu, cygdrive, U*kbrown, kbrowncornelledu
X-HELO: limerock02.mail.cornell.edu
Received: from limerock02.mail.cornell.edu (HELO limerock02.mail.cornell.edu) (128.84.13.242) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 20 Oct 2016 19:54:36 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite3.serverfarm.cornell.edu [10.16.197.8])	by limerock02.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id u9KJsYlH019890	for <cygwin-patches@cygwin.com>; Thu, 20 Oct 2016 15:54:34 -0400
Received: from [192.168.1.9] (mta-68-175-148-36.twcny.rr.com [68.175.148.36] (may be forged))	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id u9KJsXTK006437	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)	for <cygwin-patches@cygwin.com>; Thu, 20 Oct 2016 15:54:34 -0400
To: cygwin-patches@cygwin.com
From: Ken Brown <kbrown@cornell.edu>
Subject: Add _PC_CASE_INSENSITIVE flag to pathconf
Message-ID: <82692078-877f-0acf-01f7-17c5a886d64e@cornell.edu>
Date: Thu, 20 Oct 2016 19:54:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------6EBC34F23ED615E2A25F295E"
X-PMX-Cornell-Gauge: Gauge=XXXXX
X-PMX-CORNELL-AUTH-RESULTS: dkim-out=none;
X-IsSubscribed: yes
X-SW-Source: 2016-q4/txt/msg00000.txt.bz2

This is a multi-part message in MIME format.
--------------6EBC34F23ED615E2A25F295E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1002

Patch attached.

I tested it by running getconf.exe, and also as follows:

$ cat case_sens_test.c
#include <unistd.h>
#include <stdio.h>

void
test (const char *path)
{
   int ret = pathconf (path, _PC_CASE_INSENSITIVE);
   printf ("pathconf (\"%s\", _PC_CASE_INSENSITIVE) returns %d\n", path, 
ret);
   if (ret == -1)
     perror ("  pathconf");
}

int
main ()
{
   test ("/tmp");
   test ("/tmp/a");
   test ("/cygdrive/c/cygwin");
   test ("/");
   test (".");
}

$ gcc case_sens_test.c

$ ./a
pathconf ("/tmp", _PC_CASE_INSENSITIVE) returns 0
pathconf ("/tmp/a", _PC_CASE_INSENSITIVE) returns -1
   pathconf: No such file or directory
pathconf ("/cygdrive/c/cygwin", _PC_CASE_INSENSITIVE) returns 1
pathconf ("/", _PC_CASE_INSENSITIVE) returns 0
pathconf (".", _PC_CASE_INSENSITIVE) returns 0

This test was done, obviously, on a system with the obcaseinsensitive 
registry key set to 0, and with /tmp/a non-existent.  I also tested with 
the registry key set to 1, with the expected results.

Ken

--------------6EBC34F23ED615E2A25F295E
Content-Type: text/plain; charset=UTF-8;
 name="0001-Add-_PC_CASE_INSENSITIVE-to-f-pathconf.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Add-_PC_CASE_INSENSITIVE-to-f-pathconf.patch"
Content-length: 5450

RnJvbSAwNGI1MDdlZGJmYmJhYWRlNmVmMTliYTkzMDJhYzlhNzU4ODg2OTk1
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGti
cm93bkBjb3JuZWxsLmVkdT4KRGF0ZTogVGh1LCAyMCBPY3QgMjAxNiAxNToz
NTo1NCAtMDQwMApTdWJqZWN0OiBbUEFUQ0hdIEFkZCBfUENfQ0FTRV9JTlNF
TlNJVElWRSB0byBbZl1wYXRoY29uZgoKVXBkYXRlIHRoZSBnZXRjb25mIHV0
aWxpdHkgdG8gc3VwcG9ydCB0aGUgbmV3IGZsYWcgYXMgd2VsbCBhcwpfUENf
UE9TSVhfUEVSTUlTU0lPTlMgYW5kIF9QQ19QT1NJWF9TRUNVUklUWS4gIFRo
ZXNlIHdlcmUgcHJldmlvdXNseQp1bnN1cHBvcnRlZCwgcHJvYmFibHkgYXMg
YW4gb3ZlcnNpZ2h0LgotLS0KIG5ld2xpYi9saWJjL2luY2x1ZGUvc3lzL3Vu
aXN0ZC5oICAgICAgIHwgMSArCiB3aW5zdXAvY3lnd2luL2ZoYW5kbGVyLmNj
ICAgICAgICAgICAgICB8IDIgKysKIHdpbnN1cC9jeWd3aW4vaW5jbHVkZS9j
eWd3aW4vdmVyc2lvbi5oIHwgMyArKy0KIHdpbnN1cC9jeWd3aW4vcmVsZWFz
ZS8yLjYuMSAgICAgICAgICAgIHwgMiArKwogd2luc3VwL3V0aWxzL2dldGNv
bmYuYyAgICAgICAgICAgICAgICAgfCAzICsrKwogNSBmaWxlcyBjaGFuZ2Vk
LCAxMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0
IGEvbmV3bGliL2xpYmMvaW5jbHVkZS9zeXMvdW5pc3RkLmggYi9uZXdsaWIv
bGliYy9pbmNsdWRlL3N5cy91bmlzdGQuaAppbmRleCAwNWI0ZjlkLi4xNDMx
NDdkIDEwMDY0NAotLS0gYS9uZXdsaWIvbGliYy9pbmNsdWRlL3N5cy91bmlz
dGQuaAorKysgYi9uZXdsaWIvbGliYy9pbmNsdWRlL3N5cy91bmlzdGQuaApA
QCAtNDkwLDYgKzQ5MCw3IEBAIGludAlfRVhGVU4odW5saW5rYXQsIChpbnQs
IGNvbnN0IGNoYXIgKiwgaW50KSk7CiAjZGVmaW5lIF9QQ19QT1NJWF9QRVJN
SVNTSU9OUyAgICAgICAgICAgIDkwCiAvKiBBc2sgZm9yIGZ1bGwgUE9TSVgg
cGVybWlzc2lvbiBzdXBwb3J0IGluY2x1ZGluZyB1aWQvZ2lkIHNldHRpbmdz
LiAqLwogI2RlZmluZSBfUENfUE9TSVhfU0VDVVJJVFkgICAgICAgICAgICAg
ICA5MQorI2RlZmluZSBfUENfQ0FTRV9JTlNFTlNJVElWRSAgICAgICAgICAg
ICA5MgogI2VuZGlmCiAKIC8qCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2lu
L2ZoYW5kbGVyLmNjIGIvd2luc3VwL2N5Z3dpbi9maGFuZGxlci5jYwppbmRl
eCBkNzdjY2QzLi45YWI1MmFkIDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2lu
L2ZoYW5kbGVyLmNjCisrKyBiL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXIuY2MK
QEAgLTE4OTEsNiArMTg5MSw4IEBAIGZoYW5kbGVyX2Jhc2U6OmZwYXRoY29u
ZiAoaW50IHYpCiAJcmV0dXJuIHBjLmhhc19hY2xzICgpIHx8IHBjLmZzX2lz
X25mcyAoKTsKICAgICAgIHNldF9lcnJubyAoRUlOVkFMKTsKICAgICAgIGJy
ZWFrOworICAgIGNhc2UgX1BDX0NBU0VfSU5TRU5TSVRJVkU6CisgICAgICBy
ZXR1cm4gISFwYy5vYmpjYXNlaW5zZW5zaXRpdmUgKCk7CiAgICAgZGVmYXVs
dDoKICAgICAgIHNldF9lcnJubyAoRUlOVkFMKTsKICAgICAgIGJyZWFrOwpk
aWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9pbmNsdWRlL2N5Z3dpbi92ZXJz
aW9uLmggYi93aW5zdXAvY3lnd2luL2luY2x1ZGUvY3lnd2luL3ZlcnNpb24u
aAppbmRleCAxYzE0MDJjLi42YmE2MDJlIDEwMDY0NAotLS0gYS93aW5zdXAv
Y3lnd2luL2luY2x1ZGUvY3lnd2luL3ZlcnNpb24uaAorKysgYi93aW5zdXAv
Y3lnd2luL2luY2x1ZGUvY3lnd2luL3ZlcnNpb24uaApAQCAtNDY5LDEyICs0
NjksMTMgQEAgZGV0YWlscy4gKi8KICAgMzAyOiBFeHBvcnQgbmxfbGFuZ2lu
Zm9fbC4KICAgMzAzOiBFeHBvcnQgcHRocmVhZF9nZXRuYW1lX25wLCBwdGhy
ZWFkX3NldG5hbWVfbnAuCiAgIDMwNDogRXhwb3J0IHN0cmVycm9yX2wsIHN0
cnB0aW1lX2wsIHdjc2Z0aW1lX2wuCisgIDMwNTogW2ZdcGF0aGNvbmYgZmxh
ZyBfUENfQ0FTRV9JTlNFTlNJVElWRSBhZGRlZC4KIAogICBOb3RlIHRoYXQg
d2UgZm9yZ290IHRvIGJ1bXAgdGhlIGFwaSBmb3IgdWFsYXJtLCBzdHJ0b2xs
LCBzdHJ0b3VsbCwKICAgc2lnYWx0c3RhY2ssIHNldGhvc3RuYW1lLiAqLwog
CiAjZGVmaW5lIENZR1dJTl9WRVJTSU9OX0FQSV9NQUpPUiAwCi0jZGVmaW5l
IENZR1dJTl9WRVJTSU9OX0FQSV9NSU5PUiAzMDQKKyNkZWZpbmUgQ1lHV0lO
X1ZFUlNJT05fQVBJX01JTk9SIDMwNQogCiAvKiBUaGVyZSBpcyBhbHNvIGEg
Y29tcGF0aWJpdHkgdmVyc2lvbiBudW1iZXIgYXNzb2NpYXRlZCB3aXRoIHRo
ZSBzaGFyZWQgbWVtb3J5CiAgICByZWdpb25zLiAgSXQgaXMgaW5jcmVtZW50
ZWQgd2hlbiBpbmNvbXBhdGlibGUgY2hhbmdlcyBhcmUgbWFkZSB0byB0aGUg
c2hhcmVkCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL3JlbGVhc2UvMi42
LjEgYi93aW5zdXAvY3lnd2luL3JlbGVhc2UvMi42LjEKaW5kZXggNjFjZTJk
ZS4uN2NlZDNjNCAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9yZWxlYXNl
LzIuNi4xCisrKyBiL3dpbnN1cC9jeWd3aW4vcmVsZWFzZS8yLjYuMQpAQCAt
MSw2ICsxLDggQEAKIFdoYXQncyBuZXc6CiAtLS0tLS0tLS0tLQogCistIEFk
ZCBfUENfQ0FTRV9JTlNFTlNJVElWRSBmbGFnIHRvIFtmXXBhdGhjb25mKDMp
LgorCiAKIFdoYXQgY2hhbmdlZDoKIC0tLS0tLS0tLS0tLS0KZGlmZiAtLWdp
dCBhL3dpbnN1cC91dGlscy9nZXRjb25mLmMgYi93aW5zdXAvdXRpbHMvZ2V0
Y29uZi5jCmluZGV4IDg1MzkyMzMuLmU2YjMxOWUgMTAwNjQ0Ci0tLSBhL3dp
bnN1cC91dGlscy9nZXRjb25mLmMKKysrIGIvd2luc3VwL3V0aWxzL2dldGNv
bmYuYwpAQCAtMTg2LDYgKzE4Niw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
Y29uZl92YXJpYWJsZSBjb25mX3RhYmxlW10gPQogICB7ICJQT1NJWDJfUkVf
RFVQX01BWCIsCQlDT05TVEFOVCwJX1BPU0lYMl9SRV9EVVBfTUFYCX0sCiAK
ICAgLyogVmFyaWFibGVzIGZyb20gZnBhdGhjb25mKCkgKi8KKyAgeyAiQ0FT
RV9JTlNFTlNJVElWRSIsCQkJUEFUSENPTkYsCV9QQ19DQVNFX0lOU0VOU0lU
SVZFCX0sCiAgIHsgIkZJTEVTSVpFQklUUyIsCQkJUEFUSENPTkYsCV9QQ19G
SUxFU0laRUJJVFMJfSwKICAgeyAiTElOS19NQVgiLAkJCQlQQVRIQ09ORiwJ
X1BDX0xJTktfTUFYCQl9LAogICB7ICJNQVhfQ0FOT04iLAkJCVBBVEhDT05G
LAlfUENfTUFYX0NBTk9OCQl9LApAQCAtMTk1LDEwICsxOTYsMTIgQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBjb25mX3ZhcmlhYmxlIGNvbmZfdGFibGVbXSA9
CiAgIHsgIlBJUEVfQlVGIiwJCQkJUEFUSENPTkYsCV9QQ19QSVBFX0JVRgkJ
fSwKICAgeyAiUE9TSVgyX1NZTUxJTktTIiwJCQlQQVRIQ09ORiwJX1BDXzJf
U1lNTElOS1MJCX0sCiAgIHsgIlBPU0lYX0FMTE9DX1NJWkVfTUlOIiwJCVBB
VEhDT05GLAlfUENfQUxMT0NfU0laRV9NSU4JfSwKKyAgeyAiUE9TSVhfUEVS
TUlTU0lPTlMiLAkJUEFUSENPTkYsCV9QQ19QT1NJWF9QRVJNSVNTSU9OUwl9
LAogICB7ICJQT1NJWF9SRUNfSU5DUl9YRkVSX1NJWkUiLAkJUEFUSENPTkYs
CV9QQ19SRUNfSU5DUl9YRkVSX1NJWkUJfSwKICAgeyAiUE9TSVhfUkVDX01B
WF9YRkVSX1NJWkUiLAkJUEFUSENPTkYsCV9QQ19SRUNfTUFYX1hGRVJfU0la
RQl9LAogICB7ICJQT1NJWF9SRUNfTUlOX1hGRVJfU0laRSIsCQlQQVRIQ09O
RiwJX1BDX1JFQ19NSU5fWEZFUl9TSVpFCX0sCiAgIHsgIlBPU0lYX1JFQ19Y
RkVSX0FMSUdOIiwJCVBBVEhDT05GLAlfUENfUkVDX1hGRVJfQUxJR04JfSwK
KyAgeyAiUE9TSVhfU0VDVVJJVFkiLAkJCVBBVEhDT05GLAlfUENfUE9TSVhf
U0VDVVJJVFkJfSwKICAgeyAiU1lNTElOS19NQVgiLAkJCVBBVEhDT05GLAlf
UENfU1lNTElOS19NQVgJCX0sCiAgIHsgIl9QT1NJWF9DSE9XTl9SRVNUUklD
VEVEIiwJCVBBVEhDT05GLAlfUENfQ0hPV05fUkVTVFJJQ1RFRAl9LAogICB7
ICJfUE9TSVhfTk9fVFJVTkMiLAkJCVBBVEhDT05GLAlfUENfTk9fVFJVTkMJ
CX0sCi0tIAoyLjguMwoK

--------------6EBC34F23ED615E2A25F295E--
