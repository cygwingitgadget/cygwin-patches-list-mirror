Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	by sourceware.org (Postfix) with ESMTPS id 71B243858D32
	for <cygwin-patches@cygwin.com>; Mon, 13 Mar 2023 09:31:08 +0000 (GMT)
Authentication-Results: sourceware.org; dmarc=permerror header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N45th-1qbHZ40iDB-0108lg for <cygwin-patches@cygwin.com>; Mon, 13 Mar 2023
 10:31:07 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A86D9A80C87; Mon, 13 Mar 2023 10:31:06 +0100 (CET)
Date: Mon, 13 Mar 2023 10:31:06 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: doc: Update postinstall/preremove scripts
Message-ID: <ZA7tWpqAmlcKg+v7@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230308141719.7361-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230308141719.7361-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:hDacv2Z2mz+kCIlRp6EE6orqUNth9iEIF5IO9lhUBKgg5H9BiyO
 dskltK8tj1iYP6ubbTjiWS2ZCD3H/R0mMS3GRvZbGsv0yoTNjwtFzF4bkJc9AtJzIN7/MEF
 zrKKjKaNGoeayFocOJxm6pD2qER+OXo1TC+BLHuFHqUZMNggpYRzTdvq4XeU5tj9KXCzvMW
 oqaeCqLSuGmy80hOJ7BEg==
UI-OutboundReport: notjunk:1;M01:P0:zWeDFgYed0k=;lnwvU2d2x4M0AQkYYvQFNF4X5LI
 fC/O+EpH8Qpy+zjDf/wB4pzLt0dL1s9vMyiRWJq8m2p53xrKcCSIfiRpO1WSFLebOX+w//4Ax
 nZzE7oI2kBFIrEX2tECy32bLVJ5ta/wNdLQKRju11331MKnLixKZwbsSd/NM3kRGjr9ctwwH9
 2IORU0tHUZcSA3KOY7PvydLoXMyA9VNnrmOkZyezrFLag4x1aj9CMrs91nKCyYsUyZOrUWyRP
 X5YJVqKzhkIxjYWsQVTxTvmzGZdx+9G1THgvIF/bJZKASbR4yfvYV7TYiyTOW6wj3KYgp8KqI
 nthF20ON+45qDThZO1t2R1qeF21g/ttNSCIC23QUQUWELDJe0cr8bRYN2LWRKhziJ4cimZYZe
 Y8KsJeSplPBKftnENYp1Nuty2WsfQ4CNI5Dunvyb0Ns9EXJcY3CBOcL845t0dr0BoEvVHbgCK
 ooneXAGlEObpnv0SY4hqqatehzBSId5+R9tRM9ZIMQYv5VL3UGJMG517eElgfSpJMsADohCOz
 +9BdnOkipRR9ln5/5ipmGuiYby8MdHEb013RUw/hmlItkicVhjerU7+20s7YUrtAfjfulaGz2
 /uKGqAXSfNPjCRo9/1Xz6oGDgdXrVGO4Mr/yeinozDm+LoKoYpjbXmv6dh1UroKZ219+3escX
 adQeGNdvyyE+3oUvkx7oM6zx9bstdkrA4U4ZCOYfTQ==
X-Spam-Status: No, score=-103.5 required=5.0 tests=BAYES_00,GIT_PATCH_0,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Jon,

On Mar  8 14:17, Jon Turney wrote:
> Update postinstall/preremove scripts to use CYGWIN_START_MENU_SUFFIX and
> CYGWIN_SETUP_OPTIONS.

It would be great if you could explain your change in the commit
message...

>  winsup/doc/etc.postinstall.cygwin-doc.sh | 19 +++++++++++++++----
>  winsup/doc/etc.preremove.cygwin-doc.sh   |  8 ++++++--
>  2 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/winsup/doc/etc.postinstall.cygwin-doc.sh b/winsup/doc/etc.postinstall.cygwin-doc.sh
> index 97f88a16d..313c1d3ff 100755
> --- a/winsup/doc/etc.postinstall.cygwin-doc.sh
> +++ b/winsup/doc/etc.postinstall.cygwin-doc.sh
> @@ -36,9 +36,20 @@ do
>  	fi
>  done
>  
> +# setup was run with options not to create startmenu items
> +case ${CYGWIN_SETUP_OPTIONS} in
> +  *no-startmenu*)
> +    exit 0
> +    ;;
> +esac
> +
>  # Cygwin Start Menu directory
> -case $(uname -s) in *-WOW*) wow64=" (32-bit)" ;; esac
> -smpc_dir="$($cygp $CYGWINFORALL -P -U --)/Cygwin${wow64}"
> +if [ ! -v CYGWIN_START_MENU_SUFFIX ]

Isn't -v a bash extension? Ideally the shebang should reflect that.
Otherwise, -z?


Thanks,
Corinna
