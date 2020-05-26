Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id 98D4C3896C16
 for <cygwin-patches@cygwin.com>; Tue, 26 May 2020 17:16:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 98D4C3896C16
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MnagF-1jC1fL1ueT-00jX38 for <cygwin-patches@cygwin.com>; Tue, 26 May 2020
 19:16:34 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id B7A77A80FF8; Tue, 26 May 2020 19:16:33 +0200 (CEST)
Date: Tue, 26 May 2020 19:16:33 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3 v3] Cygwin: tzcode resync: basics
Message-ID: <20200526171633.GM6801@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200522093253.995-1-mark@maxrnd.com>
 <20200522093253.995-2-mark@maxrnd.com>
 <857ad727-00df-e948-c823-f47448a47fec@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <857ad727-00df-e948-c823-f47448a47fec@dronecode.org.uk>
X-Provags-ID: V03:K1:L+40VD7dg0n091JTrZJyk1WjHj+nmMsNLmAN17HwtvdNnixacvR
 IDGzdkUCiElDBJIYBvOgHyJnygObcXMGcB4F5/VjkDlZWZ02BaH6iM/EkOcAaBTQYclq5XA
 4D4ftyPpaKQ0yz2lbIMtn5B4OZ2cBz3W7S1Fz2f3caDLpu5IPFoz/aNHRxZbgfTMBZVhgU4
 foeTvU6w0k1ngt53l1d4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FWLbQW6Up84=:p+863rTgwg5DWtxXZo7pkh
 25f8GDYsUx1rq+kng0wzKDHzOaIKQzu2rL4AVu84G1lmHBCRROM1rz94hNdl6vwCQboVXcVQt
 vSM6zmH2ZlSsCKC3hNpr3vy6N9Z5RGmpZJ8XEziGteDeLEG861RJRDOeAD84VvrjCj4rsJ5Xr
 /yP5lvZBp2vJT9NvSkRLNE/ytu1GVtCONmDb9IizWmKpm54pSMg9ax+2g3JvuBZ7mQSb6L5gS
 9FqAzadHI9NaqolWGSM0o4u4kCmQEbiy8Abb2XOBB7qcNLCxf6IC39MuvIG0bActqSbQTjyxt
 0d8GILza6jr+yT8IGIXUeOTKSj2ddaekyn3XrDuc4qXnp0yFaqKeWvn1GXGtb4d3Z4k9a5y5k
 TAnklehQTu9dO4xZ+7e47GFeoxRkDsoNSZGdtf8YAnTCDZjV5QgX8zmxocPcqiZR18VrFwx82
 dSlsYeEVUZDG7xWr3eTrDiONgf8HyJO1h9UHE0M9H4YWuGZgsqH1RYUD6n1DcXviTIT5Xr6D5
 Xm+opwWRG5YcI3vSHlhNCUB5bPst00+5G4nSxZn6jUKqIgyVm6Fy2nC+wFuipiQ/Fx4LvOIIk
 pO2QVXjGkjyGiHDPOT9CskrqoUqcJmKJP8UDqOiVcDGxaV1cl5Jprpo2oe4svhAbiLCtrdZUU
 0jm0drRONGLGpQNAdqEvs5enD6vZ10lPx3griDvovsjcY7aD2J3OU3ODm4VAB2lnxe43j3hS/
 Wpv0DQHx2ykR+SB6/cHV05YJkOz+iCXxk0xY52Jeysvit4E4xRr8n7TvH0mRSAcCCPotW9nMh
 oVJHa0o8IwLFUb+QAmJC3Ir149jN6QNmU1pwLO41pepM1d0Z9kJgtEhrp9p5kHDUETjDVO8
X-Spam-Status: No, score=-103.8 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 26 May 2020 17:16:37 -0000

On May 26 16:11, Jon Turney wrote:
> On 22/05/2020 10:32, Mark Geisert wrote:
> > 
> > diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
> > index f273ba793..2ac8bcbd8 100644
> > --- a/winsup/cygwin/Makefile.in
> > +++ b/winsup/cygwin/Makefile.in
> > @@ -27,7 +27,7 @@ export CCWRAP_HEADERS:=. ${srcdir}
> >   export CCWRAP_SYSTEM_HEADERS:=@cygwin_headers@ @newlib_headers@
> >   export CCWRAP_DIRAFTER_HEADERS:=@windows_headers@
> > -VPATH+=$(srcdir)/regex $(srcdir)/lib $(srcdir)/libc $(srcdir)/math
> > +VPATH+=$(srcdir)/regex $(srcdir)/lib $(srcdir)/libc $(srcdir)/math $(srcdir)/tzcode
> >   target_cpu:=@target_cpu@
> >   target_alias:=@target_alias@
> > @@ -246,6 +246,15 @@ MATH_OFILES:= \
> >   	tgammal.o \
> >   	truncl.o
> > +TZCODE_OFILES:=localtime.o
> > +
> > +localtime.o: $(srcdir)/tzcode/localtime.cc $(srcdir)/tzcode/localtime.c.patch
> > +	(cd $(srcdir)/tzcode && \
> > +		patch -u -o localtime.c.patched localtime.c localtime.c.patch)
> > +	$(CXX) ${CXXFLAGS} ${localtime_CFLAGS} \
> > +		-I$(target_builddir)/winsup/cygwin \
> > +		-I$(srcdir) -I$(srcdir)/tzcode -c -o $@ $<
> > +
> >   DLL_OFILES:= \
> 
> This adds 'patch' to the build-time requirements of Cygwin, which should
> probably be noted in the answer to faq.programming.building-cygwin in
> winsup/doc/faq-programming.xml.
> 
> (There's also some stuff in there about LSAs requirements which is stale, I
> think?)

I meddled with the text a bit.  Feel free to patch it further if you
dislike it.


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
