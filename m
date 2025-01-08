Return-Path: <SRS0=4R3z=UA=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 4DD1D3858D28
	for <cygwin-patches@cygwin.com>; Wed,  8 Jan 2025 10:39:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4DD1D3858D28
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4DD1D3858D28
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736332769; cv=none;
	b=m5wZkRzvs0Rpjf2NzpD6X1k61Iid8rQM9RWtjATR7TrSvJg8LdTRVLibqdckJQwCHdJVr5IyBGROfqzAvoPfYPqeU/CcxvKdP4g4JIdjdithF4ly7Z0zgNtsRwUq5ZUWTMqcWVG2IIoR/rdwrdfaB1bl3UUIY+gf7JDm+VT7R84=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736332769; c=relaxed/simple;
	bh=gIhcJjeMen6Ht2G3eCI2BVj5zShHU+snF0dhSBkEofc=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=ls5UHtEeBaqgl0lPafYvjqLfkD57yoe6fH9IBdG+bW/pGA+EjMLT0Gs8Ry/43p3gGxEX6OBOe791evkRj4ME9Ireh+022Wepuwhd3EeDSSTcnzTRWJ59nya4HigKVyjan16bw0hTcKOgBc44maWpn/XVLQRCpbpFHI8E5dnYhjM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4DD1D3858D28
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=A+jWZPas
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20250108103926143.WOAR.55939.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 8 Jan 2025 19:39:26 +0900
Date: Wed, 8 Jan 2025 19:39:25 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: access: Fix X_OK behaviour for administrator
Message-Id: <20250108193925.b484833e85c61435b67333d5@nifty.ne.jp>
In-Reply-To: <20250108061424.066e0e3bc0c911b3b4c3bc97@nifty.ne.jp>
References: <20241226123410.126087-1-takashi.yano@nifty.ne.jp>
	<Z31a-_lO1hs4yc5I@calimero.vinschen.de>
	<20250108061424.066e0e3bc0c911b3b4c3bc97@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__8_Jan_2025_19_39_25_+0900_47=UkyeODX00bka5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1736332766;
 bh=nUaCNSUrCDISYtvyLZlusWLP9SogfWkSywrswWYMzbc=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=A+jWZPas8mTJD/i8vFxglyhpPnDKYOPskKzVfWoGVkYxJITpPxyretU+BzG2cbI+1VBz33X9
 FHZs++yG0v5bxGtzsazEzdczBJRUG+qAShj0/FaVUQyS82OQIrIwSxkNXW0wJPbv/ouCYqf1LM
 j60uRapeOHOFAxuAvRVbNDks/HfH8drt7UBvVSq6biIRyGrGTSF69BbqTo5XfY274xW+B9va3f
 rmhRUV5oEUFye0+/avRWviw7wdWGlQj3fCeEvDxf18gtLwpDll8nG1mD3Vs/7+AtxqwXqZCnvj
 Mnv86U1KLvRi+TBTemowj766Pc9vSo4ODwPlaydW9+tqVKMg==
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.

--Multipart=_Wed__8_Jan_2025_19_39_25_+0900_47=UkyeODX00bka5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Jan 2025 06:14:24 +0900
Takashi Yano wrote:
> Hi Corinna,
> 
> On Tue, 7 Jan 2025 17:48:59 +0100
> Corinna Vinschen wrote:
> > Hi Takashi,
> > 
> > Happy New Year!
> > 
> > On Dec 26 21:34, Takashi Yano wrote:
> > > @@ -613,6 +613,22 @@ check_file_access (path_conv &pc, int flags, bool effective)
> > >    if (flags & X_OK)
> > >      desired |= FILE_EXECUTE;
> > >  
> > > +  /* The Administrator has full access permission regardless of ACL,
> > > +     however, access() should return -1 if 'x' permission is set
> > > +     for neither user, group nor others, even though NtOpenFile()
> > > +     succeeds. */
> > 
> > The explanation isn't quite right, see below.
> > 
> > > +  if ((flags & X_OK) && !pc.isdir ())
> > > +    {
> > > +      struct stat st;
> > > +      if (stat (pc.get_posix (), &st))
> > > +	goto out;
> > > +      else if ((st.st_mode & (S_IXUSR | S_IXGRP | S_IXOTH)) == 0)
> > > +	{
> > > +	  set_errno (EACCES);
> > > +	  goto out;
> > > +	}
> > > +    }
> > > +
> > 
> > Calling stat here is not the right thing to do.  It slows down access()
> > as well as exec'ing applications a lot because it adds the overhead of a
> > full system call on each invocation.
> > 
> > When I saw your patch this morning for the first time, I was inclined to
> > request that you simply revert a0933cd17d19 ("Correction for samba/SMB
> > share").  The behaviour on Samba was not a regression, but this here
> > is, so it would be prudent to rethink the entire approach.
> > 
> > However, it occured to me that there may be a simpler way to fix this:
> > 
> > The reason for this behaviour is the way SE_BACKUP_PRIVILEGE works.  To
> > allow a user with backup privileges full access to files, you have to
> > enable the SE_BACKUP_PRIVILEGE in the user's token *and* you have to
> > open files with FILE_OPEN_FOR_BACKUP_INTENT.  The problem now is this:
> > SE_BACKUP_PRIVILEGE + FILE_OPEN_FOR_BACKUP_INTENT allow to open the
> > file, no matter what.  In particular, they allow to open the file for
> > FILE_EXECUTE, even if the execute perms in the ACL deny the user
> > execution of the file.
> > 
> > So... given how this is supposed to work, we must not use the
> > FILE_OPEN_FOR_BACKUP_INTENT flag when checking for execute permissions
> > and the result should be the desired one.  I tested this locally, and I
> > don't see a regression compared to 3.5.4.
> > 
> > Patch attached.  Please review.
> 
> Thanks for reviewing and the counter patch.
> 
> With your patch, access(_, X_OK) returns -1 for a directory without 'x'
> permission even with Administrator.
> This seems due to lack of FILE_OPEN_FOR_BACKUP_INTENT.
> 
> How about simpler patch attached?

Revised a bit.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Wed__8_Jan_2025_19_39_25_+0900_47=UkyeODX00bka5
Content-Type: text/plain;
 name="v3-0001-Cygwin-access-Fix-X_OK-behaviour-for-backup-opera.patch"
Content-Disposition: attachment;
 filename="v3-0001-Cygwin-access-Fix-X_OK-behaviour-for-backup-opera.patch"
Content-Transfer-Encoding: base64

RnJvbSAxNWJlZDM5MDkzYWNkMjBiNzExNGZjNzA2ZjQ1NWM1YzQwZTAwYzI5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogQ29yaW5uYSBWaW5zY2hlbiA8Y29yaW5uYUB2aW5zY2hlbi5k
ZT4NCkRhdGU6IFR1ZSwgNyBKYW4gMjAyNSAxNzo0NDo0NCArMDEwMA0KU3ViamVjdDogW1BBVENI
IHYzXSBDeWd3aW46IGFjY2VzczogRml4IFhfT0sgYmVoYXZpb3VyIGZvciBiYWNrdXAgb3BlcmF0
b3JzDQogYW5kIGFkbWlucw0KDQpBZnRlciBjb21taXQgYTA5MzNjZDE3ZDE5LCBhY2Nlc3MoXywg
WF9PSykgcmV0dXJucyAwIGlmIHRoZSB1c2VyDQpob2xkcyBTRV9CQUNLVVBfUFJJVklMRUdFLCBl
dmVuIGlmIHRoZSBmaWxlJ3MgQUNMIGRlbmllcyBleGVjdXRpb24NCnRvIHRoZSB1c2VyLiAgVGhp
cyBpcyB0cmlnZ2VyZWQgYnkgdHJ5aW5nIHRvIG9wZW4gdGhlIGZpbGUgd2l0aA0KRklMRV9PUEVO
X0ZPUl9CQUNLVVBfSU5URU5ULg0KDQpGaXggY2hlY2tfZmlsZV9hY2Nlc3MoKSBzbyBpdCBjaGVj
a3MgZm9yIFhfT0sgd2l0aG91dCBzcGVjaWZ5aW5nDQp0aGUgRklMRV9PUEVOX0ZPUl9CQUNLVVBf
SU5URU5UIGZsYWcgaWYgdGhlIGZpbGUgaXMgbm90IGEgZGlyZWN0b3J5Lg0KDQpSZWFycmFuZ2Ug
ZnVuY3Rpb24gc2xpZ2h0bHkgYW5kIGFkZCBjb21tZW50cyBmb3IgZWFzaWVyIGNvbXByZWhlbnNp
b24uDQoNCkZpeGVzOiBhMDkzM2NkMTdkMTkgKCJDeWd3aW46IGFjY2VzczogQ29ycmVjdGlvbiBm
b3Igc2FtYmEvU01CIHNoYXJlIikNClJlcG9ydGVkLWJ5OiBCcnVubyBIYWlibGUgPGJydW5vQGNs
aXNwLm9yZz4NClNpZ25lZC1vZmYtYnk6IENvcmlubmEgVmluc2NoZW4gPGNvcmlubmFAdmluc2No
ZW4uZGU+DQotLS0NCiB3aW5zdXAvY3lnd2luL3NlYy9iYXNlLmNjIHwgMjggKysrKysrKysrKysr
KysrKysrKysrLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCA3IGRl
bGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9zZWMvYmFzZS5jYyBiL3dp
bnN1cC9jeWd3aW4vc2VjL2Jhc2UuY2MNCmluZGV4IDY0N2MyN2VjNi4uOWYxNTI3YjdiIDEwMDY0
NA0KLS0tIGEvd2luc3VwL2N5Z3dpbi9zZWMvYmFzZS5jYw0KKysrIGIvd2luc3VwL2N5Z3dpbi9z
ZWMvYmFzZS5jYw0KQEAgLTYwNCw4ICs2MDQsMTQgQEAgY2hlY2tfYWNjZXNzIChzZWN1cml0eV9k
ZXNjcmlwdG9yICZzZCwgR0VORVJJQ19NQVBQSU5HICZtYXBwaW5nLA0KIGludA0KIGNoZWNrX2Zp
bGVfYWNjZXNzIChwYXRoX2NvbnYgJnBjLCBpbnQgZmxhZ3MsIGJvb2wgZWZmZWN0aXZlKQ0KIHsN
Ci0gIGludCByZXQgPSAtMTsNCisgIE5UU1RBVFVTIHN0YXR1czsNCiAgIEFDQ0VTU19NQVNLIGRl
c2lyZWQgPSAwOw0KKyAgVUxPTkcgb3B0cyA9IDA7DQorICBPQkpFQ1RfQVRUUklCVVRFUyBhdHRy
Ow0KKyAgSU9fU1RBVFVTX0JMT0NLIGlvOw0KKyAgSEFORExFIGggPSBOVUxMOw0KKyAgaW50IHJl
dCA9IC0xOw0KKw0KICAgaWYgKGZsYWdzICYgUl9PSykNCiAgICAgZGVzaXJlZCB8PSBGSUxFX1JF
QURfREFUQTsNCiAgIGlmIChmbGFncyAmIFdfT0spDQpAQCAtNjE2LDEzICs2MjIsMjEgQEAgY2hl
Y2tfZmlsZV9hY2Nlc3MgKHBhdGhfY29udiAmcGMsIGludCBmbGFncywgYm9vbCBlZmZlY3RpdmUp
DQogICBpZiAoIWVmZmVjdGl2ZSkNCiAgICAgY3lnaGVhcC0+dXNlci5kZWltcGVyc29uYXRlICgp
Ow0KIA0KLSAgT0JKRUNUX0FUVFJJQlVURVMgYXR0cjsNCiAgIHBjLmluaXRfcmVvcGVuX2F0dHIg
KGF0dHIsIHBjLmhhbmRsZSAoKSk7DQotICBOVFNUQVRVUyBzdGF0dXM7DQotICBJT19TVEFUVVNf
QkxPQ0sgaW87DQotICBIQU5ETEUgaDsNCi0gIHN0YXR1cyA9IE50T3BlbkZpbGUgKCZoLCBkZXNp
cmVkLCAmYXR0ciwgJmlvLCBGSUxFX1NIQVJFX1ZBTElEX0ZMQUdTLA0KLQkJICAgICAgIEZJTEVf
T1BFTl9GT1JfQkFDS1VQX0lOVEVOVCk7DQorDQorICAvKiBGb3IgUl9PSyBhbmQgV19PSyB3ZSBj
aGVjayB3aXRoIEZJTEVfT1BFTl9GT1JfQkFDS1VQX0lOVEVOVCBzaW5jZQ0KKyAgICAgd2Ugd2Fu
dCB0byBlbmFibGUgdGhlIGZ1bGwgcG93ZXIgb2YgYmFja3VwL3Jlc3RvcmUgcHJpdmlsZWdlcy4N
CisgICAgIEZvciBYX09LLCBkcm9wIHRoZSBGSUxFX09QRU5fRk9SX0JBQ0tVUF9JTlRFTlQgZmxh
Zy4gIElmIHRoZSBjYWxsZXINCisgICAgIGhvbGRzIFNFX0JBQ0tVUF9QUklWSUxFR0UsIEZJTEVf
T1BFTl9GT1JfQkFDS1VQX0lOVEVOVCBvcGVucyB0aGUgZmlsZSwNCisgICAgIG5vIG1hdHRlciB3
aGF0IGFjY2VzcyBpcyByZXF1ZXN0ZWQuDQorICAgICBGb3IgZGlyZWN0b3JpZXMsIEZJTEVfT1BF
Tl9GT1JfQkFDS1VQX0lOVEVOVCBmbGFnIGlzIGFsd2F5cyBzZXQNCisgICAgIHJlZ2FyZGxlc3Mg
b2YgWF9PSy4gKi8NCisgIGlmICghKGZsYWdzICYgWF9PSykgfHwgcGMuaXNkaXIgKCkpDQorICAg
IG9wdHMgfD0gRklMRV9PUEVOX0ZPUl9CQUNLVVBfSU5URU5UOw0KKyAgZWxzZSAvKiBGb3IgYSBy
ZWd1bGFyIGZpbGUgdG8gYmUgZXhlY3V0YWJsZSwgaXQgbXVzdCBhbHNvIGJlIHJlYWRhYmxlLiAq
Lw0KKyAgICBkZXNpcmVkIHw9IEZJTEVfUkVBRF9EQVRBOw0KKw0KKyAgc3RhdHVzID0gTnRPcGVu
RmlsZSAoJmgsIGRlc2lyZWQsICZhdHRyLCAmaW8sIEZJTEVfU0hBUkVfVkFMSURfRkxBR1MsIG9w
dHMpOw0KICAgaWYgKE5UX1NVQ0NFU1MgKHN0YXR1cykpDQogICAgIHsNCiAgICAgICBOdENsb3Nl
IChoKTsNCi0tIA0KMi40NS4xDQoNCg==

--Multipart=_Wed__8_Jan_2025_19_39_25_+0900_47=UkyeODX00bka5--
