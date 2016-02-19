Return-Path: <cygwin-patches-return-8340-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3036 invoked by alias); 19 Feb 2016 01:35:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 3016 invoked by uid 89); 19 Feb 2016 01:35:52 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,SPF_PASS,TVD_RCVD_IP autolearn=ham version=3.3.2 spammy=pivot, amd, CPUs, AMD
X-HELO: glup.org
Received: from 216-15-121-172.c3-0.smr-ubr2.sbo-smr.ma.static.cable.rcn.com (HELO glup.org) (216.15.121.172) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Fri, 19 Feb 2016 01:35:50 +0000
Received: from minipixel.local (unknown [IPv6:2001:4830:1141:1:ae87:a3ff:fe0b:f9a8])	by glup.org (Postfix) with ESMTPSA id 45613854C4;	Thu, 18 Feb 2016 20:35:48 -0500 (EST)
Authentication-Results: glup.org; dmarc=none header.from=glup.org
Subject: Re: [PATCH] Multiple timer issues + new [PATCH]
To: cygwin-patches@cygwin.com
References: <CAJCedbifwNgza6nUfSX6QH8ovnEy85bRJ=vH8SGuA_hNYdW5bw@mail.gmail.com>
From: john hood <cgull@glup.org>
X-Enigmail-Draft-Status: N1110
Message-ID: <56C67173.3030508@glup.org>
Date: Fri, 19 Feb 2016 01:35:00 -0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:38.0) Gecko/20100101 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <CAJCedbifwNgza6nUfSX6QH8ovnEy85bRJ=vH8SGuA_hNYdW5bw@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
X-SW-Source: 2016-q1/txt/msg00046.txt.bz2

On 2/18/16 6:39 PM, Irányossy Knoblauch Artúr wrote:
> The ntod timer (type hires_ns), however, is getting its time value
> from QueryPerformanceCounter(), which, according to the MSDN
> documentation, will provide a "time stamp that can be used for
> time-interval measurements" -- that is just what the doctor ordered.
> :-)

I have some interest in this because my work on select() may interact
with what you're doing here.

There's some information on the web discussing issues with
QueryPerformanceCounter(), for example
<http://www.virtualdub.org/blog/pivot/entry.php?id=106>.  This is mostly
an issue with CPUs available in the (I think) 2003-2006 time frame, such
as early AMD Athlons and early Intel Core iNNN and iNNNN CPUs.  Earlier
CPUs didn't have both changeable clock rates and RDTSC, and later CPUs
had RDTSC but the clock rate is constant for RDTSC.  It's also possible
that only some versions of Windows have issues in this area, maybe later
versions of Windows avoid this problem.  Does your code work properly in
this case?

regards,

  --jh
