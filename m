Return-Path: <cygwin-patches-return-6247-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6367 invoked by alias); 22 Feb 2008 01:01:52 -0000
Received: (qmail 6355 invoked by uid 22791); 22 Feb 2008 01:01:51 -0000
X-Spam-Check-By: sourceware.org
Received: from nf-out-0910.google.com (HELO nf-out-0910.google.com) (64.233.182.188)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 22 Feb 2008 01:01:24 +0000
Received: by nf-out-0910.google.com with SMTP id b2so195887nfb.18         for <cygwin-patches@cygwin.com>; Thu, 21 Feb 2008 17:01:22 -0800 (PST)
Received: by 10.142.188.4 with SMTP id l4mr8174331wff.183.1203642080534;         Thu, 21 Feb 2008 17:01:20 -0800 (PST)
Received: by 10.142.125.4 with HTTP; Thu, 21 Feb 2008 17:01:20 -0800 (PST)
Message-ID: <674fdff20802211701u1a866d2fw2bb21047ecc5e8ea@mail.gmail.com>
Date: Fri, 22 Feb 2008 01:01:00 -0000
From: "Noel Burton-Krahn" <noel@burton-krahn.com>
To: cygwin-patches@cygwin.com
Subject: PATCH: avoid system shared memory version mismatch detected by versioning shared memory name
In-Reply-To: <674fdff20802211641p19f7b3a1pb3f843ba262dfde6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;  	boundary="----=_Part_9940_16076408.1203642080519"
References: <674fdff20802211641p19f7b3a1pb3f843ba262dfde6@mail.gmail.com>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00021.txt.bz2


------=_Part_9940_16076408.1203642080519
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Content-length: 1500

This is a patch to avoid the "system shared memory version mismatch
detected" problem when two applications use different versions of
Cygwin.  My solution is to append the Cygwin version number to the
name of the shared memory segment, so only Cygwin with the same
version share a memory space.

ChangeLog
2008-02-21  Noel Burton-Krahn  <noel@burton-krahn.com>

    * shared.cc (shared_name): always add USER_VERSION_MAGIC to the
    shared memory space name so multiple versions of Cygwin keep their
     own shared memory space.  No more "system shared memory version
    mismatch detected"  errors.



Here's how I tested it:

1. save the attached patch

cygwin-snapshot-20080219-1-versioned-shared-memory.patch

2. patch and build:

 wget http://cygwin.com/snapshots/cygwin-src-20080219.tar.bz2
tar jxf cygwin-src-20080219.tar.bz2
 cd cygwin-snapshot-20080219-1
patch -p1 < ../cygwin-snapshot-20080219-1-versioned-shared-memory.patch
 ./configure
make

3. replace cygwin1.dll with the new one

# the compiled cygwin1.dll will not conflict with other cygwins at
# other versions. You can copy it over the cygwin1.dll in one of your
# conflicting applications
  #
cp ./i686-pc-cygwin/winsup/cygwin/new-cygwin1.dll ./cygwin1.dll

It worked for me.  Let me know how it goes for you.

By the way, there's another gotcha here.  Cygwin keeps its mount
points in the registry, so your mount.bat script will overwrite
existing cygwin mount points.  To clean up I had to run the cygwin
setup again.

~Noel

------=_Part_9940_16076408.1203642080519
Content-Type: application/octet-stream;
 name=cygwin-snapshot-20080219-1-versioned-shared-memory.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fcxzyzho
Content-Disposition: attachment;
 filename=cygwin-snapshot-20080219-1-versioned-shared-memory.patch
Content-length: 1249

ZGlmZiAtdXIgY3lnd2luLXNuYXBzaG90LTIwMDgwMjE5LTEvd2luc3VwL2N5
Z3dpbi9zaGFyZWQuY2MgY3lnd2luLXNuYXBzaG90LTIwMDgwMjE5LTEtbm9l
bGJrL3dpbnN1cC9jeWd3aW4vc2hhcmVkLmNjCi0tLSBjeWd3aW4tc25hcHNo
b3QtMjAwODAyMTktMS93aW5zdXAvY3lnd2luL3NoYXJlZC5jYwkyMDA3LTEy
LTEzIDA0OjU1OjQxLjAwMDAwMDAwMCAtMDgwMAorKysgY3lnd2luLXNuYXBz
aG90LTIwMDgwMjE5LTEtbm9lbGJrL3dpbnN1cC9jeWd3aW4vc2hhcmVkLmNj
CTIwMDgtMDItMjEgMTY6MDY6MzMuMTU2MjUwMDAwIC0wODAwCkBAIC0zOSw4
ICszOSwxNSBAQAogewogICBleHRlcm4gYm9vbCBfY3lnd2luX3Rlc3Rpbmc7
CiAKLSAgX19zbWFsbF9zcHJpbnRmIChyZXRfYnVmLCAiJXMlcy4lcy4lZCIs
IGN5Z2hlYXAtPnNoYXJlZF9wcmVmaXgsCi0JCSAgIGN5Z3dpbl92ZXJzaW9u
LnNoYXJlZF9pZCwgc3RyLCBudW0pOworICAvLyBOb2VsIEJ1cnRvbi1LcmFo
biA8bm9lbEBidXJ0b24ta3JhaG4uY29tPiAtIEZlYiAyMSwgMjAwOCAKKyAg
Ly8gYWx3YXlzIGFkZCBVU0VSX1ZFUlNJT05fTUFHSUMgdG8gdGhlIHNoYXJl
ZCBtZW1vcnkgc3BhY2UgbmFtZSBzbworICAvLyBtdWx0aXBsZSB2ZXJzaW9u
cyBvZiBDeWd3aW4gYWxsIGhhdmUgdGhlaXIgb3duIG1lbW9yeSBzcGFjZS4K
KyAgX19zbWFsbF9zcHJpbnRmKHJldF9idWYsICIlcyVzLiVzLiVkLiVkIgor
CQkgICxjeWdoZWFwLT5zaGFyZWRfcHJlZml4CisJCSAgLGN5Z3dpbl92ZXJz
aW9uLnNoYXJlZF9pZCwgc3RyLCBudW0KKwkJICAsVVNFUl9WRVJTSU9OX01B
R0lDCisJCSAgKTsKKwogICBpZiAoX2N5Z3dpbl90ZXN0aW5nKQogICAgIHN0
cmNhdCAocmV0X2J1ZiwgY3lnd2luX3ZlcnNpb24uZGxsX2J1aWxkX2RhdGUp
OwogICByZXR1cm4gcmV0X2J1ZjsK

------=_Part_9940_16076408.1203642080519--
