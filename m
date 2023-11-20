Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 5C3E53858D35; Mon, 20 Nov 2023 09:40:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5C3E53858D35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1700473256;
	bh=M1lomT5OUVKR2JfOLmJlRQnTH30zlYEIRdvYw2GMqds=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=cv4M1R4IK893h9+L156aPi8OGlrC19NY1KxnDyGd8tIGXaVrhNuqCxRu19aUatns2
	 FNna63ogLtkNYyOIiXBuyHLz8E06iK8VCHG8Qby6KgSZnBzMj/7ev4pBMvvww/PC80
	 MJgHzPOtu7AdNN3N57/tDW1tQedSn/UPWk+kxN44=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 4B1A0A807B2; Mon, 20 Nov 2023 10:40:53 +0100 (CET)
Date: Mon, 20 Nov 2023 10:40:53 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Add /dev/disk/by-label and /dev/disk/by-uuid
 symlinks
Message-ID: <ZVsppVEdC+HW2NE5@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <9c82a61c-02f8-a679-90f2-90e853d47e53@t-online.de>
 <ZVeTfEHgbgLJKFpU@calimero.vinschen.de>
 <57fb24ee-cd4c-0b54-6613-40f817e12571@t-online.de>
 <ZVeZhRmrMlbK7qkz@calimero.vinschen.de>
 <d74801f8-45fb-6a66-cc92-8f021f58c53b@t-online.de>
 <ZVfBmQiTGOjx14lW@calimero.vinschen.de>
 <b924c0f6-7ac1-9fa8-f828-0482f1ea5d36@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b924c0f6-7ac1-9fa8-f828-0482f1ea5d36@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

Hi Christian,

This puzzles me:

On Nov 17 21:25, Christian Franke wrote:
> @@ -610,7 +607,7 @@ get_by_id_table (by_id_entry * &table, fhandler_dev_disk::dev_disk_location loc)
>    if (!table)
>      return (errno_set ? -1 : 0);
>  
> -  /* Sort by name and remove duplicates. */
> +  /* Sort by name and mark duplicates. */
>    qsort (table, table_size, sizeof (*table), by_id_compare_name);
>    for (unsigned i = 0; i < table_size; i++)

by_id_compare_name only compars the actual names...

>      {
> @@ -619,12 +616,13 @@ get_by_id_table (by_id_entry * &table, fhandler_dev_disk::dev_disk_location loc)
>  	j++;
>        if (j == i + 1)
>  	continue;
> -      /* Duplicate(s) found, remove all entries with this name. */
> -      debug_printf ("removing duplicates %d-%d: '%s'", i, j - 1, table[i].name);
> -      if (j < table_size)
> -	memmove (table + i, table + j, (table_size - j) * sizeof (*table));
> -      table_size -= j - i;
> -      i--;
> +      /* Duplicate(s) found, append "#N" to all entries.  This never

...but the names are identical.  So the *order* within the identically
named entries depends on qsort's reshuffling of table
entries.  Which in turn depends on outside factors like number of table
entries and the ultimate position of the identical entries within the
ordered table.

Having said that, I don't see how adding ordinals to the names can be
unambiguous.  AFAICS, the numbers may change by just adding another
disk (USB Stick) to the system...


Thanks,
Corinna
