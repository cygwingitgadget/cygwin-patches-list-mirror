Return-Path: <cygwin-patches-return-8755-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14938 invoked by alias); 22 Apr 2017 12:51:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 14918 invoked by uid 89); 22 Apr 2017 12:51:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-23.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE,RP_MATCHES_RCVD autolearn=ham version=3.3.2 spammy=H*MI:online, H*F:D*t-online.de, rw-r, H*M:online
X-HELO: mailout11.t-online.de
Received: from mailout11.t-online.de (HELO mailout11.t-online.de) (194.25.134.85) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 22 Apr 2017 12:51:04 +0000
Received: from fwd28.aul.t-online.de (fwd28.aul.t-online.de [172.20.26.133])	by mailout11.t-online.de (Postfix) with SMTP id 8FC4D426FFB5	for <cygwin-patches@cygwin.com>; Sat, 22 Apr 2017 14:51:03 +0200 (CEST)
Received: from [192.168.2.101] (rwWkj-ZAgh5qes6fBCrotyxCIPTZEhXbhI00mU+bUOU0fwCG1gM8qI-OJVDh-5eZGX@[79.224.126.58]) by fwd28.t-online.de	with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)	esmtp id 1d1uV8-1oRcwq0; Sat, 22 Apr 2017 14:50:58 +0200
From: Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH] Fix stat.st_blocks for files compressed with CompactOS method
To: cygwin-patches@cygwin.com
Message-ID: <81896c1a-a5c8-1f96-c478-5e24f7c1eb56@t-online.de>
Date: Sat, 22 Apr 2017 12:51:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0 SeaMonkey/2.49
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------344EAD49CB8EEB872F260558"
X-IsSubscribed: yes
X-SW-Source: 2017-q2/txt/msg00026.txt.bz2

This is a multi-part message in MIME format.
--------------344EAD49CB8EEB872F260558
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1174

Cygwin 2.8.0 returns stat.st_blocks = 0 if a file is compressed with 
CompactOS method (at least on Win10 1607):

Testcase:

$ ls -ls file
280 -rw-r--r-- 1 ... ... 285363 Apr 22 13:52 file

$ compact /c file
...
$ ls -ls file
56 -rw-r--r-- 1 ... ... 285363 Apr 22 13:52 file

$ compact /u file
...
$ compact /c /exe file
...
$ ls -ls file
0 -rw-r--r-- 1 ... ... 285363 Apr 22 13:52 file

This is because StandardInformation.AllocationSize is always 0 for 
theses files. CompressedFileSize returns the correct value.

This is likely related to the interesting method how these files are 
encoded in the MFT:
The default $DATA stream is a sparse stream with original size but no 
allocated blocks.
An alternate $DATA stream WofCompressedData contains the compressed data.
An additional $REPARSE_POINT possibly marks this file a special and lets 
accesses fail on older Windows releases (and on Linux, most current 
forensic tools, ...).

With the attached patch, stat.st_blocks work as expected:

$ ls -ls file
48 -rw-r--r-- 1 ... ... 285363 Apr 22 13:52 file

The only drawback is an unnecessary FileCompressionInformation query for 
sparse files with no blocks.

Christian


--------------344EAD49CB8EEB872F260558
Content-Type: text/plain; charset=UTF-8;
 name="cygwin-2.8-fix-st_blocks-for-compact-os.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="cygwin-2.8-fix-st_blocks-for-compact-os.patch"
Content-length: 2855

QWx3YXlzIHJldHJpZXZlIEZpbGVDb21wcmVzc2lvbkluZm9ybWF0aW9uIGZv
ciBub24tZW1wdHkKZmlsZXMgaWYgRmlsZVN0YW5kYXJkSW5mb3JtYXRpb24g
cmV0dXJucyAwIGFsbG9jYXRlZCBibG9ja3MuClRoaXMgZml4ZXMgc3RhdC5z
dF9ibG9ja3MgZm9yIGZpbGVzIGNvbXByZXNzZWQgd2l0aCBDb21wYWN0T1Mg
bWV0aG9kLgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEZyYW5rZSA8ZnJh
bmtlQGNvbXB1dGVyLm9yZz4KLS0tCiB3aW5zdXAvY3lnd2luL2ZoYW5kbGVy
X2Rpc2tfZmlsZS5jYyB8IDE3ICsrKysrKysrKysrKy0tLS0tCiAxIGZpbGUg
Y2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2ZoYW5kbGVyX2Rpc2tfZmlsZS5j
YyBiL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXJfZGlza19maWxlLmNjCmluZGV4
IGZjYmUxNWMuLmJmNWY5ODggMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4v
ZmhhbmRsZXJfZGlza19maWxlLmNjCisrKyBiL3dpbnN1cC9jeWd3aW4vZmhh
bmRsZXJfZGlza19maWxlLmNjCkBAIC00NjMsMTggKzQ2MywyNSBAQCBmaGFu
ZGxlcl9iYXNlOjpmc3RhdF9oZWxwZXIgKHN0cnVjdCBzdGF0ICpidWYpCiAK
ICAgYnVmLT5zdF9ibGtzaXplID0gUFJFRkVSUkVEX0lPX0JMS1NJWkU7CiAK
LSAgaWYgKHBmYWktPlN0YW5kYXJkSW5mb3JtYXRpb24uQWxsb2NhdGlvblNp
emUuUXVhZFBhcnQgPj0gMExMKQorICBpZiAoYnVmLT5zdF9zaXplID09IDAK
KyAgICAgICYmIHBmYWktPlN0YW5kYXJkSW5mb3JtYXRpb24uQWxsb2NhdGlv
blNpemUuUXVhZFBhcnQgPT0gMExMKQorICAgIC8qIEZpbGUgaXMgZW1wdHkg
YW5kIG5vIGJsb2NrcyBhcmUgcHJlYWxsb2NhdGVkLiAqLworICAgIGJ1Zi0+
c3RfYmxvY2tzID0gMDsKKyAgZWxzZSBpZiAocGZhaS0+U3RhbmRhcmRJbmZv
cm1hdGlvbi5BbGxvY2F0aW9uU2l6ZS5RdWFkUGFydCA+IDBMTCkKICAgICAv
KiBBIHN1Y2Nlc3NmdWwgTnRRdWVyeUluZm9ybWF0aW9uRmlsZSByZXR1cm5z
IHRoZSBhbGxvY2F0aW9uIHNpemUKLSAgICAgICBjb3JyZWN0bHkgZm9yIGNv
bXByZXNzZWQgYW5kIHNwYXJzZSBmaWxlcyBhcyB3ZWxsLiAqLworICAgICAg
IGNvcnJlY3RseSBmb3IgY29tcHJlc3NlZCBhbmQgc3BhcnNlIGZpbGVzIGFz
IHdlbGwuCisgICAgICAgQWxsb2NhdGlvbiBzaXplIDAgaXMgaWdub3JlZCBo
ZXJlIGJlY2F1c2UgKGF0IGxlYXN0KSBXaW5kb3dzIDEwCisgICAgICAgMTYw
NyBhbHdheXMgcmV0dXJucyAwIGZvciBDb21wYWN0T1MgY29tcHJlc3NlZCBm
aWxlcy4gKi8KICAgICBidWYtPnN0X2Jsb2NrcyA9IChwZmFpLT5TdGFuZGFy
ZEluZm9ybWF0aW9uLkFsbG9jYXRpb25TaXplLlF1YWRQYXJ0CiAJCSAgICAg
ICsgU19CTEtTSVpFIC0gMSkgLyBTX0JMS1NJWkU7Ci0gIGVsc2UgaWYgKDo6
aGFzX2F0dHJpYnV0ZSAoYXR0cmlidXRlcywgRklMRV9BVFRSSUJVVEVfQ09N
UFJFU1NFRAotCQkJCQl8IEZJTEVfQVRUUklCVVRFX1NQQVJTRV9GSUxFKQor
ICBlbHNlIGlmICgocGZhaS0+U3RhbmRhcmRJbmZvcm1hdGlvbi5BbGxvY2F0
aW9uU2l6ZS5RdWFkUGFydCA9PSAwTEwKKwkgICAgfHwgOjpoYXNfYXR0cmli
dXRlIChhdHRyaWJ1dGVzLCBGSUxFX0FUVFJJQlVURV9DT01QUkVTU0VECisJ
CQkJCSAgfCBGSUxFX0FUVFJJQlVURV9TUEFSU0VfRklMRSkpCiAJICAgJiYg
aCAmJiAhaXNfZnNfc3BlY2lhbCAoKQogCSAgICYmICFOdFF1ZXJ5SW5mb3Jt
YXRpb25GaWxlIChoLCAmc3QsIChQVk9JRCkgJmZjaSwgc2l6ZW9mIGZjaSwK
IAkJCQkgICAgICAgRmlsZUNvbXByZXNzaW9uSW5mb3JtYXRpb24pKQogICAg
IC8qIE90aGVyd2lzZSB3ZSByZXF1ZXN0IHRoZSBhY3R1YWwgYW1vdW50IG9m
IGJ5dGVzIGFsbG9jYXRlZCBmb3IKLSAgICAgICBjb21wcmVzc2VkIGFuZCBz
cGFyc2VkIGZpbGVzLiAqLworICAgICAgIGNvbXByZXNzZWQsIHNwYXJzZWQg
YW5kIENvbXBhY3RPUyBmaWxlcy4gKi8KICAgICBidWYtPnN0X2Jsb2NrcyA9
IChmY2kuQ29tcHJlc3NlZEZpbGVTaXplLlF1YWRQYXJ0ICsgU19CTEtTSVpF
IC0gMSkKIAkJICAgICAvIFNfQkxLU0laRTsKICAgZWxzZQo=

--------------344EAD49CB8EEB872F260558--
