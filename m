Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id 94E473857003
 for <cygwin-patches@cygwin.com>; Tue, 30 Jun 2020 10:18:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 94E473857003
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MODeL-1jRng31Cbx-00OUKQ for <cygwin-patches@cygwin.com>; Tue, 30 Jun 2020
 12:18:58 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id D3D59A80864; Tue, 30 Jun 2020 12:18:57 +0200 (CEST)
Date: Tue, 30 Jun 2020 12:18:57 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3 v3] Cygwin: tzcode resync: basics
Message-ID: <20200630101857.GB3499@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200522093253.995-1-mark@maxrnd.com>
 <20200522093253.995-2-mark@maxrnd.com>
 <20200525120634.GD6801@calimero.vinschen.de>
 <20200525154901.GG6801@calimero.vinschen.de>
 <bcff83ee-c3b6-0b99-90d6-650694562250@maxrnd.com>
 <20200526082736.GH6801@calimero.vinschen.de>
 <394b2ab3-f239-72a1-21b2-a28952137253@SystematicSw.ab.ca>
 <Pine.BSF.4.63.2006092130070.1307@m0.truegem.net>
 <c24d5439-aed4-4ec6-65a0-92f3fcfa0edb@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c24d5439-aed4-4ec6-65a0-92f3fcfa0edb@SystematicSw.ab.ca>
X-Provags-ID: V03:K1:amqNsO4t7aCX9OwVsH4NT2/qs/T3uwbTTiPprBoxjBboOROO+0A
 ZAAeta5g8ucQj3YvlfbEkTuFSPZ3rdtPmu8S39vhQRzOwXnJpq+0a9ZQL72ztPzLuPe4wFm
 V+Xkcw0J9YLah1BV6BmtC27FU5vQ1JLKcBzJCPsyRELwj1cyJxEwsrHt0fo7LuCXiIMwnB0
 EtRcZi+amqhM4wPWGAiwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oY/FwIHfeAs=:tL4Fa2mlfw3gx0fWBuxhAK
 X1PDFJReefkHX0euhBG0b5Aqj5XpbTNWsqVbsTq/5OhBD+vlPaOLBTcIJpc/OK1XIzwmNPLyJ
 su3yj+lt/kNgirHEUyulskIgAmhw57dXWthI/rdYbP1Zv25ytqosqac3uCxcBK+TUL2tHibk5
 8HVfiURaehYcZ+6/UAqvcvxdnw8wBvrN+Qf99wn/msSJPFw/wukq/uGChcG1qy/85v/MUjZkp
 AJApXhTkKyjQ6fCDZCqCiEjne/K6i2V6+6NVJS4FA6+pbTB8vklmT+CTAEvWe+Ix/KZbiDFkG
 oo2XWwzQpT9wW0urgFtgaGvGNnKVCXaLTzzbdh6FFljj9zXjjzLuF++pm4U1etM32iyzkwdIf
 n9YDcnBuYkCBcMqn2mZz0xyO47HE6hpkBIe115/cVKLRlqa2G3maBT6zii3EI4q4Rjv6lZ1OF
 j85yKfW0Zysi8+d1jZ9wZFYB9GKdwgQhCNC8CNI7gkTwkrBmnt0w875xVSNY7u6DS2HM4lu9W
 XZJUnitk4T4A6kxMoGpTnjDd7NwzP4GLjnwFX7aBM0j1zk2lN35XooORI3Pqb9kxFnfMH9g81
 341GCSBBhXJqJ1anKYNeaXBZtNaz01WIS6zBY6vawGwEmemMMmgiS134l4yZM4hTfNNiz6NC4
 7pBhsFFIUFWvDCB4xRMoh6+LRVHNRtaAW2D4p3zSLWnyPfxLI0GL8vJAixQdpV4scnN++chpM
 91d77Cnwo7ydAgtX01ikrhoh6TBSOipmKXgtq+zRphXY2LzRClY8BR2/X4sg03FuTuH+Ej9BA
 niRWS8TTO2Htp5q7d39rLcONXJsjKcYiFb9u9Ji7iE4XcPNaGBYh5FiRxOrsrOkt0XFm+ie
X-Spam-Status: No, score=-99.5 required=5.0 tests=BAYES_00,
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
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 30 Jun 2020 10:19:01 -0000

On Jun 10 15:53, Brian Inglis wrote:
> On 2020-06-09 22:37, Mark Geisert wrote:
> > On Tue, 9 Jun 2020, Brian Inglis wrote:
> >> On 2020-05-26 02:27, Corinna Vinschen wrote:
> >>> On May 26 00:09, Mark Geisert wrote:
> >>>> Corinna Vinschen wrote:
> >>>>>> On May 22 02:32, Mark Geisert wrote:
> >>>>> On May 25 14:06, Corinna Vinschen wrote:
> >> The tzcode package needs updated to get fixes into zic and zdump.
> >> Also tzdata was maintained by Yaakov.
> >>
> >> Corinna, would you like to keep tzcode co-maintained with Yaakov?
> >>
> >> Or Mark, would you like to ITA tzcode and/or tzdata to keep it in sync with the
> >> base code?
> >>
> >> Or would you like me to ITA tzcode and/or tzdata?
> >> I currently check tzdb weekly in cron to download updates for my own interests.
> >> I could add cygport builds to that job.
> > 
> > This "tzcode" patch I did was a one-shot task just getting some time zone
> > handling code within the Cygwin DLL up to date.  I don't know if there's any
> > overlap between what I worked on and the tzcode+tzdata packages.  Eh, just the
> > internal binary copy of a particular tzdata file which should be kept up to
> > date: /usr/share/zoneinfo/posixrules.  Dunno how often that changes though.
> > 
> > It's fine with me for you to take over both tzcode+tzdata if nobody else
> > objects.  Sounds like you have a regular schedule for looking over updates which
> > is more than I have :-).
> 
> Thanks Mark,
> 
> I'll wait to see if we hear from Corinna or ITA if no response soon.

You don't have to ask me to ITA packages, really :)


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
