Return-Path: <cygwin-patches-return-8569-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 44982 invoked by alias); 5 Jun 2016 17:15:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 44972 invoked by uid 89); 5 Jun 2016 17:15:16 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.8 required=5.0 tests=AWL,BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=D*cornell.edu, U*kbrown, kbrowncornelledu, sk:kbrown
X-HELO: limerock01.mail.cornell.edu
Received: from limerock01.mail.cornell.edu (HELO limerock01.mail.cornell.edu) (128.84.13.241) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 05 Jun 2016 17:15:06 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite4.serverfarm.cornell.edu [10.16.197.9])	by limerock01.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id u55HF3gM025531	for <cygwin-patches@cygwin.com>; Sun, 5 Jun 2016 13:15:04 -0400
Received: from [192.168.1.3] (mta-68-175-148-36.twcny.rr.com [68.175.148.36] (may be forged))	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id u55HF2tt001941	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)	for <cygwin-patches@cygwin.com>; Sun, 5 Jun 2016 13:15:03 -0400
To: cygwin-patches <cygwin-patches@cygwin.com>
From: Ken Brown <kbrown@cornell.edu>
Subject: Fix 'make distclean'
Message-ID: <393c4fcd-4eeb-84cf-e330-e4c1ecfc3a9d@cornell.edu>
Date: Sun, 05 Jun 2016 17:15:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------EE9D5C5E5A9E25E14B1A88D9"
X-PMX-Cornell-Gauge: Gauge=XXXXX
X-IsSubscribed: yes
X-SW-Source: 2016-q2/txt/msg00044.txt.bz2

This is a multi-part message in MIME format.
--------------EE9D5C5E5A9E25E14B1A88D9
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 360

Sometimes when a build of Cygwin fails, there will be a message 
suggesting running 'make distclean'.  But this fails to clean the 
winsup/cygwin subdirectory, and the build still fails.

On the other hand, 'make clean' in winsup/cygwin removes two source 
files, which have to be restored before one can rebuild.

The attached patch fixes both problems.

Ken

--------------EE9D5C5E5A9E25E14B1A88D9
Content-Type: text/plain; charset=UTF-8;
 name="0001-Allow-make-distclean-to-clean-winsup-cygwin.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Allow-make-distclean-to-clean-winsup-cygwin.patch"
Content-length: 2831

RnJvbSA3MWMxNmVjYzMxMjZhNDFhZTQxY2JmMzU0NDI4YzY0MjgyOTUyOTUx
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGti
cm93bkBjb3JuZWxsLmVkdT4KRGF0ZTogU3VuLCA1IEp1biAyMDE2IDEyOjU4
OjIyIC0wNDAwClN1YmplY3Q6IFtQQVRDSF0gQWxsb3cgJ21ha2UgZGlzdGNs
ZWFuJyB0byBjbGVhbiB3aW5zdXAvY3lnd2luCk1JTUUtVmVyc2lvbjogMS4w
CkNvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOApDb250
ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0CgpCdXQgZG9u4oCZdCBsZXQg
aXQgcmVtb3ZlIHNvdXJjZSBmaWxlcy4KLS0tCiB3aW5zdXAvTWFrZWZpbGUu
aW4gICAgICAgIHwgNCArKy0tCiB3aW5zdXAvY3lnd2luL01ha2VmaWxlLmlu
IHwgNyArKysrLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygr
KSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvTWFrZWZp
bGUuaW4gYi93aW5zdXAvTWFrZWZpbGUuaW4KaW5kZXggMWZkZjkzYS4uOWVj
YTgwNiAxMDA2NDQKLS0tIGEvd2luc3VwL01ha2VmaWxlLmluCisrKyBiL3dp
bnN1cC9NYWtlZmlsZS5pbgpAQCAtNDgsNyArNDgsNyBAQCBDTEVBTl9TVUJE
SVJTPSR7cGF0c3Vic3QgJSxjbGVhbl8lLCQoU1VCRElSUyl9CiAKIElOU1RB
TExfTElDRU5TRTo9QElOU1RBTExfTElDRU5TRUAKIAotLlBIT05ZOiBhbGwg
aW5zdGFsbCBjbGVhbiBhbGwtaW5mbyBpbmZvIGluc3RhbGwtaW5mbyBpbnN0
YWxsLWxpY2Vuc2UgY2hlY2sgXAorLlBIT05ZOiBhbGwgaW5zdGFsbCBjbGVh
biBkaXN0Y2xlYW4gYWxsLWluZm8gaW5mbyBpbnN0YWxsLWluZm8gaW5zdGFs
bC1saWNlbnNlIGNoZWNrIFwKIAkkKFNVQkRJUlMpICQoSU5TVEFMTF9TVUJE
SVJTKSAkKENMRUFOX1NVQkRJUlMpCiAKIC5TVUZGSVhFUzoKQEAgLTcxLDcg
KzcxLDcgQEAgaW5zdGFsbC1saWNlbnNlOiBDWUdXSU5fTElDRU5TRSBDT1BZ
SU5HCiAKIGluc3RhbGw6IE1ha2VmaWxlICQoSU5TVEFMTF9MSUNFTlNFKSAk
KElOU1RBTExfU1VCRElSUykKIAotY2xlYW46ICQoQ0xFQU5fU1VCRElSUykK
K2NsZWFuIGRpc3RjbGVhbjogJChDTEVBTl9TVUJESVJTKQogCiBhbGwtaW5m
bzoKIApkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9NYWtlZmlsZS5pbiBi
L3dpbnN1cC9jeWd3aW4vTWFrZWZpbGUuaW4KaW5kZXggNDM5MTliZC4uYTU0
ODM2OCAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9NYWtlZmlsZS5pbgor
KysgYi93aW5zdXAvY3lnd2luL01ha2VmaWxlLmluCkBAIC02NTMsMTQgKzY1
MywxNSBAQCB1bmluc3RhbGwtbWFuOgogCSAgICBybSAtZiAkKERFU1RESVIp
JChtYW5kaXIpL21hbjcvYGJhc2VuYW1lICQkaWAgOyBcCiAJZG9uZQogCi1j
bGVhbjoKLQktcm0gLWYgKi5vICouZGxsICouZGJnICouYSAqLmV4cCBqdW5r
ICouYmFzZSB2ZXJzaW9uLmNjICouZXhlICouZCAqc3RhbXAqICpfbWFnaWMu
aCBzaWdmZS5zIGN5Z3dpbi5kZWYgZ2xvYmFscy5oICQoc3JjZGlyKS8kKFRM
U09GRlNFVFNfSCkgJChzcmNkaXIpL2RldmljZXMuY2MKK2NsZWFuIGRpc3Rj
bGVhbiByZWFsY2xlYW46CisJLXJtIC1mICoubyAqLmRsbCAqLmRiZyAqLmEg
Ki5leHAganVuayAqLmJhc2UgdmVyc2lvbi5jYyAqLmV4ZSAqLmQgKnN0YW1w
KiAqX21hZ2ljLmggc2lnZmUucyBjeWd3aW4uZGVmIGdsb2JhbHMuaAogCS1A
JChNQUtFKSAtQyAke2N5Z3NlcnZlcl9ibGRkaXJ9IGxpYmNsZWFuCiAKLW1h
aW50YWluZXItY2xlYW4gcmVhbGNsZWFuOiBjbGVhbgorbWFpbnRhaW5lci1j
bGVhbjogY2xlYW4KIAlAZWNobyAiVGhpcyBjb21tYW5kIGlzIGludGVuZGVk
IGZvciBtYWludGFpbmVycyB0byB1c2U7IgogCUBlY2hvICJpdCBkZWxldGVz
IGZpbGVzIHRoYXQgbWF5IHJlcXVpcmUgc3BlY2lhbCB0b29scyB0byByZWJ1
aWxkLiIKIAktcm0gLWZyIGNvbmZpZ3VyZQorCS1ybSAtZiAgJChzcmNkaXIp
LyQoVExTT0ZGU0VUU19IKSAkKHNyY2RpcikvZGV2aWNlcy5jYwogCiAjIFJ1
bGUgdG8gYnVpbGQgTERTQ1JJUFQKICQoTERTQ1JJUFQpOiAkKExEU0NSSVBU
KS5pbgotLSAKMi44LjMKCg==

--------------EE9D5C5E5A9E25E14B1A88D9--
