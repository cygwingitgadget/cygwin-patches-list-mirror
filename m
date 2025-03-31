Return-Path: <SRS0=xzMS=WS=redhat.com=vinschen@sourceware.org>
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by sourceware.org (Postfix) with ESMTP id 705C73856DEB
	for <cygwin-patches@cygwin.com>; Mon, 31 Mar 2025 21:48:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 705C73856DEB
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=redhat.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 705C73856DEB
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743457696; cv=none;
	b=xRju9SgddxVPkBm1yAyk70x1Lm9LeaECP/mDvm5/JSrYKJ4eTrcNgeVEpMObE07bFgQORachF6mdHb1p1hF8o2VaLg5DeEIwJapDDCdX1EER9tRD1Cz8wESDa+CBtlh5FQQI2YleUeFItdfUqsjAfHHtuem8kaDEFh7UoKzUuA8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743457696; c=relaxed/simple;
	bh=8DbGQq8VSxAEpAVO+aRvuz7p0e8HZkc1LpkNqdLF1iw=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=FZcAd1w87xBcN5Xqqr2MQ4MWTwu+BOZ4hr9NL/8G8n2XzeUIZyrZzgNduc+5gY6hVG7JFptUD0w9gFjPLdXgU+WZ3aBULsJElW4yV99CR7Efl0ie8wLBA0MDJQDg71vTB/phiVP3I2IvetL2Hc5Vyi1ea8Opq+1TDLgTC9URCD0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 705C73856DEB
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WIbhSs6D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743457696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7xwmecF4OV5Pq6JngTaegDQOWEs5RBVppAWU7VBnloU=;
	b=WIbhSs6DEZI+z3wCBvAkC8vEXc8+XFTjJN6a0e/gkkqJn96FMxJ2H0xX1W2r8BlxKFq3g7
	BFa32jY1jTeTV+N4n9pkBplzNwHX4GZjtb/d/AEqY2ASF37jqRe+a/5zyYspx3WgDHRrVU
	lIJdBp61T2xn/fu1Oe/aVenNCb8k7zA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-IaoYKSoUOTSD6MenfTzXIQ-1; Mon,
 31 Mar 2025 17:48:14 -0400
X-MC-Unique: IaoYKSoUOTSD6MenfTzXIQ-1
X-Mimecast-MFC-AGG-ID: IaoYKSoUOTSD6MenfTzXIQ_1743457693
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 681FD1800361;
	Mon, 31 Mar 2025 21:48:13 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.22.80.96])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EEAFF180B489;
	Mon, 31 Mar 2025 21:48:12 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id EE96AA80CA2; Mon, 31 Mar 2025 23:48:09 +0200 (CEST)
Date: Mon, 31 Mar 2025 23:48:09 +0200
From: Corinna Vinschen <vinschen@redhat.com>
To: Mark Wielaard via Overseers <overseers@sourceware.org>
Cc: cygwin-patches@cygwin.com, Mark Wielaard <mark@klomp.org>
Subject: Re: [PATCH v4 0/5] find_fast_cwd_pointer rewrite
Message-ID: <Z-sNmSuwz20-EOzU@calimero.vinschen.de>
Mail-Followup-To: Mark Wielaard via Overseers <overseers@sourceware.org>,
	cygwin-patches@cygwin.com, Mark Wielaard <mark@klomp.org>
References: <56da8997-5d48-dfb7-8a41-b3fa6ccfbecc@jdrake.com>
 <bd7bc794-7a50-228f-4f9e-a34a02fd12f6@jdrake.com>
 <Z-pQB1d2It9jkuFS@calimero.vinschen.de>
 <Z-r0vQTnzdkrCIsq@calimero.vinschen.de>
 <ed148947-2ebb-6c44-6b90-acb018b85008@jdrake.com>
 <Z-sD0CGk4L-zuyzH@calimero.vinschen.de>
 <20250331214131.GA9235@gnu.wildebeest.org>
MIME-Version: 1.0
In-Reply-To: <20250331214131.GA9235@gnu.wildebeest.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VCEw5_TE-_bd_MFuzaxSIhfWBjgFeaOs0fvvMjYxXTE_1743457693
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

On Mar 31 23:41, Mark Wielaard via Overseers wrote:
> Hi Corinna, Hi Jeremy,
> 
> On Mon, Mar 31, 2025 at 11:06:24PM +0200, Corinna Vinschen via Overseers wrote:
> > On Mar 31 13:58, Jeremy Drake via Cygwin-patches wrote:
> > > On Mon, 31 Mar 2025, Corinna Vinschen wrote:
> > > > Thank you, I approved your request on sware.  You now have
> > > > write-after-approval permissions, so please continue to send patches to
> > > > cygwin-patches first and wait for approval from Takashi, Jon or me.
> > > 
> > > I tried to push this patchset but I'm getting Permission denied
> > > (publickey) from ssh.  I assume this is still waiting on overseers.
> > > Should I expect an email from them when things are ready?
> > 
> > Usually you should get a mail from overseers.  I CCed them, just to
> > be sure.
> 
> Overseers, or at least, was a little confused, sorry.  I do see the
> account request by Jeremy and your approval.  But I was under the
> impression that Cygwin was using gitolite and you handled user keys
> yourself. Am I wrong? Is that only for some (other) repositories?

gitolite is only used for the Cygwin distro package upload.

This here is for the newlib-cygwin source repo.


Thanks,
Corinna

