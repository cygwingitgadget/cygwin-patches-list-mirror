Return-Path: <cygwin-patches-return-8616-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 40626 invoked by alias); 23 Aug 2016 17:30:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 40607 invoked by uid 89); 23 Aug 2016 17:30:51 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.2 required=5.0 tests=AWL,BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=promised, D*cornell.edu, U*kbrown, kbrowncornelledu
X-HELO: limerock04.mail.cornell.edu
Received: from limerock04.mail.cornell.edu (HELO limerock04.mail.cornell.edu) (128.84.13.244) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 23 Aug 2016 17:30:41 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite3.serverfarm.cornell.edu [10.16.197.8])	by limerock04.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id u7NHUcuh025729	for <cygwin-patches@cygwin.com>; Tue, 23 Aug 2016 13:30:39 -0400
Received: from [192.168.1.9] (mta-68-175-148-36.twcny.rr.com [68.175.148.36] (may be forged))	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id u7NHUbYw024867	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)	for <cygwin-patches@cygwin.com>; Tue, 23 Aug 2016 13:30:38 -0400
To: cygwin-patches@cygwin.com
From: Ken Brown <kbrown@cornell.edu>
Subject: Documentation patch: Clarify Cygwin's support for Win32 paths
Message-ID: <c49add49-d7e4-fa04-74f3-596919303ee0@cornell.edu>
Date: Tue, 23 Aug 2016 17:30:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------67CB1A1CAEBB43178C9567B8"
X-PMX-Cornell-Gauge: Gauge=XXXXX
X-PMX-CORNELL-AUTH-RESULTS: dkim-out=none;
X-IsSubscribed: yes
X-SW-Source: 2016-q3/txt/msg00024.txt.bz2

This is a multi-part message in MIME format.
--------------67CB1A1CAEBB43178C9567B8
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 106

The attached patch is the one promised in

   https://www.cygwin.com/ml/cygwin/2016-08/msg00431.html

Ken

--------------67CB1A1CAEBB43178C9567B8
Content-Type: text/plain; charset=UTF-8;
 name="0001-Clarify-Cygwin-s-support-for-Win32-paths.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Clarify-Cygwin-s-support-for-Win32-paths.patch"
Content-length: 3189

RnJvbSBlNDZkODhkNDE0MTczN2Y3Zjc1ZWMxZmI2MGI2ZTQwNGY1OThhOTY1
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGti
cm93bkBjb3JuZWxsLmVkdT4KRGF0ZTogVHVlLCAyMyBBdWcgMjAxNiAxMzoy
NDo0OSAtMDQwMApTdWJqZWN0OiBbUEFUQ0hdIENsYXJpZnkgQ3lnd2luJ3Mg
c3VwcG9ydCBmb3IgV2luMzIgcGF0aHMKClNlZSBodHRwczovL3d3dy5jeWd3
aW4uY29tL21sL2N5Z3dpbi8yMDE2LTA4L21zZzAwNDMxLmh0bWwuCi0tLQog
d2luc3VwL2RvYy9wYXRobmFtZXMueG1sIHwgMTQgKysrKysrKysrLS0tLS0K
IDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvd2luc3VwL2RvYy9wYXRobmFtZXMueG1sIGIv
d2luc3VwL2RvYy9wYXRobmFtZXMueG1sCmluZGV4IDNjMGJkYzEuLjZmOWZl
ZmEgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9kb2MvcGF0aG5hbWVzLnhtbAorKysg
Yi93aW5zdXAvZG9jL3BhdGhuYW1lcy54bWwKQEAgLTYsMTUgKzYsMTggQEAK
IAogPHNlY3QyIGlkPSJwYXRobmFtZXMtaW50cm8iPjx0aXRsZT5JbnRyb2R1
Y3Rpb248L3RpdGxlPgogCi08cGFyYT5DeWd3aW4gc3VwcG9ydHMgYm90aCBQ
T1NJWC0gYW5kIFdpbjMyLXN0eWxlIHBhdGhzLiAgRGlyZWN0b3J5Cis8cGFy
YT5UaGUgQ3lnd2luIERMTCBzdXBwb3J0cyBib3RoIFBPU0lYLSBhbmQgV2lu
MzItc3R5bGUgcGF0aHMuICBEaXJlY3RvcnkKIGRlbGltaXRlcnMgbWF5IGJl
IGVpdGhlciBmb3J3YXJkIHNsYXNoZXMgb3IgYmFja3NsYXNoZXMuICBQYXRo
cyB1c2luZwogYmFja3NsYXNoZXMgb3Igc3RhcnRpbmcgd2l0aCBhIGRyaXZl
IGxldHRlciBhcmUgYWx3YXlzIGhhbmRsZWQgYXMKIFdpbjMyIHBhdGhzLiAg
UE9TSVggcGF0aHMgbXVzdCBvbmx5IHVzZSBmb3J3YXJkIHNsYXNoZXMgYXMg
ZGVsaW1pdGVyLAogb3RoZXJ3aXNlIHRoZXkgYXJlIHRyZWF0ZWQgYXMgV2lu
MzIgcGF0aHMgYW5kIGZpbGUgYWNjZXNzIG1pZ2h0IGZhaWwKIGluIHN1cnBy
aXNpbmcgd2F5cy48L3BhcmE+CiAKLTxub3RlPjxwYXJhPlRoZSB1c2FnZSBv
ZiBXaW4zMiBwYXRocywgdGhvdWdoIHBvc3NpYmxlLCBpcyBkZXByZWNhdGVk
LAotc2luY2UgaXQgY2lyY3VtdmVudHMgaW1wb3J0YW50IGludGVybmFsIHBh
dGggaGFuZGxpbmcgbWVjaGFuaXNtcy4gCis8bm90ZT48cGFyYT5BbHRob3Vn
aCB0aGUgQ3lnd2luIERMTCBzdXBwb3J0cyBXaW4zMiBwYXRocywgbm90IGFs
bAorQ3lnd2luIGFwcGxpY2F0aW9ucyBzdXBwb3J0IHRoZW0uICBNb3Jlb3Zl
ciwgdGhlIHVzYWdlIG9mIFdpbjMyIHBhdGhzCitjaXJjdW12ZW50cyBpbXBv
cnRhbnQgaW50ZXJuYWwgcGF0aCBoYW5kbGluZyBtZWNoYW5pc21zLiAgVGhp
cyB1c2FnZQoraXMgdGhlcmVmb3JlIHN0cm9uZ2x5IGRlcHJlY2F0ZWQgYW5k
IG1heSBiZSByZW1vdmVkIGluIGEgZnV0dXJlCityZWxlYXNlIG9mIEN5Z3dp
bi4KIFNlZSA8eHJlZiBsaW5rZW5kPSJwYXRobmFtZXMtd2luMzIiPjwveHJl
Zj4gYW5kCiA8eHJlZiBsaW5rZW5kPSJwYXRobmFtZXMtd2luMzItYXBpIj48
L3hyZWY+IGZvciBtb3JlIGluZm9ybWF0aW9uLgogPC9wYXJhPjwvbm90ZT4K
QEAgLTQ1MSwxMSArNDU0LDEyIEBAIGZpbGVzeXN0ZW0gYm9yZGVycyBieSBj
b21tYW5kcyBsaWtlIDxjb21tYW5kPmZpbmQgLXhkZXY8L2NvbW1hbmQ+Ljwv
cGFyYT4KIAogPHNlY3QyIGlkPSJwYXRobmFtZXMtd2luMzIiPjx0aXRsZT5V
c2luZyBuYXRpdmUgV2luMzIgcGF0aHM8L3RpdGxlPgogCi08cGFyYT5Vc2lu
ZyBuYXRpdmUgV2luMzIgcGF0aHMgaW4gQ3lnd2luLCB3aGlsZSBwb3NzaWJs
ZSwgaXMgZ2VuZXJhbGx5Cis8cGFyYT5Vc2luZyBuYXRpdmUgV2luMzIgcGF0
aHMgaW4gQ3lnd2luLCB3aGlsZSBvZnRlbiBwb3NzaWJsZSwgaXMgZ2VuZXJh
bGx5CiBpbmFkdmlzYWJsZS4gIFRob3NlIHBhdGhzIGNpcmN1bXZlbnQgYWxs
IGludGVybmFsIGludGVncml0eSBjaGVja2luZyBhbmQKIGJ5cGFzcyB0aGUg
aW5mb3JtYXRpb24gZ2l2ZW4gaW4gdGhlIEN5Z3dpbiBtb3VudCB0YWJsZS48
L3BhcmE+CiAKLTxwYXJhPlRoZSBmb2xsb3dpbmcgcGF0aHMgYXJlIHRyZWF0
ZWQgYXMgbmF0aXZlIFdpbjMyIHBhdGhzIGluIEN5Z3dpbjo8L3BhcmE+Cis8
cGFyYT5UaGUgZm9sbG93aW5nIHBhdGhzIGFyZSB0cmVhdGVkIGFzIG5hdGl2
ZSBXaW4zMiBwYXRocyBieSB0aGUKK0N5Z3dpbiBETEwgKGJ1dCBub3QgbmVj
ZXNzYXJpbHkgYnkgQ3lnd2luIGFwcGxpY2F0aW9ucyk6PC9wYXJhPgogCiA8
aXRlbWl6ZWRsaXN0IHNwYWNpbmc9ImNvbXBhY3QiPgogICA8bGlzdGl0ZW0+
Ci0tIAoyLjguMwoK

--------------67CB1A1CAEBB43178C9567B8--
