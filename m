Return-Path: <cygwin-patches-return-6404-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1335 invoked by alias); 18 Jan 2009 00:52:25 -0000
Received: (qmail 1320 invoked by uid 22791); 18 Jan 2009 00:52:24 -0000
X-SWARE-Spam-Status: No, hits=-1.2 required=5.0 	tests=AWL,BAYES_00,J_CHICKENPOX_92,SARE_MSGID_LONG40,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from nf-out-0910.google.com (HELO nf-out-0910.google.com) (64.233.182.184)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 18 Jan 2009 00:52:17 +0000
Received: by nf-out-0910.google.com with SMTP id b11so319476nfh.18         for <cygwin-patches@cygwin.com>; Sat, 17 Jan 2009 16:52:14 -0800 (PST)
Received: by 10.210.35.17 with SMTP id i17mr5198180ebi.165.1232239934196;         Sat, 17 Jan 2009 16:52:14 -0800 (PST)
Received: by 10.210.81.20 with HTTP; Sat, 17 Jan 2009 16:52:14 -0800 (PST)
Message-ID: <2ca21dcc0901171652s44c72ca7teb1ca6041344e4a4@mail.gmail.com>
Date: Sun, 18 Jan 2009 00:52:00 -0000
From: "Dave Korn" <dave.korn.cygwin@googlemail.com>
To: gcc-patches@gcc.gnu.org, binutils@sourceware.org, gdb-patches@sourceware.org,  	cygwin-patches@cygwin.com
Subject: [PATCH/libiberty] Fix PR38903 Cygwin GCC bootstrap failure [was Re: Libiberty issue vs cygwin [was Re: This is a Cygwin failure yeah?]]
Cc: kirkshorts@googlemail.com, "DJ Delorie" <dj@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;  	boundary="----=_Part_4196_20370896.1232239934190"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2009-q1/txt/msg00002.txt.bz2


------=_Part_4196_20370896.1232239934190
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Content-length: 1402

DJ Delorie wrote:
> IIRC, that whole clause was because cygwin's dll itself linked with
> libiberty, so the auto-detect stuff needed an override to make sure
> the right files were there when you build cygwin1.dll.  Otherwise, it
> would detect that cygwin had strsignal, not build it, then fail later
> when cygwin1.dll couldn't find strsignal.
>
> If cygwin no longer links with libiberty, that whole clause can
> probably go away now.  As it's target-specific, I'm OK with letting
> the target maintainers have the last word about it, too.

  There are no longer any references to ../libiberty/* in Cygwin's Makefile,
and indeed the libiberty subdir has been removed from the module definition
for winsup so you don't even get it in a fresh checkout any more.

  Given that, I think we can remove the clause entirely.  I've tested this by
doing (separate) native builds of GCC, winsup, binutils and GDB, with no
issues arising.  I haven't tried cross-builds or combined source-tree builds,
but there's no reason to believe they would be affected any differently.

  GCC is in stage 4, but this is target-specific and fixes a bootstrap
failure on a secondary platform.

  Ok for HEAD of both gcc/ and src/ ?

libiberty/ChangeLog

	* configure.ac (funcs, vars, checkfuncs):  Don't munge on Cygwin,
	as it no longer shares libiberty object files.
	* configure:  Regenerated.

     cheers,
       DaveK

------=_Part_4196_20370896.1232239934190
Content-Type: application/octet-stream;
 name=libiberty-cyghack-removal-patch.diff
Content-Transfer-Encoding: base64
X-Attachment-Id: file0
Content-Disposition: attachment;
 filename=libiberty-cyghack-removal-patch.diff
Content-length: 1757

SW5kZXg6IGxpYmliZXJ0eS9jb25maWd1cmUuYWMKPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQotLS0gbGliaWJlcnR5L2NvbmZpZ3VyZS5hYwkocmV2aXNpb24g
MTQzNDcxKQorKysgbGliaWJlcnR5L2NvbmZpZ3VyZS5hYwkod29ya2luZyBj
b3B5KQpAQCAtNTcxLDI5ICs1NzEsNiBAQCBpZiB0ZXN0IC16ICIke3NldG9i
anN9IjsgdGhlbgogCiAgIGNhc2UgIiR7aG9zdH0iIGluCiAKLSAgKi0qLWN5
Z3dpbiopCi0gICAgIyBUaGUgQ3lnd2luIGxpYnJhcnkgYWN0dWFsbHkgdXNl
cyBhIGNvdXBsZSBvZiBmaWxlcyBmcm9tCi0gICAgIyBsaWJpYmVydHkgd2hl
biBpdCBpcyBidWlsdC4gIElmIHdlIGFyZSBidWlsZGluZyBhIG5hdGl2ZQot
ICAgICMgQ3lnd2luLCBhbmQgd2UgcnVuIHRoZSB0ZXN0cywgd2Ugd2lsbCBh
cHBlYXIgdG8gaGF2ZSB0aGVzZQotICAgICMgZmlsZXMuICBIb3dldmVyLCB3
aGVuIHdlIGdvIG9uIHRvIGJ1aWxkIHdpbnN1cCwgd2Ugd2lsbCB3aW5kIHVw
Ci0gICAgIyB3aXRoIGEgbGlicmFyeSB3aGljaCBkb2VzIG5vdCBoYXZlIHRo
ZSBmaWxlcywgc2luY2UgdGhleSBzaG91bGQKLSAgICAjIGhhdmUgY29tZSBm
cm9tIGxpYmliZXJ0eS4KLQotICAgICMgV2UgaGFuZGxlIHRoaXMgYnkgcmVt
b3ZpbmcgdGhlIGZ1bmN0aW9ucyB0aGUgd2luc3VwIGxpYnJhcnkKLSAgICAj
IHByb3ZpZGVzIGZyb20gb3VyIHNoZWxsIHZhcmlhYmxlcywgc28gdGhhdCB0
aGV5IGFwcGVhciB0byBiZQotICAgICMgbWlzc2luZy4KLQotICAgICMgREog
LSBvbmx5IGlmIHdlJ3JlICpidWlsZGluZyogY3lnd2luLCBub3QganVzdCBi
dWlsZGluZyAqd2l0aCogY3lnd2luCi0gIAotICAgIGlmIHRlc3QgLW4gIiR7
d2l0aF90YXJnZXRfc3ViZGlyfSIKLSAgICB0aGVuCi0gICAgICBmdW5jcz0i
YGVjaG8gJGZ1bmNzIHwgc2VkIC1lICdzL3JhbmRvbS8vJ2AiCi0gICAgICBB
Q19MSUJPQkooW3JhbmRvbV0pCi0gICAgICB2YXJzPSJgZWNobyAkdmFycyB8
IHNlZCAtZSAncy9zeXNfc2lnbGlzdC8vJ2AiCi0gICAgICBjaGVja2Z1bmNz
PSJgZWNobyAkY2hlY2tmdW5jcyB8IHNlZCAtZSAncy9zdHJzaWduYWwvLycg
LWUgJ3MvcHNpZ25hbC8vJ2AiCi0gICAgZmkKLSAgICA7OwotCiAgICotKi1t
aW5ndzMyKikKICAgICAjIFVuZGVyIG1pbmd3MzIsIHN5c19uZXJyIGFuZCBz
eXNfZXJybGlzdCBleGlzdCwgYnV0IHRoZXkgYXJlCiAgICAgIyBtYWNyb3Ms
IHNvIHRoZSB0ZXN0IGJlbG93IHdvbid0IGZpbmQgdGhlbS4K

------=_Part_4196_20370896.1232239934190--
