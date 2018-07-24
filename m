Return-Path: <cygwin-patches-return-9146-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 65966 invoked by alias); 24 Jul 2018 22:33:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 65955 invoked by uid 89); 24 Jul 2018 22:33:40 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-25.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3 autolearn=ham version=3.3.2 spammy=H*RU:!192.168.0.15!, H*r:ip*192.168.0.15, Hx-spam-relays-external:!192.168.0.15!, SYSTEM
X-HELO: limerock01.mail.cornell.edu
Received: from limerock01.mail.cornell.edu (HELO limerock01.mail.cornell.edu) (128.84.13.241) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 24 Jul 2018 22:33:39 +0000
Received: from authusersmtp.mail.cornell.edu (granite3.serverfarm.cornell.edu [10.16.197.8])	by limerock01.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id w6OMXaq1004937	for <cygwin-patches@cygwin.com>; Tue, 24 Jul 2018 18:33:37 -0400
Received: from [192.168.0.15] (mta-68-175-129-7.twcny.rr.com [68.175.129.7] (may be forged))	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id w6OMXZu4029712	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)	for <cygwin-patches@cygwin.com>; Tue, 24 Jul 2018 18:33:36 -0400
Subject: Re: getfacl output
To: cygwin-patches@cygwin.com
References: <48785885-6501-f00e-1949-d923fe7ed41b@cornell.edu> <20180723150622.GB3312@calimero.vinschen.de> <2961960c-9b29-708d-8491-72f938728f90@cornell.edu> <20180723153700.GC3312@calimero.vinschen.de> <4da0ada7-bfb0-4ac1-030b-6b7253d60a1b@cornell.edu>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <b6063dcc-b755-b531-186a-6ff43e308d17@cornell.edu>
Date: Tue, 24 Jul 2018 22:33:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4da0ada7-bfb0-4ac1-030b-6b7253d60a1b@cornell.edu>
Content-Type: multipart/mixed; boundary="------------F147150C94490676E866821F"
X-IsSubscribed: yes
X-SW-Source: 2018-q3/txt/msg00041.txt.bz2

This is a multi-part message in MIME format.
--------------F147150C94490676E866821F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-length: 1124

On 7/23/2018 12:06 PM, Ken Brown wrote:
> On 7/23/2018 11:37 AM, Corinna Vinschen wrote:
>> On Jul 23 11:15, Ken Brown wrote:
>>> [Redirecting to cygwin-patches.]
>>>
>>> On 7/23/2018 11:06 AM, Corinna Vinschen wrote:
>>>> On Jul 23 10:43, Ken Brown wrote:
>>>>> This is obviously very minor, but I bumped into it because of a 
>>>>> failing
>>>>> emacs test.
>>>>>
>>>>> Cygwin's getfacl prints only one colon after "mask" and "other", 
>>>>> but Linux's
>>>>> prints two.Â  I'm sure this was done for a reason, but I'm wondering 
>>>>> if it
>>>>> would be better to follow Linux.
>>>>
>>>> The original version was designed after Solaris documentation,
>>>> but the layout is supposed to look like Linux for a while, so
>>>> ther missing colon is a bug.
>>>>
>>>>> Â Â Â  I'll be glad to submit a patch.
>>>>
>>>> Glad to review it :)
>>>
>>> Attached.
> 
>> Pushed.Â  I just wonder if we shouldn't simplify getfacl to use
>> acl_to_text instead.
> 
> Yes, that makes sense.Â  I'll take a look.

Patch attached.

I thought it might be possible to simplify setfacl in a similar way, but 
I didn't see a way to do it.

Ken

--------------F147150C94490676E866821F
Content-Type: text/plain; charset=UTF-8;
 name="0001-getfacl-Simplify-by-using-acl_to_any_text.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-getfacl-Simplify-by-using-acl_to_any_text.patch"
Content-length: 7800

RnJvbSA4OWNjNThlNWM0Nzg3ZTRhMDFiNjkzODI1NmNjMmZhMDEwMWQwMzEz
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGti
cm93bkBjb3JuZWxsLmVkdT4KRGF0ZTogTW9uLCAyMyBKdWwgMjAxOCAxNzo0
Njo0MSAtMDQwMApTdWJqZWN0OiBbUEFUQ0hdIGdldGZhY2w6IFNpbXBsaWZ5
IGJ5IHVzaW5nIGFjbF90b19hbnlfdGV4dAoKLS0tCiB3aW5zdXAvdXRpbHMv
Z2V0ZmFjbC5jIHwgMTUzICsrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNDEgaW5zZXJ0aW9ucygr
KSwgMTEyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC91dGls
cy9nZXRmYWNsLmMgYi93aW5zdXAvdXRpbHMvZ2V0ZmFjbC5jCmluZGV4IDM2
MzIyNmQ2ZS4uMDhkZmMwYmYzIDEwMDY0NAotLS0gYS93aW5zdXAvdXRpbHMv
Z2V0ZmFjbC5jCisrKyBiL3dpbnN1cC91dGlscy9nZXRmYWNsLmMKQEAgLTE0
LDYgKzE0LDggQEAgZGV0YWlscy4gKi8KICNpbmNsdWRlIDx1bmlzdGQuaD4K
ICNpbmNsdWRlIDxnZXRvcHQuaD4KICNpbmNsdWRlIDxjeWd3aW4vYWNsLmg+
CisjaW5jbHVkZSA8c3lzL2FjbC5oPgorI2luY2x1ZGUgPGFjbC9saWJhY2wu
aD4KICNpbmNsdWRlIDxzeXMvc3RhdC5oPgogI2luY2x1ZGUgPGN5Z3dpbi92
ZXJzaW9uLmg+CiAjaW5jbHVkZSA8c3RyaW5nLmg+CkBAIC0yMSwxOCArMjMs
NiBAQCBkZXRhaWxzLiAqLwogCiBzdGF0aWMgY2hhciAqcHJvZ19uYW1lOwog
Ci1jaGFyICoKLXBlcm1zdHIgKG1vZGVfdCBwZXJtKQotewotICBzdGF0aWMg
Y2hhciBwYnVmWzRdOwotCi0gIHBidWZbMF0gPSAocGVybSAmIFNfSVJPVEgp
ID8gJ3InIDogJy0nOwotICBwYnVmWzFdID0gKHBlcm0gJiBTX0lXT1RIKSA/
ICd3JyA6ICctJzsKLSAgcGJ1ZlsyXSA9IChwZXJtICYgU19JWE9USCkgPyAn
eCcgOiAnLSc7Ci0gIHBidWZbM10gPSAnXDAnOwotICByZXR1cm4gcGJ1ZjsK
LX0KLQogY29uc3QgY2hhciAqCiB1c2VybmFtZSAodWlkX3QgdWlkKQogewpA
QCAtMTUwLDkgKzE0MCw5IEBAIG1haW4gKGludCBhcmdjLCBjaGFyICoqYXJn
dikKICAgaW50IGVvcHQgPSAwOwogICBpbnQgZG9wdCA9IDA7CiAgIGludCBu
b3B0ID0gMDsKKyAgaW50IG9wdGlvbnMgPSAwOwogICBpbnQgaXN0dHkgPSBp
c2F0dHkgKGZpbGVubyAoc3Rkb3V0KSk7CiAgIHN0cnVjdCBzdGF0IHN0Owot
ICBhY2xlbnRfdCBhY2xzW01BWF9BQ0xfRU5UUklFU107CiAKICAgcHJvZ19u
YW1lID0gcHJvZ3JhbV9pbnZvY2F0aW9uX3Nob3J0X25hbWU7CiAKQEAgLTE5
MiwxOSArMTgyLDI2IEBAIG1haW4gKGludCBhcmdjLCBjaGFyICoqYXJndikK
ICAgICAgIHVzYWdlIChzdGRlcnIpOwogICAgICAgcmV0dXJuIDE7CiAgICAg
fQorICBpZiAobm9wdCkKKyAgICBvcHRpb25zIHw9IFRFWFRfTlVNRVJJQ19J
RFM7CisgIGlmIChlb3B0ID4gMCkKKyAgICBvcHRpb25zIHw9IFRFWFRfQUxM
X0VGRkVDVElWRTsKKyAgZWxzZSBpZiAoIWVvcHQpCisgICAgb3B0aW9ucyB8
PSBURVhUX1NPTUVfRUZGRUNUSVZFOworICBpZiAoaXN0dHkpCisgICAgb3B0
aW9ucyB8PSBURVhUX1NNQVJUX0lOREVOVDsKICAgZm9yICg7IG9wdGluZCA8
IGFyZ2M7ICsrb3B0aW5kKQogICAgIHsKLSAgICAgIGludCBpLCBudW1fYWNs
czsKLSAgICAgIG1vZGVfdCBtYXNrID0gU19JUldYTywgZGVmX21hc2sgPSBT
X0lSV1hPOworICAgICAgYWNsX3QgYWNjZXNzX2FjbCA9IE5VTEwsIGRlZmF1
bHRfYWNsID0gTlVMTDsKKyAgICAgIGNoYXIgKmFjY2Vzc190eHQsICpkZWZh
dWx0X3R4dDsKIAogICAgICAgaWYgKHN0YXQgKGFyZ3Zbb3B0aW5kXSwgJnN0
KQotCSAgfHwgKG51bV9hY2xzID0gYWNsIChhcmd2W29wdGluZF0sIEdFVEFD
TCwgTUFYX0FDTF9FTlRSSUVTLCBhY2xzKSkgPCAwKQotCXsKLQkgIGZwcmlu
dGYgKHN0ZGVyciwgIiVzOiAlczogJXNcbiIsCi0JCSAgIHByb2dfbmFtZSwg
YXJndltvcHRpbmRdLCBzdHJlcnJvciAoZXJybm8pKTsKLQkgIHJldCA9IDI7
Ci0JICBjb250aW51ZTsKLQl9CisJICB8fCAoIWRvcHQKKwkgICAgICAmJiAh
KGFjY2Vzc19hY2wgPSBhY2xfZ2V0X2ZpbGUgKGFyZ3Zbb3B0aW5kXSwgQUNM
X1RZUEVfQUNDRVNTKSkpCisJICB8fCAoIWFvcHQgJiYgU19JU0RJUiAoc3Qu
c3RfbW9kZSkKKwkgICAgICAmJiAhKGRlZmF1bHRfYWNsID0gYWNsX2dldF9m
aWxlIChhcmd2W29wdGluZF0sCisJCQkJCSAgICAgICBBQ0xfVFlQRV9ERUZB
VUxUKSkpKQorCWdvdG8gZXJyOwogICAgICAgaWYgKCFjb3B0KQogCXsKIAkg
IHByaW50ZiAoIiMgZmlsZTogJXNcbiIsIGFyZ3Zbb3B0aW5kXSk7CkBAIC0y
MjMsMTAzICsyMjAsMzUgQEAgbWFpbiAoaW50IGFyZ2MsIGNoYXIgKiphcmd2
KQogCQkJCQkgKHN0LnN0X21vZGUgJiBTX0lTR0lEKSA/ICdzJyA6ICctJywK
IAkJCQkJIChzdC5zdF9tb2RlICYgU19JU1ZUWCkgPyAndCcgOiAnLScpOwog
CX0KLSAgICAgIGZvciAoaSA9IDA7IGkgPCBudW1fYWNsczsgKytpKQotCXsK
LQkgIGlmIChhY2xzW2ldLmFfdHlwZSA9PSBDTEFTU19PQkopCi0JICAgIG1h
c2sgPSBhY2xzW2ldLmFfcGVybTsKLQkgIGVsc2UgaWYgKGFjbHNbaV0uYV90
eXBlID09IERFRl9DTEFTU19PQkopCi0JICAgIGRlZl9tYXNrID0gYWNsc1tp
XS5hX3Blcm07Ci0JfQotICAgICAgZm9yIChpID0gMDsgaSA8IG51bV9hY2xz
OyArK2kpCisgICAgICBpZiAoYWNjZXNzX2FjbCkKIAl7Ci0JICBpbnQgbiA9
IDA7Ci0JICBpbnQgcHJpbnRfZWZmZWN0aXZlID0gMDsKLQkgIG1vZGVfdCBl
ZmZlY3RpdmUgPSBhY2xzW2ldLmFfcGVybTsKLQotCSAgaWYgKGFjbHNbaV0u
YV90eXBlICYgQUNMX0RFRkFVTFQpCi0JICAgIHsKLQkgICAgICBpZiAoYW9w
dCkKLQkJY29udGludWU7Ci0JICAgICAgbiArPSBwcmludGYgKCJkZWZhdWx0
OiIpOwotCSAgICB9Ci0JICBlbHNlIGlmIChkb3B0KQotCSAgICBjb250aW51
ZTsKLQkgIHN3aXRjaCAoYWNsc1tpXS5hX3R5cGUgJiB+QUNMX0RFRkFVTFQp
CisJICBpZiAoIShhY2Nlc3NfdHh0ID0gYWNsX3RvX2FueV90ZXh0IChhY2Nl
c3NfYWNsLCBOVUxMLCAnXG4nLCBvcHRpb25zKSkpCiAJICAgIHsKLQkgICAg
Y2FzZSBVU0VSX09CSjoKLQkgICAgICBwcmludGYgKCJ1c2VyOjoiKTsKLQkg
ICAgICBicmVhazsKLQkgICAgY2FzZSBVU0VSOgotCSAgICAgIGlmIChub3B0
KQotCQluICs9IHByaW50ZiAoInVzZXI6JWx1OiIsICh1bnNpZ25lZCBsb25n
KWFjbHNbaV0uYV9pZCk7Ci0JICAgICAgZWxzZQotCQluICs9IHByaW50ZiAo
InVzZXI6JXM6IiwgdXNlcm5hbWUgKGFjbHNbaV0uYV9pZCkpOwotCSAgICAg
IGJyZWFrOwotCSAgICBjYXNlIEdST1VQX09CSjoKLQkgICAgICBuICs9IHBy
aW50ZiAoImdyb3VwOjoiKTsKLQkgICAgICBicmVhazsKLQkgICAgY2FzZSBH
Uk9VUDoKLQkgICAgICBpZiAobm9wdCkKLQkJbiArPSBwcmludGYgKCJncm91
cDolbHU6IiwgKHVuc2lnbmVkIGxvbmcpYWNsc1tpXS5hX2lkKTsKLQkgICAg
ICBlbHNlCi0JCW4gKz0gcHJpbnRmICgiZ3JvdXA6JXM6IiwgZ3JvdXBuYW1l
IChhY2xzW2ldLmFfaWQpKTsKLQkgICAgICBicmVhazsKLQkgICAgY2FzZSBD
TEFTU19PQko6Ci0JICAgICAgcHJpbnRmICgibWFzazo6Iik7Ci0JICAgICAg
YnJlYWs7Ci0JICAgIGNhc2UgT1RIRVJfT0JKOgotCSAgICAgIHByaW50ZiAo
Im90aGVyOjoiKTsKLQkgICAgICBicmVhazsKKwkgICAgICBhY2xfZnJlZSAo
YWNjZXNzX2FjbCk7CisJICAgICAgZ290byBlcnI7CiAJICAgIH0KLQkgIG4g
Kz0gcHJpbnRmICgiJXMiLCBwZXJtc3RyIChhY2xzW2ldLmFfcGVybSkpOwot
CSAgc3dpdGNoIChhY2xzW2ldLmFfdHlwZSkKLQkgICAgewotCSAgICBjYXNl
IFVTRVI6Ci0JICAgIGNhc2UgR1JPVVBfT0JKOgotCSAgICAgIGVmZmVjdGl2
ZSA9IGFjbHNbaV0uYV9wZXJtICYgbWFzazsKLQkgICAgICBwcmludF9lZmZl
Y3RpdmUgPSAxOwotCSAgICAgIGJyZWFrOwotCSAgICBjYXNlIEdST1VQOgot
CSAgICAgIC8qIFNwZWNpYWwgY2FzZSBTWVNURU0gYW5kIEFkbWlucyBncm91
cDogIFRoZSBtYXNrIG9ubHkKLQkgICAgICAgICBhcHBsaWVzIHRvIHRoZW0g
YXMgZmFyIGFzIHRoZSBleGVjdXRlIGJpdCBpcyBjb25jZXJuZWQuICovCi0J
ICAgICAgaWYgKGFjbHNbaV0uYV9pZCA9PSAxOCB8fCBhY2xzW2ldLmFfaWQg
PT0gNTQ0KQotCQllZmZlY3RpdmUgPSBhY2xzW2ldLmFfcGVybSAmIChtYXNr
IHwgU19JUk9USCB8IFNfSVdPVEgpOwotCSAgICAgIGVsc2UKLQkJZWZmZWN0
aXZlID0gYWNsc1tpXS5hX3Blcm0gJiBtYXNrOwotCSAgICAgIHByaW50X2Vm
ZmVjdGl2ZSA9IDE7Ci0JICAgICAgYnJlYWs7Ci0JICAgIGNhc2UgREVGX1VT
RVI6Ci0JICAgIGNhc2UgREVGX0dST1VQX09CSjoKLQkgICAgICBlZmZlY3Rp
dmUgPSBhY2xzW2ldLmFfcGVybSAmIGRlZl9tYXNrOwotCSAgICAgIHByaW50
X2VmZmVjdGl2ZSA9IDE7Ci0JICAgICAgYnJlYWs7Ci0JICAgIGNhc2UgREVG
X0dST1VQOgotCSAgICAgIC8qIFNwZWNpYWwgY2FzZSBTWVNURU0gYW5kIEFk
bWlucyBncm91cDogIFRoZSBtYXNrIG9ubHkKLQkgICAgICAgICBhcHBsaWVz
IHRvIHRoZW0gYXMgZmFyIGFzIHRoZSBleGVjdXRlIGJpdCBpcyBjb25jZXJu
ZWQuICovCi0JICAgICAgaWYgKGFjbHNbaV0uYV9pZCA9PSAxOCB8fCBhY2xz
W2ldLmFfaWQgPT0gNTQ0KQotCQllZmZlY3RpdmUgPSBhY2xzW2ldLmFfcGVy
bSAmIChkZWZfbWFzayB8IFNfSVJPVEggfCBTX0lXT1RIKTsKLQkgICAgICBl
bHNlCi0JCWVmZmVjdGl2ZSA9IGFjbHNbaV0uYV9wZXJtICYgZGVmX21hc2s7
Ci0JICAgICAgcHJpbnRfZWZmZWN0aXZlID0gMTsKLQkgICAgICBicmVhazsK
LQkgICAgfQotCSAgaWYgKHByaW50X2VmZmVjdGl2ZSAmJiBlb3B0ID49IDAK
LQkgICAgICAmJiAoZW9wdCA+IDAgfHwgZWZmZWN0aXZlICE9IGFjbHNbaV0u
YV9wZXJtKSkKKwkgIHByaW50ZiAoIiVzXG4iLCBhY2Nlc3NfdHh0KTsKKwkg
IGFjbF9mcmVlIChhY2Nlc3NfdHh0KTsKKwkgIGFjbF9mcmVlIChhY2Nlc3Nf
YWNsKTsKKwl9CisgICAgICBpZiAoZGVmYXVsdF9hY2wpCisJeworCSAgaWYg
KCEoZGVmYXVsdF90eHQgPSBhY2xfdG9fYW55X3RleHQgKGRlZmF1bHRfYWNs
LCAiZGVmYXVsdDoiLAorCQkJCQkgICAgICAgJ1xuJywgb3B0aW9ucykpKQog
CSAgICB7Ci0JICAgICAgaWYgKGlzdHR5KQotCQl7Ci0JCSAgbiA9IDQwIC0g
bjsKLQkJICBpZiAobiA8PSAwKQotCQkgICAgbiA9IDE7Ci0JCSAgcHJpbnRm
ICgiJSpzIiwgbiwgIiAiKTsKLQkJfQotCSAgICAgIGVsc2UKLQkgICAgICAg
IHB1dGNoYXIgKCdcdCcpOwotCSAgICAgIHByaW50ZiAoIiNlZmZlY3RpdmU6
JXMiLCBwZXJtc3RyIChlZmZlY3RpdmUpKTsKKwkgICAgICBhY2xfZnJlZSAo
ZGVmYXVsdF9hY2wpOworCSAgICAgIGdvdG8gZXJyOwogCSAgICB9Ci0JICBw
dXRjaGFyICgnXG4nKTsKKwkgIHByaW50ZiAoIiVzXG4iLCBkZWZhdWx0X3R4
dCk7CisJICBhY2xfZnJlZSAoZGVmYXVsdF90eHQpOworCSAgYWNsX2ZyZWUg
KGRlZmF1bHRfYWNsKTsKIAl9CiAgICAgICBwdXRjaGFyICgnXG4nKTsKKyAg
ICAgIGNvbnRpbnVlOworICAgIGVycjoKKyAgICAgIGZwcmludGYgKHN0ZGVy
ciwgIiVzOiAlczogJXNcblxuIiwKKwkgICAgICAgcHJvZ19uYW1lLCBhcmd2
W29wdGluZF0sIHN0cmVycm9yIChlcnJubykpOworICAgICAgcmV0ID0gMjsK
ICAgICB9CiAgIHJldHVybiByZXQ7CiB9Ci0tIAoyLjE3LjAKCg==

--------------F147150C94490676E866821F--
