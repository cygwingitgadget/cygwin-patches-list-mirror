Return-Path: <cygwin-patches-return-5375-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6651 invoked by alias); 10 Mar 2005 10:45:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5309 invoked from network); 10 Mar 2005 10:43:40 -0000
Received: from unknown (HELO mail.gmx.net) (213.165.64.20)
  by sourceware.org with SMTP; 10 Mar 2005 10:43:40 -0000
Received: (qmail invoked by alias); 10 Mar 2005 10:43:38 -0000
Received: from unknown (EHLO mordor) (213.91.247.38)
  by mail.gmx.net (mp014) with SMTP; 10 Mar 2005 11:43:38 +0100
X-Authenticated: #14308112
Date: Thu, 10 Mar 2005 10:45:00 -0000
From: Pavel Tsekov <ptsekov@gmx.net>
X-X-Sender: ptsekov@mordor
To: cygwin-patches@cygwin.com
Subject: [PATCH]: autoload.cc: Remove unnecessary data entries from .dllname_info
 sections
Message-ID: <Pine.CYG.4.58.0503101212001.1188@mordor>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-533232094-1110451309=:1188"
Content-ID: <Pine.CYG.4.58.0503101242410.1168@mordor>
X-Y-GMX-Trusted: 0
X-SW-Source: 2005-q1/txt/msg00078.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-533232094-1110451309=:1188
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.CYG.4.58.0503101242411.1168@mordor>
Content-length: 3639

Hello,

I've been looking at the contents of the cygwin1.dll image in the last
few days and I've noticed that the sections named .dllname_info contain
a lot of duplicate entries - one for each autoloaded function from a given
dll. Although it doesn't hurt to have it, this information is not really
neccassary for the autoload functionality - autoload only needs one entry
per dll in .dllname_info. Another point to consider here is that for dlls
that use an auxillary initialization routine (ws2_32 and wsock32)
currently you have one entry (the one that is used) with the address
of the right auxillary initialization routine  and many entries with the
default auxillary initialization routine . This is due to the following
usage:

LoadDLLprime (wsock32, _wsock_init)

[...]

LoadDLLfunc (WSAAsyncSelect, 16, wsock32)

Of course this could be corrected by extending the LoadDLLfunc* macros to
support passing of an auxillary routine or it could be simply ignored
since it doesn't harm :)

Since the current scheme works ok I don't have much arguments for my
patch. IMHO, first it does the right thing  and  second it saves some
memory. I cannot know the thoughts of the original implementor of
autoload.cc but maybe it intended to fix this duplication with the
.linkonce directive of gas or maybe he was willing to pay the prize of
the duplicate entries. However from what I understand .linkonce works only
for sections defined in different object files.

I am including the output of `objdump -h new-cygwin1.dll' with original
and patched autoload.cc.

Original autoload.cc:

new-cygwin1.dll:     file format pei-i386

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
[...]
  2 .ws2_32_info  00000144  610d1000  610d1000  000cf600  2**2

  3 .wsock32_info 00000378  610d2000  610d2000  000cf800  2**2

  4 .advapi32_info 000006c0  610d3000  610d3000  000cfc00  2**2

  6 .netapi32_info 000000b0  610d5000  610d5000  000d1000  2**2

  8 .ntdll_info   00000160  610d7000  610d7000  000d1400  2**2

 10 .psapi_info   00000070  610d9000  610d9000  000d1a00  2**2

 12 .secur32_info 00000078  610db000  610db000  000d1e00  2**2

 14 .user32_info  00000310  610dd000  610dd000  000d2200  2**2

 18 .iphlpapi_info 00000064  610e1000  610e1000  000d3400  2**2

 20 .ole32_info   00000018  610e3000  610e3000  000d3800  2**2

 22 .kernel32_info 000001f4  610e5000  610e5000  000d3c00  2**2

 24 .shell32_info 00000018  610e7000  610e7000  000d4200  2**2

 26 .winmm_info   000001d0  610e9000  610e9000  000d4600  2**2

 28 .rpcrt4_info  00000030  610eb000  610eb000  000d4c00  2**2


Patched autoload.cc:

new-cygwin1.dll:     file format pei-i386

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  2 .ws2_32_info  00000018  610d1000  610d1000  000cf600  2**2

  3 .wsock32_info 00000018  610d2000  610d2000  000cf800  2**2

  4 .advapi32_info 0000001c  610d3000  610d3000  000cfa00  2**2

  5 .netapi32_info 0000001c  610d4000  610d4000  000cfc00  2**2

  6 .ntdll_info   00000018  610d5000  610d5000  000cfe00  2**2

  7 .psapi_info   00000018  610d6000  610d6000  000d0000  2**2

  8 .secur32_info 00000018  610d7000  610d7000  000d0200  2**2

  9 .user32_info  00000018  610d8000  610d8000  000d0400  2**2

 10 .iphlpapi_info 0000001c  610d9000  610d9000  000d0600  2**2

 11 .ole32_info   00000018  610da000  610da000  000d0800  2**2

 12 .kernel32_info 0000001c  610db000  610db000  000d0a00  2**2

 13 .shell32_info 00000018  610dc000  610dc000  000d0c00  2**2

 14 .winmm_info   00000018  610dd000  610dd000  000d0e00  2**2

 15 .rpcrt4_info  00000018  610de000  610de000  000d1000  2**2
---559023410-533232094-1110451309=:1188
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="autoload.cc.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.CYG.4.58.0503101241490.1188@mordor>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="autoload.cc.patch"
Content-length: 1696

SW5kZXg6IGF1dG9sb2FkLmNjDQo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpS
Q1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3aW4vYXV0b2xvYWQu
Y2Msdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjk1DQpkaWZmIC11IC1wIC1y
MS45NSBhdXRvbG9hZC5jYw0KLS0tIGF1dG9sb2FkLmNjCTMgTWFyIDIwMDUg
MTU6MTI6NTAgLTAwMDAJMS45NQ0KKysrIGF1dG9sb2FkLmNjCTEwIE1hciAy
MDA1IDEwOjEyOjQxIC0wMDAwDQpAQCAtNzYsNyArNzYsNiBAQCBkZXRhaWxz
LiAqLw0KIA0KIC8qIE1haW4gRExMIHNldHVwIHN0dWZmLiAqLw0KICNkZWZp
bmUgTG9hZERMTGZ1bmNFeDIobmFtZSwgbiwgZGxsbmFtZSwgbm90aW1wLCBl
cnIpIFwNCi0gIExvYWRETExwcmltZSAoZGxsbmFtZSwgZGxsX2Z1bmNfbG9h
ZCkJCQlcDQogICBfX2FzbV9fICgiCQkJCQkJXG5cDQogICAuc2VjdGlvbgku
IiAjZGxsbmFtZSAiX3RleHQsXCJ3eFwiCQlcblwNCiAgIC5nbG9iYWwJXyIg
bWFuZ2xlIChuYW1lLCBuKSAiCQkJXG5cDQpAQCAtMjk5LDYgKzI5OCwxOCBA
QCB3c29ja19pbml0ICgpDQogDQogTG9hZERMTHByaW1lICh3c29jazMyLCBf
d3NvY2tfaW5pdCkNCiBMb2FkRExMcHJpbWUgKHdzMl8zMiwgX3dzb2NrX2lu
aXQpDQorTG9hZERMTHByaW1lIChhZHZhcGkzMiwgZGxsX2Z1bmNfbG9hZCkN
CitMb2FkRExMcHJpbWUgKG5ldGFwaTMyLCBkbGxfZnVuY19sb2FkKQ0KK0xv
YWRETExwcmltZSAobnRkbGwsIGRsbF9mdW5jX2xvYWQpDQorTG9hZERMTHBy
aW1lIChwc2FwaSwgZGxsX2Z1bmNfbG9hZCkNCitMb2FkRExMcHJpbWUgKHNl
Y3VyMzIsIGRsbF9mdW5jX2xvYWQpDQorTG9hZERMTHByaW1lICh1c2VyMzIs
IGRsbF9mdW5jX2xvYWQpDQorTG9hZERMTHByaW1lIChpcGhscGFwaSwgZGxs
X2Z1bmNfbG9hZCkNCitMb2FkRExMcHJpbWUgKG9sZTMyLCBkbGxfZnVuY19s
b2FkKQ0KK0xvYWRETExwcmltZSAoa2VybmVsMzIsIGRsbF9mdW5jX2xvYWQp
DQorTG9hZERMTHByaW1lIChzaGVsbDMyLCBkbGxfZnVuY19sb2FkKQ0KK0xv
YWRETExwcmltZSAod2lubW0sIGRsbF9mdW5jX2xvYWQpDQorTG9hZERMTHBy
aW1lIChycGNydDQsIGRsbF9mdW5jX2xvYWQpDQogDQogTG9hZERMTGZ1bmMg
KEFjY2Vzc0NoZWNrLCAzMiwgYWR2YXBpMzIpDQogTG9hZERMTGZ1bmMgKEFk
ZEFjY2Vzc0FsbG93ZWRBY2UsIDE2LCBhZHZhcGkzMikNCg==

---559023410-533232094-1110451309=:1188--
