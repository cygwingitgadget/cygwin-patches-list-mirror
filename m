Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id 22B8E3860017
 for <cygwin-patches@cygwin.com>; Wed, 26 Aug 2020 08:16:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 22B8E3860017
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M5Qhx-1kA1n13EST-001TjP for <cygwin-patches@cygwin.com>; Wed, 26 Aug 2020
 10:16:22 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 30432A83A75; Wed, 26 Aug 2020 10:16:22 +0200 (CEST)
Date: Wed, 26 Aug 2020 10:16:22 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 3/3] winsup/doc/faq-api.xml(faq.api.timezone): explain
 time zone updates
Message-ID: <20200826081622.GM3272@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200825125715.48238-1-Brian.Inglis@SystematicSW.ab.ca>
 <20200825125715.48238-4-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200825125715.48238-4-Brian.Inglis@SystematicSW.ab.ca>
X-Provags-ID: V03:K1:QthNdnlms/WxTCWsahZRmk8zLUw6h4jiF++r8h2GfIARLcZu5aq
 iPC7nydqkyQlAzY03JndNE85EGZcnKjIgvlxYdjmQD33n+xWUHoxT2tc/aD5CpB+1Nxhnbf
 L3SIrXPFQUvovcLTloRixm3RzpqVmNLbzi2tZrVYojP2N/Ycg79BPTfIpAQh7Ndsb8ZGfCx
 4Yfalq1GST0Kgr7v7yKgw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XLJJsw5zRVA=:8y8LPHaNZeev/AlXVgR6cI
 KHshcsZuUNrlhd9Ug3T1YM7JYIS3YzzeHpJPQqRbh1IsN+88QGlS5ur2MqZdZc3roJxgoihmz
 BM5JsnVuZIdbaT2D1R7GhRviG+WzfZ2IFvERpGQpdmX8GPmyLuz25Tq688coZg8WWKsEqKduJ
 dm0LZg5PKlqUB/C33Q9yf4dgBc/oyVuYfAXE8g3a0HfJ0MD7XJAwIR7/8ZJosvTxHVbjlLZoC
 kRUgOSqnJIJBGWGz2SRFsbwNZRoy+D/d1swSR16ElgDftcigAXDt91/oStHq4XWoU5VcOCEMI
 KYtRLPiTCePhcqUEZUiLAlQbovWX24eXOSieDbivNl6giXH3KyBTkeDpuieudA/m+JLDo9ldC
 aHWQLVEGngUIfjc0LPm0SSX0UkU9FI7/YhwQ27RL07ajbaumh/6AV1mU6+bU9/TzN/4MNq1sI
 Rw1iSCxxLJq0EXB7vWAyqyPUqRcM7I7Hu9RXodTCEDhxA1g29imbh71cvdLcs2wuv3K8vJ7U5
 dTEQBGJgEXlp/d5ovNO+/D5lYJ7MBPYEl80EZJ0btfLn7yyxWSaUfK8cHIryzahiieKJTPs4g
 PQWF+d3/bogcpzvHPpN6U9/Qs8Qg8eueggf7Qtnl7h+cqzO7ZbBwPDLFxszz3aI33BCMkKTF4
 XlI3vMd6Qa92v6NUYRjT3D1uhHwqDZokefdMqKeuvl3a192qiGmHMEjiA826sZ1g6ubqUtfvm
 IyhptgMo9BG2HVRcrPJcDEKoMdjpQhzd4X1gYGqHKaZzJ9f2xEYDddwtcwU6gDa4L/t0byVZq
 0ZSygfSZZ74WRlWuiFBDgepy2WnRd9sXAUKi3CZqEuG3OLHb548pP5/PmTaxb9I5IBaZ/Lvcx
 4qhsa1wEeVDaLFMi8/5w==
X-Spam-Status: No, score=-105.0 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
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
X-List-Received-Date: Wed, 26 Aug 2020 08:16:25 -0000

On Aug 25 06:57, Brian Inglis wrote:
> based on material from tz@IANA.org mailing list sources
> ---
>  winsup/doc/faq-api.xml | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/winsup/doc/faq-api.xml b/winsup/doc/faq-api.xml
> index 829e4d7febd8..365e301555a5 100644
> --- a/winsup/doc/faq-api.xml
> +++ b/winsup/doc/faq-api.xml
> @@ -385,13 +385,34 @@ Cygwin version number details, check out the
>  </answer></qandaentry>
>  
>  <qandaentry id="faq.api.timezone">
> -<question><para>Why isn't timezone set correctly?</para></question>
> +<question><para>Why isn't time zone set correctly?</para></question>
>  <answer>
>  
> -<para><emphasis role='bold'>(Please note: This section has not yet been updated for the latest net release.)</emphasis>
> -</para>
> -<para>Did you explicitly call tzset() before checking the value of timezone?
> +<para>Did you explicitly call tzset() before checking the value of time zone?
>  If not, you must do so.
> +Time zone settings are updated by changes to the tzdata package included in all
> +Cygwin installations.

Shouldn't a new paragraph start at this point?

Actually, maybe this could be changed a bit more.  The question might be
better called "Why isn't my (or the) time zone set correctly?" and the
order inside the FAQ seems a bit upside down now.  Starting with a reply
only affecting developers with self-written applications is rather weird
given the general discussion only follows afterwards.

The discussion on how time zones are updated in real life might be the
better start, then how to rectify local settings by running Setup, and
only then implications for developers.

Make sense?

Thanks, I pushed the other two patches in the meantime.


Corinna
