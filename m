Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	by sourceware.org (Postfix) with ESMTPS id 2EF613858428
	for <cygwin-patches@cygwin.com>; Fri,  4 Nov 2022 11:10:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 2EF613858428
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=tempfail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mr8zO-1pKyPM3tva-00oG7y for <cygwin-patches@cygwin.com>; Fri, 04 Nov 2022
 12:10:42 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 9D417A80C18; Fri,  4 Nov 2022 11:34:36 +0100 (CET)
Date: Fri, 4 Nov 2022 11:34:36 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Improve FAQ on early breakpoint for ASLR
Message-ID: <Y2TqvPTB7Hui2jmJ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20221103170430.4448-1-jon.turney@dronecode.org.uk>
 <alpine.BSO.2.21.2211031120540.30152@resin.csoft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.BSO.2.21.2211031120540.30152@resin.csoft.net>
X-Provags-ID: V03:K1:w+VAwDezRjBuUsKTTUGSwXHdIvxFFi1MxTO9HvNKdE7ta0jsKHF
 MrWdzz3+cpI40GyrH5Qcp0s6fWD1Z8CattVN9rnJXDoyZYq6R3+JDLXCCyxE9U+/UzdvVj/
 yX9SW1ZMaIm53dkU1ibfSeQog30MM3xd9vyIvug99KDjDt0DPQE2ExO2aLJeyMStjofLTmd
 VzuHhAa2xlx7/WH4H5V8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QSmpglA+BCY=:Va0VSjpDruhS4G512dnTRs
 XSvebY6GrlT0T+ft19qv8LaifjXXfuVeUevFSVjF87A4+Bh/+y1qsHo1kyCvXFZ1MyJzasSlW
 Fo3twZTATL7h28VnZQblk/WX4XJM1lpHsNCa796Pa5KyURFZBa/cyYChlVp6GcpaIB5uDFy9L
 jpV5MN5gU1KwOzdSgbVMZyVnhH4q+0u+jXKz2TYT7xFppfyBYnxGEqQX7XMGbFyoa0N+AMuxW
 fSZB97CpO05x+IEeluizXH3ulohnaEQLBl3YBiMh+UToqiGrz4/nNjCJaBlriy+19uhAKppIj
 f1veuG4+ZzKgZX0nBjj52U/XQgLepGCmmMAxwqqk3nGTYvYa/Gl8AWfpKp6/kevjITd4HA+s6
 C6Y9MXfH+vEEvg+9M2wwDnSiUvxvZN3+KXia01eX8h6wDflaI7zQ1fKOmMTLw7YjxNllK+W9C
 bvq2mg0hrMT1vbHSXAOiduvqJ3Pg05Fh1phTDVuHqGr2KODAewJ2JbkbQ4xnGqtfvA8NwOkwk
 UFaQopQP3oBd8S3tqMditnWld8UVtXJCXaWq/LWyYrnxnXvuxAoK3pbceb8BxtgJ59wW5e3op
 Qof5SFAEN2aTY37NWoLhPWSLHe/LNYDx0T122C3Fqu44d4LpLulxgT29W74g4XzaeBTt4Nc8D
 BUb+/EBofLmb+OZwambMm9s0d+rLmANQs9uKXWpGh63kv90h5GT1O/1BtYQsVXj6qP3j8NuKA
 F/6yvODSWUY7XU9+JcIHs0XGmdJnKiX7tzjN8UAqjKllr+meBluzt9dhUHzETX3n8ZwoAFISt
 O4ByYKb32bfWTGPBhYjY/DlQZ/S3g==
X-Spam-Status: No, score=-95.4 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,TXREP,T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Nov  3 11:22, Jeremy Drake via Cygwin-patches wrote:
> On Thu, 3 Nov 2022, Jon Turney wrote:
> 
> > gdb supports 'set disable-randomization off' on Windows since [1]
> > (included in gdb 13).
> >
> > https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=bcb9251f029da8dcf360a4f5acfa3b4211c87bb0;hp=8fea1a81c7d9279a6f91e49ebacfb61e0f8ce008
> 
> Is it really *disable*-randomization *off*?  The double-negative seems to
> suggest that in that case ASLR would be left *on*.

Yeah, sounds weird....


Corinna
