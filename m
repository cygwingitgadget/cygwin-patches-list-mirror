Return-Path: <cygwin-patches-return-8830-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4915 invoked by alias); 19 Aug 2017 17:25:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 4739 invoked by uid 89); 19 Aug 2017 17:24:49 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-26.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RP_MATCHES_RCVD,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=68, para
X-HELO: limerock04.mail.cornell.edu
Received: from limerock04.mail.cornell.edu (HELO limerock04.mail.cornell.edu) (128.84.13.244) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 19 Aug 2017 17:24:47 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite4.serverfarm.cornell.edu [10.16.197.9])	by limerock04.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id v7JHOSsZ002910	for <cygwin-patches@cygwin.com>; Sat, 19 Aug 2017 13:24:28 -0400
Received: from [192.168.0.4] (mta-68-175-129-7.twcny.rr.com [68.175.129.7] (may be forged))	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id v7JHOQjQ019182	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)	for <cygwin-patches@cygwin.com>; Sat, 19 Aug 2017 13:24:27 -0400
Subject: Re: renameat2
To: cygwin-patches@cygwin.com
References: <992f81ea-736b-ebe3-2177-153b4d2e1852@cornell.edu> <20170818151525.GA6314@calimero.vinschen.de> <f7e3cc27-6989-54d8-8e3e-c11cdd5dfeca@cornell.edu> <20170819095707.GE6314@calimero.vinschen.de> <68b3c713-3261-e9d7-0865-384d18553744@cornell.edu> <20170819162828.GF6314@calimero.vinschen.de>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <cf284aed-c86a-b9ac-cff1-cef6477b7e32@cornell.edu>
Date: Wed, 23 Aug 2017 18:52:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170819162828.GF6314@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------BC65D5A7D17E5107DA944A3C"
X-PMX-Cornell-Gauge: Gauge=XXXXX
X-PMX-CORNELL-AUTH-RESULTS: dkim-out=none;
X-IsSubscribed: yes
X-SW-Source: 2017-q3/txt/msg00032.txt.bz2

This is a multi-part message in MIME format.
--------------BC65D5A7D17E5107DA944A3C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 89

On 8/19/2017 12:28 PM, Corinna Vinschen wrote:
> Doc changes coming? :)

Attached.

Ken


--------------BC65D5A7D17E5107DA944A3C
Content-Type: text/plain; charset=UTF-8;
 name="0001-Document-renameat2.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Document-renameat2.patch"
Content-length: 2802

RnJvbSAwNzA0NTQxZjFkMjllMGQ5YWEwYWY2ZTU0OWY4Y2EwMTE0YTQ0YTdj
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGti
cm93bkBjb3JuZWxsLmVkdT4KRGF0ZTogU2F0LCAxOSBBdWcgMjAxNyAxMzox
NTowNCAtMDQwMApTdWJqZWN0OiBbUEFUQ0hdIERvY3VtZW50IHJlbmFtZWF0
MgoKLS0tCiB3aW5zdXAvY3lnd2luL3JlbGVhc2UvMi45LjAgfCAyICsrCiB3
aW5zdXAvZG9jL25ldy1mZWF0dXJlcy54bWwgfCA0ICsrKysKIHdpbnN1cC9k
b2MvcG9zaXgueG1sICAgICAgICB8IDQgKysrKwogMyBmaWxlcyBjaGFuZ2Vk
LCAxMCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dp
bi9yZWxlYXNlLzIuOS4wIGIvd2luc3VwL2N5Z3dpbi9yZWxlYXNlLzIuOS4w
CmluZGV4IDQyMWQ2ZjI0Zi4uYWM0YzY0OTQ5IDEwMDY0NAotLS0gYS93aW5z
dXAvY3lnd2luL3JlbGVhc2UvMi45LjAKKysrIGIvd2luc3VwL2N5Z3dpbi9y
ZWxlYXNlLzIuOS4wCkBAIC02LDYgKzYsOCBAQCBXaGF0J3MgbmV3OgogLSBO
ZXcgQVBJczogcHRocmVhZF9tdXRleF90aW1lZHdhaXQsIHB0aHJlYWRfcnds
b2NrX3RpbWVkcmRsb2NrLAogCSAgICBwdGhyZWFkX3J3bG9ja190aW1lZHdy
bG9jay4KIAorLSBOZXcgQVBJOiByZW5hbWVhdDIuCisKIAogV2hhdCBjaGFu
Z2VkOgogLS0tLS0tLS0tLS0tLQpkaWZmIC0tZ2l0IGEvd2luc3VwL2RvYy9u
ZXctZmVhdHVyZXMueG1sIGIvd2luc3VwL2RvYy9uZXctZmVhdHVyZXMueG1s
CmluZGV4IDIzNjczZDFlMC4uMGFhODU3NzMwIDEwMDY0NAotLS0gYS93aW5z
dXAvZG9jL25ldy1mZWF0dXJlcy54bWwKKysrIGIvd2luc3VwL2RvYy9uZXct
ZmVhdHVyZXMueG1sCkBAIC0xNyw2ICsxNywxMCBAQCBOZXcgQVBJczogcHRo
cmVhZF9tdXRleF90aW1lZHdhaXQsIHB0aHJlYWRfcndsb2NrX3RpbWVkcmRs
b2NrLAogcHRocmVhZF9yd2xvY2tfdGltZWR3cmxvY2suCiA8L3BhcmE+PC9s
aXN0aXRlbT4KIAorPGxpc3RpdGVtPjxwYXJhPgorTmV3IEFQSTogcmVuYW1l
YXQyLgorPC9wYXJhPjwvbGlzdGl0ZW0+CisKIDxsaXN0aXRlbT48cGFyYT4K
IEltcHJvdmVkIGltcGxlbWVudGF0aW9uIG9mICZsdDtlbGYuaCZndDsuCiA8
L3BhcmE+PC9saXN0aXRlbT4KZGlmZiAtLWdpdCBhL3dpbnN1cC9kb2MvcG9z
aXgueG1sIGIvd2luc3VwL2RvYy9wb3NpeC54bWwKaW5kZXggYTJmZmZlZWJm
Li42ZTk2MjcyYjcgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9kb2MvcG9zaXgueG1s
CisrKyBiL3dpbnN1cC9kb2MvcG9zaXgueG1sCkBAIC0xMzU2LDYgKzEzNTYs
NyBAQCBhbHNvIElFRUUgU3RkIDEwMDMuMS0yMDA4IChQT1NJWC4xLTIwMDgp
LjwvcGFyYT4KICAgICBwdHNuYW1lX3IKICAgICBwdXR3Y191bmxvY2tlZAog
ICAgIHB1dHdjaGFyX3VubG9ja2VkCisgICAgcmVuYW1lYXQyCQkJKHNlZSBj
aGFwdGVyICJJbXBsZW1lbnRhdGlvbiBOb3RlcyIpCiAgICAgcXNvcnRfcgkJ
CShzZWUgY2hhcHRlciAiSW1wbGVtZW50YXRpb24gTm90ZXMiKQogICAgIHF1
b3RhY3RsCiAgICAgcmF3bWVtY2hyCkBAIC0xNjcxLDYgKzE2NzIsOSBAQCBn
cm91cCBxdW90YXMsIG5vIGlub2RlIHF1b3Rhcywgbm8gdGltZSBjb25zdHJh
aW50cy48L3BhcmE+CiA8cGFyYT48ZnVuY3Rpb24+cXNvcnRfcjwvZnVuY3Rp
b24+IGlzIGF2YWlsYWJsZSBpbiBib3RoIEJTRCBhbmQgR05VIGZsYXZvcnMs
CiBkZXBlbmRpbmcgb24gd2hldGhlciBfQlNEX1NPVVJDRSBvciBfR05VX1NP
VVJDRSBpcyBkZWZpbmVkIHdoZW4gY29tcGlsaW5nLjwvcGFyYT4KIAorPHBh
cmE+VGhlIExpbnV4LXNwZWNpZmljIGZ1bmN0aW9uIDxmdW5jdGlvbj5yZW5h
bWVhdDI8L2Z1bmN0aW9uPiBvbmx5CitzdXBwb3J0cyB0aGUgUkVOQU1FX05P
UkVQTEFDRSBmbGFnLjwvcGFyYT4KKwogPHBhcmE+PGZ1bmN0aW9uPmJhc2Vu
YW1lPC9mdW5jdGlvbj4gaXMgYXZhaWxhYmxlIGluIGJvdGggUE9TSVggYW5k
IEdOVSBmbGF2b3JzLAogZGVwZW5kaW5nIG9uIHdoZXRoZXIgbGliZ2VuLmgg
aXMgaW5jbHVkZWQgb3Igbm90LjwvcGFyYT4KIAotLSAKMi4xNC4xCgo=

--------------BC65D5A7D17E5107DA944A3C--
