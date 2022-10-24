Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	by sourceware.org (Postfix) with ESMTPS id 79564385840A
	for <cygwin-patches@cygwin.com>; Mon, 24 Oct 2022 12:09:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 79564385840A
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N7Qkv-1pAJE10og9-017i1i for <cygwin-patches@cygwin.com>; Mon, 24 Oct 2022
 14:09:48 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id B5B68A80CFE; Mon, 24 Oct 2022 14:09:47 +0200 (CEST)
Date: Mon, 24 Oct 2022 14:09:47 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] strptime.cc(__strptime): add %q GNU quarter
Message-ID: <Y1aAi3WLLlDEzJJF@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20221022051603.2787-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221022051603.2787-1-Brian.Inglis@SystematicSW.ab.ca>
X-Provags-ID: V03:K1:EwIinlS5lmO3BUQq4iphut9HPh7KYuS0VOZ9KdZfLTfhqyUpL2L
 Tw7WewFpK4sruDvgLbM8sM2zgceuyWn0GuB0VhJmhT19zAXTd4uhyOARSjgsG/3wc1g0wz3
 W5DveRjvq+8RRV5xVTCmYbDax9AyXQKizFqDoqNxFfvGCRpJq5aLa1s/WdNCQ5YAtqjgkBR
 HMUcXbQeWPKY2Imi8ffcg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TAQcPn/7w0k=:Rz4uWGtwYCVeSr7wPnicOO
 Cc9gcHX2okyW7QPoajUbHMpjS8Cgcpp5Kw3SbJqlONiAFxFHyEcfOACsxU2U2iNrMR6mFE7sX
 qP5aDlccyVncgAamVWLn3yRGVuP+Y5K4SYT9qpxJeWrwUHgiHcGWj80xMKT5kbO2F4CBJP/Tr
 CCG8n1GottQUgo98U93GxVIjLAQeOARhTJmA5JfEfCvuINmj4l4y0JZNDBBDD/laiteUQi/iv
 9J1t6PNqS8wq51DpPLbszzhmUIOuRCd1E771/cAO3M3TLoh29ShSGqyL9E1czGBKUemmX9fVV
 HZ4KNxBSEGd49gbmnz9zNYtcKvenyX9BPjueHtZxHPt+VTrZDfoJgrX6CcTVEuGgKeUji6SXL
 qGCIvs/KhYw8yBMfVagScBvwShkHpQphI2bui67CgDEDbYYlwEk1tgRFeVb9CAO+rvr35wwwX
 At5sxdKiG/9FkTRX7MamQJI+JrglOKje9qG8OVzvkYq9oz5dNIzoY4iGEEHino8/Jo+gof+y1
 yhBdXAbwBfpBif0yxUZsERzFdqIBCOHRHxMrAgY8XF6OG8ZyEMSGABtoINToLZRD7GLtR4DHR
 +U5To7HxTn4CAVHDorkpm6Na5tSTJlYZRajhwPBBbloltaePpES+Q7Ys/n5fI6OvYY6/C9rdE
 OxLqT+10aKXLdC7MtSbQw+GLy2NbScq4jitOVYwKlvaWf+oV/ngBd1GCdt7FuKQmbZJqkwsIQ
 xG8HmuNhn/VVBLIdbdoW2YuWpOPoCUXeqa0IFLiXLDHLUQRgm4bPdIBtDiIWeeCVVigd+h77j
 U4zV7cC2gSeQn1cF2uA4szLv7myKg==
X-Spam-Status: No, score=-101.6 required=5.0 tests=BAYES_00,GIT_PATCH_0,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Oct 21 23:16, Brian Inglis wrote:
> ---
>  winsup/cygwin/libc/strptime.cc | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 

> diff --git a/winsup/cygwin/libc/strptime.cc b/winsup/cygwin/libc/strptime.cc
> index 3a9bdbb300d4..d1e635cd279f 100644
> --- a/winsup/cygwin/libc/strptime.cc
> +++ b/winsup/cygwin/libc/strptime.cc
> @@ -570,6 +570,14 @@ literal:
>  			LEGAL_ALT(0);
>  			continue;
>  
> +		case 'q':	/* The quarter year. GNU extension. */
> +			LEGAL_ALT(0);
> +			i = 1;
> +			bp = conv_num(bp, &i, 1, 4, ALT_DIGITS);
> +			tm->tm_mon = (i - 1)*3;
> +			ymd |= SET_MON;
> +			continue;
> +
>  		case 'S':	/* The seconds. */
>  			LEGAL_ALT(ALT_O);
>  			bp = conv_num(bp, &tm->tm_sec, 0, 61, ALT_DIGITS);
> @@ -655,7 +663,7 @@ literal:
>  			got_eoff = 0;
>  			continue;
>  
> -		case 'y':	/* The year within 100 years of the epoch. */
> +		case 'y':	/* The year within 100 years of the century or era. */
>  			/* LEGAL_ALT(ALT_E | ALT_O); */
>  			ymd |= SET_YEAR;
>  			if ((alt_format & ALT_E) && *era_info)

Pushed.


Thanks,
Corinna
