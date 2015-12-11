Return-Path: <cygwin-patches-return-8283-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 125288 invoked by alias); 11 Dec 2015 22:13:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 125273 invoked by uid 89); 11 Dec 2015 22:13:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,SPF_HELO_PASS,SPF_PASS,T_RP_MATCHES_RCVD autolearn=ham version=3.3.2
X-HELO: limerock02.mail.cornell.edu
Received: from limerock02.mail.cornell.edu (HELO limerock02.mail.cornell.edu) (128.84.13.242) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 11 Dec 2015 22:13:30 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite4.serverfarm.cornell.edu [10.16.197.9])	by limerock02.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id tBBMDSCH026385	for <cygwin-patches@cygwin.com>; Fri, 11 Dec 2015 17:13:28 -0500
Received: from [192.168.1.8] (cpe-67-249-176-138.twcny.res.rr.com [67.249.176.138])	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id tBBMDRQR004856	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)	for <cygwin-patches@cygwin.com>; Fri, 11 Dec 2015 17:13:28 -0500
To: cygwin-patches@cygwin.com
From: Ken Brown <kbrown@cornell.edu>
Subject: Trivial fix to last change
Message-ID: <566B4AB2.1000905@cornell.edu>
Date: Fri, 11 Dec 2015 22:13:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101 Thunderbird/38.4.0
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080709060304070109030607"
X-IsSubscribed: yes
X-SW-Source: 2015-q4/txt/msg00036.txt.bz2

This is a multi-part message in MIME format.
--------------080709060304070109030607
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 110

cygwin1.dll doesn't build on x86 after the last commit (eed35ef).  The 
trivial patch attached fixes it.

Ken

--------------080709060304070109030607
Content-Type: text/plain; charset=UTF-8;
 name="0001-Fix-regparm-attribute-of-fhandler_base-fstat_helper.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Fix-regparm-attribute-of-fhandler_base-fstat_helper.pat";
 filename*1="ch"
Content-length: 1814

RnJvbSAxY2Q2MWM1NDk5NGIyYmE2YzZlYzFkMWY4ZjEyNDlmNWY4ZmQ0YWYz
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGti
cm93bkBjb3JuZWxsLmVkdT4KRGF0ZTogRnJpLCAxMSBEZWMgMjAxNSAxNzow
ODoyOCAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIEZpeCByZWdwYXJtIGF0dHJp
YnV0ZSBvZiBmaGFuZGxlcl9iYXNlOjpmc3RhdF9oZWxwZXIKCiogd2luc3Vw
L2N5Z3dpbi9maGFuZGxlcl9kaXNrX2ZpbGUuY2MgKGZoYW5kbGVyX2Jhc2U6
OmZzdGF0X2hlbHBlcik6CkFsaWduIHJlZ3Bhcm0gYXR0cmlidXRlIHRvIGRl
Y2xhcmF0aW9uIGluIGZoYW5kbGVyLmguCi0tLQogd2luc3VwL2N5Z3dpbi9D
aGFuZ2VMb2cgICAgICAgICAgICAgfCA1ICsrKysrCiB3aW5zdXAvY3lnd2lu
L2ZoYW5kbGVyX2Rpc2tfZmlsZS5jYyB8IDIgKy0KIDIgZmlsZXMgY2hhbmdl
ZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0
IGEvd2luc3VwL2N5Z3dpbi9DaGFuZ2VMb2cgYi93aW5zdXAvY3lnd2luL0No
YW5nZUxvZwppbmRleCAzYzk4MDRiLi43MDc5YmFhIDEwMDY0NAotLS0gYS93
aW5zdXAvY3lnd2luL0NoYW5nZUxvZworKysgYi93aW5zdXAvY3lnd2luL0No
YW5nZUxvZwpAQCAtMSwzICsxLDggQEAKKzIwMTUtMTItMTEgIEtlbiBCcm93
biAgPGticm93bkBjb3JuZWxsLmVkdT4KKworCSogZmhhbmRsZXJfZGlza19m
aWxlLmNjIChmaGFuZGxlcl9iYXNlOjpmc3RhdF9oZWxwZXIpOiBBbGlnbgor
CXJlZ3Bhcm0gYXR0cmlidXRlIHRvIGRlY2xhcmF0aW9uIGluIGZoYW5kbGVy
LmguCisKIDIwMTUtMTItMTAgIENvcmlubmEgVmluc2NoZW4gIDxjb3Jpbm5h
QHZpbnNjaGVuLmRlPgogCiAJKiBwYXRoLmggKGNsYXNzIHBhdGhfY29udl9o
YW5kbGUpOiBVc2UgRklMRV9BTExfSU5GT1JNQVRJT04gaW5zdGVhZCBvZgpk
aWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9maGFuZGxlcl9kaXNrX2ZpbGUu
Y2MgYi93aW5zdXAvY3lnd2luL2ZoYW5kbGVyX2Rpc2tfZmlsZS5jYwppbmRl
eCBmZTlkZDAzLi4xZGQxYjhjIDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2lu
L2ZoYW5kbGVyX2Rpc2tfZmlsZS5jYworKysgYi93aW5zdXAvY3lnd2luL2Zo
YW5kbGVyX2Rpc2tfZmlsZS5jYwpAQCAtNDI4LDcgKzQyOCw3IEBAIGZoYW5k
bGVyX2Jhc2U6OmZzdGF0X2ZzIChzdHJ1Y3Qgc3RhdCAqYnVmKQogICByZXR1
cm4gcmVzOwogfQogCi1pbnQgX19yZWczCitpbnQgX19yZWcyCiBmaGFuZGxl
cl9iYXNlOjpmc3RhdF9oZWxwZXIgKHN0cnVjdCBzdGF0ICpidWYpCiB7CiAg
IElPX1NUQVRVU19CTE9DSyBzdDsKLS0gCjIuNi4yCgo=

--------------080709060304070109030607--
