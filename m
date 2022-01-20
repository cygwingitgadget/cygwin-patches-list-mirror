Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id 86B203858D37
 for <cygwin-patches@cygwin.com>; Thu, 20 Jan 2022 16:46:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 86B203858D37
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MoNyA-1mUgB92xiq-00onda for <cygwin-patches@cygwin.com>; Thu, 20 Jan 2022
 17:46:43 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id AEA42A8087B; Thu, 20 Jan 2022 17:46:42 +0100 (CET)
Date: Thu, 20 Jan 2022 17:46:42 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/4] Cygwin: silence dblatex when building PDFs
Message-ID: <YemR8tK+rc1oHX7o@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220119131521.51616-1-jon.turney@dronecode.org.uk>
 <20220119131521.51616-3-jon.turney@dronecode.org.uk>
 <e3affd29-31c9-7b0c-62a3-0517a4160c3a@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e3affd29-31c9-7b0c-62a3-0517a4160c3a@dronecode.org.uk>
X-Provags-ID: V03:K1:EHmx7v60NsNq3KST+Yl+GiOPo1CMwgI/Hlod19F8FYiPx7ZP+Ih
 99squorsjSP6HOWl6Ff6L4Lu5vygG/qtfm7thQD0MA6BVYWTjRiTSNBJaIfoJ8/mVsLywMu
 sfy4vByDK72zCjRuB4Imt7w+c1eVMOCwg9ql2Qw3uRa1ClunW8EjreS1nLpGcAg0xEc6o+k
 pwkRw9C9DH9SfyfgQleiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MZXPy47GJLI=:veXIp8i7lvZgVYb3aecew2
 3jPX82kG4Vo9FdYukocmqj960y3L5RHyqLC8QD//pRnnDF9NKpq89FA2i4gIOmzIU+CcvEc7W
 1vRBiKG/FpXkbsMngF145zAfP5N3hXJ4e2jrGzAL3G7xZwddOkJPq96iTdeRF65w/tono3+e5
 rikhYCYVNsv+yzU33q93bOS/QfMbKDumJSOnOBCnNPmWAbg7T20SJZl8QGT/dafOFU8SkCQyW
 eZePnfCXyOMXJbJ0outS+3UzxcN0UFDK7KXFcxRWE6YmmGdrs+mthbAITHYiDyWOF2mi8xAWL
 461VxzmhODLnO7X3HGTrdKfAdRHiFQNgwdvobPBMgDgoWaPAwSR/jcL5BluIqyu/0UWmocXAl
 USVwPgQJo26lSaB+MiMFrZlfoMPrVjKq/bxr94ACrOiqqzFgocRToA+k948EYHh9RCoUPLsvt
 +aarQ5zmSwWEF3uMLlBh2Lh+SiBSI9vH41x0vnxdhliId8+hVhZq1gja0BlkDsk0gebc4+61W
 IfAYYFbriKex49d7/G44M7J1ROQ5YdWWfc8V3vvT2eVez1VT1fqJzH5FBYaqvQAJtVNZdlXlW
 WeLDqLybyZrnRpeYcDdhvL4zbWdFojItmKnoYx6Kp9XCZuxouBPGZqXsl6Kv6yO9/F6SFN4cV
 mVeSXWNKxd0mW8cI60DaSQifF9PfFCTmpK9rED7d9vDtN+0N/xN1mja7eF+clINJaBoiNKJX8
 BlgIwlXJjQX0G9t7
X-Spam-Status: No, score=-103.5 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_MSPIKE_H5,
 RCVD_IN_MSPIKE_WL, SPF_FAIL, SPF_HELO_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Thu, 20 Jan 2022 16:46:47 -0000

On Jan 20 16:43, Jon Turney wrote:
> On 19/01/2022 13:15, Jon Turney wrote:
> > Unless make is invoked with V=1, have xmlto pass '-q' to dblatex when
> > building PDFs, to avoid "default template used in programlisting or
> > screen" warnings from dblatex's verbatim.xsl stylesheet.
> > ---
> >   winsup/doc/Makefile.am | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/winsup/doc/Makefile.am b/winsup/doc/Makefile.am
> > index 44b64babc..57b74341a 100644
> > --- a/winsup/doc/Makefile.am
> > +++ b/winsup/doc/Makefile.am
> > @@ -17,6 +17,9 @@ doc_DATA = \
> >   htmldir = $(datarootdir)/doc
> >   XMLTO=@XMLTO@ --skip-validation --with-dblatex
> > +XMLTO_DBLATEX_QUIET_=-p '-q'
> > +XMLTO_DBLATEX_QUIET=$(XMLTO_DBLATEX_QUIET_$(V))
> 
> 
> This doesn't seem to be working as expected when building on Fedora Rawhide
> [1], but it looks like xmlto isn't using dblatex despite ' --with-dblatex'?

Did you install dblatex?


Corinna
