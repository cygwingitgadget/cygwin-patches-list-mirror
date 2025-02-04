Return-Path: <SRS0=0bfK=U3=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 705573858D20
	for <cygwin-patches@cygwin.com>; Tue,  4 Feb 2025 21:47:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 705573858D20
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 705573858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1738705634; cv=none;
	b=mQz+VGfcWWXJ0pf+uDDUsq/24BETWoEs3f7pfWWJEbYADIZzdiwTjXzjOBQnNyd1LXSq9GCEqZn46OC6LjLfsSrH7CUyP1LgCkzCHuDAHKqTFUg4Cry0MhjQsx1dQ/2Qe59CUnTmarcfUC0at5+IK4EEqBgGZ2ovfI6Tc6MNz9c=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1738705634; c=relaxed/simple;
	bh=/VseZF+g7HjcEaOlZGg66M5nSsZUd3U2xfGutJa3Vxo=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=CTYq+8DSTDKpWTnuCq3KjBx+4oAU3TZYTOAIEmdDwV4N6idsIXqu8LWVKcGn4KnSUOBUgtFAk20KewLONuaCqKlzYP1qML5u1EKNKTF5T/uaB2LjHV64gv7llpsCBseErnuSe0WpFEwaN+Hvuim3+qDvlCTvWiUEcB6Jx/NAcJI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 705573858D20
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=u4kR5elc
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id F252A45CE6
	for <cygwin-patches@cygwin.com>; Tue,  4 Feb 2025 16:47:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=310BgnC+2WXfGjZGdPb4Hhiv3Gs=; b=u4kR5
	elczZFJE0awmkO+6IYig45D2bvxLpVBLrVkEl9H8QZKyRTStC+rpPK2H08t3h5Cl
	QRvAEo/yqftGqVikQknPUWrTboVBv6gUNXM+Ajcy1X1Rxg85EIHKvjiKj/3TYjBA
	XBZ3viifmObOpW0vkCM9sZZCfH+c7shtSaCueU=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id BA2B645CE5
	for <cygwin-patches@cygwin.com>; Tue,  4 Feb 2025 16:47:13 -0500 (EST)
Date: Tue, 4 Feb 2025 13:47:13 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: /proc/<PID>/mount*: escape strings.
In-Reply-To: <d7c79b40-237b-2f76-fc4d-3b7c3376199d@jdrake.com>
Message-ID: <f3707f39-5858-15b0-e136-a07b2d8d7e76@jdrake.com>
References: <d7c79b40-237b-2f76-fc4d-3b7c3376199d@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

I sent this patch in June
(https://cygwin.com/pipermail/cygwin-patches/2024q2/012712.html), and I
recently remembered I hadn't heard anything about it.



On Tue, 4 Jun 2024, Jeremy Drake via Cygwin-patches wrote:

> In order for these formats to be machine-parseable, characters used as
> delimiters must be escaped.  Linux escapes space, tab, newline,
> backslash, and hash (because code that parses mounts/mtab and fstab
> would handle comments) using octal escapes.  Replicate that behavior
> here.
>
> Addresses: https://cygwin.com/pipermail/cygwin/2024-June/256082.html
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> ---
>
> Changes from original:
> * forgot to include tab '\t' in characters that need escaping
> * I mis-iterpreted how octal escapes work: they don't require a leading 0,
> but Linux uses a fixed 3 digit format, which makes calculating the length
> cleaner.
>
>  winsup/cygwin/fhandler/process.cc | 76 +++++++++++++++++++++++++++----
>  1 file changed, 66 insertions(+), 10 deletions(-)
>
> diff --git a/winsup/cygwin/fhandler/process.cc b/winsup/cygwin/fhandler/process.cc
> index 37bdff84e3..db1763d702 100644
> --- a/winsup/cygwin/fhandler/process.cc
> +++ b/winsup/cygwin/fhandler/process.cc
> @@ -1317,9 +1317,39 @@ extern "C" {
>    struct mntent *getmntent (FILE *);
>  };
>
> +static size_t
> +escape_string_length (const char *str, const char *escapees)
> +{
> +  size_t i, len = 0;
> +
> +  for (i = strcspn (str, escapees);
> +       str[i];
> +       i += strcspn (str + i + 1, escapees) + 1)
> +    len += 3;
> +  return len + i;
> +}
> +
> +static size_t
> +escape_string (char *destbuf, const char *str, const char *escapees)
> +{
> +  size_t s, i;
> +  char *p = destbuf;
> +
> +  for (s = 0, i = strcspn (str, escapees);
> +       str[i];
> +       s = i + 1, i += strcspn (str + s, escapees) + 1)
> +    {
> +      p = stpncpy (p, str + s, i - s);
> +      p += __small_sprintf (p, "\\%03o", (int)(unsigned char) str[i]);
> +    }
> +  p = stpcpy (p, str + s);
> +  return (p - destbuf);
> +}
> +
>  static off_t
>  format_process_mountstuff (void *data, char *&destbuf, bool mountinfo)
>  {
> +  static const char MOUNTSTUFF_ESCAPEES[] = " \t\n\\#";
>    _pinfo *p = (_pinfo *) data;
>    user_info *u_shared = NULL;
>    HANDLE u_hdl = NULL;
> @@ -1369,9 +1399,9 @@ format_process_mountstuff (void *data, char *&destbuf, bool mountinfo)
>  	    continue;
>  	}
>        destbuf = (char *) crealloc_abort (destbuf, len
> -						  + strlen (mnt->mnt_fsname)
> -						  + strlen (mnt->mnt_dir)
> -						  + strlen (mnt->mnt_type)
> +						  + escape_string_length (mnt->mnt_fsname, MOUNTSTUFF_ESCAPEES)
> +						  + escape_string_length (mnt->mnt_dir, MOUNTSTUFF_ESCAPEES)
> +						  + escape_string_length (mnt->mnt_type, MOUNTSTUFF_ESCAPEES)
>  						  + strlen (mnt->mnt_opts)
>  						  + 30);
>        if (mountinfo)
> @@ -1380,18 +1410,44 @@ format_process_mountstuff (void *data, char *&destbuf, bool mountinfo)
>  	  dev_t dev = pc.exists () ? pc.fs_serial_number () : -1;
>
>  	  len += __small_sprintf (destbuf + len,
> -				  "%d %d %d:%d / %s %s - %s %s %s\n",
> +				  "%d %d %d:%d / ",
>  				  iteration, iteration,
> -				  major (dev), minor (dev),
> -				  mnt->mnt_dir, mnt->mnt_opts,
> -				  mnt->mnt_type, mnt->mnt_fsname,
> +				  major (dev), minor (dev));
> +	  len += escape_string (destbuf + len,
> +				mnt->mnt_dir,
> +				MOUNTSTUFF_ESCAPEES);
> +	  len += __small_sprintf (destbuf + len,
> +				  " %s - ",
> +				  mnt->mnt_opts);
> +	  len += escape_string (destbuf + len,
> +				mnt->mnt_type,
> +				MOUNTSTUFF_ESCAPEES);
> +	  destbuf[len++] = ' ';
> +	  len += escape_string (destbuf + len,
> +				mnt->mnt_fsname,
> +				MOUNTSTUFF_ESCAPEES);
> +	  len += __small_sprintf (destbuf + len,
> +				  " %s\n",
>  				  (pc.fs_flags () & FILE_READ_ONLY_VOLUME)
>  				  ? "ro" : "rw");
>  	}
>        else
> -	len += __small_sprintf (destbuf + len, "%s %s %s %s %d %d\n",
> -				mnt->mnt_fsname, mnt->mnt_dir, mnt->mnt_type,
> -				mnt->mnt_opts, mnt->mnt_freq, mnt->mnt_passno);
> +        {
> +	  len += escape_string (destbuf + len,
> +				mnt->mnt_fsname,
> +				MOUNTSTUFF_ESCAPEES);
> +	  destbuf[len++] = ' ';
> +	  len += escape_string (destbuf + len,
> +				mnt->mnt_dir,
> +				MOUNTSTUFF_ESCAPEES);
> +	  destbuf[len++] = ' ';
> +	  len += escape_string (destbuf + len,
> +				mnt->mnt_type,
> +				MOUNTSTUFF_ESCAPEES);
> +	  len += __small_sprintf (destbuf + len, " %s %d %d\n",
> +				  mnt->mnt_opts, mnt->mnt_freq,
> +				  mnt->mnt_passno);
> +	}
>      }
>
>    /* Restore available_drives */
>

