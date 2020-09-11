Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id 8177C385703C
 for <cygwin-patches@cygwin.com>; Fri, 11 Sep 2020 14:06:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 8177C385703C
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MoOIi-1ks3aT3pnc-00oqXd for <cygwin-patches@cygwin.com>; Fri, 11 Sep 2020
 16:06:01 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 6942BA804E5; Fri, 11 Sep 2020 16:06:01 +0200 (CEST)
Date: Fri, 11 Sep 2020 16:06:01 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Add workaround for ISO-2022 and ISCII in
 convert_mb_str().
Message-ID: <20200911140601.GK4127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200911105401.153-1-takashi.yano@nifty.ne.jp>
 <20200911120840.GH4127@calimero.vinschen.de>
 <20200911213515.98a88ca7f186ede9bf8fc106@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200911213515.98a88ca7f186ede9bf8fc106@nifty.ne.jp>
X-Provags-ID: V03:K1:FbpNPgZroOB5hqJpn08DobGTSsi+m0+tbIEIH4vkl3bCjaAzMMF
 D6CVxBFFD48ceA/jvcbLSwwu/QiCP4gzqjwZvoq6P4kS+HbKIV2379d8XmX2bd3gIIMWemz
 +T2LP38o4zeipsZSWnDMrTfnGRrKqBoxMXQollpr2GXN6UaTEDTDFX++7Gr7pLb6lm5+70U
 qDZqDFpa3FDl97zU/OLHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jOLKjFCSaKg=:FgtIpjDHLtjbbPhPKVcXNl
 9PYc3q5qWJ1vwT7/yCUT9Qzu9qyED4keFgMvSUZVpdM9WgSIaHhNopS/8pfgQKxOoFzKzqhM4
 kG5FcqcfvsJ5jWeSqzyPZR4NO1/gIenIwm4s6SpqwEZxXXwEJCYAIt16uRiag01zwiyncrOmS
 X4FU4Ik9n7kyYQMZqPDxCfmelwYyWUG9QAIbIKZ7wGujkTiGHBV7TJQ3wUn2sPzF/AkzczTID
 vGh1n5C8Lo60YFYeGXebmg3hKWwVtTSnHcH96swT70yt7N0EXd5YjSKrh0DflVf6sz5Vcl9FS
 FapNbLz1VGCVlUITanryEJKzdV5hfE1q2KYDkpD/ooKfKfGzxKg7Ib9haHuj0PdLi5Sr6HnXa
 r8oJQEPx4rTARpnNPBL3RDvTuxmgn43Lf6nCcEUlYmmobjE0+S7xczNU80a8hmFPdCbRZtnyI
 tR/ZbKZ1kxxI0w4451iqL9HhmwbJHGkkGCCu1Tpzg15TiAvcfpHNcLXqtVkEGiHylcgu255R0
 Iy8sSo8yKLxfIAJFR1rm34gs5YnM8/4THh3GAKsJzdCTJBm0aN/7fN7XhB+MUbcbF2DLaCaze
 zRiN3f+EkuRdiohWydUjZPLJZECjPBaloZeEkg8Ai62PABvcxYyIunC4D/gHdix2eZhKbxcc3
 K5p+NpvY+m61oo97S1qgT/tENMMY8LOMGl9nBHuadzhOAOJ99nVPCPXbZwg4nekRMw6VNhW4T
 Zl+B+f1R9mhRVwGyzXEuiy2Zsub1HwAcCtFjXl96LfKI6t2NzyMFG8oNvcvI62NitqLB0NxTE
 UU0Ucw+zyKj1bjYTq1v+3DpuIPqKHt+HVEFnkpynwfpS6PD0tBGEbaJIYvP9vNfW8B95RwKGi
 wRJG4X8R/C807CDUp7yg==
X-Spam-Status: No, score=-105.8 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Fri, 11 Sep 2020 14:06:05 -0000

On Sep 11 21:35, Takashi Yano via Cygwin-patches wrote:
> Hi Corinna,
> 
> On Fri, 11 Sep 2020 14:08:40 +0200
> Corinna Vinschen wrote:
> > On Sep 11 19:54, Takashi Yano via Cygwin-patches wrote:
> > > - In convert_mb_str(), exclude ISO-2022 and ISCII from the processing
> > >   for the case that the multibyte char is splitted in the middle.
> > >   The reason is as follows.
> > >   * ISO-2022 is too complicated to handle correctly.
> > >   * Not sure what to do with ISCII.
> > > ---
> > >  winsup/cygwin/fhandler_tty.cc | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> > > index 37d033bbe..ee5c6a90a 100644
> > > --- a/winsup/cygwin/fhandler_tty.cc
> > > +++ b/winsup/cygwin/fhandler_tty.cc
> > > @@ -117,6 +117,9 @@ CreateProcessW_Hooked
> > >    return CreateProcessW_Orig (n, c, pa, ta, inh, f, e, d, si, pi);
> > >  }
> > >  
> > > +#define IS_ISO_2022(x) ( (x) >= 50220 && (x) <= 50229 )
> > > +#define IS_ISCII(x) ( (x) >= 57002 && (x) <= 57011 )
> > > +
> > >  static void
> > >  convert_mb_str (UINT cp_to, char *ptr_to, size_t *len_to,
> > >  		UINT cp_from, const char *ptr_from, size_t len_from,
> > > @@ -126,8 +129,10 @@ convert_mb_str (UINT cp_to, char *ptr_to, size_t *len_to,
> > >    tmp_pathbuf tp;
> > >    wchar_t *wbuf = tp.w_get ();
> > >    int wlen = 0;
> > > -  if (cp_from == CP_UTF7)
> > > -    /* MB_ERR_INVALID_CHARS does not work properly for UTF-7.
> > > +  if (cp_from == CP_UTF7 || IS_ISO_2022 (cp_from) || IS_ISCII (cp_from))
> > > +    /* - MB_ERR_INVALID_CHARS does not work properly for UTF-7.
> > > +       - ISO-2022 is too complicated to handle correctly.
> > > +       - FIXME: Not sure what to do for ISCII.
> > >         Therefore, just convert string without checking */
> > >      wlen = MultiByteToWideChar (cp_from, 0, ptr_from, len_from,
> > >  				wbuf, NT_MAX_PATH);
> > > -- 
> > > 2.28.0
> > 
> > I'd prefer to not handle them at all.  We just don't support these
> > charsets, same as JIS, EBCDIC, you name it, which are not ASCII
> > compatible.  Let's please just drop any handling for these weird
> > or outdated codepages.
> 
> What do you mean by "just drop any handling"? 
> 
> Do you mean remove following if block?
> > > +  if (cp_from == CP_UTF7 || IS_ISO_2022 (cp_from) || IS_ISCII (cp_from))
> > > +    /* - MB_ERR_INVALID_CHARS does not work properly for UTF-7.
> > > +       - ISO-2022 is too complicated to handle correctly.
> > > +       - FIXME: Not sure what to do for ISCII.
> > >         Therefore, just convert string without checking */
> > >      wlen = MultiByteToWideChar (cp_from, 0, ptr_from, len_from,
> > >  				wbuf, NT_MAX_PATH);
> In this case, the conversion for ISO-2022, ISCII and UTF-7 will
> not be done correctly.
> 
> Or skip charset conversion if the codepage is EBCDIC, ISO-2022
> or ISCII? What should we do for UTF-7?

Nothing, just like for any other of these weird charsets.  Cygwin never
supported any charset which wasn't at least ASCII compatible in the
0 <= x <= 127 range.  Just ignore them and the possibility that a
user chooses them for fun.

> What should happen if user or apps chage codepage to one of them?

Garbage output, I guess.  We shouldn't really care.


Corinna
