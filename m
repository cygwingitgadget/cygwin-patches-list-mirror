Return-Path: <cygwin-patches-return-7679-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30827 invoked by alias); 18 Jul 2012 00:31:10 -0000
Received: (qmail 30814 invoked by uid 22791); 18 Jul 2012 00:31:09 -0000
X-SWARE-Spam-Status: No, hits=-5.2 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,KHOP_THREADED,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mail-yw0-f43.google.com (HELO mail-yw0-f43.google.com) (209.85.213.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 18 Jul 2012 00:30:56 +0000
Received: by yhl10 with SMTP id 10so1102583yhl.2        for <cygwin-patches@cygwin.com>; Tue, 17 Jul 2012 17:30:55 -0700 (PDT)
Received: by 10.42.61.134 with SMTP id u6mr2660603ich.11.1342571454768;        Tue, 17 Jul 2012 17:30:54 -0700 (PDT)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id bo7sm26905488igb.2.2012.07.17.17.30.53        (version=TLSv1/SSLv3 cipher=OTHER);        Tue, 17 Jul 2012 17:30:53 -0700 (PDT)
Message-ID: <500603C6.1000708@users.sourceforge.net>
Date: Wed, 18 Jul 2012 00:31:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: *Very* outdated FAQ entry
References: <20120717190842.GF31055@calimero.vinschen.de>
In-Reply-To: <20120717190842.GF31055@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------050806030505060403080602"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q3/txt/msg00000.txt.bz2

This is a multi-part message in MIME format.
--------------050806030505060403080602
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 671

On 2012-07-17 14:08, Corinna Vinschen wrote:
> due to Aram's request for permission to translate the FAQ, I accidentally
> stumbled over FAQ entry 6.40, "How should I port my Unix GUI to Windows?",
> http://cygwin.com/faq-nochunks.html#faq.programming.unix-gui
>
> Per cvs annotate, this text is at least 7 years old but probably older.
> As such, it is hopelessly outdated.
>
> Given that we have X, the X server, and a lot of extra libs like GTK
> Qt, etc, does anybody have a good idea how to rewrite the FAQ entry
> so that it makes sense in our modern times?  Kind of like "only
> marginal porting necessary"?  Patches are welcome.

How about the attached?


Yaakov

--------------050806030505060403080602
Content-Type: application/x-itunes-itlp;
 name="faq-unix-gui.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="faq-unix-gui.patch"
Content-length: 5307

MjAxMi0wNy0xNyAgWWFha292IFNlbGtvd2l0eiAgPHlzZWxrb3dpdHpALi4u
PgoKCSogZmFxLXByb2dyYW1taW5nLnhtbCAoZmFxLnByb2dyYW1taW5nLnVu
aXgtZ3VpKTogVXBkYXRlIHRvCglyZWZsZWN0IHRoZSBhdmFpbGFiaWxpdHkg
b2YgWDExIHRvb2xraXRzIG9uIEN5Z3dpbi4KCkluZGV4OiBmYXEtcHJvZ3Jh
bW1pbmcueG1sCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KUkNTIGZpbGU6IC9j
dnMvc3JjL3NyYy93aW5zdXAvZG9jL2ZhcS1wcm9ncmFtbWluZy54bWwsdgpy
ZXRyaWV2aW5nIHJldmlzaW9uIDEuMTkKZGlmZiAtdSAtcCAtcjEuMTkgZmFx
LXByb2dyYW1taW5nLnhtbAotLS0gZmFxLXByb2dyYW1taW5nLnhtbAkyMyBB
cHIgMjAxMiAyMTo0Njo0NiAtMDAwMAkxLjE5CisrKyBmYXEtcHJvZ3JhbW1p
bmcueG1sCTE4IEp1bCAyMDEyIDAwOjI5OjMwIC0wMDAwCkBAIC04MTAsMjAg
KzgxMCw0MiBAQCBhIFdpbmRvd3MgZW52aXJvbm1lbnQgd2hpY2ggQ3lnd2lu
IGhhbmRsCiA8cXVlc3Rpb24+PHBhcmE+SG93IHNob3VsZCBJIHBvcnQgbXkg
VW5peCBHVUkgdG8gV2luZG93cz88L3BhcmE+PC9xdWVzdGlvbj4KIDxhbnN3
ZXI+CiAKLTxwYXJhPlRoZXJlIGFyZSB0d28gYmFzaWMgc3RyYXRlZ2llcyBm
b3IgcG9ydGluZyBVbml4IEdVSXMgdG8gV2luZG93cy4KLTwvcGFyYT4KLTxw
YXJhPlRoZSBmaXJzdCBpcyB0byB1c2UgYSBwb3J0YWJsZSBncmFwaGljcyBs
aWJyYXJ5IHN1Y2ggYXMgdGNsL3RrLCBYMTEsIG9yCi1WIChhbmQgb3RoZXJz
PykuICBUeXBpY2FsbHksIHlvdSB3aWxsIGVuZCB1cCB3aXRoIGEgR1VJIG9u
IFdpbmRvd3MgdGhhdAotcmVxdWlyZXMgc29tZSBydW50aW1lIHN1cHBvcnQu
ICBXaXRoIHRjbC90aywgeW91J2xsIHdhbnQgdG8gaW5jbHVkZSB0aGUKLW5l
Y2Vzc2FyeSBsaWJyYXJ5IGZpbGVzIGFuZCB0aGUgdGNsL3RrIERMTHMuICBJ
biB0aGUgY2FzZSBvZiBYMTEsIHlvdSdsbAotbmVlZCBldmVyeW9uZSB1c2lu
ZyB5b3VyIHByb2dyYW0gdG8gaGF2ZSB0aGUgWDExIHNlcnZlciBpbnN0YWxs
ZWQuCi08L3BhcmE+Ci08cGFyYT5UaGUgc2Vjb25kIG1ldGhvZCBpcyB0byBy
ZXdyaXRlIHlvdXIgR1VJIHVzaW5nIFdpbjMyIEFQSSBjYWxscyAob3IgTUZD
Ci13aXRoIFZDKyspLiAgSWYgeW91ciBwcm9ncmFtIGlzIHdyaXR0ZW4gaW4g
YSBmYWlybHkgbW9kdWxhciBmYXNoaW9uLCB5b3UKLW1heSBzdGlsbCB3YW50
IHRvIHVzZSBDeWd3aW4gaWYgeW91ciBwcm9ncmFtIGNvbnRhaW5zIGEgbG90
IG9mIHNoYXJlZAotKG5vbi1HVUktcmVsYXRlZCkgY29kZS4gIFRoYXQgd2F5
IHlvdSBzdGlsbCBnYWluIHNvbWUgb2YgdGhlIHBvcnRhYmlsaXR5Ci1hZHZh
bnRhZ2VzIGluaGVyZW50IGluIHVzaW5nIEN5Z3dpbi4KLTwvcGFyYT4KKzxw
YXJhPkxpa2Ugb3RoZXIgVW5peC1saWtlIHBsYXRmb3JtcywgdGhlIEN5Z3dp
biBkaXN0cmlidGlvbiBpbmNsdWRlcyBtYW55IG9mCit0aGUgY29tbW9uIEdV
SSB0b29sa2l0cywgaW5jbHVkaW5nIFgxMSwgWCBBdGhlbmEgd2lkZ2V0cywg
TW90aWYsIFRrLCBHVEsrLAorYW5kIFF0LiBNYW55IHByb2dyYW1zIHdoaWNo
IHJlbHkgb24gdGhlc2UgdG9vbGtpdHMgd2lsbCB3b3JrIHdpdGggbGl0dGxl
LCBpZgorYW55LCBwb3J0aW5nIHdvcmsgaWYgdGhleSBhcmUgb3RoZXJ3aXNl
IHBvcnRhYmxlLiAgSG93ZXZlciwgdGhlcmUgYXJlIGEgZmV3Cit0aGluZ3Mg
dG8gbG9vayBvdXQgZm9yOjwvcGFyYT4KKzxvcmRlcmVkbGlzdD4KKzxsaXN0
aXRlbT48cGFyYT5Tb21lIHBhY2thZ2VzIHdyaXR0ZW4gZm9yIGJvdGggV2lu
ZG93cyBhbmQgWDExIGluY29ycmVjdGx5Cit0cmVhdCBDeWd3aW4gYXMgYSBX
aW5kb3dzIHBsYXRmb3JtIHJhdGhlciB0aGFuIGEgVW5peCB2YXJpYW50LiAg
TWl4aW5nIEN5Z3dpbidzCitVbml4IEFQSXMgd2l0aCBXaW5kb3dzJyBHREkg
aXMgYmVzdCBhdm9pZGVkOyByYXRoZXIsIHJlbW92ZSB0aGVzZSBhc3N1bXB0
aW9ucworc28gdGhhdCBDeWd3aW4gaXMgdHJlYXRlZCBsaWtlIG90aGVyIFgx
MSBwbGF0Zm9ybXMuPC9wYXJhPjwvbGlzdGl0ZW0+Cis8bGlzdGl0ZW0+PHBh
cmE+R1RLKyBwcm9ncmFtcyB3aGljaCB1c2UgPGxpdGVyYWw+Z3RrX2J1aWxk
ZXJfY29ubmVjdF9zaWduYWxzKCk8L2xpdGVyYWw+CitvciA8bGl0ZXJhbD5n
bGFkZV94bWxfc2lnbmFsX2F1dG9jb25uZWN0KCk8L2xpdGVyYWw+IG5lZWQg
dG8gYmUgYWJsZSB0bworPGxpdGVyYWw+ZGxvcGVuKCk8L2xpdGVyYWw+IHRo
ZW1zZWx2ZXMuICBJbiBvcmRlciBmb3IgdGhpcyB0byB3b3JrLCB0aGUgcHJv
Z3JhbQorbXVzdCBiZSBsaW5rZWQgd2l0aCB0aGUgPGxpdGVyYWw+LVdsLC0t
ZXhwb3J0LWFsbC1zeW1ib2xzPC9saXRlcmFsPiBsaW5rZXIgZmxhZy4KK1Ro
aXMgY2FuIGJlIGFkZGVkIHRvIExERkxBR1MgbWFudWFsbHksIG9yIGhhbmRs
ZWQgYXV0b21hdGljYWxseSB3aXRoIHRoZQorPGxpdGVyYWw+LWV4cG9ydC1k
eW5hbWljPC9saXRlcmFsPiBsaWJ0b29sIGZsYWcgKHJlcXVpcmVzIGxpYnRv
b2wgMi4yLjgpIG9yCitieSBhZGRpbmcgPGxpdGVyYWw+Z21vZHVsZS1leHBv
cnQtMi4wPC9saXRlcmFsPiB0byB0aGUgcGtnLWNvbmZpZyBtb2R1bGVzIHVz
ZWQKK3RvIGJ1aWxkIHRoZSBwYWNrYWdlLjwvcGFyYT48L2xpc3RpdGVtPgor
PGxpc3RpdGVtPjxwYXJhPlByb2dyYW1zIHdoaWNoIGluY2x1ZGUgdGhlaXIg
b3duIGxvYWRhYmxlIG1vZHVsZXMgKHBsdWdpbnMpCitvZnRlbiBtdXN0IGhh
dmUgaXRzIG1vZHVsZXMgbGlua2VkIGFnYWluc3QgdGhlIHN5bWJvbHMgaW4g
dGhlIHByb2dyYW0uICBUaGUKK21vc3QgcG9ydGFibGUgc29sdXRpb24gaXMg
Zm9yIHN1Y2ggcHJvZ3JhbXMgdG8gcHJvdmlkZSBhbGwgaXRzIHN5bWJvbHMg
KGV4Y2VwdAorZm9yIDxsaXRlcmFsPm1haW4oKTwvbGl0ZXJhbD4pIGluIGEg
c2hhcmVkIGxpYnJhcnksIGFnYWluc3Qgd2hpY2ggdGhlIHBsdWdpbnMKK2Nh
biBiZSBsaW5rZWQuPC9wYXJhPgorPHBhcmE+SWYgdGhlIHBhY2thZ2UgdXNl
cyB0aGUgQ01ha2UgYnVpbGQgc3lzdGVtLCB0aGlzIGNhbiBiZSBkb25lIGJ5
IGFkZGluZworPGxpdGVyYWw+RU5BQkxFX0VYUE9SVFMgVFJVRTwvbGl0ZXJh
bD4gdG8gdGhlIHByb2dyYW0ncyA8bGl0ZXJhbD5zZXRfdGFyZ2V0X3Byb3Bl
cnRpZXM8L2xpdGVyYWw+Citjb21tYW5kLCB0aGVuIGFkZGluZyB0aGUgcHJv
Z3JhbSdzIHRhcmdldCBuYW1lIHRvIHRoZSA8bGl0ZXJhbD50YXJnZXRfbGlu
a19saWJyYXJpZXM8L2xpdGVyYWw+Citjb21tYW5kIGZvciB0aGUgcGx1Z2lu
cy48L3BhcmE+Cis8cGFyYT5Gb3Igb3RoZXIgYnVpbGQgc3lzdGVtcywgdGhl
IGZvbGxvd2luZyBzdGVwcyBhcmUgcmVxdWlyZWQ6PC9wYXJhPgorPG9yZGVy
ZWRsaXN0PgorPGxpc3RpdGVtPjxwYXJhPlRoZSBwcm9ncmFtIG11c3QgYmUg
YnVpbHQgYmVmb3JlIGl0cyBwbHVnaW5zLjwvcGFyYT48L2xpc3RpdGVtPgor
PGxpc3RpdGVtPjxwYXJhPlN5bWJvbHMgbXVzdCBiZSBleHBvcnRlZCBmcm9t
IHRoZSBwcm9ncmFtIHdpdGggYQorPGxpdGVyYWw+LVdsLC0tZXhwb3J0LWFs
bC1zeW1ib2xzLC0tb3V0LWltcGxpYixsaWJmb28uZXhlLmE8L2xpdGVyYWw+
CitsaW5rZXIgZmxhZy48L3BhcmE+PC9saXN0aXRlbT4KKzxsaXN0aXRlbT48
cGFyYT5UaGUgcGx1Z2lucyBtdXN0IGJlIGxpbmtlZCB3aXRoIGEgPGxpdGVy
YWw+LVdsLC9wYXRoL3RvL2xpYmZvby5leGUuYTwvbGl0ZXJhbD4KK2xpbmtl
ciBmbGFnLjwvcGFyYT48L2xpc3RpdGVtPgorPC9vcmRlcmVkbGlzdD48L2xp
c3RpdGVtPjwvb3JkZXJlZGxpc3Q+CiA8L2Fuc3dlcj48L3FhbmRhZW50cnk+
CiAKIDxxYW5kYWVudHJ5IGlkPSJmYXEucHJvZ3JhbW1pbmcuZGpncHAiPgo=

--------------050806030505060403080602--
