Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id F2EE73890427
 for <cygwin-patches@cygwin.com>; Fri, 22 Jan 2021 10:52:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org F2EE73890427
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MCsLu-1lBfUH1xoW-008qcM for <cygwin-patches@cygwin.com>; Fri, 22 Jan 2021
 11:52:01 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 14A35A80D50; Fri, 22 Jan 2021 11:52:01 +0100 (CET)
Date: Fri, 22 Jan 2021 11:52:01 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/8] syscalls.cc: unlink_nt: Try
 FILE_DISPOSITION_IGNORE_READONLY_ATTRIBUTE
Message-ID: <20210122105201.GD810271@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210115134534.13290-1-ben@wijen.net>
 <20210120161056.77784-2-ben@wijen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210120161056.77784-2-ben@wijen.net>
X-Provags-ID: V03:K1:mTThS9gV6fhciQmBHh8QCCmk0pjrGBqLBO5d/XZ8Ncretq5ENVm
 4qBHLQkHxcRTLEpiXwXDXGPE6Jn+n9L9f9zWAlBS7idJ9dxN3AVzYjYbt2HoSaaL6ukET8p
 5+hgQEnSoKuAGkrezDC/Eudt/RrTlMRpY0VWj3Fsw1F+c0M4BK7X9lRK8KKQVQLKkftNbPG
 6y/jYewTuluAm+obKZCFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r24n9H704iI=:0bh7DBJUjUYWXSLlYkOo5m
 7DNodKu1jXh4Rvzk5OZ0s+jsO6R+E0Cw25rt9+VPeg/OgSRNGjbK+J+NhAaBrTTbB97144hRS
 1H8nKLE7q7bUHwrH2ZET8XvcZP2WDDZ2wVvMLuW7AEthfzF+8XGcOSsX/US1hxNc53H2UNXnG
 qva06ZGO2AxSaBSERibgv32laJaBb3bGdUrFQxaMKP+JhqEhUGhPMToE/8fySg1D0JT3JVAl/
 afs1uT0IyT0Mp/SvRNGIyUonhI9bDtVegcxtY10h47BlV2Gl7TenXlP3itedr4/segFIzdyji
 VHhebP+2LHwWuS+zqSpsqTC8Ua/9yDYFTVOoR5PRbdKomG5Zs78ivH6bKIUXvJ+C5Jk/aTgmO
 r+V/83zKdTyz7Jsd+UGQB6RAQhxZhV6QDefJ1L4NQ5ac7V7loONcQrEcKl49pqE8HAiwS57Sj
 CyvFWhaG7Q==
X-Spam-Status: No, score=-107.1 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Fri, 22 Jan 2021 10:52:13 -0000

Hi Ben,

On Jan 20 17:10, Ben Wijen wrote:
> Implement wincap.has_posix_unlink_semantics_with_ignore_readonly and when set
> skip setting/clearing of READONLY attribute and instead use
> FILE_DISPOSITION_IGNORE_READONLY_ATTRIBUTE
> ---
>  winsup/cygwin/ntdll.h     |  3 ++-
>  winsup/cygwin/syscalls.cc | 14 +++++-----
>  winsup/cygwin/wincap.cc   | 11 ++++++++
>  winsup/cygwin/wincap.h    | 56 ++++++++++++++++++++-------------------
>  4 files changed, 49 insertions(+), 35 deletions(-)
> 
> diff --git a/winsup/cygwin/ntdll.h b/winsup/cygwin/ntdll.h
> index d4f6aaf45..7eee383dd 100644
> --- a/winsup/cygwin/ntdll.h
> +++ b/winsup/cygwin/ntdll.h
> @@ -497,7 +497,8 @@ enum {
>    FILE_DISPOSITION_DELETE				= 0x01,
>    FILE_DISPOSITION_POSIX_SEMANTICS			= 0x02,
>    FILE_DISPOSITION_FORCE_IMAGE_SECTION_CHECK		= 0x04,
> -  FILE_DISPOSITION_ON_CLOSE				= 0x08
> +  FILE_DISPOSITION_ON_CLOSE				= 0x08,
> +  FILE_DISPOSITION_IGNORE_READONLY_ATTRIBUTE		= 0x10,
>  };
>  
>  enum
> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> index 4742c6653..2e50ad7d5 100644
> --- a/winsup/cygwin/syscalls.cc
> +++ b/winsup/cygwin/syscalls.cc
> @@ -709,14 +709,11 @@ _unlink_nt (path_conv &pc, bool shareable)
>  			   flags);

A few lines above, FILE_WRITE_ATTRIBUTES is added to the
access mask, if the file is R/O.  This, too, depends on
wincap.has_posix_unlink_semantics_with_ignore_readonly().

>        if (!NT_SUCCESS (status))
>  	goto out;
> -      /* Why didn't the devs add a FILE_DELETE_IGNORE_READONLY_ATTRIBUTE
> -	 flag just like they did with FILE_LINK_IGNORE_READONLY_ATTRIBUTE
> -	 and FILE_LINK_IGNORE_READONLY_ATTRIBUTE???
> -
> -         POSIX unlink semantics are nice, but they still fail if the file
> +      /* POSIX unlink semantics are nice, but they still fail if the file
>  	 has the R/O attribute set.  Removing the file is very much a safe
>  	 bet afterwards, so, no transaction. */

This comment should contain a short comment "W10 1809+, blah blah",
analogue to the comment in line 698 in terms of 1709+ ("++"?  Oops,
fix typo...).


> -      if (pc.file_attributes () & FILE_ATTRIBUTE_READONLY)
> +      if (!wincap.has_posix_unlink_semantics_with_ignore_readonly ()
> +          && (pc.file_attributes () & FILE_ATTRIBUTE_READONLY))

I'd invert the test order here.  On 1809+ systems, the majority of
systems these days, the first test is always true, but it's always
checked, even if the file is not R/O.  First checking for R/O would
reduce the hits on the "with_ignore_readonly" check.

>  	{
>  	  status = NtSetAttributesFile (fh, pc.file_attributes ()
>  					    & ~FILE_ATTRIBUTE_READONLY);
> @@ -727,10 +724,13 @@ _unlink_nt (path_conv &pc, bool shareable)
>  	    }
>  	}
>        fdie.Flags = FILE_DISPOSITION_DELETE | FILE_DISPOSITION_POSIX_SEMANTICS;
> +      if(wincap.has_posix_unlink_semantics_with_ignore_readonly ())
          ^^^
          space
> +          fdie.Flags |= FILE_DISPOSITION_IGNORE_READONLY_ATTRIBUTE;
         ^^^^
         indentation 2, not 4.

>        status = NtSetInformationFile (fh, &io, &fdie, sizeof fdie,
>  				     FileDispositionInformationEx);
>        /* Restore R/O attribute in case we have multiple hardlinks. */
> -      if (pc.file_attributes () & FILE_ATTRIBUTE_READONLY)
> +      if (!wincap.has_posix_unlink_semantics_with_ignore_readonly ()
> +          && (pc.file_attributes () & FILE_ATTRIBUTE_READONLY))

Same here.

Actually, on second thought, what about introducing another bool at the
start of the posix handling, along the lines of

   const bool needs_ro_handling =
     (pc.file_attributes () & FILE_ATTRIBUTE_READONLY)
     && !wincap.has_posix_unlink_semantics_with_ignore_readonly ();

and then check for needs_ro_handling throughout?


Thanks,
Corinna
