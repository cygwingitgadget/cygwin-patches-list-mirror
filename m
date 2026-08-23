Return-Path: <SRS0=IzLV=GQ=gmail.com=dan.f.shelton@sourceware.org>
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by sourceware.org (Postfix) with ESMTPS id D35554BA2E21
	for <cygwin-patches@cygwin.com>; Sun, 23 Aug 2026 14:39:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D35554BA2E21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D35554BA2E21
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a00:1450:4864:20::535
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1787495948; cv=pass;
	b=IfvhbCNVLcj8TMHm+0zDDBsxZJ+RIEyN7jOr9bUlO05eg8UYmwbyJw+XJjQT+6WAnnZ82zb+EWZqbKC9rNUib72TSuZzCN2uXJ5G2Zg9jhinJJ/iqyumZyrmghGgK28MXAKsC6+ANWDryYb37iHHnyHXnx/hrWgSJCEjJ1YQ/54=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1787495948; c=relaxed/simple;
	bh=LOjAVtGv6NBcJCsogjb14NKeODjhEJq40ev0/xpGTNk=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=Uv3hvqCLpcOLiE96BjZLZ9QZfQXa3wnkTGn+J8Mb2umgG65RpZQ7+F2rbps7Fmny+hAfZ0cJDTEqUwNTgdkmGDtNMtEiSg2XAecT1B+gazMuvrh6ovH4aQU7ETbjEOSrhN6eI6WKGiGOE8+9eQCLmRKSK2fFT5NVyTpOZAOlenQ=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PA20MuEg
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D35554BA2E21
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PA20MuEg
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-6a051b737d8so3282807a12.1
        for <cygwin-patches@cygwin.com>; Sun, 23 Aug 2026 07:39:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787495946; cv=none;
        d=google.com; s=arc-20260327;
        b=kRQs+E+dloxzDjCq2nB3RpWLvNzHYRgtjursEjPd3u+lQe7T8dbGQsIOlL3gt/+d5S
         A/Ci2Bhs24as9/MoHYCvMsDuW2WEsbK/gC1gTO/AX65y7Ybml6RB2fkz3ruXGDhdBRJq
         xorOh9yHtrpYASH7Og/pewSQQzQvAH7kFwBm9pGWE5ZBHhsLydRDL02lKy2IIF69AC4v
         dvsYAwwbnRxxfeJFtRgVlFPwHfVtfjt/efWI5SRNH2SQxbYc1ZrnvMRO3MEUWxvA+GQC
         qC/X8kdkGItPRhc4rwTavuN/gTbVEW9OzygHYF6o4s0vSa6ooevGSRHGI/gem0laNeoN
         0/uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=0tRUKyXeKoBzY3cKdjHknhAaJemjeScNh1Z5IM4eopw=;
        fh=LDuCfoqTHLfBJJnUY9ekX7myLl4cc7+1mDvALRdt/Ts=;
        b=A/wjh2FuUs/KnztL4nlvuCT/RvtDa5jaN7YFBg4E806juXBZ2BPJR8EYii3M4M7WrH
         s9gKo9MDZ9jfgDmNg+/ABUHv8pWF2CEkigOZIZT58DENjW/x/wZtyXdhBaQwzIy39041
         1X8h/H85irFek8fANX79ax4Zz5xGGsT4lzJNhlrBywqg+Ddhe45xAytoOdiHdesf+s4L
         nr4GnqdwjQO78Q/AdiINBju+COt9OgSD4xpviAZw3oF4urMHSA2CJPX3h4zbOo1pUBMx
         CIRf00P/mLfiapedwUzQJs39dzMdJA/BSTYn21ltIXbmX1315ovsiJHENWY8GFKSG64n
         yr/Q==;
        darn=cygwin.com
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787495946; x=1788100746; darn=cygwin.com;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0tRUKyXeKoBzY3cKdjHknhAaJemjeScNh1Z5IM4eopw=;
        b=PA20MuEgO+CRwrYlNPspXKihLhKdmauFLMBtAan+IHHsJcc79ljgiAXlbFmh4k+iuB
         3Gl99s4J7B+0A/u/YAg9OmgP4Hee++2Iku6g8PqXEvv7gYZTbYSsn7Q+H5F5apgHMDTu
         oqkA9kE8niummqYQ8mBPM+R4leQQUzOeyNcZzqHkihnZjkupagqUn6udZTlgLSzJcQOm
         oWeghIrNLwCFEtFHvafLERNzsUCCscyP571GlQPMZlyyaTV6lD9V66KPipWMv5BlEx7d
         1ELlNeAASxJXaOoyi75aTdCHgKgoC+0pi6Z8VAta87lvKtCnY1mr7+mT1ZUyx7FIPHVW
         2ovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787495946; x=1788100746;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0tRUKyXeKoBzY3cKdjHknhAaJemjeScNh1Z5IM4eopw=;
        b=q4GuUctOZD0MItWXj43f4RMl9sMQtJKtorP3x9ZQRQ3OjRohppSNuMBU+eDIfYfHEi
         pUefeOU8WyUmP/aJxr5vN2q1bJhigBQXzQsIiR0XZ3XphlBh7YzgZHPMlIyiWCJ/aukN
         LMvY2LnJobBb0KBg+m2aFcyp8c4xVjJBDibTS0m0h3jKKLlMAO+GumNww8lQPSvnadX3
         o4+N4tXY3a8vkiwh9g9QXR7Tt6fR1WPjBacIOPSFB3V4DbiWPTdPayi1JdJAzZxzobd4
         6s06BH193miKLedti3LCGkVqSu2i4vGsFxUJye2bf5lvV1GtHk8Yxq3K9jqKAZ4nzD80
         DbZw==
X-Gm-Message-State: AFuF++kFA3VSKv94ZgPfy2IEDKQUP/sZM5fdXCv3x7IZAHarL/POls78
	hU8ZOQQbPvu5D7czwNZLHFM0NhWKboBWALDRWk3DC57Fti0hG7uy5Oa/5MZ6cboWcVUOunV7S3Q
	zBg1ACyt05vs+XduQVdgZ41WTnTxnQf1TTH5X
X-Gm-Gg: AR+sD11XZuZe8HM5Shzru0s0f2/hl0qhx2LV8j7EEJrW35ROtdj73ESTqSN6CBBSta/
	hecHEqyZrPosDym7pz+jOsckJweYbaY0LZ/NanDST6mkv3nHx0m1MEX7EPGlh66CenOTHcvYVWC
	7fF8zth8gPyfk5WTUMQ3269nLLRRRLUQESun32OxS+gIrR/yfvNP5teWYwpHBzNRsYkE38EAuW/
	89b9NjhePJ33WOizqhETeYwN6AjXS8SOjakdhdDDy/7BJKg6XFzyKvi+uNQTVdAE3x7luNBFUI0
	L9ZN7b4x4wMbGoyP+iYlg3Fq7YCYPQVrDY7Wyxqi06GU0Tc=
X-Received: by 2002:a05:6402:458d:b0:6a3:87b7:b5a9 with SMTP id
 4fb4d7f45d1cf-6a42f1f9d6cmr23092094a12.12.1787495945863; Sun, 23 Aug 2026
 07:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAPJSo4UZZN2w=RhhsycAgBW9mim928K9MVw+T7O_9W2uynMD3g@mail.gmail.com>
 <CAPJSo4XhJJJxV=FpWQ44Q5NP=Y46-XPsopNhexzSyGYENjhdRA@mail.gmail.com> <CAPJSo4WPqHqcxFS6AL8Cauo4Na6=u14Tw8eennKk_27rnd-rtQ@mail.gmail.com>
In-Reply-To: <CAPJSo4WPqHqcxFS6AL8Cauo4Na6=u14Tw8eennKk_27rnd-rtQ@mail.gmail.com>
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Sun, 23 Aug 2026 16:38:29 +0200
X-Gm-Features: AcwNN1XaF1-rXSGnefaUgCHeUTk4ICDmjsk2JpyuK-ZC0-ysIoWIeJzYZV91VZs
Message-ID: <CAAvCNcBwn0F84avS5pFS+oUoHuUAoSuKBEc2ybYScO8RDHV9NA@mail.gmail.com>
Subject: Re: [Ms-nfs41-client-devel] [PATCH/RFC] Patch to fix uid/gid lookup
 for NFSv4 filesystems
To: cygwin-patches@cygwin.com, ms-nfs41-client-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 21 Aug 2026 at 17:21, Lionel Cons <lionelcons1972@gmail.com> wrote:
>
> On Sun, 16 Aug 2026 at 19:35, Lionel Cons <lionelcons1972@gmail.com> wrote:
> >
> > Repost with proper [PATCH/RFC] tag.
> >
> > I've attached a patch
> > (cygwin_dll_fix_uidgid4nfsv4_fs_20260709.diff.txt from the
> > ms-nfs41-client project) that resolves an issue with uid/gid lookups
> > on Windows NFSv4 filesystems.
> >
> > Currently, Cygwin assumes that all Windows NFS clients operate
> > similarly to the Windows NFSv3 client. It expects that account names
> > and numeric uid/gid values are identical on both the client and server
> > sides, with LDAP acting as the sole authority for these numeric
> > values.
> >
> > However, the NFSv4 protocol fundamentally changes this paradigm. As
> > defined in RFC 7530 (Section 5.9) and expanded upon in RFC 8178 (Rules
> > for NFSv4 Domain and ID Mapping), NFSv4 deprecates raw numeric uid/gid
> > protocol representation in favor of string-based identifiers (e.g.,
> > user@domain and group@domain).
> >
> > To handle this, all NFSv4 clients implement a local "idmapper"
> > component that translates these string-based identities from the
> > network side into local account data (in the case of Windows, mapping
> > user/group names and uid/gid values via nfs3attr XATTR). Because NFSv4
> > clients manage their own uid/gid translation locally, Cygwin's
> > reliance on raw LDAP data fails in these environments and results in
> > the dreaded "Unix_User+<1234>" and "Unix_Group+<5678>"-kind of
> > owner/group output in Cygwin ls -l.
> >
> > The attached patch addresses this by detecting whether the underlying
> > filesystem is NFSv4. If it is, Cygwin bypasses the LDAP assumption and
> > performs a direct pass-through of the uid/gid values supplied by the
> > NFSv4 client's idmapper.
> >
> > I have successfully tested this fix against several major clients, including:
> > - Exceed NFSv4 client
> > - OpenText NFSv4 client
> > - ms-nfs41-client
> > - ms-nfs42-client
> > - Windows NFSv3 client (no change, it continues to use LDAP raw data)
> >
> > Please let me know if you have any questions or require modifications
> > to the patch.

This is the same patch as
https://github.com/kofemann/ms-nfs41-client/blob/master/cygwin/cygwin_patches/cygwin_dll_fix_uidgid4nfsv4_fs_20260709.diff
right? Who did auhor it - Roland Mainz or someone else? Why was that
patch not submitted before?

Dan
-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd
