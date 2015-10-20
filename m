Return-Path: <cygwin-patches-return-8252-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10517 invoked by alias); 20 Oct 2015 22:48:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 10500 invoked by uid 89); 20 Oct 2015 22:48:48 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2
X-HELO: limerock02.mail.cornell.edu
Received: from limerock02.mail.cornell.edu (HELO limerock02.mail.cornell.edu) (128.84.13.242) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 20 Oct 2015 22:48:47 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite4.serverfarm.cornell.edu [10.16.197.9])	by limerock02.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id t9KMmjMa026306	for <cygwin-patches@cygwin.com>; Tue, 20 Oct 2015 18:48:45 -0400
Received: from [192.168.1.5] (cpe-67-249-176-138.twcny.res.rr.com [67.249.176.138])	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id t9KMmi04007991	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)	for <cygwin-patches@cygwin.com>; Tue, 20 Oct 2015 18:48:45 -0400
Subject: Re: New FAQ entry about permissions since Cygwin 1.7.34
To: cygwin-patches@cygwin.com
References: <56143209.6060201@cornell.edu> <20151020192559.GC17374@calimero.vinschen.de>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <5626C4CC.3000603@cornell.edu>
Date: Tue, 20 Oct 2015 22:48:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <20151020192559.GC17374@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------010506000606010501090901"
X-IsSubscribed: yes
X-SW-Source: 2015-q4/txt/msg00005.txt.bz2

This is a multi-part message in MIME format.
--------------010506000606010501090901
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 648

On 10/20/2015 3:25 PM, Corinna Vinschen wrote:
> Hi Ken,
>
> On Oct  6 16:41, Ken Brown wrote:
>> There have been several recent threads on the cygwin list stemming from the
>> permissions change in 1.7.34.  I've pointed people to the FAQ about ssh
>> public key authentication, which is not the first place where someone with
>> this problem is likely to look.  The following patch attempts to remedy
>> this:
>
> Unfortunately it doesn't apply cleanly.  There are weird differences in
> whitespaces and a patch-breaking line wrap.  Can you check and resend,
> please?

Sorry, my mailer must have messed it up.  Here it is as an attachment.

Ken


--------------010506000606010501090901
Content-Type: text/plain; charset=UTF-8;
 name="0001-winsup-doc-faq-using.xml-faq.using.same-with-permiss.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-winsup-doc-faq-using.xml-faq.using.same-with-permiss.pa";
 filename*1="tch"
Content-length: 3181

RnJvbSBkMDczYTQ1NjM0MWNiNThkOTJjZTc1YzJiNWI0NmUxZDJhNTRlYzA5
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGti
cm93bkBjb3JuZWxsLmVkdT4KRGF0ZTogVHVlLCA2IE9jdCAyMDE1IDE2OjMx
OjA1IC0wNDAwClN1YmplY3Q6IFtQQVRDSF0gKiB3aW5zdXAvZG9jL2ZhcS11
c2luZy54bWwgKGZhcS51c2luZy5zYW1lLXdpdGgtcGVybWlzc2lvbnMpOgog
TmV3IGVudHJ5LgoKLS0tCiB3aW5zdXAvZG9jL0NoYW5nZUxvZyAgICAgfCAg
NCArKysrCiB3aW5zdXAvZG9jL2ZhcS11c2luZy54bWwgfCA0MiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMg
Y2hhbmdlZCwgNDYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3dpbnN1
cC9kb2MvQ2hhbmdlTG9nIGIvd2luc3VwL2RvYy9DaGFuZ2VMb2cKaW5kZXgg
MzU5MzViZS4uN2U4NWE3NiAxMDA2NDQKLS0tIGEvd2luc3VwL2RvYy9DaGFu
Z2VMb2cKKysrIGIvd2luc3VwL2RvYy9DaGFuZ2VMb2cKQEAgLTEsMyArMSw3
IEBACisyMDE1LTEwLTA2ICBLZW4gQnJvd24gIDxrYnJvd25AY29ybmVsbC5l
ZHU+CisKKwkqIGZhcS11c2luZy54bWwgKGZhcS51c2luZy5zYW1lLXdpdGgt
cGVybWlzc2lvbnMpOiBOZXcgZW50cnkuCisKIDIwMTUtMDktMDcgIEJyaWFu
IEluZ2xpcyAgPEJyaWFuLkluZ2xpc0BTeXN0ZW1hdGljU3cuYWIuY2E+CiAK
IAkqIGZhcS11c2luZy54bWwgKGZhcS51c2luZy5tYW4pOiBSZXBsYWNlIG1h
a2V3aGF0aXMgd2l0aCBtYW5kYi4KZGlmZiAtLWdpdCBhL3dpbnN1cC9kb2Mv
ZmFxLXVzaW5nLnhtbCBiL3dpbnN1cC9kb2MvZmFxLXVzaW5nLnhtbAppbmRl
eCA3NjU2ODgwLi40Y2ZjODIyIDEwMDY0NAotLS0gYS93aW5zdXAvZG9jL2Zh
cS11c2luZy54bWwKKysrIGIvd2luc3VwL2RvYy9mYXEtdXNpbmcueG1sCkBA
IC0xMTgzLDYgKzExODMsNDggQEAgVXNlcnM8L2NvbXB1dGVyb3V0cHV0PiBn
cm91cCBpbnN0ZWFkLjwvcGFyYT4KIAogPC9hbnN3ZXI+PC9xYW5kYWVudHJ5
PgogCis8cWFuZGFlbnRyeSBpZD0iZmFxLnVzaW5nLnNhbWUtd2l0aC1wZXJt
aXNzaW9ucyI+Cis8cXVlc3Rpb24+PHBhcmE+V2h5IGRvIG15IGZpbGVzIGhh
dmUgZXh0cmEgcGVybWlzc2lvbnMgYWZ0ZXIgdXBkYXRpbmcgdG8gQ3lnd2lu
IDEuNy4zND88L3BhcmE+PC9xdWVzdGlvbj4KKzxhbnN3ZXI+CisKKzxwYXJh
PlRoZSBwcm9ibGVtIGlzIGV4YWN0bHkgdGhlIHNhbWUgYXMgd2l0aCB0aGUg
a2V5IGZpbGVzIG9mIFNTSC4gIFNlZQorPHhyZWYgbGlua2VuZD0iZmFxLnVz
aW5nLnNzaC1wdWJrZXktc3RvcHMtd29ya2luZyIvPi48L3BhcmE+CisKKzxw
YXJhPlRoZSBzb2x1dGlvbiBpcyB0aGUgc2FtZTo8L3BhcmE+CisKKzxzY3Jl
ZW4+CisgICQgbHMgLWwgKgorICAtcnctcnd4ci0tKyAxIHVzZXIgZ3JvdXAg
NDIgTm92IDEyICAyMDEwIGZpbGUxCisgIC1ydy1yd3hyLS0rIDEgdXNlciBn
cm91cCA0MiBOb3YgMTIgIDIwMTAgZmlsZTIKKyAgJCBzZXRmYWNsIC1iICoK
KyAgJCBscyAtbCAqCisgIC1ydy1yLS1yLS0gIDEgdXNlciBncm91cCA0MiBO
b3YgMTIgIDIwMTAgZmlsZTEKKyAgLXJ3LXItLXItLSAgMSB1c2VyIGdyb3Vw
IDQyIE5vdiAxMiAgMjAxMCBmaWxlMgorPC9zY3JlZW4+CisKKzxwYXJhPllv
dSBtYXkgZmluZCB0aGF0IG5ld2x5LWNyZWF0ZWQgZmlsZXMgYWxzbyBoYXZl
IHVuZXhwZWN0ZWQKK3Blcm1pc3Npb25zOjwvcGFyYT4KKworPHNjcmVlbj4K
KyAgJCB0b3VjaCBmb28KKyAgJCBscyAtbCBmb28KKyAgLXJ3LXJ3eHItLSsg
MSB1c2VyIGdyb3VwIDQyIE5vdiAxMiAgMjAxMCBmb28KKzwvc2NyZWVuPgor
Cis8cGFyYT5UaGlzIHByb2JhYmx5IG1lYW5zIHRoYXQgdGhlIGRpcmVjdG9y
eSBpbiB3aGljaCB5b3UncmUgY3JlYXRpbmcKK3RoZSBmaWxlcyBoYXMgdW53
YW50ZWQgZGVmYXVsdCBBQ0wgZW50cmllcyB0aGF0IGFyZSBpbmhlcml0ZWQg
YnkKK25ld2x5LWNyZWF0ZWQgZmlsZXMgYW5kIHN1YmRpcmVjdG9yaWVzLiAg
VGhlIHNvbHV0aW9uIGlzIGFnYWluIHRoZQorc2FtZTo8L3BhcmE+CisKKzxz
Y3JlZW4+CisgICQgc2V0ZmFjbCAtYiAuCisgICQgdG91Y2ggYmFyCisgICQg
bHMgLWwgYmFyCisgIC1ydy1yLS1yLS0gIDEgdXNlciBncm91cCA0MiBOb3Yg
MTIgIDIwMTAgYmFyCis8L3NjcmVlbj4KKworPC9hbnN3ZXI+PC9xYW5kYWVu
dHJ5PgorCiA8cWFuZGFlbnRyeSBpZD0iZmFxLnVzaW5nLnRjbC10ayI+CiA8
cXVlc3Rpb24+PHBhcmE+V2h5IGRvIG15IFRrIHByb2dyYW1zIG5vdCB3b3Jr
IGFueW1vcmU/PC9wYXJhPjwvcXVlc3Rpb24+CiA8YW5zd2VyPgotLSAKMi41
LjMKCg==

--------------010506000606010501090901--
