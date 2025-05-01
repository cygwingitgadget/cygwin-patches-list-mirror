Return-Path: <SRS0=nMGZ=XR=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id EFFF73858C50
	for <cygwin-patches@cygwin.com>; Thu,  1 May 2025 15:58:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EFFF73858C50
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EFFF73858C50
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746115085; cv=none;
	b=s61AyuNHB/TWa2IRmowoAK3qY+dlKNlZioR8xHaLT6QxKO56R0MbRcyCd8d9hQMMCictU8Qzb8xhpSxDN8/WaqrpfC7GUKmMRq7TN9XB/gq0J/oRihpGrnufAlx/wfKC/81s8Z4MWGYe0VXxFKqfM+F+wQlQX+iJDm3CnNKytS4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746115085; c=relaxed/simple;
	bh=gWd4K4j2SEvtygmB59Js2wOnDD4IRmLrnVqF479XGOI=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=DSfbuP57kqobt+cBTeDG/1mKadqaiRqM3v2uWHnNllGJ4ktQJFX/DuZYOjbGOlm56H9KlorlG/zk/cVIVtbFcu558EgZ9E8z+VdZZ4UJYzVc7E9uROWrnq0+tZe38j9fhiM49KLyiSU/+NOD4I43FluOKDrU3VkMsYTdjOxqffs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EFFF73858C50
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=XZ6y6znI
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 9FB9645C68;
	Thu, 01 May 2025 11:58:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=HsLqMVEVQ+o26nvd3B5iJqYt7DM=; b=XZ6y6
	znIflf0ueijxCiwi3Cz05BpZhpN6sW2WjDf2xuxkUsN2JvBduInXs6lrITWtjTCN
	JThT5MOKviNIJePAMh4/RwrTUg1PxuFI7rjsefsCdv9ICNhjYUOs8dvaGobq9/eE
	gjeNwIY9cZf90NC4medxCWdLfgCdsHubTLi52A=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 9BEF345C64;
	Thu, 01 May 2025 11:58:04 -0400 (EDT)
Date: Thu, 1 May 2025 08:58:04 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Jon Turney <jon.turney@dronecode.org.uk>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: cygwin_conv_path: don't write to `to` before
 size is validated.
In-Reply-To: <69d84bb5-fdfd-47a2-aea7-dccdf5ac2414@dronecode.org.uk>
Message-ID: <f1fbe13f-9d36-9b0b-e965-68df3c951ff0@jdrake.com>
References: <bd0e9cdd-ba1f-423b-089c-7f84e5e8bb3f@jdrake.com> <69d84bb5-fdfd-47a2-aea7-dccdf5ac2414@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 1 May 2025, Jon Turney wrote:

> On 29/04/2025 18:42, Jeremy Drake via Cygwin-patches wrote:
> > In the CCP_POSIX_TO_WIN_W path, when `from` is a device,
> > cygwin_conv_path would attempt to write to the `to` buffer before the
> > validation of the `size`.  This resulted in an EFAULT error in the
> > common use-case of passing `to` as NULL and `size` as 0 to get the
> > required size of `to` for the conversion (as used in
>
> This is clearly not what's wanted! Thanks for fixing this!
>
> > @@ -4019,7 +4020,7 @@ cygwin_conv_path (cygwin_conv_path_t what, const void
> > *from, void *to,
> >   	    {
> >   	      /* Device name points to somewhere else in the NT namespace.
> >   		 Use GLOBALROOT prefix to convert to Win32 path. */
> > -	      to = (void *) wcpcpy ((wchar_t *) to, ro_u_globalroot.Buffer);
> > +	      prependglobalroot = true;
>
> It seems like this could all be done in-place in .Buffer here, but I'm going
> to defer to Corinna on if that's at all clearer...

I thought of that, but I wasn't sure if there was room to memmove the
contents over to prepend the ro_u_globalroot constant.  I could check the
MaximumLength and if not reallocate Buffer but that would then require
knowledge of which allocation mechanism was used to ensure the matching
realloc or free is called.  Either way, there's a lot more memory being
copied around.

> > +
> > +- Fix cygwin_conv_path writing to 'to' pointer before size is checked.
> > +  Addresses: https://cygwin.com/pipermail/cygwin/2025-April/258068.html
>
>
> Seems like this should also touch:
>
> https://cygwin.com/cygwin-api/func-cygwin-conv-path.html
>
> (source in winsup/doc/path.xml)
>
>
> I'm not sure what the conventional language to use for this common behaviour:
>
> "If size is 0, (to is ignored|to can be NULL) and cygwin_conv_path just
> returns the required buffer size in bytes" ?


Hmm, did you read the rust backtrace thread?  The reviewer there was
concerned that the docs didn't specify that to could be NULL if size was
0, even though the example on that page does just that.  It'd also be nice
to guarantee that to will always be NUL-terminated and never truncated.


I'd probably go with 'can be NULL', I don't want somebody to think that
it'd be a better idea to use (void *)8 :P


