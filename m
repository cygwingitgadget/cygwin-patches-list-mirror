Return-Path: <cygwin-patches-return-7753-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9534 invoked by alias); 24 Oct 2012 10:26:20 -0000
Received: (qmail 9521 invoked by uid 22791); 24 Oct 2012 10:26:18 -0000
X-SWARE-Spam-Status: No, hits=-5.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,KHOP_THREADED,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mail-ie0-f171.google.com (HELO mail-ie0-f171.google.com) (209.85.223.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 24 Oct 2012 10:26:13 +0000
Received: by mail-ie0-f171.google.com with SMTP id s9so409737iec.2        for <cygwin-patches@cygwin.com>; Wed, 24 Oct 2012 03:26:12 -0700 (PDT)
Received: by 10.50.190.137 with SMTP id gq9mr1960514igc.27.1351074372671;        Wed, 24 Oct 2012 03:26:12 -0700 (PDT)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id a10sm1690043igd.1.2012.10.24.03.26.11        (version=TLSv1/SSLv3 cipher=OTHER);        Wed, 24 Oct 2012 03:26:11 -0700 (PDT)
Message-ID: <1351074380.1244.94.camel@YAAKOV04>
Subject: Re: [patch]: Decouple cygwin building from in-tree mingw/w32api building
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Date: Wed, 24 Oct 2012 10:26:00 -0000
In-Reply-To: <20121024100140.GA31527@calimero.vinschen.de>
References: <20121017193258.GA15271@ednor.casa.cgf.cx>	 <1350545597.3492.59.camel@YAAKOV04>	 <20121018083419.GC6221@calimero.vinschen.de>	 <1350580828.3492.73.camel@YAAKOV04>	 <20121019092135.GA22432@calimero.vinschen.de>	 <1350664438.3492.114.camel@YAAKOV04> <1350855543.1244.64.camel@YAAKOV04>	 <20121022122344.GC2469@calimero.vinschen.de>	 <1351071053.1244.89.camel@YAAKOV04>	 <20121024095054.GB28666@calimero.vinschen.de>	 <20121024100140.GA31527@calimero.vinschen.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q4/txt/msg00030.txt.bz2

On Wed, 2012-10-24 at 12:01 +0200, Corinna Vinschen wrote:
> > Checking in toplevel patches requires global checkin rights.  I can
> > apply the toplevel patch when you applied the rest.  Other than that,
> > toplevel patches also have to be kept aligned with the gcc repo.  I'll
> > make sure to inform the gcc guys.
> 
> Oh btw., if that wasn't clear:  Please apply all but toplevel.

Done.  While you're at it, perhaps you could bump this patch as well:

http://gcc.gnu.org/ml/gcc-patches/2011-07/msg01578.html


Yaakov

