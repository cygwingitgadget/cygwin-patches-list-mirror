Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id 662643857806
 for <cygwin-patches@cygwin.com>; Thu, 10 Sep 2020 14:04:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 662643857806
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N45th-1khDfi3l9F-0100on for <cygwin-patches@cygwin.com>; Thu, 10 Sep 2020
 16:04:07 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 3BC67A804C1; Thu, 10 Sep 2020 16:04:07 +0200 (CEST)
Date: Thu, 10 Sep 2020 16:04:07 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset ==
 "UTF-8"
Message-ID: <20200910140407.GB4127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <nycvar.QRO.7.76.6.2009011818560.56@tvgsbejvaqbjf.bet>
 <20200904190337.cde290e4b690793ef6a0f496@nifty.ne.jp>
 <nycvar.QRO.7.76.6.2009040822000.56@tvgsbejvaqbjf.bet>
 <20200905000302.9c777e3d2df4f49f3a641e42@nifty.ne.jp>
 <nycvar.QRO.7.76.6.2009072309070.56@tvgsbejvaqbjf.bet>
 <20200908171648.e65665caebb643ce99910fa3@nifty.ne.jp>
 <20200909072123.GX4127@calimero.vinschen.de>
 <20200910091500.388ab2f6796a4abce57a3cd2@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200910091500.388ab2f6796a4abce57a3cd2@nifty.ne.jp>
X-Provags-ID: V03:K1:uX/MijhQ9uUSSj6ooPj8CpVD2cPU711RStwH7WqtGU4hMVzyZmX
 ulnrOJ3Ug4vYzD9hwmhQA69UAmlKo9eWBKrNwy5cxt01Vm8K1Y+3PDWirwNj3US72zs1PBg
 hZqVXUaX5JubR5iWFQoyR7e6hVC2WByTHK5YQLfRND/Oe5DgmOUgt8QYWIdfCzVw+YqYd4o
 Z1Gb6MpDG1ghKqdg76k3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UUjO0H7ewnA=:Zkmk3zz+ddpmVxvEvzVkJC
 uTF8sRTVh1DzFz/sBhWXf3U869iO+DohhrX9YOWLst703bMrYYE1ikxWBSVJ2Ov7umcfN9lv/
 u3qzpEATjAUJwsE06r7bJ85AiT5scOH35cygszGvTmFvN4+ykyu9CTZ4sLm5TeenyvCKlwvub
 jeMgn8MN7uGupAm9tKS0P5DRfMzGyFrnP1KuHlO6oqOKaB4dXp2/SSkKIInDRRN5GfJmEXh5Q
 3IMaJZSJeie3ReE6U2bMP6Wni62IahaR9Mhi3ZqI0yTdPlgLXCKAkJfU8gjlxMeULoLIZb04l
 87VLiB+27jjNBXzEDmMl4D60QbrKRN2V/pIEAHB1xg9TiZTHIw51jBE2OfFJvA8WVBaBk6/3o
 OAUrnxWwNGQN4FFB5GdUtTCJ1YhodFUohcv99iza/53sT9v+bBy43U7kjTsIlD/Gq8f6+pmMJ
 WFirCStkrFm+uGP5IvQtW31EEbtzutOR06Rd4HafYDMwpi6KPZ+SCGwkkgGiyAukh3OSJmb+w
 SMn8sUjvdHd09Svz/HJD6uN+yloadM5SJAYBoNP+achJmX5wPLub73xkTBMNGwJnSnA+FexqV
 4IN/wiYPwoF2IaJs+8SypZhi1UTjtfmCJk9aDpAZstXY38fhZy9I8aA+vPw1HG1momxSAH3jr
 67bHDn/SZP8e6lNzvzXLkbtekNbL6XYUT8qnCVNkZjkAS+KZVQkwu6420r6JBIOjHB1xh6fCH
 dQnUXGI8wv+VCjJ0f59iAp25IA9US8ARqPJuTTPDqBTVHnJJ5CCe79Rul+8MjMnoLHMNzBbBc
 kdDSlAfebL9tD4hL3QLAsvJdWEa15B5Aw0Zj83tcyDteX6ElqO2FtNCxolN22Tu8kq5QoJX4e
 o8sMty4k1yXBvu0GMbIw==
X-Spam-Status: No, score=-105.4 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
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
X-List-Received-Date: Thu, 10 Sep 2020 14:04:11 -0000

Hi Takashi,

On Sep 10 09:15, Takashi Yano via Cygwin-patches wrote:
> On Wed, 9 Sep 2020 09:21:23 +0200
> Corinna Vinschen wrote:
> > Takashi, does the patch from
> > https://cygwin.com/pipermail/cygwin-developers/2020-August/011951.html
> > still apply to the latest from master?  Question is, shouldn't the
> > Windows calls setting the codepage be only called if started from
> > child_info_spawn::worker for non-Cygwin executables?
> 
> I'd propose the patch:
> 
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index 37d033bbe..95b28c3da 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -1830,7 +1830,11 @@ fhandler_pty_slave::setup_locale (void)
>    extern UINT __eval_codepage_from_internal_charset ();
> 
>    if (!get_ttyp ()->term_code_page)
> -    get_ttyp ()->term_code_page = __eval_codepage_from_internal_charset ();
> +    {
> +      get_ttyp ()->term_code_page = __eval_codepage_from_internal_charset ();
> +      SetConsoleCP (get_ttyp ()->term_code_page);
> +      SetConsoleOutputCP (get_ttyp ()->term_code_page);
> +    }
>  }
> 
>  void
> 
> However, Johannes insists setting codepage for non-cygwin apps
> even when pseudo console is enabled, which I cannot agree.
> 
> Actually, I hesitate even the patch above, however, it seems to
> be necessary for msys apps in terms of backward compatibility.

If we do as above, doesn't that mean the invocation of convert_mb_str in
fhandler_pty_master::accept_input, as well as the second invocation of
convert_mb_str in fhandler_pty_master::pty_master_fwd_thread are
redundant?  Both are only called if get_ttyp ()->term_code_page differs
from the input or output console codepage.  Given the above setting of
the console CP to term_code_page, this would never be the case, right?


Corinna
