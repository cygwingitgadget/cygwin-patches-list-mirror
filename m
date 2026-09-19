Return-Path: <SRS0=UN7C=HL=gmail.com=lionelcons1972@sourceware.org>
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com [IPv6:2a00:1450:4864:33::10])
	by sourceware.org (Postfix) with ESMTPS id F01F34BA2E36
	for <cygwin-patches@cygwin.com>; Sat, 19 Sep 2026 09:54:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F01F34BA2E36
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org F01F34BA2E36
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a00:1450:4864:33::10
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1789811681; cv=pass;
	b=J7BvvnZK7hvRaByRswfM2F1Am3Qd3L3vNSp5YIz6E71jKZHNUoMDu1rA1qD4CHNKLiRTWxtvtu/Qi79dL93dpcn7bqwX/N7Tkw36Wc1hqoecwYPX31Lgt7OOrgodX7FCOFWhCbSj/KYNLHZKMCNwCxFYehyXNuRPKwblyWg09T8=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789811681; c=relaxed/simple;
	bh=rqQSyfkvKvv8dVJxy/lZ2FQyYQpyxfuvs6+GKCKbKsA=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=hK0sp9fr5w+BoQmbygC2uVsw0rAlZ+ywRA6GK9Z0sVYNnrE6W1W0AxMy9WXA8v9/FAr6v1L74Z0lxLl8n0IqBScBjUrsps5XPRdegEeBY8QAgLBXhz22qcSOiAVP0YgLo7vf/4+PNU4iXe2Q5udcmLvZARUXYLaNynP5H7K8zZs=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UmjKOX+t
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F01F34BA2E36
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UmjKOX+t
Received: by mail-ed2-x10.google.com with SMTP id 4fb4d7f45d1cf-6a60591bb18so1025100a12.1
        for <cygwin-patches@cygwin.com>; Sat, 19 Sep 2026 02:54:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789811680; cv=none;
        d=google.com; s=arc-20260327;
        b=ntey9QONMVxBQSxcWvV2o6Ot0hqcLclOhoPfub4/m/RIUfSENf28g43adYmdqVMZ83
         +E6yNKHrpcOvJKGTaFOWGsonIPo3KeRKePb0qja8Wjoi19SpZKdI2O2dmdss0rXrslNI
         FuCU4yM3hUJ6fExTRRmy05tXcg9H53c9UgGwyY0zh75DGnWLaE4juz2ERxH8KPRjY/1G
         EFqRSx0+eCjzjU1XhSc1OxESMgdhcsbHkWG//1AfjQpZEEm4OiqrTeY9ge+bHH7ayJzJ
         IalAmr+nlPSG/kAyuovZnBdd67Jjd6uWXkItg5SLT6VkoGsSl7IsRrGblOS6WEujB6PL
         RnHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=rqQSyfkvKvv8dVJxy/lZ2FQyYQpyxfuvs6+GKCKbKsA=;
        fh=YLobnwiB6mlxg8mZw4jwzI5+9rNrzFWI954radGPi+I=;
        b=J3tTxeW8qpUd8/9gj+bFxpsIJ5gQ8eeicWmZ703HaDXtKQg1kjm6RW/HnoF8iLAxpA
         EvRNjXUOqv8THIvo1ib0q/T4b6kni864Nb2z03sOpRY6EPcjD2I5aTOqExX0P37MiPg/
         qZEkPpa9cp+7vQGET8pNBd8PN8a88ftfilSDSPvpOF+QCPqKuowh0nlIGvNVngJCY7tv
         R/dD/8K9dOGSNErEf3q9OIoQWpxVJUNxO+tngqqENdPd8yCi3W6/sd9vaPxT3VtqJYwE
         rLKtJcSSoqTSgokIcQsgmsCwmL2H6PuqLAV/JONYId1u+15SLSOSPPydetzsByaBwSV3
         BkWg==;
        darn=cygwin.com
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789811680; x=1790416480; darn=cygwin.com;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rqQSyfkvKvv8dVJxy/lZ2FQyYQpyxfuvs6+GKCKbKsA=;
        b=UmjKOX+tOwXSNuMdkvSOdpA0DZRVvD00VCZBPA9oAP44Ce7n7U4lCLxGN4teBOK2Qq
         TWymbo9qXLdLR0ePaoUo/xxAofauNUg4yfp+QIXWFUQDrB63THpRKLColroqhws/ukzF
         Jb1FYPkA7+UNUWWUBGMylK+xEQYdBuV80jiHgXfrfgO1U7m9gWay/isE7A3ezOJjItLE
         ndcOcUNzGWJCE5iBmDg4cEknCW1Mtuh249pqh32Pwbn+44RRCyCIplRB8GgHwhh01QtG
         A1XVjPsK2TYxe84lC0brGIhbjjn/7xjOch0hKSewun9iNLthiZAMhF6kOq5Yj4dztfsJ
         mcmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789811680; x=1790416480;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rqQSyfkvKvv8dVJxy/lZ2FQyYQpyxfuvs6+GKCKbKsA=;
        b=o2V0cbzHasJzMNFm/crMquHImZUDbZAExYtEfC+t8jB6cU+sPOUbvzj6wK4IjfBIlF
         rwAvvPI071nyA7HsuA7Fwu39+LyqOGcTYHa+71OIDAPAm9waeGntBlIzZ9PDCh2rV9Vm
         BTBZRAgaOamtFERCVPtOLroOub7VWp/0JdM/eC0Lawmcan0oMnRB7rLmCckKfQ4E6Wrm
         SV3fildr/LOWhd9WiXZztVZ5gcq+51kT/Q24VYaR70/f694XzlEQd5FaHITrMXy7tKfl
         aJ25YWWFFieb0SA9pB0jmRbWw/CS/dOpEJywWLof76L6cG+IUAFPidTYfDimFW7Sqzy2
         38dw==
X-Gm-Message-State: AFuF++kf7SJpxBniMNlxrSMPsWkM8j7Dd/jkWDpWlzYDtRp0qCLI/bx0
	zsuiHxOLaa3Wn+rI2JbXmIJ8Kh9Pqv/Vn1BYUZmB9AxPtMdJ1Aj1MYnAO9GqcZqGmksGE43wnP5
	L3TliT700QrXPiZ+ImfqOL+M2HFCXzJBM7g==
X-Gm-Gg: AYBFou30ZB25Taw32dlOuAI37uNV289jL7s+jpswGbegmzvvMriUgOBIt1w4BCY+5Yy
	OQyvcDLZ6x5S8LNEVdtVVpfmPPNXHQIWN/m4+MOU5pF8btXO86q2J4H8kj3wRq10bEYdZZ0k1gF
	wHSAN8LltA4odmsLG4FUd3xNTrLQ7BdB+dtXhmS74UDjIl5WPWnU3JdLiBeHBNcaucTRKEwGfRC
	AymDsJx3gmH/bY1ubnk8kShiHFEmSatQuB1eaCyvb9gta50s/vwZ1jmKAuKQQSuKFEHlcbvJpLG
	BH9a7LKFF72cflltjgmkhZkPQRuQHHgbl5nPcosiXRFmoU9WQhImqj8=
X-Received: by 2002:a05:6402:24d4:b0:6a6:32e3:9ba with SMTP id
 4fb4d7f45d1cf-6aa4fe1a58emr3122119a12.10.1789811679512; Sat, 19 Sep 2026
 02:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAPJSo4UZZN2w=RhhsycAgBW9mim928K9MVw+T7O_9W2uynMD3g@mail.gmail.com>
 <CAPJSo4XhJJJxV=FpWQ44Q5NP=Y46-XPsopNhexzSyGYENjhdRA@mail.gmail.com> <CAPJSo4WPqHqcxFS6AL8Cauo4Na6=u14Tw8eennKk_27rnd-rtQ@mail.gmail.com>
In-Reply-To: <CAPJSo4WPqHqcxFS6AL8Cauo4Na6=u14Tw8eennKk_27rnd-rtQ@mail.gmail.com>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Sat, 19 Sep 2026 11:54:03 +0200
X-Gm-Features: AcwNN1XDDPGWALEFfEmE4XA4Dt9SUIT65lhXyR2rDBDNBZSDPIDTTM4eaJpijBM
Message-ID: <CAPJSo4X2yqaua0LfD-4qeJsMTLgMGfJT-m05b_8poDwtMGc2sA@mail.gmail.com>
Subject: Re: [PATCH/RFC] Patch to fix uid/gid lookup for NFSv4 filesystems
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 21 Aug 2026 at 17:20, Lionel Cons <lionelcons1972@gmail.com> wrote:
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
>
> ?

Can anyone PLEASE have a look at this patch?

Lionel
