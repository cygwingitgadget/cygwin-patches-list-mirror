Return-Path: <SRS0=BywE=U7=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 7A8103858D38
	for <cygwin-patches@cygwin.com>; Sat,  8 Feb 2025 18:41:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7A8103858D38
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7A8103858D38
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1739040061; cv=none;
	b=rPPiPfKkWrc6o3BcCA/qNWw5i8xC97QT+yQ9r1066J3OzRjNMG2Qdc9cn3WD/n9UIdpKco9pReapDxElEzkNXi2r5EQnttwlK8d2rN6q4DchIMFywCgDMcc3vE8JfFViU3TZQZVPANp+5z5/UVax4uBEFy/cNuwnLPlmLN+RmnA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1739040061; c=relaxed/simple;
	bh=0ZA/LC6+WSCQ+ooBpS0tu+suV4RCEd8QygfiU0Y05pQ=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=UEfxnJpNwAIgsVtj9eBoF35d8OIlX6nzI6SlZXMeO4HIZiBS/OH7q+LXF8b3pNl7nSSfKE4H6jT0xs8tm8rhGfM+5ZMMAzMvLUcFDkqtSbL+AALVAOia0CkH3uKPTwLu5qs1m4q07eXLNRhA7v7SLSZp7ASpGcbaDCaYKJoOOd4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7A8103858D38
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=ZaIK9ilU
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 4D48845C91
	for <cygwin-patches@cygwin.com>; Sat,  8 Feb 2025 13:41:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=hNeZfJiAAUREgyeYXdSe71e0hwg=; b=ZaIK9
	ilUfyUcSw5iUlr9ojqi43bSEA/2x/3mR6HsZ3IQbtQpY+71rV8/K1AnioDGTcsCn
	zNQVX9u/c2u+PWd3enH4ZKynwCa9lVGyNGKFAkgJB7vh4YcqPru0HBsyvSD3Zkr0
	c+CQc8CS6s3gOifcxMA0HdHPzDNL0FJgxkbi9c=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 22E6245C8F
	for <cygwin-patches@cygwin.com>; Sat,  8 Feb 2025 13:41:01 -0500 (EST)
Date: Sat, 8 Feb 2025 10:41:01 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: expose all windows volume mount points.
In-Reply-To: <be64d541-a24d-b5ff-5a50-9aae577a48ae@jdrake.com>
Message-ID: <3ab1074f-4a3a-5396-c878-1dba76fa8a65@jdrake.com>
References: <be64d541-a24d-b5ff-5a50-9aae577a48ae@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Bit of commentary/review on my own patch.

On Fri, 7 Feb 2025, Jeremy Drake via Cygwin-patches wrote:

> diff --git a/winsup/cygwin/local_includes/cygtls.h b/winsup/cygwin/local_includes/cygtls.h
> index d814814b19..ba9e980ec1 100644
> --- a/winsup/cygwin/local_includes/cygtls.h
> +++ b/winsup/cygwin/local_includes/cygtls.h
> @@ -93,10 +93,13 @@ struct _local_storage
>    int dl_error;
>    char dl_buffer[256];
>
> -  /* path.cc */
> +  /* mount.cc */
>    struct mntent mntbuf;
>    int iteration;
> -  unsigned available_drives;
> +  int volumemountpointoffset;
> +  HANDLE volumesearchhandle;
> +  WCHAR *volumemountpoints; // note: malloced
> +  DWORD volumemountpointslen;
>    char mnt_type[80];
>    char mnt_opts[80];
>    char mnt_fsname[CYG_MAX_PATH];

I'm regretting the length of those variable names now...

> diff --git a/winsup/cygwin/local_includes/mount.h b/winsup/cygwin/local_includes/mount.h
> index b2acdf08b4..7120281069 100644
> --- a/winsup/cygwin/local_includes/mount.h
> +++ b/winsup/cygwin/local_includes/mount.h
> @@ -216,6 +216,7 @@ class mount_info
>    bool from_fstab (bool user, WCHAR [], PWCHAR);
>
>    int cygdrive_win32_path (const char *src, char *dst, int& unit);
> +  struct mntent *cygdrive_getmntent ();
>  };
>
>  class dos_drive_mappings

I wasn't sure about making that a member.  The existing code was already
accessing things in mount_info via mount_table->whatever.  This code could
just do that too.

> +      _my_tls.locals.volumemountpoints = (WCHAR *) malloc (NT_MAX_PATH * sizeof (WCHAR));

Forgot to check for NULL return and fail.  Got that in my working copy
now.

>  struct mntent *
>  mount_info::getmntent (int x)
>  {
>    if (x < 0 || x >= nmounts)
> -    return cygdrive_getmntent ();
> -
> +    {
> +      struct mntent *ret;
> +      /* de-duplicate against explicit mount entries */
> +      while ((ret = cygdrive_getmntent ()))
> +	{
> +	  for (int i = 0; i < nmounts; ++i)
> +	    {
> +	      if (!strcmp (ret->mnt_dir, mount[i].posix_path) &&
> +		  strcasematch (ret->mnt_fsname, mount[i].native_path))

This could be improved by using a sorted version, and breaking from the
for loop once past where it could possibly still match.

