Return-Path: <cygwin-patches-return-2047-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 29548 invoked by alias); 10 Apr 2002 10:06:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29499 invoked from network); 10 Apr 2002 10:06:46 -0000
Date: Wed, 10 Apr 2002 03:06:00 -0000
From: Pavel Tsekov <ptsekov@syntrex.com>
Reply-To: Pavel Tsekov <cygwin@cygwin.com>
Organization: Syntrex, Inc.
X-Priority: 3 (Normal)
Message-ID: <08165371.20020410120613@syntrex.com>
To: cygwin@cygwin.com
CC: rjlpub@kc.rr.com, cygwin-patches@cygwin.com
Subject: Re[2]: Cygwin 1.3.10 Setup.exe 2.194.2.22 Install Problems With MSVCRT.DLL and source code on Win98
In-Reply-To: <1921297856.20020410101146@syntrex.com>
References: <000401c1e033$e5bce3c0$0301a8c0@kc.rr.com>
 <1921297856.20020410101146@syntrex.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----------321D8C7338E6328"
X-SW-Source: 2002-q2/txt/msg00031.txt.bz2

------------321D8C7338E6328
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 974

Hello, there! :)

Wednesday, April 10, 2002, 10:11:46 AM, you wrote:

Ok, found it - its canonicalize_version() in version.cc. There is
a pointer 'v' which is modified and then delete[]'d.

A trivial patch is attached :)

2002-04-10  Pavel Tsekov  <ptsekov@gmx.net>

            * version.cc (canonicalize_version): Fix a call delete[]
            to delete.


PT> Wednesday, April 10, 2002, 4:03:24 AM, you wrote:

rkrc>> Two major problems (summary):

rkrc>> 1. Setup.exe (2.194.2.22) ends with a invalid page fault against MSVCRT.DLL
rkrc>> (details below) on my Windows 98 machine, before complely fininshing the
rkrc>> install.

PT> I have not investigated this yet - but from what I see the crash is
PT> similiar to one reported earlier to the ml. The address at which the
PT> crash occurs is inside the code of a helper function for
PT> free() and realloc().

PT> I'll look into this maybe this night.

PT> P.S. Thanks for the very good description of your problem :)
------------321D8C7338E6328
Content-Type: application/octet-stream; name="version.cc.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="version.cc.diff"
Content-length: 578

LS0tIHZlcnNpb24uY2MJTW9uIEZlYiAxOCAyMzoxNTowMiAyMDAyCisrKyB2
ZXJzaW9uLmNjLmZpeGVkCVdlZCBBcHIgMTAgMTA6MDA6MjMgMjAwMgpAQCAt
MzIsNiArMzIsNyBAQCBTdHJpbmcgCiBjYW5vbmljYWxpemVfdmVyc2lvbiAo
U3RyaW5nIGNvbnN0ICZhU3RyaW5nKQogewogICBjaGFyICp2ID1hU3RyaW5n
LmNzdHIoKTsKKyAgY2hhciAqdnNhdmUgPSB2OwogICBzdGF0aWMgY2hhciBu
dlszXVsxMDBdOwogICBzdGF0aWMgaW50IGlkeCA9IDA7CiAgIGNoYXIgKm5w
OwpAQCAtNTUsNiArNTYsNiBAQCBjYW5vbmljYWxpemVfdmVyc2lvbiAoU3Ry
aW5nIGNvbnN0ICZhU3RyCiAJKm5wKysgPSAqdisrOwogICAgIH0KICAgKm5w
KysgPSAwOwotICBkZWxldGVbXSB2OworICBkZWxldGVbXSB2c2F2ZTsKICAg
cmV0dXJuIG52W2lkeF07CiB9Cg==

------------321D8C7338E6328--
