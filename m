Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id 434C13846013
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 10:45:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 434C13846013
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MZTyi-1lVbgW3N4w-00WYS5 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021
 11:45:34 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 45EE3A8093E; Mon, 18 Jan 2021 11:45:34 +0100 (CET)
Date: Mon, 18 Jan 2021 11:45:34 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 01/11] syscalls.cc: unlink_nt: Try
 FILE_DISPOSITION_IGNORE_READONLY_ATTRIBUTE first
Message-ID: <20210118104534.GR59030@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210115134534.13290-1-ben@wijen.net>
 <20210115134534.13290-2-ben@wijen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210115134534.13290-2-ben@wijen.net>
X-Provags-ID: V03:K1:Yn0b7qfpQMuJBfGELrC43nFVodzJZ2KSfgLPBRIUcyhv9MlZyDg
 +D7HS3mJvRujctIS54haK6YDet6a4GyyvFrfuKq69xkftvOs5vP5F5T6p05yUqh1BcfYJln
 SycuBJ9Ym43oBZ28mKyXMWZ8hgOvL+kO0UAdqHjYHE0PyVeWHcMaJKJExsTgSNp08Soeju5
 X8sXIlgUXysvDmPTq8Y/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w/7EqK1UWGo=:7rVDWHe+Cg7euGn84yBero
 of/otVIdW5/4fxaCyaqFAjTPijS6hn9gL17otwUp37D3CxJuMHlM3pnCUc2iPZXdflkkL6Pvk
 YxhG8j6ZjpII0sM5ws+JpABRumXmC1pWHHiJWshv76zVN0UrPzqmNlHF6D2yrbVIWWXPQXdHR
 ySTBGbY+Id/8rsstsTwxspvBS9UNUJl9Z/EikS0A4xnBMYhLNeLNCLdipvgiu48JfmiP61dWV
 M2A3I239Zpp8SOCJDTX6t/ah1d/+n/oPqx62boVI6aKlZJpptRjLZZ1Y5kweX5zJ4nj/eDwcN
 qNTE9qYdEULhq7wnB9n+lMNAEea+B8DnHKctgusLXbv/bxRlhAQhHKaqfNJzAWW//4BUVDAkI
 GP0UfelMnWvWauxHgFP7nOmjnG7cWrqmVoAWN9gUG/bmn5AIqh/pZXB/BOkxVDmtPRW8gSQyz
 ql/wpzDHeA==
X-Spam-Status: No, score=-106.6 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Mon, 18 Jan 2021 10:45:37 -0000

Hi Ben,

after venting that I missed this flag, back to the patch itself:

On Jan 15 14:45, Ben Wijen wrote:
> ---
>  winsup/cygwin/ntdll.h     |  3 ++-
>  winsup/cygwin/syscalls.cc | 20 ++++++++++++++++----
>  2 files changed, 18 insertions(+), 5 deletions(-)
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
> index 525efecf3..ce4e9c65c 100644
> --- a/winsup/cygwin/syscalls.cc
> +++ b/winsup/cygwin/syscalls.cc
> @@ -709,11 +709,23 @@ _unlink_nt (path_conv &pc, bool shareable)
>  			   flags);
>        if (!NT_SUCCESS (status))
>  	goto out;
> -      /* Why didn't the devs add a FILE_DELETE_IGNORE_READONLY_ATTRIBUTE
> -	 flag just like they did with FILE_LINK_IGNORE_READONLY_ATTRIBUTE
> -	 and FILE_LINK_IGNORE_READONLY_ATTRIBUTE???
> +      /* Try FILE_DISPOSITION_IGNORE_READONLY_ATTRIBUTE first
> +         it was added with Redstone 5 (Win10 18_09) (as were POSIX rename semantics)
> +         If it fails: fall-back to usual trickery */
> +      if (wincap.has_posix_rename_semantics ())
> +        {
> +          fdie.Flags = FILE_DISPOSITION_DELETE | FILE_DISPOSITION_POSIX_SEMANTICS;
> +          fdie.Flags|= FILE_DISPOSITION_IGNORE_READONLY_ATTRIBUTE;
> +          status = NtSetInformationFile (fh, &io, &fdie, sizeof fdie,
> +                                         FileDispositionInformationEx);
> +          if (NT_SUCCESS (status))
> +            {
> +              NtClose (fh);
> +              goto out;
> +            }
> +        }

Rather than calling NtSetInformationFile here again, we should rather
just skip the transaction stuff on 1809 and later.  I'd suggest adding
another wincap flag like, say, "has_posix_ro_override", being true
for 1809 and later.  Then we can skip the transaction handling if
wincap.has_posix_ro_override () and just add the
FILE_DISPOSITION_IGNORE_READONLY_ATTRIBUTE flag to fdie.Flags, if
it's available.


Thanks,
Corinna
