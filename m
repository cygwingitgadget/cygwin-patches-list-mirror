Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id ADF473858D20; Wed, 12 Feb 2025 21:20:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org ADF473858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1739395217;
	bh=1lWV9a+449ygD6N6vzRyAIU/tAseudDhPgPPzhPqVgI=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=ubVuHLJa9xc8Pfa1EK3wdlM6kMWr8P+dz4PpP0UCCkJDWX7IdQyTZAyrffU+3I3GS
	 L/gX9CshS9ojJOWqZdKKaPpmhsdofc4AM4nL4c1OocmFFxN1Nd/XalqGiJFX7SUsAQ
	 U1TS8UGsyw2h6+FMgN+XNf3dCAaJPO9ZJMlJaEkY=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 7DEE6A80D2E; Wed, 12 Feb 2025 22:20:08 +0100 (CET)
Date: Wed, 12 Feb 2025 22:20:08 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 2/2] Cygwin: expose all windows volume mount points.
Message-ID: <Z60QiLIEAvDzSs5k@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4f314ab3-8406-0a5c-2cc5-9f2f0af9df50@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f314ab3-8406-0a5c-2cc5-9f2f0af9df50@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Jeremy,

your patch is basically fine, and I was about to push it, when I
realized that I don't quite understand this:

On Feb 12 10:56, Jeremy Drake via Cygwin-patches wrote:
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
> +	      int cmp = strcmp (ret->mnt_dir, mount[posix_sorted[i]].posix_path);
> +	      if (!cmp && strcasematch (ret->mnt_fsname,
> +					mount[posix_sorted[i]].native_path))
> +		goto cygdrive_mntent_continue;
> +	      else if (cmp > 0)
> +		break;
> +	    }
> +	  break;
> +cygdrive_mntent_continue:;
> +	}
> +      return ret;
> +    }

What exactly is de-duplicated here?

I have a drive mounted under C:\drvmount.
I create an additional mount entry:

  $ mount C:/drvmount /home/corinna/drv

If I call mount, I see two mount entries, both pointing to the
/home/corinna/drv dir:

  $ mount | grep drvmount
  C:/drvmount on /home/corinna/drv type ntfs (binary,user)
  C:/drvmount on /home/corinna/drv type ntfs (binary,posix=0,noumount,auto)

The first is the explicit mount, the second is the cygdrive entry.
If I disable the above de-dup code, the result is the same.

However, either way, both point to the explicit mount point.
Wouldn't it be helpful to see /cygdrive/c/drvmount?

  C:/drvmount on /home/corinna/drv type ntfs (binary,user)
  C:/drvmount on /cygdrive/c/drvmount type ntfs (binary,posix=0,noumount,auto)


Thanks,
Corinna
