Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id 1AC863858D34
 for <cygwin-patches@cygwin.com>; Thu,  9 Jul 2020 07:35:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 1AC863858D34
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Md66H-1kSDwW2WP5-00aFBO for <cygwin-patches@cygwin.com>; Thu, 09 Jul 2020
 09:35:31 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 1D555A80746; Thu,  9 Jul 2020 09:35:31 +0200 (CEST)
Date: Thu, 9 Jul 2020 09:35:31 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Cygwin 3.1.6
Message-ID: <20200709073531.GL514059@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6d8e377f-1ff0-6b47-33a7-3f3b5af317b3@dronecode.org.uk>
 <9d336a71-8ccc-7f4f-cc18-518769aed6eb@maxrnd.com>
 <5f9895b3-411b-0264-ed3d-8b576389f037@cornell.edu>
X-Provags-ID: V03:K1:7UhUF/gJAI3nsXrkaei4Sbv3UgoejVYz/GzxY1G2BNphPWdkMt5
 hciFBQlHxYuIyVEtvkJEZzaLEOAjn8yCtDFeLnSyL7hOpzmIui/oD5DVktwAsugPLt2zco3
 wzX4YXBmvvDGdHQcoDFVlpdaxdMfxbPx45AxFv30Y/rrKboVZW3JrcECp+DnKUFhcbrXNQl
 9P0Q/Pd7DSPGpM8j37Frg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:f4x1BOgBJw8=:facOS9dG0LA4v+yZyaVLcg
 VV7BtCc3DD3xzsvDkuR32ob1llax9EMepEjA+v2Q5mHZE9FxMIprocaoLtctOjZIEP5Qdx3Dg
 9b2wMuqAlvxgfLCSr4bbcXG0Rv2iBK/Y4bSRXdJfl4M4+1FxOXARIV/S3ViYYVkPLJimLwouw
 ikJrk4b8srW/22gNZw4ZPkpqacz2tJNPvIFdWquVm8F0pRZx3NWlRH6XfMKS7oWHjqXWaqPKm
 nHgyHWtNXRCx/6z/Gn2QCHIcvSQCMLVnVSFsP/nmNvZPOlPKIvzFed77DvQI+TvGtBap6CNvm
 WonLSZUVfFwTGwqWphX27tyEB9Ujnv6OfmQeAgF138Vhc5SInf9x/36ZYYrRfYMBtJK6fMt8I
 LxKrCdiLQV3eqB+p+FNxxF/Iae99ts1SpxLlFn6dbCLmxERdb672cxIytEb8KlBtRC027tjz0
 LW2nbov3izUCRo3CrelgoAl4zoNzcizl5HLU8xkrFwAR9IGf94atX6ZqfMkg8mSl6O7WRPeTq
 miDpkZXWZZLqERFGQu8yVF++uPCuxNkD2lZ/dBuhfoaGAZiYFtdTMfK2xB5HWpPiGKyGt0sFZ
 PIBB0iOBGJLS8+W45FayKJkepzEWVhaChQtcXfVo0D5O7CyRuIAOXxdHWsSoweFFgYCuc6xyQ
 PTTpqKB3Wt9Jlpf33dNHsCzUsf1Oc1QZQNN9W9DK+zJ/ru3HSiXNJ/fIswr+oosFtk1sshSBr
 +xrPeUQDdDKF37PN9t/qHpaomKRWd44cKU/nYFj1NiORLUvMblhslVHj37vc1lNciWiqPus1j
 SwTstmpSk2phcPMKUffwNXvNSv6w1wdlPaYKHO8DlTBdAYk/XsY4cj29jLPltNF0ZA1sLJgpG
 PryKP0FC9OjOKcjYtdIw==
X-Spam-Status: No, score=-97.8 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS, KAM_NUMSUBJECT, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 09 Jul 2020 07:35:35 -0000

On Jul  6 16:01, Ken Brown via Cygwin-patches wrote:
> On 7/6/2020 3:50 PM, Corinna Vinschen wrote:
> > Hi guys,
> > 
> > Do you have anything in the loop which should go into 3.1.6?
> > 
> > Given https://sourceware.org/git/?p=newlib-cygwin.git;a=commitdiff;h=bb96bd0,
> > I'd like to release 3.1.6 this week.
> 
> I'm working on some FIFO fixes, but it could be another week until they're
> done and thoroughly tested.  So I think you should go ahead, and the FIFO
> stuff can wait for 3.1.7.
> 
> Ken

On Jul  6 13:17, Mark Geisert wrote:
> Nothing from me, thanks.

On Jul  7 02:28, Jon Turney wrote:
> On 06/07/2020 20:50, Corinna Vinschen wrote:
> > Hi guys,
> > 
> > Do you have anything in the loop which should go into 3.1.6?
> 
> No

Thanks, guys!


Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
